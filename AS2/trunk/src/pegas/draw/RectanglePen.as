﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.display.Align;

import pegas.draw.EasyPen;
import pegas.geom.Rectangle;

/**
 * @author eKameleon
 */
class pegas.draw.RectanglePen extends EasyPen 
{

	/**
	 * Creates a new RectanglePen instance.
	 */
	public function RectanglePen(target:MovieClip, isNew:Boolean) {
		_rectangle = new Rectangle() ;
		initialize(target, isNew) ;
	}

	public var h:Number ;

	public var w:Number ;

	public var x:Number ;

	public var y:Number ;
		
	public function clone() 
	{
		var rec:RectanglePen = new RectanglePen(_target) ;
		rec.setRectangle(w, h, x, y, getAlign()) ;
		return rec ;
	}
	
	public function draw(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number):Void {
		if (arguments.length > 0) {
			setRectangle(p_w, p_h, p_x, p_y, p_align) ;
		}
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
		if (isEndFill) endFill() ;		
	}
	
	public function getRectangle():Rectangle 
	{
		return _rectangle ;	
	}
	
	public function setRectangle(p_w:Number, p_h:Number, p_x:Number, p_y:Number, p_align:Number):Void 
	{
		if (!isNaN(p_w)) w = p_w ;
		if (!isNaN(p_h)) h = p_h ;
		if (!isNaN(p_x)) x = p_x ;
		if (!isNaN(p_y)) y = p_y ;
		if (!isNaN(p_align)) setAlign(p_align, true) ;
		_rectangle.x = isNaN(x) ? 0 : x ;
		_rectangle.y = isNaN(y) ? 0 : y ;
		var a:Number = getAlign() ;
		if (a == Align.CENTER) 
		{
			_rectangle.x -= w/2 ;
			_rectangle.y -= h/2 ;
		}
		else if (a == Align.BOTTOM) 
		{
			_rectangle.x -= w/2 ;
			_rectangle.y -= h ;
		}
		else if (a == Align.BOTTOM_LEFT) 
		{
			_rectangle.y -= h ;
		}
		else if (a == Align.BOTTOM_RIGHT) 
		{
			_rectangle.x -= w ;
			_rectangle.y -= h ;
		}
		else if (a == Align.LEFT) 
		{
			_rectangle.y -= h/2 ;
		}
		else if (a ==  Align.RIGHT) 
		{
			_rectangle.x -= w ;
			_rectangle.y -= h/2 ;
		}
		else if (a == Align.TOP) 
		{
			_rectangle.x -= w/2 ;
		}
		else if (a == Align.TOP_RIGHT) 
		{
			_rectangle.x -= w ;
		} 
		else 
		{
			// top left
		}
		_rectangle.width = w ;
		_rectangle.height = h ;
	}

	private var _rectangle:Rectangle ;
	
}
