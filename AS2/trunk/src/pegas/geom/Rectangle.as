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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import pegas.geom.Point;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IComparator;
import vegas.core.IEquality;

// TODO creates unit tests.

/**
 * @author eKameleon
 */
class pegas.geom.Rectangle extends CoreObject implements ICloneable, IComparator, IEquality
{

	/**
	 * Creates a new Rectangle instance.
	 */
	public function Rectangle(p_x:Number, p_y:Number, p_w:Number, p_h:Number) 
	{
		var l = arguments.length ;
		if (isNaN(l)) 
		{
			setEmpty() ;
		}
		else 
		{
			x = p_x ;
			y = p_y ;
			width = p_w ;
			height = p_h ;
		}
	}

	// ----o Public Properties
	
	public function get bottom():Number 
	{
		return getBottom() ;
	}

	public function set bottom( n:Number ):Void 
	{
		setBottom(n) ;	
	}	

	public function get bottomLeft():Point 
	{
		return getBottomLeft() ;
	}

	public function set bottomLeft( p:Point ):Void 
	{
		setBottomLeft(p) ;	
	}	

	public function get bottomRight():Point 
	{
		return getBottomRight() ;
	}

	public function set bottomRight( p:Point ):Void 
	{
		setBottomRight(p) ;	
	}	
	
	public function get center():Point 
	{
		return getCenter() ;
	}

	public function get left():Number 
	{
		return getLeft() ;
	}

	public function set left( n:Number ):Void 
	{
		setLeft(n) ;	
	}
	
	// public var center:Point ; // [R/W]
	public var height:Number ;

	public function get right():Number 
	{
		return getRight() ;
	}

	public function set right( n:Number ):Void 
	{
		setRight(n) ;	
	}
	
	public function get size():Point 
	{
		return getSize() ;	
	}
	
	public function set size( o ):Void 
	{
		setSize(o) ;	
	}

	public function get top():Number 
	{
		return getTop() ;
	}

	public function set top( n:Number ):Void 
	{
		setTop(n) ;	
	}

	public function get topLeft():Point 
	{
		return getTopLeft() ;
	}

	public function set topLeft( p:Point ):Void 
	{
		setTopLeft(p) ;	
	}	

	public function get topRight():Point 
	{
		return getTopRight() ;
	}

	public function set topRight( p:Point ):Void 
	{
		setTopRight(p) ;	
	}	

	public var width:Number ;
	
	public var x:Number ;
	
	public var y:Number ;
	
	public function clone() 
	{
		return new Rectangle(x, y, width, height) ;
	}
	
	public function contains(p_x:Number, p_y:Number):Boolean 
	{
		return (x <= p_x && x + width > p_x && y <= p_y && y + this.height > p_y) ;
	}
	
	public function containsPoint(pt:Point):Boolean 
	{
		return (pt.x >= x && pt.x < x + width && pt.y >= y && pt.y < y + height);
	}
	
	public function containsRectangle(rec:Rectangle):Boolean 
	{
		var a:Number = rec.x + rec.width ;
		var b:Number = rec.y + rec.height ;
		var c:Number = x + width ;
		var d:Number = y + height ;
		return (rec.x >= x && rec.x < c && rec.y >= y && rec.y < d && a > this.x && a <= c && b > y && b <= d) ;
	}
	
