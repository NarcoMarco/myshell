pragma ComponentBehavior: Bound

import qs.bar.widgets
import qs.singletons
import qs.popouts.quickpanel

import QtQuick

Rectangle {
	id: root

	property bool hovered: false

	implicitWidth: content.width + 2 * Style.defaultMargin
	implicitHeight: Style.widgetHeight

	radius: Style.defaultRadius
	color: root.hovered
		? Style.hoverColor
		: Style.bgColor

	Row {
		id: content
		anchors.centerIn: parent

		BarBrightness {}
		Volume {}
		Battery {}
	}

	MouseArea {
		anchors.fill: parent

		hoverEnabled: true

		cursorShape: Qt.PointingHandCursor

		onEntered: root.hovered = true
		onExited: root.hovered = false

		onClicked: quickpanel.toggle()
	}
	
	Quickpanel {
		id: quickpanel
	}
}
