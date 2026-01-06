pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
	id: root

	readonly property ObjectModel notifs: server.trackedNotifications

	property var popups: []

	property int popupTimeout: 5000

	NotificationServer {
		id: server

		bodySupported: true
		imageSupported: true
		actionsSupported: true
		bodyMarkupSupported: true

		onNotification: notif => {
			notif.tracked = true
			root.addPopup(notif)
		}
	}

	function clearNotifs() {
		const notifsCopy = [...server.trackedNotifications.values]
		notifsCopy.forEach((notif) => {
			removePopup(notif)
			notif.dismiss()
		})
	}

	function addPopup(notif) {
		popups = [notif, ...popups]

		Qt.callLater(() => {
			let t = Qt.createQmlObject(
				'import QtQuick; Timer { interval: ' + root.popupTimeout + '; running: true; repeat: false }',
				root
			)

			t.triggered.connect(() => removePopup(notif))
		})
	}

	function removePopup(notif) {
		if (notif._timer) {
			notif._timer.stop()
			notif._timer.destroy()
		}
		popups = popups.filter(n => n !== notif)
	}
}
