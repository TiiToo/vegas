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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */
 
import pegas.draw.LinePen;
import pegas.geom.Vector2;

/**
 * This pen is the basic tool to draw a dash line in a MovieClip reference.
 * @author eKameleon
 */
class pegas.draw.DashLinePen extends LinePen 
{

	/**
	 * Creates a new DashLinePen instance.
	 */
	public function DashLinePen(target:MovieClip, isNew:Boolean) 
	{
		super(target, isNew) ;
	}

	/**
	 * The default length value of the dashs in the line.
	 */
	public static var DEFAULT_LENGTH:Number = 2 ;

	/**
	 * The default spacing value of the dashs in the line.
	 */
	public static var DEFAULT_SPACING:Number = 2 ;

	/**
	 * (read-write) Determinates the length of a dash in the line.
	 */
	public function get length():Number 
	{
		return getLength() ;	
	}
	
	/**
	 * @private
	 */
	public function set length(n:Number):Void 
	{
		setLength(n) ;	
	}

	/**
	 * (read-write) Determinates the spacing value between two dashs in this line.
	 */
	public function get spacing():Number {
		return getSpacing() ;	
	}
	
	/**
	 * @private
	 */
	public function set spacing(n:Number):Void 
	{
		setSpacing(n) ;	
	}
	
	/**
	 * Returns a shallow copy of this pen.
	 * @return a shallow copy of this pen.
	 */
	public function clone() 
	{
		var p:DashLinePen = new DashLinePen(_target) ;
		p.setLine( getStart(), getEnd(), getThickness(), getColor(), getAlpha(), getLength(), getSpacing()) ;
		return p ;
	}
	
	/**
	 * Draw the dash line shape.
	 * @param start The vector object who define the start position to draw the line.
	 * @param end The vector object who define the end position to draw the line.
	 * @param thickness The thickness value of the line.
	 * @param color The color value of the line.
	 * @param alpha The alpha value of the line.
	 * @param length The length of a dash.
	 * @param spacing The spacing between two dashs.
	 */
	public function draw( start:Vector2 , end:Vector2, thickness:Number, color:Number, alpha:Number, length:Number, spacing:Number ):Void 
	{
		
		if (arguments.length > 0) 
		{
			setLine.apply(this, arguments) ;
		}
		
		var s:Vector2 = _pStart ;
		var e:Vector2 = _pEnd ;
		var segl:Number = getLength() + getSpacing() ;
		if (isNaN(segl)) segl = 0 ;
		var dx:Number = e.x - s.x ;
		var dy:Number = e.y - s.y ;
		var delta = Math.sqrt((dx * dx) + (dy * dy));
		var nbSegs:Number = Math.floor(Math.abs(delta / segl)) ;
		_radians = Math.atan2 ( dy, dx ) ;
		__x = s.x;
		__y = s.y;
		dx = Math.cos(_radians)* segl ;
		dy = Math.sin(_radians)* segl ;
		if (_autoClear) clear () ;
		lineStyle (t, lc, la) ;
		for (var i:Number = 0; i < nbSegs; i++) 
		{
			moveTo( __x, __y ) ;
			_lineRadiansTo ( _length ) ;
			__x += dx ;
			__y += dy ;
		}
		moveTo(__x, __y) ; 
		delta = Math.sqrt((e.x - __x)*(e.x - __x)+ (e.y - __y)* (e.y - __y)) ;
		if(delta>_length) 
		{
			_lineRadiansTo ( _length ) ;
		}
		else if (delta > 0) 
		{
			_lineRadiansTo ( delta ) ;
		}
		moveTo(e.x, e.y);
	}

	/**
	 * Returns the length of a dash in the line.
	 * @return the length of a dash in the line.
	 */
	public function getLength():Number
	{ 
		return _length ;
	}

	/**
	 * Returns the spacing value between two dashs.
	 * @return the spacing value between two dashs.
	 */
	public function getSpacing():Number 
	{ 
		return _spacing ;
	}
	
	/**
	 * Returns the size of a dash.
	 * @return the size of a dash.
	 */
	public function setLength(n:Number, noDraw:Boolean):Void 
	{
		_length = isNaN(n) ? DEFAULT_LENGTH : n ; 
		if (!noDraw) draw() ;	
	}

	/**
	 * Sets all the line properties before draw it.
	 */
	public function setLine( start:Vector2, end:Vector2, thickness:Number, color:Number, alpha:Number, length:Number, spacing:Number ):Void 
	{
		super.setLine(start, end, thickness, color, alpha) ;
		if (!isNaN( length ) ) 
		{
			setLength( length, true) ;
		}
		if (!isNaN( spacing ) ) 
		{
			setSpacing( spacing, true) ;
		}
	}

	/**
	 * Sets the spacing value between two dashs in the line.
	 */
	public function setSpacing(n:Number, noDraw:Boolean):Void 
	{ 
		_spacing = isNaN( n ) ? DEFAULT_SPACING : n ; 
		if (!noDraw) draw() ;	
	}

	private var _length:Number = 2 ;
	
	private var _radians:Number ; 
	
	private var _spacing:Number = 2 ;
	
	private var __x:Number ;
	
	private var __y:Number ;
	
	/**
	 * @private
	 */
	private function _lineRadiansTo ( n:Number ) : Void 
	{
		lineTo ( __x + Math.cos(_radians) * n ,  __y + Math.sin(_radians) * n ) ;
	}
	
}
