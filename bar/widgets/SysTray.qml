import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Rectangle {

	MarginWrapperManager { 
		rightMargin: 2 * Style.defaultMargin 
		leftMargin: 2 * Style.defaultMargin 
		implicitHeight: Style.widgetHeight
	}

	radius: Style.defaultRadius
	color: Style.bgColor

	Row {
		spacing: Style.defaultMargin
		anchors.centerIn: parent

		Repeater {
			model: SystemTray.items

			Rectangle {
				id: trayItem

				required property SystemTrayItem modelData

				implicitWidth: icon.width + Style.defaultMargin
				implicitHeight: Style.widgetHeight

				color: Style.bgColor
				radius: Style.defaultRadius

				IconImage {
					id: icon

					anchors.centerIn: parent
					
					implicitSize: Style.iconHeight

					source: trayItem.modelData.icon
				}
			}
		}
	}
}
