import qs.singletons

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

Item {
	id: root
	
	Layout.fillWidth: true
	Layout.leftMargin: Style.popoutDefaultMargin / 2
	Layout.rightMargin: Style.popoutDefaultMargin / 2
	
	implicitHeight: Style.popoutWidgetHeight * 0.75

	readonly property UPowerDevice battery: UPower.displayDevice

	readonly property color textColor: {
		if (battery.state == UPowerDeviceState.Charging) return Style.textColor
		if (battery.percentage > 0.15) return Style.textColor
		if (battery.percentage <= 0.15) return Style.warningColor
	}

	readonly property string batTime: {
		if (battery.state === UPowerDeviceState.Charging) {
			return "Time to Full: " + formatTime(battery.timeToFull)
		} else {
			return "Time to Empty: " + formatTime(battery.timeToEmpty)
		}
	}

	function formatTime(seconds) {
		if (seconds <= 0 || seconds === undefined)
			return "Calculating…"

		const hours = Math.floor(seconds / 3600)
		const minutes = Math.floor((seconds % 3600) / 60)

		const mm = minutes.toString().padStart(2, "0")
		return hours + ":" + mm
	}

	RowLayout {
		anchors.fill: parent

		Row {
			Layout.alignment: Qt.AlignLeft

			spacing: Style.defaultMargin

			Text {
				anchors.verticalCenter: parent.verticalCenter

				color: root.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize * 0.75

				text: root.batTime
			}
		}

		Text {
			Layout.alignment: Qt.AlignHCenter

			color: root.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.popoutFontSize * 0.75

			text: root.battery.changeRate + "W"
		}

		Row {
			id: batText

			Layout.alignment: Qt.AlignRight

			spacing: Style.defaultMargin

			Text {
				anchors.verticalCenter: parent.verticalCenter

				color: root.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize
				font.weight: Font.DemiBold

				text: Math.round(root.battery.percentage * 100, 0) + "%"
			}

			// Add Icons
			Text {
				anchors.verticalCenter: parent.verticalCenter

				color: root.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize

				text: {
					if (root.battery.state == UPowerDeviceState.Charging) return "󰂄"
					if (root.battery.percentage > 0.90) return "󰁹" 
					if (root.battery.percentage > 0.80) return "󰂂" 
					if (root.battery.percentage > 0.70) return "󰂁" 
					if (root.battery.percentage > 0.60) return "󰂀" 
					if (root.battery.percentage > 0.50) return "󰁿" 
					if (root.battery.percentage > 0.40) return "󰁾" 
					if (root.battery.percentage > 0.30) return "󰁽" 
					if (root.battery.percentage > 0.20) return "󰁼" 
					if (root.battery.percentage > 0.10) return "󰁻" 
					if (root.battery.percentage > 0.0) return "󰂃" 
				}
			}
		}
	}
}
