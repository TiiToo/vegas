
import vegas.events.Delegate ;
import vegas.events.EventDispatcher ;

import asgard.display.DisplayObject ;

import pegas.geom.Point ;
import pegas.geom.Rectangle ;
import pegas.events.MouseEvent ;
import pegas.events.MouseEventType ;

class test.display.RectangleDisplay extends DisplayObject
{

	/**
	 * Creates a new RectangleDisplay instance.
	 */
	public function RectangleDisplay( name:String, target:MovieClip, rec:Rectangle, color:Number ) 
	{
	
		super( name , target ) ;
		
		// initialize the display
	
		this.rec = rec ;
		this.color = isNaN(color) ? 0xFFFFFF : color ;
				
		// behaviour
		
		view.onPress          = Delegate.create(this, _press) ;
		view.onRelease        = Delegate.create(this, _release) ; 
		view.onReleaseOutside = Delegate.create(this, _release) ;
		view.useHandCursor = false ;

		// update the view of this display
		
		this.draw() ;
		
	}
	

	public var color:Number ;
	
	public var rec:Rectangle ;

	/**
	 * Draw the rectangle shape of this display.
	 */
	public function draw():Void 
	{
		
		var p0:Point = rec.getTopLeft() ;
		var p1:Point = rec.getBottomRight() ;
		
		view.clear() ;
		view.lineStyle(2, 0, 100) ;
		view.beginFill(color, 100) ;
		view.moveTo(p0.x, p0.y) ;
		view.lineTo(p1.x, p0.y) ;
		view.lineTo(p1.x, p1.y) ;
		view.lineTo(p0.x, p1.y) ;
		view.lineTo(p0.x, p0.y) ;
		view.endFill() ;
	}

	private function _press():Void 
	{
		var ev:MouseEvent = new MouseEvent( MouseEventType.CLICK ) ;
		ev.buttonDown = true ;
		dispatchEvent(ev)
	}

	private function _release():Void 
	{
		var ev:MouseEvent = new MouseEvent(MouseEventType.MOUSE_UP) ;
		ev.buttonDown = false ;
		dispatchEvent(ev)
	}
    
}