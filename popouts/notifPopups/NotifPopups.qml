import qs.singletons
import qs.popouts

import QtQuick
import QtQuick.Layouts

PopoutBase {
	id: notifPopup

	anchorRight: true
	anchorTop: true

	animateRight: true

	panelWidth: Style.popoutWidgetWidth + 2 * Style.popoutDefaultMargin
	panelHeight: implicitHeight

	popupOpen: Notifs.popups.length > 0

	panelContent: Rectangle {}
}
