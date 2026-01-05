import qs.singletons

import QtQuick
import QtQuick.Controls

Slider {
	id: control

	property color color: Style.fgColor

	background: Rectangle {
		x: control.leftPadding
		y: control.topPadding + control.availableHeight / 2 - height / 2
		implicitWidth: control.availableWidth
		implicitHeight: control.availableHeight * 0.5
		width: control.availableWidth
		height: implicitHeight
		radius: height / 2
		color: Style.disabledColor

		Rectangle {
			width: control.visualPosition * parent.width > height ? control.visualPosition * parent.width : height
			height: parent.height
			radius: height / 2
			color: {
				if (control.pressed) return Style.clickedColor
				else if (hoverHandler.hovered) return Style.hoverColor
				else return control.color
			}
		}
	}

	handle: Rectangle {
		id: handleRoot

		x: control.leftPadding + control.visualPosition * (control.availableWidth - height)
		y: control.topPadding + control.availableHeight / 2 - height / 2

		implicitHeight: control.availableHeight
		implicitWidth: control.availableHeight

		radius: height / 2
		color: {
			if (control.pressed) return Style.clickedColor
			else if (hoverHandler.hovered) return Style.hoverColor
			else return control.color
		}
	}
	HoverHandler {
		id: hoverHandler
		cursorShape: Qt.PointingHandCursor
	}
}
