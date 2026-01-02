import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
	id: root

	required property int widgetHeight
	required property int widgetWidth

	property bool hovered: false

	readonly property string activeSSID: {
		if (Network.wifiEnabled) {
			Network.active ? Network.active.ssid : "Disconnected"
		} else {
			"Wifi"
		}
	}

	readonly property string activeSSIDShort: {
		if (activeSSID.length > Style.maxWifiLength) {
			return activeSSID.slice(0, Style.maxWifiLength) + "…"
		} else {
			return activeSSID
		}
	}

	readonly property color textColor: Network.wifiEnabled ? Style.bgColor : Style.textColor

	implicitWidth: widgetWidth
	implicitHeight: widgetHeight

	radius: height / 2
	color: {
		if (hovered) return Style.hoverColor
		else if (Network.wifiEnabled) return Style.fgColor
		else return Style.disabledColor
	}

	Row {
		spacing: Style.defaultMargin
		anchors.centerIn: parent
		height: parent.height
		width: parent.width

		Item {
			width: parent.height
			height: parent.height

			Text {
				anchors.fill: parent
				anchors.leftMargin: Style.popoutDefaultMargin

				verticalAlignment: Text.AlignVCenter

				font.family: Style.fontFamily
				minimumPixelSize: 6
				font.pixelSize: Style.popoutFontSize
				fontSizeMode: Text.Fit
				font.weight: Font.DemiBold

				color: root.textColor

				text: {
					if (Network.wifiEnabled  == false) return "󰤭"
					else if (Network.active) {
						if (Network.active.strength >= 75) return "󰤨"
						if (Network.active.strength >= 50) return "󰤥"
						if (Network.active.strength >= 25) return "󰤢"
						if (Network.active.strength >= 0) return "󰤟"
					}
					else return "󰤯"
				}
			}
		}

		Item {
			height: parent.height
			width: parent.width - parent.height

			Text {
				anchors.fill: parent
				anchors.rightMargin: Style.popoutDefaultMargin

				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter
				rightPadding: Style.popoutDefaultMargin

				font.family: Style.fontFamily
				minimumPixelSize: 6
				font.pixelSize: Style.popoutFontSize
				fontSizeMode: Text.Fit

				color: root.textColor

				text: activeSSIDShort
			}
		}
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true

		onEntered: root.hovered = true
		onExited: root.hovered = false

		propagateComposedEvents: true

		cursorShape: Qt.PointingHandCursor

		onClicked: Network.toggleWifi()
	}
}
