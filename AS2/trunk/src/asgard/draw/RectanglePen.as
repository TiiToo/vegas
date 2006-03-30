/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** RectanglePen
	
	AUTHOR
	
		Name : RectanglePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var rec:Rectangle = new Rectangle(target:MovieClip, isNew:Boolean) ;

	PROPERTY SUMMARY
	
		- align:String [R/W]
		
		- round:Number [R/W]
		
		- rotation [R/W]
		
		- la:Number
		
			line alpha
		
		- lc:Number
		
			line color
		
		- fa:Number
		
			fill alpha
		
		- fc:Number
		
			fill color
	
		- t:Number
		
			thickness
		
		- C:Function 
		
			curveTo
			
		- CL:Function 
		
			clear
		
		- EF:Function
		
			endFill
			
		- F:Function
		
			beginFill
		
		- GF:Function
		
			GradientFill
		
		- L:Function
		
			lineTo
		
		- M:Function
		
			moveTo
		
		- S:Function
		
			lineStyle
	
	METHOD SUMMARY

		- beginFill(fc:Number, fa:Number):Void
		
		- beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix):Void
		
		- clear():Void
		
		- clone():Rectangle
		
		- curveTo(x1:Number, y1:Number, x2:Number, y2:Number):Void
		
		- draw(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- endFill():Void
		
		- getAlign():String
		
		- getRound():Number
	
		- getRotation():Number
			
		- getTarget():MovieClip
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setRectangle(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- setAlign (str:String, noDraw:Boolean):Void
		
		- setRound(n:Number, noDraw:Boolean):Void
		
		- setRotation(n:Number, noDraw:Boolean):Void
		
		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		CoreObject > AbstractPen > EasyPen > Rectangle

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape

----------  */

import asgard.display.Align;
import asgard.draw.EasyPen;
import asgard.geom.Rectangle;

class asgard.draw.RectanglePen extends EasyPen {

	// -----o Constructor

	public function RectanglePen(target:MovieClip, isNew:Boolean) {
		_rectangle = new Rectangle() ;
		initialize(target, isNew) ;
	}

	// -----o Public Properties

	public var h:Number ;
	public var rectangle:Rectangle ; // [Read Only]
	public var rotation:Number ; // [R/W]
	public var round:Number ; // [R/W]
	public var w:Number ;
	public var x:Number ;
	public var y:Number ;
	
	// -----o Public Methods
	
	public function clone() {
		var rec:RectanglePen = new RectanglePen(_target) ;
		rec.setRectangle(w, h, x, y, getAlign()) ;
		return rec ;
	}
	
	public function draw(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number, p_round:Number, p_rotation:Number):Void {
		if (arguments.length > 0) setRectangle.apply(this, arguments) ;
		var r:Rectangle = getRectangle() ;
		var nX:Number = r.x ;
		var nY:Number = r.y ;
		var nW:Number = nX + r.width ;
		var nH:Number = nY + r.height ;
		moveTo(nX, nY) ;
		lineTo(nW, nY) ;
		lineTo(nW, nH) ;
		lineTo(nX, nH) ;
		lineTo(nX, nY) ;
		endFill() ;		
	}
	
	public function getRectangle():Rectangle {
		return _rectangle ;	
	}
	
	public function setRectangle(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number):Void {
		if (!isNaN(p_w)) w = p_w ;
		if (!isNaN(p_h)) h = p_h ;
		if (!isNaN(p_x)) x = p_x ;
		if (!isNaN(p_y)) y = p_y ;
		if (!isNaN(p_align)) setAlign(p_align, true) ;
		_rectangle.x = isNaN(x) ? 0 : x ;
		_rectangle.y = isNaN(y) ? 0 : y ;
		var a:Number = getAlign() ;
		if (a == Align.CENTER) {
			_rectangle.x -= w/2 ;
			_rectangle.y -= h/2 ;
		} else if (a == Align.BOTTOM) {
			_rectangle.x -= w/2 ;
			_rectangle.y -= h ;
		} else if (a == Align.BOTTOM_LEFT) {
			_rectangle.y -= h ;
		} else if (a == Align.BOTTOM_RIGHT) {
			_rectangle.x -= w ;
			_rectangle.y -= h ;
		} else if (a == Align.LEFT) {
			_rectangle.y -= h/2 ;
		} else if (a ==  Align.RIGHT) {
			_rectangle.x -= w ;
			_rectangle.y -= h/2 ;
		} else if (a == Align.TOP) {
			_rectangle.x -= w/2 ;
		} else if (a == Align.TOP_RIGHT) {
			_rectangle.x -= w ;
		} else {
			// top left
		}
		_rectangle.width = w ;
		_rectangle.height = h ;
	}

	// ----o Private  Properties

	private var _rectangle:Rectangle ;
	
}
