import qs.singletons
import qs.components
import qs.popouts.quickpanel

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

Rectangle {
	radius: Style.popoutDefaultRadius
	color: Style.barColor

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

					text: "Wi-Fi: " + (Network.wifiEnabled ? "On" : "Off")
				}

				Item {
					Layout.fillWidth: true
				}

				StyledSwitch {
					id: control
					Layout.alignment: Qt.AlignRight

					toggleHeight: Style.popoutToggleHeight

					checked: Network.wifiEnabled
					onClicked: Network.toggleWifi()
				}
			}

			ColumnLayout {
				Layout.fillWidth: true
				visible: Network.active

				Text {
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Current Network"
				}

				WifiAccessPoint {
					Layout.fillWidth: true

					implicitHeight: Style.popoutWidgetHeight

					accessPoint: Network.active
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

							text: "Available Networks"
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
							font.pixelSize: Style.popoutFontSize * 1.2

							text: "󱍷"

							MouseArea {
								anchors.fill: parent
								hoverEnabled: true

								onEntered: refreshIcon.hovered = true
								onExited: refreshIcon.hovered = false

								cursorShape: Qt.PointingHandCursor

								onClicked: Network.rescanWifi()
							}
						}
					}
				}

				Repeater {
					model: Network.networks

					WifiAccessPoint {
						required property var modelData

						visible: modelData != Network.active

						Layout.fillWidth: true

						implicitHeight: Style.popoutWidgetHeight

						accessPoint: modelData
					}
				}
			}
		}
	}
}
