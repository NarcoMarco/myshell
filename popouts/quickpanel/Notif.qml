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

	readonly property list<NotificationAction> actions: notif ? notif.actions : []

	readonly property string summary: notif ? notif.summary : ""

	readonly property string body: notif ? notif.body : ""

	readonly property string image: notif ? notif.image: ""

	readonly property bool critical: notif ? notif.urgency == NotificationUrgency.Critical : false

	property bool expanded: false

	property bool dismissing: false

	Layout.fillWidth: parent

	implicitHeight: content.height
	
	function dismiss() {
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
		onRunningChanged: {
			if (!running) {
				root.notif?.dismiss()
			}
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

			active: root.image != ""

			sourceComponent: IconImage {

				implicitSize: Style.popoutWidgetHeight * 1.25

				source: root.image
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

					color: root.critical ? Style.warningColor : Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize
					font.weight: Font.DemiBold

					text: root.summary
				}

				CircleButton {
					implicitSize: Style.popoutWidgetHeight * 0.5

					property bool expandHovered: false

					text: "󰅖"

					onClicked: root.dismiss()
				}
				
				CircleButton {
					implicitSize: Style.popoutWidgetHeight * 0.5

					property bool expandHovered: false

					text: root.expanded ? "󰅀" : "󰅂"

					onClicked: root.expanded = !root.expanded
				}
			}

			Item {
				id: bodyTextWrapper
				Layout.fillWidth: true
				Layout.rightMargin: Style.popoutDefaultMargin
				clip: true

				implicitHeight: root.expanded ? bodyText.implicitHeight : bodyText.lineHeight + 2 * Style.popoutDefaultMargin	

				Behavior on implicitHeight {
					NumberAnimation {
						duration: Style.defaultAnimDuration
						easing.type: root.expanded ? Style.inAnimation : Style.outAnimation
					}
				}

				Text {
					id: bodyText

					anchors.top: parent.top

					width: parent.width

					horizontalAlignment: Text.AlignLeft

					color: root.critical ? Style.warningColor : Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize * .75

					elide: Text.ElideRight
					wrapMode: Text.Wrap

					// maximumLineCount: root.expanded ? 100 : 1

					// clip: true

					text: root.body
				}
			}

			RowLayout {
				Layout.fillWidth: true

				Layout.topMargin: childrenRect.height > 0 ? Style.popoutDefaultMargin : 0
				Layout.margins: 0

				Repeater {
					model: root.actions ?? []

					Button {
						id: actionButton
						required property var modelData

						Layout.fillWidth: true

						text: modelData?.text

						onClicked: modelData.invoke()

						implicitHeight: root.expanded ? Style.popoutWidgetHeight * 0.75 : 0
						opacity: root.expanded ? 1 : 0

						Behavior on implicitHeight {
							NumberAnimation {
								duration: Style.defaultAnimDuration
								easing.type: root.expanded ? Style.outAnimation : Style.inAnimation
							}
						}

						Behavior on opacity {
							NumberAnimation {
								duration: Style.defaultAnimDuration
								easing.type: root.expanded ? Style.outAnimation : Style.inAnimation
							}
						}

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
							anchors.fill: parent

							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter

							font.family: Style.fontFamily
							font.pixelSize: Style.popoutFontSize
							font.weight: Font.DemiBold

							elide: Text.ElideRight

							color: Style.bgColor

							text: actionButton.text
						}

						HoverHandler {
							id: actionHover
							enabled: true
						}

						StyledToolTip {
							text: actionButton.text 
							visible: actionHover.hovered
						}
					}
				}
			}
		}
	}
}
