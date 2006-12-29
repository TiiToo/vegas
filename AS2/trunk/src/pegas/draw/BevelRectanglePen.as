/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** BevelRectanglePen
	
	AUTHOR
	
		Name : BevelRectanglePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2006-03-30
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var rec:BevelRectangle = new BevelRectangle(target:MovieClip, isNew:Boolean) ;

	PROPERTY SUMMARY
	
		- align:String [R/W]
		
		- hBevel:Number [R/W]
		
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
		
		- vBevel:Number [R/W]
		
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
		
		- getCorner():Corner
		
		- getRectangle():Rectangle
		
		- getRound():Number
	
		- getTarget():MovieClip
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setCorner(c:Corner , noDraw:Boolean):Void
		
		- setRectangle(p_w:Number, p_h:Number, p_round:Number, p_rotation:Number, p_x:Number, p_y:Number, p_align:String):Void
		
		- setAlign (str:String, noDraw:Boolean):Void
		
		- setRound(n:Number, noDraw:Boolean):Void

		- setTarget(target:MovieClip):Void
		
		- toString():String


	INHERIT
	
		CoreObject 
			> AbstractPen
				> EasyPen
					> RectanglePen
						> CornerRectangle
							> RoundedRectangle

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape

----------  */

import pegas.draw.Corner;
import pegas.draw.CornerRectanglePen;
import pegas.geom.Rectangle;

class pegas.draw.BevelRectanglePen extends CornerRectanglePen {

	// -----o Constructor

	public function BevelRectanglePen(target:MovieClip, isNew:Boolean) {
		initialize(target, isNew) ;
	}

	// -----o Public Properties

	// public var hBevel:Number ; // [R/W]
	// public var vBevel:Number ; // [R/W]
	
	// -----o Public Methods
	
	public function clone() {
		var rec:BevelRectanglePen = new BevelRectanglePen(_target) ;
		rec.setRectangle(w, h, x, y, getAlign(), getHBevel(), getVBevel()) ;
		return rec ;
	}

	public function draw(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number, p_hBevel:Number, p_vBevel:Number, corner:Corner):Void {
		
		if (arguments.length > 0) setRectangle.apply(this, arguments) ;
		
		var hb:Number = getHBevel() ;
		var vb:Number = getVBevel() ;
		
		if (hb > 0 && vb > 0) {
			
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
			
			moveTo ( nX + hb , nY) ;
			if (tr) {
				lineTo( nW - hb , nY) ;
				lineTo( nW , nY + vb ) ;
			} else {
				lineTo( nW , nY ) ;
			}
			if (br) {
				lineTo( nW , nH - vb ) ;
				lineTo( nW - hb , nH) ;		
			} else {
				lineTo( nW , nH ) ;
			}
			if (bl) {
				lineTo( nX  + hb, nH ) ;
				lineTo( nX  ,  nH - vb ) ;
			} else {
				lineTo( nX , nH ) ;
			}
			if (tl) {
				lineTo( nX , nY + vb) ;
				lineTo( nX + hb, nY);
			} else {
				lineTo( nX , nY ) ;
			}
			if (isEndFill) endFill() ;	
		} else {
			super.draw.apply(this) ;
		}

	}

	public function getHBevel():Number {
		return (_hBevel <= w ) ? _hBevel : 0 ;
	}

	public function getVBevel():Number {
		return (_vBevel <= h ) ? _vBevel : 0 ;
	}

	public function setHBevel(n:Number, noDraw:Boolean):Void {
		_hBevel = ( n>0 ) ? n : 0 ; 
		if (!noDraw) draw();
	}
	
	public function setRectangle(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number, p_hBevel:Number, p_vBevel:Number, p_corner:Corner):Void {
		super.setRectangle(p_w, p_h, p_x, p_y, p_align) ;
		if (!isNaN(p_hBevel)) setHBevel(p_hBevel, true) ;
		if (!isNaN(p_vBevel)) setHBevel(p_vBevel, true) ;
		if (p_corner) setCorner(p_corner, true) ;
	}

	public function setVBevel(n:Number, noDraw:Boolean):Void {
		_vBevel = (n>0) ? n : 0 ; 
		if (!noDraw) draw();
	}	
	
	// ----o Virtual Properties

	public function get hBevel():Number {
		return getHBevel() ;	
	}

	public function set hBevel(n:Number):Void {
		setHBevel(n) ;	
	}

	public function get vBevel():Number {
		return getVBevel() ;	
	}

	public function set vBevel(n:Number):Void {
		setVBevel(n) ;	
	}
		
	// ----o Private  Properties

	private var _hBevel:Number = 10 ;
	private var _vBevel:Number = 15 ;
	
}