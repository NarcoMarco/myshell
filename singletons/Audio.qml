pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
	id: audioRoot

	// readonly property ObjectModel nodes: Pipewire.nodes

	readonly property list<PwNode> sinkNodes: Pipewire.nodes.values.filter(d => d.audio && d.isSink && !d.isStream)

	readonly property list<PwNode> sourceNodes: Pipewire.nodes.values.filter(d => d.audio && !d.isSink && !d.isStream)

	readonly property list<PwNode> appNodes: Pipewire.nodes.values.filter(d => d.audio && d.isStream)

	readonly property PwNode defaultNode: Pipewire.defaultAudioSink

	readonly property PwNodeAudio defaultAudio: defaultNode ? defaultNode.audio : null

	//bind node so we can read properties
	// PwObjectTracker { objects: [ audioRoot.defaultNode ] }
	PwObjectTracker { objects: audioRoot.sinkNodes }
	PwObjectTracker { objects: audioRoot.sourceNodes }
	PwObjectTracker { objects: audioRoot.appNodes }

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

	function setNodeVolume(n: PwNode, v: real) {
		if (n) {
			n.audio.volume = Math.max(0, v / 100)
		}
	}

	function toggleNodeMute(n: PwNode) {
		if (n) {
			n.audio.muted = !n.audio.muted
		}
	}

	function setDefault(n: PwNode) {
		if (n.isSink) {
			Pipewire.preferredDefaultAudioSink = n
		} else {
			Pipewire.preferredDefaultAudioSource = n
		}
	}
}
