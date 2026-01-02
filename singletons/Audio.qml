pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
	id: audioRoot

	readonly property PwNode defaultNode: Pipewire.defaultAudioSink

	readonly property PwNodeAudio defaultAudio: defaultNode ? defaultNode.audio : null

	//bind node so we can read properties
	PwObjectTracker { objects: [ audioRoot.defaultNode ] }

	readonly property real volume: defaultAudio ? defaultAudio.volume : 0
	readonly property bool muted: defaultAudio ? defaultAudio.muted : false

	function setVolume(v: real) {
		if (defaultAudio) {
			defaultAudio.volume = Math.max(0, v / 100)
		}
	}

	function toggleMute() {
		if (defaultAudio) {
			defaultAudio.muted = !defaultAudio.muted
		}
	}
}
