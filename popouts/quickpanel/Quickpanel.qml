import qs.singletons
import qs.popouts
import qs.popouts.quickpanel

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

PopoutBase {
	anchorRight: true
	anchorTop: true
	anchorBottom: true

	animateRight: true

	enableFocus: true

	panelContent: Rectangle {
		id: contentPlane

		property int widgetWidth: contentPlane.width / 2 - Style.popoutDefaultMargin * 2

		MarginWrapperManager { 
			margin: Style.popoutDefaultMargin * 2
		}

		anchors {
			fill: parent
		}

		color: Style.barColor

		topLeftRadius: Style.popoutDefaultRadius
		bottomLeftRadius: Style.popoutDefaultRadius

		ColumnLayout {
			id: columnRoot
			anchors.horizontalCenter: parent.horizontalCenter

			spacing: Style.popoutDefaultMargin * 2

			BatteryDetails {}

			GridLayout {
				id: buttonGrid
				
				Layout.alignment: Qt.AlignHCenter

				columnSpacing: Style.popoutDefaultMargin
				rowSpacing: Style.popoutDefaultMargin 

				columns: 2

				WifiToggle {
					widgetWidth: contentPlane.widgetWidth
					widgetHeight: Style.popoutWidgetHeight
				}

				BluetoothToggle {
					widgetWidth: contentPlane.widgetWidth
					widgetHeight: Style.popoutWidgetHeight
				}

				PowerModeToggle {
					widgetWidth: contentPlane.widgetWidth
					widgetHeight: Style.popoutWidgetHeight
				}
			}

			VolumeSlider {}

			BrightnessSlider {}

			QuickpanelTabBar {
				id: tabs
				onCurrentIndexChanged: swipeview.setCurrentIndex(currentIndex)
			}

			SwipeView {
				id: swipeview

				Layout.fillWidth: true
				Layout.fillHeight: true

				currentIndex: tabs.currentIndex
				onCurrentIndexChanged: tabs.setCurrentIndex(currentIndex)
				spacing: Style.popoutDefaultMargin

				NotifCenter {}

				WifiControl {}

				BluetoothControl {}

				AudioMixer {}
			}
		}
	}
}
