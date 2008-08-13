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
 
import pegas.draw.AbstractPen;
import pegas.geom.Line;
import pegas.geom.Point;
import pegas.geom.Vector2;

/**
 * This pen is the basic tool to draw a line in a MovieClip reference.
 * @author eKameleon
 */
class pegas.draw.LinePen extends AbstractPen 
{

	/**
	 * Creates a new LinePen instance.
	 */
	public function LinePen(target:MovieClip, isNew:Boolean) 
	{
		initialize(target, isNew) ;
		_pEnd = new Point(0,0) ;
		_pStart = new Point(0,0) ;
	}
	
	/**
	 * The alpha value of this pen.
	 */
	public function get alpha():Number 
	{
		return getAlpha() ;	
	}

	/**
	 * @private
	 */
	public function set alpha(n:Number):Void 
	{
		setAlpha(n) ;	
	}
	
	/**
	 * The color value of this pen.
	 */
	public function get color():Number 
	{
		return getColor() ;	
	}
	
	/**
	 * @private
	 */
	public function set color(n:Number):Void 
	{
		setColor(n) ;	
	}

	/**
	 * The end 
	 */
	public function get end():Vector2D 
	{
		return getEnd() ;	
	}
	
	public function set end(p:Point):Void 
	{
		setEnd(p) ;	
	}
	
	/**
	 * The line alpha value of this pen.
	 */
	public var la:Number = 100 ;

	/**
	 * The line color value of this pen.
	 */
	public var lc:Number = 0x000000 ;
	
	/**
	 * Returns the Line equation object of this pen.
	 * @return the Line equation object of this pen.
	 */
	public function get line():Line 
	{
		return getLine() ;	
	}

	/**
	 * (read-write) The start vector object of this line pen.
	 */
	public function get start():Vector2 
	{
		return getStart() ;	
	}
	
	/**
	 * @private
	 */
	public function set start(p:Vector2):Void 
	{
		setStart(p) ;	
	}
	
	/**
	 * The thickness value of the pen.
	 */
	public var t:Number = 1 ;

	/**
	 * (read-write) The thickness value of the pen.
	 */
	public function get thickness():Number 
	{
		return getThickness() ;	
	}
	
	/**
	 * @private
	 */
	public function set thickness(n:Number):Void 
	{
		setThickness(n) ;	
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		var p:LinePen = new LinePen(_target) ;
		p.setLine(getStart(), getEnd(), getThickness(), getColor(), getAlpha()) ;
		return p ;
	}
	
	/**
	 * Draw the pen.
	 */
	public function draw(p_start:Point, p_end:Point, p_thickness:Number, p_color:Number, p_alpha:Number):Void 
	{
		if (arguments.length > 0) 
		{
			setLine.apply(this, arguments) ;
		}
		if (_autoClear) clear () ;
		lineStyle (t, lc, la) ;
		moveTo(_pStart.x, _pStart.y) ;
		lineTo(_pEnd.x, _pEnd.y) ;
	}

	/**
	 * Returns the alpha value of this pen.
	 * @return the alpha value of this pen.
	 */
	public function getAlpha():Number 
	{ 
		return la ;
	}

	/**
	 * Returns the color value of this pen.
	 * @return the color value of this pen.
	 */
	public function getColor():Number 
	{ 
		return lc ;
	}
	
	/**
	 * Returns the end vector reference of this pen.
	 * @return the end vector reference of this pen.
	 */
	public function getEnd():Vector2 
	{
		return _pEnd ;	
	}
	
	/**
	 * Returns the Line reference of this pen.
	 * @return the Line reference of this pen.
	 */
	public function getLine():Line 
	{
		return Line.getLine( _pStart, _pEnd ) ;	
	}

	/**
	 * Returns the start vector reference of this pen.
	 * @return the start vector reference of this pen.
	 */
	public function getStart():Vector2 
	{
		return _pStart ;	
	}

	/**
	 * Returns the thickness value of this pen.
	 * @return the thickness value of this pen.
	 */
	public function getThickness():Number 
	{
		return t ;	
	}

	/**
	 * Indicates if the pen use auto clear.
	 */
	public function isAutoClear():Boolean 
	{
		return _autoClear ;	
	}

	/**
	 * Sets the alpha value of the line pen.
	 */
	public function setAlpha(nAlpha:Number, noDraw:Boolean):Void 
	{ 
		la = isNaN(nAlpha) ? default_la : nAlpha ; 
		if (!noDraw) draw() ;	
	}
	
	/**
	 * Sets the auto clear feature of this pen.
	 */
	public function setAutoClear(b:Boolean):Void 
	{
		_autoClear = b ;	
	}
	
	/**
	 * Sets the color value of the pen.
	 */
	public function setColor(nColor:Number, noDraw:Boolean):Void 
	{ 
		lc = isNaN(nColor) ? default_lc : nColor ; 
		if (!noDraw) draw() ;	
	}

	/**
	 * Sets the end vector value of this pen.
	 * @param v The Vector2 object who defines the end vector of the line.
	 * @param noDraw (optional) Indicates if the pen redraw the shape.
	 */
	public function setEnd(p:Vector2, noDraw:Boolean):Void 
	{
		_pEnd = p ;
		if (!noDraw) draw() ;	
	}
	
	/**
	 * Sets the line pen properties.
	 * @param vStart The start vector position of the line.
	 * @param vEnd The end vector position of the line.
	 * @param thickness The thickness value of the line pen.
	 * @param color The color value of the line pen.
	 * @param alpha The alpha value of the line pen.
	 */
	public function setLine( vStart:Vector2, vEnd:Vector2, thickness:Number, color:Number, alpha:Number):Void 
	{
		if (vEnd != null)   setEnd( vEnd, true) ;
		if (vStart != null) setStart( vStart, true) ;
		if (color != null) setColor( color, true) ;
		if (alpha != null) setAlpha( alpha, true) ;
		if (thickness != null) setThickness( thickness, true) ;
	}
	
	/**
	 * Sets the start vector value of this pen.
	 * @param v The Vector2 object who defines the start vector of the line.
	 * @param noDraw (optional) Indicates if the pen redraw the shape.
	 */
	public function setStart(v:Vector2, noDraw:Boolean):Void 
	{
		_pStart = v ;
		if (!noDraw) draw() ;	
	}
	
	/**
	 * Sets the thickness value of the line pen.
	 */
	public function setThickness(n:Number, noDraw:Boolean):Void 
	{ 
		t = isNaN(n) ? default_t : n ; 
		if (!noDraw) draw() ;	
	}

	private var _autoClear:Boolean ;
	private var _line:Line ;
	private var _pEnd:Vector2 ;
	private var _pStart:Vector2 ;	

}
