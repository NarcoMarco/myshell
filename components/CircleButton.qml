import qs.singletons

import QtQuick
import QtQuick.Controls

Button {
	id: button

	required property int implicitSize

	property color color: Style.fgColor
	property color textColor: Style.bgColor

	implicitWidth: implicitSize
	implicitHeight: implicitSize

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

			horizontalAlignment: Text.AlignHCenter

			font.family: Style.fontFamily
			font.pixelSize: button.implicitSize

			color: button.textColor

			text: button.text
		}
	}
}
