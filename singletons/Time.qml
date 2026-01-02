pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	readonly property string time: {
		Qt.formatDateTime(clock.date, "ddd dd MMM HH:mm")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
