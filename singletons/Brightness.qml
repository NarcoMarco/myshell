pragma Singleton

import qs.singletons

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: brightness

    /// current brightness percentage (0–100)
    property int percent: 0

    /// update interval in ms
    property int interval: Style.brightnessUpdate

		function setPercent(value: int): void {
			value = Math.max(0, Math.min(100, value))
			setProc.command = ["brightnessctl", "set", value + "%"]
			setProc.running = true
		}

    Process {
      id: brightnessProc

      command: ["brightnessctl", "g"]
			running: true

      stdout: StdioCollector {
				onStreamFinished: {
					brightness.percent = Math.round(this.text * 100/255)
				}
      }
    }

		Process {
			id: setProc

			stdout: StdioCollector {
				onStreamFinished: brightnessProc.running = true
			}

			stderr: StdioCollector {
				onStreamFinished: {
					console.warn("brightnessctl error:", this.text)
					brightnessProc.running = true
				}
			}
		}

    Timer {
      interval: brightness.interval
      running: true
      repeat: true
      onTriggered: brightnessProc.running = true
    }

    // initial fetch
    Component.onCompleted: brightnessProc.running = true
}
