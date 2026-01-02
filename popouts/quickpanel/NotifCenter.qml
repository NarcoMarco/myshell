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

			Text {
				color: Style.textColor

				font.family: Style.fontFamily
				font.pixelSize: Style.popoutFontSize

				text: "Notifications"
			}

			ListView {
				model: Notifs.notifs

				Layout.fillWidth: true

				implicitHeight: contentHeight

				spacing: Style.popoutDefaultMargin

				delegate: Notif {
					required property var modelData

					// Layout.fillWidth: true
					width: ListView.view.width

					notif: modelData
				}

				removeDisplaced: Transition {
					NumberAnimation {
						properties: "y"
						duration: Style.defaultAnimDuration
						easing.type: Style.defaultAnimation
					}
				}
			}
		}
	}
}
