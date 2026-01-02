import qs.singletons
import qs.components
import qs.popouts.quickpanel

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth

Rectangle {
	id: root
	radius: Style.popoutDefaultRadius
	color: Style.barColor

	readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter

	readonly property ObjectModel devices: adapter ? adapter.devices : null

	readonly property int numConnected: adapter ? devices.values.filter(d => d.connected).length : 0

	readonly property int numPaired: adapter ? devices.values.filter(d => d.paired).length : 0

	property bool btEnabled: adapter ? adapter.enabled : null

	property bool discovering: adapter ? adapter.discovering : false
	
	Flickable {
		id: scroll

		anchors.fill: parent
		clip: true

		// padding: Style.popoutDefaultMargin

		// contentWidth: availableWidth
		contentWidth: parent.width
		contentHeight: columnContent.implicitHeight

		flickableDirection: Flickable.VerticalFlick

		ColumnLayout {
			id: columnContent
			width: parent.width
					
			spacing: Style.popoutDefaultMargin * 2

			RowLayout {
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

				Text {
					Layout.alignment: Qt.AlignLeft

					verticalAlignment: Text.AlignVCenter

					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize
					font.weight: Font.DemiBold

					text: "Bluetooth: " + (root.btEnabled ? "On" : "Off")
				}

				Item {
					Layout.fillWidth: true
				}

				StyledSwitch {
					id: control
					Layout.alignment: Qt.AlignRight

					toggleHeight: Style.popoutToggleHeight

					checked: root.btEnabled
					onClicked: root.adapter.enabled = !root.adapter.enabled
				}
			}

			ColumnLayout {
				Layout.fillWidth: true
				visible: root.numConnected

				Text {
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Connected Devices"
				}

				Repeater {
					model: root.devices?.values.filter(d => d.connected)

					BTDevice {
						required property var modelData

						Layout.fillWidth: true

						implicitHeight: Style.popoutWidgetHeight

						device: modelData
					}
				}
			}

			ColumnLayout {
				Layout.fillWidth: true
				visible: root.numPaired

				Text {
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Paired Devices"
				}

				Repeater {
					model: root.devices?.values.filter(d => d.paired)

					BTDevice {
						required property var modelData

						Layout.fillWidth: true

						implicitHeight: Style.popoutWidgetHeight

						device: modelData
					}
				}
			}

			ColumnLayout {
				Layout.fillWidth: true
				visible: Network.wifiEnabled	

				Item {
					Layout.fillWidth: true
					implicitHeight: Style.popoutWidgetHeight

					RowLayout {
						anchors.fill: parent

						Text {
							Layout.alignment: Qt.AlignLeft

							verticalAlignment: Text.AlignVCenter

							color: Style.textColor

							font.family: Style.fontFamily
							font.pixelSize: Style.popoutFontSize

							text: "Available Devices"
						}

						Item { Layout.fillWidth: true }

						Text {
							id: refreshIcon

							Layout.alignment: Qt.AlignRight
							rightPadding: Style.popoutDefaultMargin

							property bool hovered: false

							color: if (Network.scanning) {
								Style.clickedColor
							} else hovered ? Style.hoverColor : Style.textColor

							font.family: Style.fontFamily
							font.pixelSize: Style.popoutFontSize

							text: (root.discovering ? "Stop" : "Scan")

							MouseArea {
								anchors.fill: parent
								hoverEnabled: true

								onEntered: refreshIcon.hovered = true
								onExited: refreshIcon.hovered = false

								cursorShape: Qt.PointingHandCursor

								onClicked: {
									root.adapter.discovering = !root.adapter.discovering
								}
							}
						}
					}
				}

				Repeater {
					model: root.devices?.values.filter(d =>
							!d.connected &&
							!d.paired &&
							d.name.replace(/-/g, ":") != d.address
					)

					BTDevice {
						required property var modelData

						Layout.fillWidth: true

						implicitHeight: Style.popoutWidgetHeight

						device: modelData
					}
				}
			}
		}
	}
}
