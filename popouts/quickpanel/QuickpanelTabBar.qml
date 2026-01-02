import qs.singletons
import qs.components

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
	id: root

	// anchors {
	// 	left: parent.left
	// 	right: parent.right
	// }
	
	Layout.fillWidth: true

	height: Style.popoutWidgetHeight * 1.5 + indicator.implicitHeight

	property alias currentIndex: bar.currentIndex

	function setCurrentIndex(index: int): void {
		bar.setCurrentIndex(index)
	}

	TabBar {
		id: bar

		anchors {
			left: parent.left
			right: parent.right
		}

		height: parent.height

		background: null

		Tab {
			text: "Alerts"
			textIcon: "󰂚"
		}

		Tab {
			text: "Wi-Fi"
			textIcon: "󰖩"
		}

		Tab {
			text: "BT"
			textIcon: "󰂯"
		}

		Tab {
			text: "Mixer"
			textIcon: "󰓃"
		}
	}

	Rectangle {
		id: indicator

		anchors.top: bar.bottom

		implicitWidth: bar.currentItem.implicitWidth
		implicitHeight: Style.tabIndicatorHeight

		x: {
			const tab = bar.currentItem
			return width * tab.TabBar.index + (width - tab.implicitWidth) / 2
		}

		Behavior on x {
			NumberAnimation {
				duration: Style.defaultAnimDuration
				easing.type: Style.defaultAnimation
			}
		}

		radius: height / 2

		color: Style.fgColor
	}
}
