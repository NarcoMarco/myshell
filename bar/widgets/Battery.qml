import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets

Loader {
	active: Style.enableBattery

	asynchronous: false

	sourceComponent: Item {
		id: root

		MarginWrapperManager { 
			rightMargin: Style.defaultMargin 
			leftMargin: Style.defaultMargin 
			implicitHeight: Style.widgetHeight
		}

		// radius: Style.defaultRadius
		// color: Style.bgColor

		readonly property UPowerDevice battery: UPower.displayDevice

		readonly property color textColor: {
			if (battery.state == UPowerDeviceState.Charging) return Style.textColor
			if (battery.percentage > 0.15) return Style.textColor
			if (battery.percentage <= 0.15) return Style.warningColor
		}

		Row {
			id: batText
			anchors.centerIn: parent
			spacing: Style.defaultMargin

			// Add Icons
			Text {
				anchors.verticalCenter: parent.verticalCenter

				color: root.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.fontSize

				text: {
					if (root.battery?.state == UPowerDeviceState.Charging) return "󰂄"
					if (root.battery?.percentage > 0.90) return "󰁹" 
					if (root.battery?.percentage > 0.80) return "󰂂" 
					if (root.battery?.percentage > 0.70) return "󰂁" 
					if (root.battery?.percentage > 0.60) return "󰂀" 
					if (root.battery?.percentage > 0.50) return "󰁿" 
					if (root.battery?.percentage > 0.40) return "󰁾" 
					if (root.battery?.percentage > 0.30) return "󰁽" 
					if (root.battery?.percentage > 0.20) return "󰁼" 
					if (root.battery?.percentage > 0.10) return "󰁻" 
					if (root.battery?.percentage > 0.0) return "󰂃" 
					else return "󰁹"
				}
			}

			Text {
				anchors.verticalCenter: parent.verticalCenter

				color: root.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.fontSize
				font.weight: Font.DemiBold

				text: Math.round(root.battery.percentage * 100, 0) + "%"
			}
		}
	}
}
