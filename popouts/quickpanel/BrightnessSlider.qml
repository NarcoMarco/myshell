import qs.singletons
import qs.components

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
	id: root

	Layout.fillWidth: true

	implicitHeight: Style.popoutWidgetHeight

	RowLayout {
		anchors.fill: parent

		spacing: Style.popoutDefaultMargin

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

		StyledSlider {
			Layout.fillWidth: true
			Layout.preferredHeight: Style.popoutWidgetHeight / 2
			from: 0
			value: Brightness.percent
			to: 100
			onMoved: Brightness.setPercent(valueAt(position))
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
