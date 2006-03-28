
import vegas.events.Delegate ;
import vegas.events.EventDispatcher ;
import vegas.util.factory.PropertyFactory ;

import lunas.geom.Point ;
import lunas.geom.Rectangle ;
import lunas.events.MouseEvent ;
import lunas.events.MouseEventType ;

class test.display.RectangleDisplay extends EventDispatcher {
    
	// ----o BlackList Properties

	public static var className:String = "RectangleDisplay" ;
	public static var classPackage:String = "test.display";
	public static var version:String = "1.0.0.0";
	public static var author:String = "ekameleon";
	public static var link:String = "http://www.ekameleon.net" ;

	// ----o Constructor
	
	public function RectangleDisplay(target:MovieClip, rec:Rectangle, color:Number) {
		_target = target ;
		_target.onPress = Delegate.create(this, _press) ;
		_target.onRelease = _target.onReleaseOutside = Delegate.create(this, _release) ;
		_target.useHandCursor = false ;
		this.rec = rec ;
		this.color = isNaN(color) ? 0xFFFFFF : color ;
		this.draw() ;
	}
	
	// ----o Public Properties

	public var parent ;
	public var color:Number ;
	public var rec:Rectangle ;

	// ----o Public Methods

	public function draw():Void {
		var p0:Point = rec.getTopLeft() ;
		var p1:Point = rec.getBottomRight() ;
		_target.clear() ;
		_target.lineStyle(2, 0, 100) ;
		_target.beginFill(color, 100) ;
		_target.moveTo(p0.x, p0.y) ;
		_target.lineTo(p1.x, p0.y) ;
		_target.lineTo(p1.x, p1.y) ;
		_target.lineTo(p0.x, p1.y) ;
		_target.lineTo(p0.x, p0.y) ;
		_target.endFill() ;
	}

	public function getTarget():MovieClip {
		return _target ;
	}

	public function toString():String {
		return "[" + _target + "]"
	}
	
	// ----o Virtual Properties

	static private var __TARGET__:Boolean = PropertyFactory.create(RectangleDisplay, "target", true, true) ; 

	// ----o Private Properties

	private var _target:MovieClip ;

	// ----o Private Methods

	private function _press():Void {
		var ev:MouseEvent = new MouseEvent(MouseEventType.CLICK) ;
		ev.buttonDown = true ;
		dispatchEvent(ev)
	}

	private function _release():Void {
		var ev:MouseEvent = new MouseEvent(MouseEventType.MOUSE_UP) ;
		ev.buttonDown = false ;
		dispatchEvent(ev)
	}
    
}