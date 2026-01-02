import qs.singletons

import QtQuick
import QtQuick.Controls

ToolTip {
	id: control
	delay: Style.tooltipDelay

	contentItem: Text {
		font.family: Style.fontFamily
		font.pixelSize: Style.tooltipFontSize

		color: Style.textColor

		text: control.text
	}

	background: Rectangle {
		radius: height / 2
		color: Style.bgColor
	}
}
