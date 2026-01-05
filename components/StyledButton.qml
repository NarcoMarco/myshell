import qs.singletons

import QtQuick
import QtQuick.Controls

Button {
	id: button

	property color color: Style.fgColor
	property color textColor: Style.bgColor

	HoverHandler {
		id: test
		enabled: true
		cursorShape: Qt.PointingHandCursor
	}

	background: Rectangle {
		radius: height / 2

		color: test.hovered ? Style.hoverColor : button.color  
	}

	contentItem: Item {
		implicitWidth:buttonText.width
		Text {
			id: buttonText
			anchors.centerIn: parent
			padding: 0
			leftPadding: 5
			rightPadding: 5

			horizontalAlignment: Text.AlignHCenter

			font.family: Style.fontFamily
			font.pixelSize: button.implicitSize

			color: button.textColor

			text: button.text
		}
	}
}
