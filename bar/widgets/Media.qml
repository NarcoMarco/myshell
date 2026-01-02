import qs.singletons

import QtQuick
import Quickshell.Widgets
import Quickshell.Services.Mpris

Rectangle {
	id: root

	readonly property MprisPlayer activePlayer: MprisController.activePlayer

	readonly property string cleanedText: activePlayer 
			? activePlayer.trackArtist.trim() + " - " + activePlayer.trackTitle.trim()
			: "Nothing Playing!"

	readonly property string shortenedText: {
		if (cleanedText.length > Style.maxMediaLength) {
			return cleanedText.slice(0, Style.maxMediaLength) + "…"
		} else {
			return cleanedText
		}
	}

	MarginWrapperManager {
		rightMargin: 2 * Style.defaultMargin
		leftMargin: 2 * Style.defaultMargin
		implicitHeight: Style.widgetHeight
	}

	radius: Style.defaultRadius
	color: Style.bgColor

	Row {
		anchors.centerIn: parent
		spacing: Style.defaultMargin

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize * 1.2

			text: {
				if (root.activePlayer) {
					return root.activePlayer.isPlaying ? "󰏤" :"󰐊"
				} else {
					return "󰝛"
				}
			}
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize

			text: "|"
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter

			color: Style.textColor

			font.family: Style.fontFamily
			font.pixelSize: Style.fontSize

			text: root.shortenedText
		}
	}
}
