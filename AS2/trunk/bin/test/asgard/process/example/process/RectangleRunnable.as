/* ---------- RectangleRunnable

	AUTHOR

		Name : RectangleRunnable
		Package : example.process
		Version : 1.0.0.0
		Date :  2005-11-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
----------  */	

import asgard.display.* ;

import asgard.transitions.Tween ;
import asgard.transitions.TweenEntry ;
import asgard.transitions.easing.* ;


import vegas.core.IRunnable ;
import vegas.events.* ;


class example.process.RectangleRunnable extends MovieClip implements IRunnable {

	// ----o Author Properties

	public static var className:String = "RectangleRunnable" ;
	public static var classPackage:String = "example.process";
	public static var version:String = "1.0.0.0";
	public static var author:String = "ekameleon";
	public static var link:String = "http://www.ekameleon.net" ;

	// ----o Constructor
	
	public function RectangleRunnable() {
		
		Stage.align = StageAlign.TOP_LEFT ;
		Stage.scaleMode = "noScale" ;
		var resizer:StageResizer = new StageResizer() ;
		resizer.addEventListener(EventType.RESIZE, new EventListenerProxy(this, run)) ;
		
		onResize = run ;
		
		_tw = new Tween(this) ;
		_tw.duration = 2 ;		
		_tw.useSeconds = true ;
		
		draw() ;		
	}
	
	// ----o Public Methods

	public function draw():Void {
		var w:Number = 20 ;
		var h:Number = 20 ;
		var color:Number = Math.round(Math.random() * 0xFFFFFF) ;
		clear() ;
		beginFill(Math.round(Math.random()*0xFFFFFF), 100) ;
		lineStyle(2, 0xFFFFFF, 100) ;
		moveTo(-w/2, -h/2) ;
		lineTo(w/2, -h/2) ;
		lineTo(w/2, h/2) ;
		lineTo(-w/2, h/2) ;
		lineTo(-w/2, -h/2) ;
		endFill() ;
	}
	
	public function run():Void {
		_tw.tweenProvider = [
			new TweenEntry("_x", Bounce.easeOut, _x, Math.random()*Stage.width ) ,
			new TweenEntry("_y", Back.easeOut, _y, Math.random()*Stage.height) ,
			new TweenEntry("_rotation", Back.easeOut, _rotation, Math.random() * 360)
		] ;
		_tw.run() ;
	}

	public var onResize:Function ;

	// ----o Private Properties
	
	private var _tw:Tween ;
	
}