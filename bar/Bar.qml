import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.bar.layout
import qs.shapes
import qs.singletons


Scope {

	Variants {
		model: Quickshell.screens

		PanelWindow {
			required property var modelData
			screen: modelData
			color: "transparent"

			anchors {
				top: true
				left: true
				right: true
			}

			implicitHeight: Style.barHeight + Style.windowRadius
			exclusiveZone: Style.barHeight

			aboveWindows: false

			Rectangle {
				id: barBackground
				anchors {
					top: parent.top
					left: parent.left
					right: parent.right
				}
				color: Style.barColor
				implicitHeight: Style.barHeight

				RowLayout {
					anchors.fill: parent
					anchors.rightMargin: Style.defaultMargin
					anchors.leftMargin: Style.defaultMargin

					Left {
						Layout.alignment: Qt.AlignLeft
					}

					Item { Layout.fillWidth: true }

					Right {
						Layout.alignment: Qt.AlignRight
					}

				}

				Center {
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
				}

			}

			RoundCorner {
				anchors {
					top: barBackground.bottom
					left: parent.left
				}

				implicitWidth: Style.windowRadius
	 			implicitHeight: Style.windowRadius

				rotationAngle: 0
			}

			RoundCorner {
				anchors {
					top: barBackground.bottom
					right: parent.right
				}
				implicitWidth: Style.windowRadius
				implicitHeight: Style.windowRadius

				rotationAngle: 90
			}

		}
	}
}
