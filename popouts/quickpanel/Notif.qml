pragma ComponentBehavior: Bound
import qs.singletons
import qs.components

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications


MouseArea {
	id: root

	required property Notification notif

	property bool expanded

	property bool dismissing: false

	Layout.fillWidth: parent

	implicitHeight: content.height

	onClicked: print(y)
	
	function dismiss() {
		Qt.callLater(() => {
			root.notif.dismiss()
		})
		removeAnimation.start()
	}

	SequentialAnimation {
		id: removeAnimation

		PropertyAction {
			target: root
			property: "ListView.delayRemove"
			value: true
		}
		NumberAnimation {
			target: root
			property: "x"
			to: root.width
			duration: Style.defaultAnimDuration
			easing.type: Style.defaultAnimation
		}
		PropertyAction {
			target: root
			property: "ListView.delayRemove"
			value: false
		}
	}
	
	property real dragDismissThreshold: 100

	drag {
		axis: Drag.XAxis
		target: content
		minimumX: 0
		onActiveChanged: {
			if (drag.active) {
				return
			}
			if (content.x > root.dragDismissThreshold) {
				root.dismiss()
			} else {
				content.x = 0
			}
		}
	}

	Rectangle {
		id: content

		width: root.width

		implicitHeight: Math.max(contentColumn.implicitHeight, imageLoader.height) + Style.popoutDefaultMargin * 2


		color: Style.bgColor

		radius: (Style.popoutWidgetHeight * 1.25 + 2 * Style.popoutDefaultMargin) / 2
		
		Loader {
			id: imageLoader
			anchors {
				top: parent.top
				left: parent.left
				margins: Style.popoutDefaultMargin
			}

			active: root.notif.image != ""

			sourceComponent: IconImage {

				implicitSize: Style.popoutWidgetHeight * 1.25

				source: root.notif.image
			}
		}

		ColumnLayout {
			id: contentColumn

			anchors {
				top: parent.top
				left: imageLoader.right
				right: parent.right
				margins: Style.popoutDefaultMargin
				rightMargin: anchors.margins * 2
			}

			spacing: Style.popoutDefaultMargin * 0.2

			RowLayout {
				Layout.fillWidth: true

				Text {
					Layout.fillWidth: true

					horizontalAlignment: Text.AlignLeft
					verticalAlignment: Text.AlignTop

					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize
					font.weight: Font.DemiBold

					text: root.notif.summary
				}

				ExpandButton {
					// implicitWidth: Style.popoutWidgetHeight * 0.5
					// implicitHeight: Style.popoutWidgetHeight * 0.5
					implicitSize: Style.popoutWidgetHeight * 0.5

					property bool expandHovered: false

					// color: expandHovered ? Style.hoverColor: Style.fgColor
					text: root.expanded ? "󰅀" : "󰅂"

					onClicked: root.expanded = !root.expanded
				}
			}

			Text {
				Layout.fillWidth: true

				horizontalAlignment: Text.AlignLeft

				color: Style.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize * .75

				elide: Text.ElideRight
				wrapMode: Text.WordWrap

				maximumLineCount: root.expanded ? 100 : 1

				text: root.notif.body
			}

			RowLayout {
				Layout.fillWidth: true

				Layout.topMargin: Style.popoutDefaultMargin

				visible: root.expanded && root.notif.actions.length > 0

				Repeater {
					model: root.notif.actions

					Button {
						id: actionButton
						required property var modelData

						Layout.fillWidth: true

						text: modelData.text

						onClicked: modelData.invoke()

						HoverHandler {
							id: actButHover
							enabled: true
							cursorShape: Qt.PointingHandCursor
						}

						background: Rectangle {
							anchors.fill: parent

							color: actButHover.hovered ? Style.hoverColor : Style.fgColor
							radius: height / 2
						}

						contentItem: Text {
							anchors.centerIn: parent

							horizontalAlignment: Text.AlignHCenter

							font.family: Style.fontFamily
							font.pixelSize: Style.popoutFontSize
							font.weight: Font.DemiBold

							color: Style.bgColor

							text: actionButton.text
						}
					}
				}
			}
		}
	}
}
