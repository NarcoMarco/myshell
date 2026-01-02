import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland

Rectangle {
	id: root

	readonly property Toplevel topLevel: ToplevelManager.activeToplevel

	readonly property DesktopEntry activeEntry: DesktopEntries.byId(topLevel?.appId)
	
	readonly property string activeWindowTitle: {
		if (topLevel?.activated) {
			return activeEntry ? activeEntry.name : activeWindowTitle
		} else {
			return "Desktop"
		}	
	}

	readonly property string iconSource: {
		if (topLevel?.activated) {
			return activeEntry ? Quickshell.iconPath(root.activeEntry.icon) : iconSource
		} else {
			return Quickshell.iconPath("desktop")
		}
	}

	MarginWrapperManager {
		rightMargin: 2 * Style.defaultMargin
		leftMargin: 2 * Style.defaultMargin
		implicitHeight: Style.widgetHeight
	}

	radius: Style.defaultRadius
	color: Style.bgColor

	Row {
		anchors.centerIn: parent
		spacing: Style.defaultMargin

		IconImage {
			anchors.verticalCenter: parent.verticalCenter

			implicitSize: Style.iconHeight

			source: root.iconSource
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize

			text: "|"
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize

			text: root.activeWindowTitle
		}
	}
}
