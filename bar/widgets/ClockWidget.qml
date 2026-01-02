import qs.singletons

import QtQuick

Rectangle {
	color: Style.bgColor
	radius: Style.defaultRadius
	implicitWidth: timeText.width + 6 * Style.defaultMargin
	implicitHeight: Style.widgetHeight

	Text {
		id: timeText

		anchors.centerIn: parent
		color: Style.textColor
		font.family: Style.fontFamily
		font.pixelSize: Style.fontSize
		font.weight: Font.Bold

		text: Time.time
	}
}
