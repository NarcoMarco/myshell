import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
	id: root
	
	MarginWrapperManager {
		rightMargin: Style.defaultMargin
		leftMargin: Style.defaultMargin
		implicitHeight: Style.widgetHeight
	}

	// radius: Style.defaultRadius
	// color: Style.bgColor

	Row {
		// Add Icons

		anchors.centerIn: parent
		spacing: Style.defaultMargin

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize
			font.weight: Font.DemiBold

			text: {
				if (Audio.muted == true) return "󰝟"
				if (Audio.volume > 0.70) return "󰕾" 
				if (Audio.volume > 0.30) return "󰖀" 
				if (Audio.volume >= 0.0) return "󰕿" 
				else return "󰕿"
			}
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize
			font.weight: Font.DemiBold

			text: Math.round(Audio.volume * 100) + "%"
		}
	}
}