	public function compare(o1, o2):Number 
	{
		var s1:Point = o1.getSize() ;
		var s2:Point = o2.getSize() ;
		var a1:Number = s1.x * s1.y ;
		var a2:Number = s2.x * s2.y ;
		if (a1 == a2) return 0 ;
		else if(a1 > a2) return 1 ;
		else return -1 ;
	}

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		return ( (o instanceof Rectangle) && (o.x == x) && (o.y == y) && (o.width == width) && (o.height == height)) ;
	}
	
	public function getBottom():Number 
	{
		return y + height ;
	}

	public function getBottomLeft():Point 
	{
		return new Point(x, y + height) ;
	}

	public function getBottomRight():Point 
	{
		return new Point(x + width, y + height) ;
	}

	public function getCenter():Point 
	{
		return new Point(x + width/2, y + height/2);
	}

	public function getLeft():Number 
	{
		return x ;
	}
	
	public function getRight():Number 
	{
		return x + width ;
	}
	
	public function getSize():Point {
		return new Point(width, height) ;
	}
	
	public function getTop():Number 
	{
		return y ;
	}	
	
	public function getTopLeft():Point 
	{
		return new Point(x, y) ;
	}

	public function getTopRight():Point 
	{
		return new Point(x + width, y) ;
	}

	public function inflate(dx:Number, dy:Number):Void 
	{
		x = x - dx;
		width = width + 2 * dx;
		y = y - dy;
		height = height + 2 * dy;
	}
	
	public function inflatePoint(pt:Point):Void 
	{
		x = x - pt.x;
		width = width + 2 * pt.x;
		y = y - pt.y;
		height = height + 2 * pt.y;
	}
	
	public function intersection(toIntersect:Rectangle):Rectangle 
	{
		var rec:Rectangle = new Rectangle() ;
		if (isEmpty() || toIntersect.isEmpty()) {
			rec.setEmpty();
			return rec ;
		}
		rec.x = Math.max(x, toIntersect.x);
		rec.y = Math.max(y, toIntersect.y);
		rec.width = Math.min( x + width, toIntersect.x + toIntersect.width) - rec.x ;
		rec.height = Math.min(y + height, toIntersect.y + toIntersect.height) - rec.y ;
		if ( rec.width <= 0 || rec.height <= 0 ) rec.setEmpty();
		return rec ;
	}
	
	public function intersects(toIntersect:Rectangle):Boolean 
	{
		return !intersection(toIntersect).isEmpty() ;
	}

	public function isEmpty():Boolean 
	{
		return !(width > 0 || height > 0) ;
	}
	
	public function offset(dx:Number, dy:Number):Void 
	{
		x = x + dx ;
		y = y + dy ;
	}
	
	public function offsetPoint(pt:Point):Void 
	{
		x = x + pt.x ;
		y = y + pt.y ;
	}
	
	public function setEmpty():Void 
	{
		x = y = width = height = 0 ;
	}

	public function setBottom(n:Number):Void 
	{
		height = n - y ;
	}

	public function setBottomLeft(value):Void 
	{
		width = width + (x - value.x) ;
		height = value.y - y ;
		x = value.x ;
	}

	public function setBottomRight(value):Void 
	{
		width = value.x - x;
		height = value.y - y;
	}

	public function setLeft(n:Number):Void 
	{
		width = width + (x - n) ;
		x = n ;
	}
	
	public function setRight(n:Number):Void 
	{
		width = n - x ;
	}
	
	public function setTop(n:Number):Void
	{
		height = height + (y - n);
		y = n ;
	}

	public function setTopLeft(value):Void 
	{
		width = width + (x - value.x) ;
		height = height + (y - value.y) ;
		x = value.x ;
		y = value.y ;
	}

	public function setTopRight(value):Void 
	{
		width = value.x - x;
		height = height + (y - value.y) ;
		y = value.y ;
	}
	
	public function setSize( value ):Void 
	{
		width = value.x ;
		height = value.y ;
	}
	
	public function toFlash():flash.geom.Rectangle
	{
		return new flash.geom.Rectangle(x, y, width, height) ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource( indent:Number, indentor:String):String 
	{
		return "new Rectangle(" + x + "," + y + "," + width + "," + height + ")" ;
	}

	/**
	 * Returns the string representation of the object.
	 * @return the string representation of the object.
	 */ 
	public function toString():String 
	{
		return "{x:" + (x||0) + ",y:" + (y||0) + ",width:" + (width||0) + ",height:" + (height||0) + "}" ;
	}
	
	public function union(toUnion):Rectangle 
	{
		if (isEmpty()) 
		{
			return toUnion.clone() ;
		}
		else if (toUnion.isEmpty()) 
		{
			return clone() ;
		}
		else 
		{
			var rec:Rectangle = new Rectangle();
			rec.x = Math.min(x, toUnion.x);
			rec.y = Math.min(y, toUnion.y);
			rec.width = Math.max(x + width, toUnion.x + toUnion.width) - rec.x;
			rec.height = Math.max(y + height, toUnion.y + toUnion.height) - rec.y;
			return rec ;
		}
	}
	
}