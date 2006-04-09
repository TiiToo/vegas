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

/** DashLinePen
	
	AUTHOR
	
		Name : DashLinePen
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2006-03-30
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var lp:DashLinePen = new DashLinePen(target:MovieClip, isNew:Boolean) ;

	PROPERTY SUMMARY
	
		- alpha:Number [R/W]
		
		- color:Number [R/W]	
		
		- la:Number
		
			line alpha
		
		- lc:Number
		
			line color
		
		- length:Number [R/W]
		
		- line:Line [Read Only]
		
		- fa:Number
		
			fill alpha
		
		- fc:Number
		
			fill color
	
		- t:Number
		
			thickness
		
		- spacing:Number [R/W]
		
		- thickness:Number [R/W]
		
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
		
		- draw(start:Point, end:Point, color:Number, alpha:Number, length:Number, spacing:Number):Void
		
		- endFill():Void
		
		- getAlpha():Number
		
		- getEnd():Point
		
		- getColor():Number
		
		- getLine():Line
		
		- getStart():Point
		
		- getTarget():MovieClip
		
		- getThickness():Number
		
		- initialize(target:MovieClip , bNew:Boolean):Void
		
		- isAutoClear()
		
		- lineStyle(t:Number, lc:Number, la:Number):Void
		
		- lineTo(x:Number, y:Number):Void 
		
		- moveTo(x:Number, y:Number):Void
		
		- run():Void
		
		- setAlpha(nAlpha:Number, noDraw:Boolean):Void
		
		- setAutoClear(b:Boolean):Void
		
		- setColor(nColor:Number, noDraw:Boolean):Void
		
		- setEnd(p:Point, noDraw:Boolean):Void
		
		- setLength(n:Number, noDraw:Boolean)
		
		- setLine(start:Point, end:Point, color:Number, alpha:Number, length:Number, spacing:Number):Void
		
		- setSpacing(n:Number, noDraw:Boolean)
		
		- setStart(p:Point, noDraw:Boolean):Void
		
		- setTarget(target:MovieClip):Void
		
		- setThickness(n:Number, noDraw:Boolean):Void
		
		- toString():String

	INHERIT
	
		CoreObject > AbstractPen > AbstractPen > Line

	IMPLEMENT
	
		ICloneable, IFormattable, IHashCode, IPen, IRunnable, IShape

----------  */

import asgard.draw.LinePen;
import asgard.geom.Point;

class asgard.draw.DashLinePen extends LinePen {

	// -----o Constructor

	public function DashLinePen(target:MovieClip, isNew:Boolean) {
		super(target, isNew) ;
	}

	// -----o Public Properties

	public var default_length:Number = 2 ;
	public var default_spacing:Number = 2 ;

	// public var length:Number ; // [R/W]
	// public var spacing:Number ; // [R/W]

	// -----o Public Methods
	
	public function clone() {
		var p:DashLinePen = new DashLinePen(_target) ;
		p.setLine(getStart(), getEnd(), getThickness(), getColor(), getAlpha(), getLength(), getSpacing()) ;
		return p ;
	}
	
	public function draw(
	
		p_start:Point, p_end:Point, 
		p_thickness:Number, p_color:Number,
		p_alpha:Number, p_length:Number, p_spacing:Number
	
	):Void {
		
		if (arguments.length > 0) setLine.apply(this, arguments) ;
		
		var s:Point = _pStart ;
		var e:Point = _pEnd ;
		var segl:Number = getLength() + getSpacing() ;
		if (isNaN(segl)) segl = 0 ;
		var dx:Number = e.x - s.x ;
		var dy:Number = e.y - s.y ;
		var delta = Math.sqrt((dx * dx) + (dy * dy));
		var nbSegs:Number = Math.floor(Math.abs(delta / segl)) ;
		__radians = Math.atan2 ( dy, dx ) ;
		__x = s.x;
		__y = s.y;
		dx = Math.cos(__radians)* segl ;
		dy = Math.sin(__radians)* segl ;
		if (_autoClear) clear () ;
		lineStyle (t, lc, la) ;
		for (var i:Number = 0; i < nbSegs; i++) {
			moveTo( __x, __y ) ;
			_lineRadiansTo ( _length ) ;
			__x += dx ;
			__y += dy ;
		}
		moveTo(__x, __y) ; 
		delta = Math.sqrt((e.x - __x)*(e.x - __x)+ (e.y - __y)* (e.y - __y)) ;
		if(delta>_length) _lineRadiansTo ( _length ) ;
		else if (delta > 0) _lineRadiansTo ( delta ) ;
		moveTo(e.x, e.y);
	}

	public function getLength():Number { 
		return _length ;
	}

	public function getSpacing():Number { 
		return _spacing ;
	}

	public function setLength(n:Number, noDraw:Boolean):Void {
		_length = isNaN(n) ? default_length : n ; 
		if (!noDraw) draw() ;	
	}

	public function setLine(
		p_start:Point, p_end:Point, 
		p_thickness:Number, p_color:Number, p_alpha:Number, 
		p_length:Number, p_spacing:Number 
	):Void {
		super.setLine(p_start, p_end, p_thickness, p_color, p_alpha) ;
		if (!isNaN(p_length)) setLength(p_length, true) ;
		if (!isNaN(p_spacing)) setSpacing(p_spacing, true) ;
	}

	public function setSpacing(n:Number, noDraw:Boolean):Void { 
		_spacing = isNaN(n) ? default_spacing : n ; 
		if (!noDraw) draw() ;	
	}

	// ----o Virtual Properties

	public function get length():Number {
		return getLength() ;	
	}
	
	public function set length(n:Number):Void {
		setLength(n) ;	
	}

	public function get spacing():Number {
		return getSpacing() ;	
	}
	
	public function set spacing(n:Number):Void {
		setSpacing(n) ;	
	}
	
	// ----o Private  Properties

	private var _length:Number = 2 ;
	private var __radians:Number ; 
	private var _spacing:Number = 2 ;
	private var __x:Number ;
	private var __y:Number ;
	
	// ----o Private Methods
	
	private function _lineRadiansTo ( n:Number ) : Void {
		lineTo ( __x + Math.cos(__radians) * n ,  __y + Math.sin(__radians) * n ) ;
	}
}
