import qs.singletons

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

TabButton {
	id: buttonRoot

	implicitHeight: parent.height
	implicitWidth: Math.max(icon.width, label.width)

	background: null

	required property string textIcon

	readonly property bool current: TabBar.tabBar.currentItem == this

	HoverHandler {
		cursorShape: Qt.PointingHandCursor
	}


	
	contentItem: Rectangle {
		anchors {
			fill: parent
		}
		width: parent.width
		height: parent.height
		color: "transparent"

		Text {
			id: icon
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.bottom: label.top

			width: parent.width

			horizontalAlignment: Text.AlignHCenter


			color: buttonRoot.current ? Style.textColor : Style.inactiveColor

			font.family: Style.fontFamily
			font.pixelSize: Style.popoutFontSize * 2
			font.weight: Font.DemiBold
			fontSizeMode: Text.Fit
			minimumPixelSize: 6


			text: buttonRoot.textIcon
		}

		Text {
			id: label
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom: parent.bottom

			width: parent.width

			height: parent.height * 0.4

			horizontalAlignment: Text.AlignHCenter

			color: buttonRoot.current ? Style.textColor : Style.inactiveColor

			font.family: Style.fontFamily
			font.pixelSize: Style.popoutFontSize
			// font.weight: Font.DemiBold
			fontSizeMode: Text.Fit
			minimumPixelSize: 6

			text: buttonRoot.text
		}
	}
}
