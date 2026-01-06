pragma ComponentBehavior: Bound

import qs.singletons
import qs.components
import qs.popouts

import qs.popouts.quickpanel

import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

PopoutBase {
	id: notifPopup

	anchorRight: true
	anchorTop: true

	animateRight: true

	panelWidth: Style.popoutWidgetWidth * 0.75

	popupOpen: Notifs.popups.length > 0

	panelContent: Item {
		Rectangle {
			id: contentPlane
			anchors {
				top: parent.top
				right: parent.right
				left: parent.left
			}

			color: Style.barColor
			bottomLeftRadius: Style.popoutDefaultRadius

			implicitHeight: listView.contentHeight + 2 * Style.popoutDefaultMargin

			Behavior on implicitHeight {
				NumberAnimation {
					duration: Style.defaultAnimDuration
					easing.type: Style.defaultAnimation
				}
			}

			ListView {
				id: listView
				model: Notifs.popups

				anchors.fill: parent
				anchors.margins: Style.popoutDefaultMargin

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
			}
		}
	}
}
