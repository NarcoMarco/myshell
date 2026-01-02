import qs.singletons

import QtQuick
import Quickshell.Hyprland
import Quickshell.Widgets

Rectangle {

	MarginWrapperManager { 
		rightMargin: Style.defaultMargin 
		leftMargin: Style.defaultMargin 
		implicitHeight: Style.widgetHeight
	}

	radius: Style.defaultRadius
	color: Style.bgColor

	Row {
		id: workspaces
		spacing: Style.defaultMargin
		anchors.centerIn: parent

		Repeater {
			model: Hyprland.workspaces

			Rectangle {
				id: workspace
				required property var modelData

				radius: Style.defaultRadius

				property bool hovered: false

				color: hovered
						? Style.hoverColor
						: (modelData.focused ? Style.textColor : Style.bgColor)

				implicitWidth: label.implicitWidth + 2 * Style.defaultMargin
				implicitHeight: Style.widgetHeight * 0.8

				anchors.verticalCenter: parent.verticalCenter

				Text {
					id: label

					text: workspace.modelData.id
					anchors.centerIn: parent
					color: workspace.modelData.focused
						? Style.bgColor
						: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.fontSize
					font.weight: Font.Bold
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					cursorShape: Qt.PointingHandCursor

					onClicked: {
						workspace.modelData.activate()
					}

					onEntered: workspace.hovered = true
					onExited: workspace.hovered = false
				}
			}
		}
	}
}
