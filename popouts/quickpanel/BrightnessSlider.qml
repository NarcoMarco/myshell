import qs.singletons

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
	id: root

	Layout.fillWidth: true

	implicitHeight: Style.popoutWidgetHeight

	RowLayout {
		anchors.fill: parent

		Rectangle {
			id: volumeIcon

			property bool hovered: false

			Layout.alignment: Qt.AlignLeft

			implicitHeight: Style.popoutWidgetHeight
			implicitWidth: Style.popoutWidgetHeight

			radius: height / 2

			color: hovered ? Style.hoverColor : Style.bgColor

			Text {
				id: iconText
				anchors.fill: parent

				verticalAlignment: Text.AlignVCenter
				horizontalAlignment: Text.AlignHCenter

				rightPadding: font.pixelSize * 0.35

				color: Style.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize * 1.2
				font.weight: Font.DemiBold

				text: "󰃞"
			}
		}

		Slider {
			id: control
			Layout.fillWidth: true
			Layout.preferredHeight: Style.popoutWidgetHeight / 2
			from: 0
			value: Brightness.percent
			to: 100
			onMoved: Brightness.setPercent(valueAt(position))

			leftPadding: Style.popoutDefaultMargin
			rightPadding: 0
			topPadding: 0
			bottomPadding: 0

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
					width: control.visualPosition * parent.width
					height: parent.height
					radius: height / 2
					color: {
						if (control.pressed) return Style.clickedColor
						else if (hoverHandler.hovered) return Style.hoverColor
						else return Style.fgColor
					}
				}
			}

			handle: Rectangle {
				id: handleRoot

				x: control.leftPadding + control.visualPosition * (control.availableWidth - height)
				y: control.topPadding + control.availableHeight / 2 - height / 2

				implicitWidth: Style.popoutWidgetHeight / 2
				implicitHeight: Style.popoutWidgetHeight / 2

				radius: height / 2
				// color: control.pressed ? Style.hoverColor : Style.fgColor
				color: {
					if (control.pressed) return Style.clickedColor
					else if (hoverHandler.hovered) return Style.hoverColor
					else return Style.fgColor
				}
			}
			HoverHandler {
				id: hoverHandler
				cursorShape: Qt.PointingHandCursor
			}
		}

		Rectangle {
			Layout.alignment: Qt.AlignLeft

			implicitHeight: Style.popoutWidgetHeight
			implicitWidth: 1.5 * Style.popoutWidgetHeight
			// implicitWidth: percentText.implicitWidth + 2 * Style.popoutDefaultMargin

			radius: height / 2

			color: Style.bgColor

			Text {
				id: percentText
				anchors.centerIn: parent

				color: Style.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize

				text: Brightness.percent + "%"
			}
		}
	}
}
