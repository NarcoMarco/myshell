pragma ComponentBehavior: Bound

import qs.singletons
import qs.components
import qs.popouts.quickpanel

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications

Rectangle {
	id: root
	radius: Style.popoutDefaultRadius
	color: Style.barColor

	ColumnLayout {
		anchors.fill: parent

		Item {
			Layout.fillWidth: true
			implicitHeight: Style.popoutWidgetHeight

			RowLayout {
				anchors.fill: parent
				Text {
					id: topText
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Notifications"
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

					text: "Clear"

					MouseArea {
						anchors.fill: parent
						hoverEnabled: true

						onEntered: refreshIcon.hovered = true
						onExited: refreshIcon.hovered = false

						cursorShape: Qt.PointingHandCursor

						onClicked: {
							Notifs.clearNotifs()
						}
					}
				}
			}
		}

		ListView {
			id: listView
			model: Notifs.notifs

			Layout.fillWidth: true
			Layout.fillHeight: true

			spacing: Style.popoutDefaultMargin

			boundsBehavior: Flickable.DragOverBounds

			clip: true

			delegate: Notif {
				required property var modelData

				// Layout.fillWidth: true
				width: ListView.view.width

				notif: modelData
			}


			displaced: Transition {
				NumberAnimation {
					property: "y"
					duration: Style.defaultAnimDuration
					easing.type: Style.defaultAnimation
				}
			}

			Text {
				anchors.centerIn: parent

				visible: Notifs.notifs.values.length == 0

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize

				color: Style.textColor

				text: "No Notifications"
			}
		}
	}
}
