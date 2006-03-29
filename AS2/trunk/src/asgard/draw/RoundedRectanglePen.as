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

/** RoundedRectanglePen
	
	AUTHOR
	
		Name : RoundedRectanglePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-05-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var rec:RoundedRectangle = new RoundedRectangle(target:MovieClip, isNew:Boolean) ;

	PROPERTY SUMMARY
	
		- align:String [R/W]
		
		- round:Number [R/W]
		
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
		
		- getRectangle():Rectangle
		
		- getRound():Number
	
		- getTarget():MovieClip
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setRectangle(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- setAlign (str:String, noDraw:Boolean):Void
		
		- setRound(n:Number, noDraw:Boolean):Void

		- setTarget(target:MovieClip):Void
		
		- toString():String

	INHERIT
	
		CoreObject > AbstractPen > EasyPen > Rectangle

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape

----------  */

import asgard.draw.Corner;
import asgard.draw.CornerRectanglePen;
import asgard.geom.Rectangle;

import vegas.util.factory.PropertyFactory;


class asgard.draw.RoundedRectanglePen extends CornerRectanglePen {

	// -----o Constructor

	public function RoundedRectanglePen(target:MovieClip, isNew:Boolean) {
		initialize(target, isNew) ;
	}

	// -----o Public Properties

	public var round:Number ; // [R/W]
	
	// -----o Public Methods
	
	public function clone() {
		var rec:RoundedRectanglePen = new RoundedRectanglePen(_target) ;
		rec.setRectangle(w, h, x, y, getAlign(), getRound()) ;
		return rec ;
	}

	public function draw(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number, p_round:Number, corner:Corner):Void {
		
		if (arguments.length > 0) setRectangle.apply(this, arguments) ;
		
		if (_round > 0) {
			
			var r:Rectangle = getRectangle() ;
			var nX:Number = r.x ;
			var nY:Number = r.y ;
			var nW:Number = nX + r.width ;
			var nH:Number = nY + r.height ;
			var c:Corner = getCorner() ;
			var tr:Boolean = c.getTr() ;
			var br:Boolean = c.getBr() ;
			var bl:Boolean = c.getBl() ;
			var tl:Boolean = c.getTl() ;
			
			_currentRadius  = (_round > (Math.min (w, h) / 2) ) ? (Math.max (w, h) / 2) : _round  ;

			moveTo( nX + _currentRadius, nY);
			lineTo( nW - _currentRadius , nY) ;
			if (tr) {
				drawCorner (nW - _currentRadius , nY + _currentRadius) ;
			} else {
				lineTo( nW , nY ) ;
				lineTo( nW , nY + _currentRadius) ;
				simulateCorner () ;
			}
			lineTo ( nW , nH - _currentRadius ) ;
			if (br) {
				drawCorner ( nW - _currentRadius, nH - _currentRadius) ;
			} else {
				lineTo ( nW , nH ) ;
				lineTo ( nW - _currentRadius , nH ) ;
				simulateCorner () ;	
			}
			lineTo( nX  + _currentRadius , nH ) ;
			if (bl) {
				drawCorner ( nX + _currentRadius , nH - _currentRadius) ;
			} else {
				lineTo( nX , nH ) ;
				lineTo( nX  , nH - _currentRadius ) ;
				simulateCorner () ;	
			}
			lineTo( nX, nY + _currentRadius) ;
			if (tl) {
				drawCorner( nX + _currentRadius, nY + _currentRadius) ;
			} else {
				lineTo( nX , nY ) ;
			}
			endFill () ;
			_angle = null ;
			
		} else {
			super.draw.apply(this) ;
		}

	}
	
	public function drawCorner (x:Number, y:Number) { 
		curve (x,y) ; 
		curve (x,y) ;
	}
	
	public function curve(x:Number , y:Number ):Void {
		var cx, cy, px, py :Number  ;
		_angle = ( isNaN(_angle)) ? (- Math.PI / 2) : (_angle + _theta) ;
		cx =  x + ( Math.cos ( _angle + ( _theta / 2 ) ) * _currentRadius / Math.cos ( _theta / 2 ) );
		cy = y +  ( Math.sin ( _angle + ( _theta / 2 ) ) * _currentRadius / Math.cos( _theta / 2 ) ) ;
		px = x  + ( Math.cos (_angle + _theta) * _currentRadius ) ;
		py = y  + ( Math.sin ( _angle + _theta ) * _currentRadius ) ;
		curveTo (cx, cy, px, py);
	}
		
	public function getRound():Number {
		return _round ;
	}
	
	public function setRectangle(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number, p_rnd:Number, p_corner:Corner):Void {
		super.setRectangle(p_w, p_h, p_x, p_y, p_align) ;
		if (!isNaN(p_rnd)) setRound(p_rnd, true) ;
		if (p_corner) setCorner(p_corner, true) ;
	}

	public function setRound(n:Number, noDraw:Boolean):Void {
		_round = isNaN(n) ? 0 : n ;
		if (!noDraw) draw() ;
	}

	public function simulateCorner () {
		_angle = ( ( isNaN(_angle) ) ? (- Math.PI / 2) : (_angle + _theta) ) + _theta ;
	}

	// ----o Virtual Properties

	static private var __ROUND__:Boolean = PropertyFactory.create(RoundedRectanglePen, "round", true) ;	
		
	// ----o Private  Properties

	private var _angle:Number ;
	private var _currentRadius:Number ;
	private var _round:Number  ;
	private var _theta:Number = Math.PI/4 ;
	
}