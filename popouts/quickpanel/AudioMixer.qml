import qs.singletons
import qs.components
import qs.popouts.quickpanel

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

Rectangle {
	radius: Style.popoutDefaultRadius
	color: Style.barColor

	Flickable {
		id: scroll

		anchors.fill: parent
		clip: true

		// padding: Style.popoutDefaultMargin

		// contentWidth: availableWidth
		contentWidth: parent.width
		contentHeight: columnContent.implicitHeight

		flickableDirection: Flickable.VerticalFlick

		ColumnLayout {
			id: columnContent
			width: parent.width
					
			spacing: Style.popoutDefaultMargin * 2

			RowLayout {
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

				Text {
					Layout.alignment: Qt.AlignLeft

					verticalAlignment: Text.AlignVCenter

					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize
					font.weight: Font.DemiBold

					text: "Audio Mixer"
				}

				Item {
					Layout.fillWidth: true
				}
			}

			ColumnLayout {
				Layout.fillWidth: true

				spacing: 0

				Text {
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Outputs"
					bottomPadding: Style.popoutDefaultMargin
				}

				Repeater {
					model: Audio.sinkNodes

					AudioDevice {
						required property var modelData

						Layout.fillWidth: true

						device: modelData
					}
				}
			}

			ColumnLayout {
				Layout.fillWidth: true

				spacing: 0

				Text {
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Inputs"
					bottomPadding: Style.popoutDefaultMargin
				}

				Repeater {
					model: Audio.sourceNodes

					AudioDevice {
						required property var modelData

						Layout.fillWidth: true

						device: modelData
					}
				}
			}

			ColumnLayout {
				Layout.fillWidth: true

				spacing: 0

				Text {
					color: Style.textColor

					font.family: Style.fontFamily
					font.pixelSize: Style.popoutFontSize

					text: "Applications"
					bottomPadding: Style.popoutDefaultMargin
				}

				Repeater {
					model: Audio.appNodes

					AudioDevice {
						required property var modelData

						Layout.fillWidth: true

						device: modelData
					}
				}
			}
		}
	}
}
