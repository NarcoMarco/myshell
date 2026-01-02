import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

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
		anchors.centerIn: parent

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize
			font.weight: Font.DemiBold

			text: "󰃠 "
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize
			font.weight: Font.DemiBold

			text: Brightness.percent + "%"
		}
	}
}
