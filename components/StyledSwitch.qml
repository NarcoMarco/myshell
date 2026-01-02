import qs.singletons

import QtQuick
import QtQuick.Controls

Switch {
	id: control
	padding: 0

	required property real toggleHeight 

	indicator: Rectangle {
		implicitHeight: control.toggleHeight
		implicitWidth: height * 2
		radius: height / 2
		color: control.checked ? Style.fgColor : Style.inactiveColor

		Rectangle {
			x: control.checked ? parent.width - width - anchors.margins : anchors.margins

			anchors {
				top: parent.top
				bottom: parent.bottom
				margins: Style.defaultMargin / 2
			}

			implicitWidth: height
			radius: height / 2
			color: Style.bgColor

			Behavior on x {
				NumberAnimation {
					duration: Style.defaultAnimDuration
					easing.type: Style.defaultAnimation
				}
			}
		}

		Behavior on color {
			ColorAnimation {
				duration: Style.defaultAnimDuration
				easing.type: Style.defaultAnimation
			}
		}
	}
}
