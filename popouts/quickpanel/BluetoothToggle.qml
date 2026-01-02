import qs.singletons

import QtQuick
import Quickshell.Bluetooth

Rectangle {
	id: root

	required property int widgetHeight
	required property int widgetWidth

	property bool hovered: false

	readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter

	property bool btEnabled: adapter ? adapter.enabled : null

	readonly property int numConnected: adapter ? adapter.devices.values.filter(d => d.connected).length : 0

	readonly property string statusText: {
		if (numConnected > 0) {
			return "Connected (" + numConnected + ")"
		} else {
			return "Bluetooth"
		}
	}

	readonly property color textColor: btEnabled ? Style.bgColor : Style.textColor
	
	implicitWidth: widgetWidth
	implicitHeight: widgetHeight

	radius: height / 2
	color: {
		if (hovered) return Style.hoverColor
		else if (btEnabled) return Style.fgColor
		else return Style.disabledColor
	}

	Row {
		spacing: Style.defaultMargin
		anchors.centerIn: parent
		height: parent.height
		width: parent.width

		Item {
			width: parent.height
			height: parent.height

			Text {
				anchors.centerIn: parent

				font.family: Style.fontFamily
				minimumPixelSize: 6
				font.pixelSize: Style.popoutFontSize
				fontSizeMode: Text.Fit
				font.weight: Font.DemiBold

				color: root.textColor

				text: root.btEnabled ? "󰂯" : "󰂲"
			}
		}

		Item {
			height: parent.height
			width: parent.width - parent.height

			Text {
				anchors.fill: parent
				anchors.rightMargin: Style.popoutDefaultMargin

				verticalAlignment: Text.AlignVCenter

				font.family: Style.fontFamily
				minimumPixelSize: 6
				font.pixelSize: Style.popoutFontSize
				fontSizeMode: Text.Fit

				color: root.textColor

				text: root.statusText
			}
		}
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true

		onEntered: root.hovered = true
		onExited: root.hovered = false

		cursorShape: Qt.PointingHandCursor

		propagateComposedEvents: true

		onClicked: root.adapter.enabled = !root.adapter.enabled
	}
}
