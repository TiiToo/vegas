
import asgard.display.* ;

import pegas.transitions.Tween ;
import pegas.transitions.TweenEntry ;
import pegas.transitions.easing.* ;

import vegas.core.IRunnable ;
import vegas.events.* ;

class example.process.RectangleRunnable extends MovieClip implements IRunnable
{

	/**
	 * Creates a new RectangleRunnable instance.
	 */
	public function RectangleRunnable() 
	{
		
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
	
	public var onResize:Function ;

	public function draw():Void 
	{
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
	
	public function run():Void 
	{
		_tw.tweenProvider = 
		[
			new TweenEntry("_x", Bounce.easeOut, _x, Math.random()*Stage.width ) ,
			new TweenEntry("_y", Back.easeOut, _y, Math.random()*Stage.height) ,
			new TweenEntry("_rotation", Back.easeOut, _rotation, Math.random() * 360)
		] ;
		_tw.run() ;
	}

	
	private var _tw:Tween ;
	
}