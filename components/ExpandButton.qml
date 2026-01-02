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
		Text {
			anchors.centerIn: parent
			padding: 0

			font.family: Style.fontFamily
			font.pixelSize: button.implicitSize

			color: button.textColor

			text: button.text
		}
	}
}
