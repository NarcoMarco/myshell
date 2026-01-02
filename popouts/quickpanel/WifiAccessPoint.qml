import qs.singletons

import QtQuick
import QtQuick.Layouts


Rectangle {
	id: root
	implicitHeight: Style.popoutWidgetHeight

	required property Network.AccessPoint accessPoint

	readonly property bool isSecure: accessPoint ? accessPoint.isSecure : false

	readonly property int strength: accessPoint ? accessPoint.strength : 0

	readonly property string ssid: accessPoint ? accessPoint.ssid : "Wi-Fi"

	readonly property string ssidShort: {
		if (ssid.length > Style.maxWifiLength * 2) {
			return ssid.slice(0, Style.maxWifiLength * 2) + "…"
		} else {
			return ssid
		}
	}

	property bool hovered: false

	color: hovered ? Style.hoverColor : Style.bgColor

	radius: height / 2

	RowLayout {
		anchors {
			fill: parent
			leftMargin: Style.popoutDefaultMargin
			rightMargin: Style.popoutDefaultMargin
		}

		Text {
			Layout.alignment: Qt.AlignLeft

			verticalAlignment: Text.AlignVCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.popoutFontSize
			font.weight: Font.DemiBold

			text: root.ssidShort
		}

		Item {
			Layout.fillWidth: true
		}

		Text {
			Layout.alignment: Qt.AlignRight

			verticalAlignment: Text.AlignVCenter

			font.family: Style.fontFamily
			minimumPixelSize: 6
			font.pixelSize: Style.popoutFontSize
			fontSizeMode: Text.Fit
			font.weight: Font.DemiBold

			color: Style.fgColor

			text: {
					if (!root.isSecure) {
					if (root.strength >= 75) return "󰤨"
					if (root.strength >= 50) return "󰤥"
					if (root.strength >= 25) return "󰤢"
					if (root.strength >= 0) return "󰤟"
				} else if (root.isSecure) {
					if (root.strength >= 75) return "󰤪"
					if (root.strength >= 50) return "󰤧"
					if (root.strength >= 25) return "󰤤"
					if (root.strength >= 0) return "󰤡"
				} else return "󰤨"
			}
		}
	}

	MouseArea {	
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true

		cursorShape: Qt.PointingHandCursor

		onEntered: root.hovered = true
		onExited: root.hovered = false

		onClicked: {
			if (root.accessPoint == Network.active) {
				Network.disconnectFromNetwork()
			} else {
				Network.connectToNetwork(root.accessPoint.ssid)
			}
		}
	}
}
