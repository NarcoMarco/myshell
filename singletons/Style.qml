pragma Singleton

import QtQuick

QtObject {

	// Computer Specific
	property bool enableBattery: true

	// Heights
	// Bar
	property int barHeight: 40 // Only size that *should* have to be changed
	property int widgetHeight: barHeight * 0.75
	property int iconHeight: widgetHeight * 0.75

	// Popouts
	property int popoutWidgetWidth: barHeight * 10 
	property int popoutWidgetHeight: widgetHeight * 1.25
	property int tabIndicatorHeight: popoutWidgetHeight / 8
	property int popoutSeparatorHeight: popoutWidgetHeight / 10
	property int popoutToggleHeight: popoutWidgetHeight * 0.625


	// Margins and Rounding	
	// Bar
	property int defaultMargin: barHeight / 8
	property int defaultRadius: widgetHeight / 2
	property int windowRadius: 15 // Should be same as Hyprland window rounding

	// Popouts
	property int popoutDefaultMargin: defaultMargin * 2
	property int popoutDefaultRadius: windowRadius
	property int defaultTabWidth: popoutWidgetHeight * 2

	// Animations
	property int defaultAnimDuration: 220
	property int defaultAnimation: Easing.InOutQuart

	// Font
	property int fontSize: widgetHeight / 2
	property int popoutFontSize: popoutWidgetHeight / 2
	property string fontFamily: "JetBrains Mono Nerd Font"


	// Misc
	// Bar
	property int maxMediaLength: 75 // Max length of media text before cut off
	property int brightnessUpdate: 500 // How often monitor brightness updates

	// Popouts
	property int maxWifiLength: 12

	// Tooltips	
	property int tooltipFontSize: fontSize
	property int tooltipDelay: 1000


	// Colours
	property color warningColor: "#f38ba8"
	
	property color barColor: "#11111b"
	property color bgColor: "#1e1e2e"
	property color fgColor: "#b4befe"
	property color inactiveColor: "#a6adc8"
	property color textColor: "#b4befe"
	property color disabledColor: "#1e1e2e"
	property color hoverColor: "#45475a"
	property color clickedColor: "#313244"
}
