import qs.singletons
import qs.components

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth


Rectangle {
	id: root
	implicitHeight: Style.popoutWidgetHeight

	required property BluetoothDevice device

	readonly property bool connected: device ? device.connected : false

	readonly property bool paired: device ? device.paired : false

	readonly property bool bonded: device ? device.bonded : false

	readonly property bool trusted: device ? device.trusted : false

	readonly property bool batteryAvailable: device ? device.batteryAvailable : false

	readonly property int batteryPercent: device.batteryAvailable ? Math.round(device.battery * 100) : 0

	readonly property string name: device ? device.name : "Bluetooth Device"

	readonly property string nameShort: {
		if (name.length > Style.maxWifiLength * 2) {
			return name.slice(0, Style.maxWifiLength * 2) + "…"
		} else {
			return name
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

			text: root.nameShort
		}

		Item {
			Layout.fillWidth: true
		}

		RowLayout {
			Layout.alignment: Qt.AlignRight
			Layout.preferredHeight: parent.height

			Text {
				id: connectedIcon

				property bool hovered: false

				verticalAlignment: Text.AlignVCenter

				visible: root.paired

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize
				font.weight: Font.DemiBold

				color: hovered ? Style.hoverColor : Style.fgColor

				text: root.connected ? "󰚥" : "󱐤"

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					cursorShape: Qt.PointingHandCursor

					StyledToolTip {
						text: root.connected ? "Disconnect" : "Connect"
						visible: parent.containsMouse
					}

					onEntered: connectedIcon.hovered = true
					onExited: connectedIcon.hovered = false

					onClicked: root.connected ? root.device.disconnect() : root.device.connect()
				}
			}

			Text {
				id: trustedIcon

				property bool hovered: false

				verticalAlignment: Text.AlignVCenter

				visible: root.paired

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize
				font.weight: Font.DemiBold

				color: hovered ? Style.hoverColor : Style.fgColor

				text: root.trusted ? "󱈘" : "󱖡"

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					cursorShape: Qt.PointingHandCursor

					StyledToolTip {
						text: root.trusted ? "Distrust" : "Trust"
						visible: parent.containsMouse
					}

					onEntered: trustedIcon.hovered = true
					onExited: trustedIcon.hovered = false

					onClicked: root.device.trusted = !root.trusted
				}
			}

			Text {
				id: pairIcon

				property bool hovered: false

				verticalAlignment: Text.AlignVCenter

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize
				font.weight: Font.DemiBold

				color: hovered ? Style.hoverColor : Style.fgColor

				text: root.paired ? "󰩺" : "󱐤"

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					cursorShape: Qt.PointingHandCursor

					StyledToolTip {
						text: root.paired ? "Unpair" : "Pair"
						visible: parent.containsMouse
					}

					onEntered: pairIcon.hovered = true
					onExited: pairIcon.hovered = false

					onClicked: root.paired ? root.device.forget() : root.device.pair()
				}
			}

			IconImage {
				implicitSize: parent.height - Style.popoutDefaultMargin

				visible: !root.batteryAvailable

				source: Quickshell.iconPath(root.device.icon)
			}

			Text {
				visible: root.batteryAvailable

				Layout.preferredWidth: parent.height - Style.popoutDefaultMargin

				horizontalAlignment: Text.AlignHCenter

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize * 1.2
				font.weight: Font.DemiBold

				color: Style.fgColor

				text: {
					if (root.batteryPercent > 90) return "󰁹" 
					if (root.batteryPercent > 80) return "󰂂" 
					if (root.batteryPercent > 70) return "󰂁" 
					if (root.batteryPercent > 60) return "󰂀" 
					if (root.batteryPercent > 50) return "󰁿" 
					if (root.batteryPercent > 40) return "󰁾" 
					if (root.batteryPercent > 30) return "󰁽" 
					if (root.batteryPercent > 20) return "󰁼" 
					if (root.batteryPercent > 10) return "󰁻" 
					if (root.batteryPercent > 0) return "󰂃" 
					return "󰁹"
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					StyledToolTip {
						visible: parent.containsMouse
						text: root.batteryPercent + "%"
					}
				}
			}
		}
	}
}
