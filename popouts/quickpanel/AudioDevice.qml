import qs.singletons
import qs.components

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire


Item {
	id: root

	required property PwNode device

	// readonly property string description: device ? device.description : ""
	
	readonly property string description: {
		if (device?.isStream) {
			return device.name
		} else {
			return device.description
		}
	}

	readonly property string descriptionShort: {
		if (description.length > Style.maxWifiLength * 2) {
			return description.slice(0, Style.maxWifiLength * 2) + "…"
		} else {
			return description
		}
	}

	property real volume: {
		if (device && device.audio) {
			return device.audio.volume * 100
		} else return 0
	}

	property bool hovered: false

	implicitHeight: content.implicitHeight + Style.popoutDefaultMargin

	// color: hovered ? Style.hoverColor : Style.bgColor

	// radius: height / 2

	ColumnLayout {
		id: content

		anchors {
			top: parent.top
			right: parent.right
			left: parent.left

			leftMargin: Style.popoutDefaultMargin * 2
			rightMargin: Style.popoutDefaultMargin * 2
		}

		spacing: Style.popoutDefaultMargin

		RowLayout {

			Text {
				Layout.alignment: Qt.AlignLeft

				verticalAlignment: Text.AlignVCenter

				color: Style.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize
				font.weight: Font.DemiBold

				text: root.descriptionShort
			}

			Item {
				Layout.fillWidth: true
			}

			Rectangle {
				id: activeIcon

				visible: !root.device.isStream

				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

				implicitHeight: Style.popoutWidgetHeight - 2 * Style.popoutDefaultMargin
				implicitWidth: height

				radius: height / 2

				property bool hovered: false

				color: {
					if (hovered) {
						return Style.hoverColor
					} else if (device == Pipewire.defaultAudioSink || device == Pipewire.defaultAudioSource) {
						return Style.fgColor
					} else {
						return Style.bgColor
					}
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onEntered: activeIcon.hovered = true
					onExited: activeIcon.hovered = false

					onClicked: Audio.setDefault(root.device)
				}
			}
		}

		RowLayout {
			Layout.fillWidth: true

			spacing: Style.popoutDefaultMargin

			Rectangle {
				id: volumeIcon

				property bool hovered: false

				Layout.alignment: Qt.AlignLeft

				implicitHeight: Style.popoutWidgetHeight
				implicitWidth: Style.popoutWidgetHeight

				radius: height / 2

				color: hovered ? Style.hoverColor : Style.bgColor

				Text {
					id: iconText
					anchors.centerIn: parent

					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize * 1.2
					font.weight: Font.DemiBold

					text: {
						if (root.device.audio.muted == true) return "󰝟"
						if (root.device.audio.volume > 0.70) return "󰕾" 
						if (root.device.audio.volume > 0.30) return "󰖀" 
						if (root.device.audio.volume >= 0.0) return "󰕿" 
						else return "󰕿"
					}
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onEntered: volumeIcon.hovered = true
					onExited: volumeIcon.hovered = false

					cursorShape: Qt.PointingHandCursor

					onClicked: Audio.toggleNodeMute(root.device)
				}
			}

			StyledSlider {
				Layout.fillWidth: true
				Layout.preferredHeight: Style.popoutWidgetHeight / 2

				from: 0
				to: 100
				value: root.volume
				onMoved: Audio.setNodeVolume(root.device, valueAt(position))
			}

			Rectangle {
				Layout.alignment: Qt.AlignLeft

				implicitHeight: Style.popoutWidgetHeight
				implicitWidth: 1.5 * Style.popoutWidgetHeight
				// implicitWidth: percentText.implicitWidth + 2 * Style.popoutDefaultMargin

				radius: height / 2

				color: Style.bgColor

				Text {
					id: percentText
					anchors.centerIn: parent

					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: Math.round(root.volume) + "%"
				}
			}
		}
	}
}
