import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower

Rectangle {
	id: root

	required property int widgetHeight
	required property int widgetWidth

	property bool hovered: false

	readonly property int profile: PowerProfiles.profile

	implicitWidth: widgetWidth
	implicitHeight: widgetHeight

	readonly property color textColor: Style.bgColor

	radius: height / 2
	color: hovered ? Style.hoverColor : Style.fgColor

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
					if (root.profile == PowerProfile.PowerSaver) return "󰾆"
					if (root.profile == PowerProfile.Balanced) return "󰾅"
					if (root.profile == PowerProfile.Performance) return "󰓅"
					else return "󰾅"
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

				text: {
					if (root.profile == PowerProfile.PowerSaver) return "Power Saver"
					if (root.profile == PowerProfile.Balanced) return "Balanced"
					if (root.profile == PowerProfile.Performance) return "Performance"
					else return "󰾅"
				}
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

		onClicked: {
			if (root.profile == 2) PowerProfiles.profile = 0
			else PowerProfiles.profile += 1
		}
	}
}
