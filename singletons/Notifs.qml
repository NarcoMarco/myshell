pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {

	readonly property ObjectModel notifs: server.trackedNotifications

	NotificationServer {
		id: server

		bodySupported: true
		imageSupported: true
		actionsSupported: true
		bodyMarkupSupported: true

		onNotification: notif => notif.tracked = true
	}
}
