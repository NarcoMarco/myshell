pragma ComponentBehavior: Bound

import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Loader {
	id: loaderRoot

	property bool popupOpen: false
	property bool popupClosing: false
	property Component panelContent: null

	property real panelWidth: Style.popoutWidgetWidth + Style.popoutDefaultMargin
	property real panelHeight: screen.height - Style.barHeight

	property bool anchorRight: false
	property bool anchorLeft: false
	property bool anchorTop: false
	property bool anchorBottom: false

	property bool animateRight: false
	property bool animateLeft: false
	property bool animateTop: false
	property bool animateBottom: false

	property int animDuration: Style.defaultAnimDuration
	property int panelEasingType: Style.defaultAnimation

	active: popupOpen || popupClosing

	function toggle(): void {
		if (!popupOpen) {
			popupOpen = true
			popupClosing = false
		} else if (loaderRoot.item){
			item.closing = true
			item.opened = false
			popupClosing = true
		}
	}

	sourceComponent: PanelWindow {
		id: root

		WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

		HyprlandFocusGrab {
			id: focusGrab
			active: true
			windows: [root]
			onCleared: loaderRoot.toggle()
		}

		visible: true

		property bool closing: false
		property bool opened: false
		
		anchors {
			right: loaderRoot.anchorRight ? true : false
			left: loaderRoot.anchorLeft ? true : false
			top: loaderRoot.anchorTop ? true : false
			bottom: loaderRoot.anchorBottom ? true : false
		}

		exclusiveZone: 0

		implicitWidth: loaderRoot.panelWidth
		implicitHeight: loaderRoot.panelHeight
		
		color: "transparent"

		property real animRight: {
			if (!loaderRoot.animateRight) return 0
			else opened && loaderRoot.anchorRight ? 0 : -implicitWidth
		}
		property real animLeft: {
			if (!loaderRoot.animateLeft) return 0
			else opened && loaderRoot.anchorLeft ? 0 : -implicitWidth
		}
		property real animTop: {
			if (!loaderRoot.animateTop) return 0
			else opened && loaderRoot.anchorTop ? 0 : -implicitWidth
		}
		property real animBottom: {
			if (!loaderRoot.animateBottom) return 0
			else opened && loaderRoot.anchorBottom ? 0 : -implicitWidth
		}

		margins {
			right: animRight
			left: animLeft
			top: animTop
			bottom: animBottom
		}

		Loader {
			id: contentLoader
			anchors.fill: parent
			sourceComponent: loaderRoot.panelContent
		}


		Behavior on animRight {
			enabled: loaderRoot.animateRight
			NumberAnimation {
				duration: loaderRoot.animDuration
				easing.type: loaderRoot.panelEasingType
				onRunningChanged: {
					if (!running && root.closing) {
						root.close()
					}
				}
			}
		}

		Behavior on animLeft {
			enabled: loaderRoot.animateLeft
			NumberAnimation {
				duration: loaderRoot.animDuration
				easing.type: loaderRoot.panelEasingType
				onRunningChanged: {
					if (!running && root.closing) {
						root.close()
					}
				}
			}
		}
		Behavior on animTop {
			enabled: loaderRoot.animateTop
			NumberAnimation {
				duration: loaderRoot.animDuration
				easing.type: loaderRoot.panelEasingType
				onRunningChanged: {
					if (!running && root.closing) {
						root.close()
					}
				}
			}
		}

		Behavior on animBottom {
			enabled: loaderRoot.animateBottom
			NumberAnimation {
				duration: loaderRoot.animDuration
				easing.type: loaderRoot.panelEasingType
				onRunningChanged: {
					if (!running && root.closing) {
						root.close()
					}
				}
			}
		}

		Component.onCompleted: opened = true

		signal close()

		onClose: {
			loaderRoot.popupOpen = false
			loaderRoot.popupClosing = false
		}
	}
}
