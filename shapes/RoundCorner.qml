import QtQuick
import qs.singletons

Canvas {
	id: root

	property color fillColor: Style.barColor
	property int cornerRadius: Style.windowRadius
	property int rotationAngle: 0 

	onPaint: {	
		var ctx = getContext("2d")
		ctx.clearRect(0, 0, width, height)

		ctx.save()

		ctx.translate(width/2, height/2)
		ctx.rotate(rotationAngle * Math.PI / 180)
		ctx.translate(-width/2, -height/2)

		ctx.beginPath()
		ctx.moveTo(0, 0)
		ctx.lineTo(width, 0)
		ctx.lineTo(width, height - cornerRadius)
		ctx.arc(width, height, cornerRadius, Math.PI * 1.5, Math.PI, true)
		ctx.lineTo(0, height)
		ctx.closePath()

		ctx.fillStyle = fillColor
		ctx.fill()
	}
}
