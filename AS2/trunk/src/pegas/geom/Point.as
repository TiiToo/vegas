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

import pegas.geom.Trigo;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.ICopyable;
import vegas.core.IEquality;
import vegas.util.TypeUtil;

// TODO finish unit tests + documentation !!

/**
 * The Point class represents a location in a two-dimensional coordinate system, where x represents the horizontal axis and y represents the vertical axis.
 * <p>The following code creates a point at (0,0) :</p>
 * {@code var myPoint:Point = new Point() ; }
 * @author eKameleon
 */
dynamic class pegas.geom.Point extends CoreObject implements ICloneable, ICopyable, IEquality
{

	/**
	 * Creates a new Point instance.
	 */
	public function Point() 
	{
		var l:Number = arguments.length ;
		var o1 = arguments[0] ; 
		if (l == 0) 
		{
			x = y = 0 ;
		} 
		else if( TypeUtil.typesMatch(o1, Point)) 
		{
			x = o1.x ;
			y = o1.y ;
		}
		else 
		{
			var o2 = arguments[1] ;
			x = isNaN(o1) ? 0 : o1 ;
			y = isNaN(o2) ? 0 : o2 ;
		}
	}

	/**
	 * Returns the angle of this point in this referential.
	 * @return the angle of this point in this referential.
	 */
	public function get angle():Number 
	{
		return getAngle() ;
	}

	/**
	 * Sets the angle of this point in this referential.
	 */
	public function set angle( n:Number ):Void 
	{
		setAngle(n) ;	
	}
	
	/**
	 * Returns the length of the line segment from (0,0) to this point.
	 * @return the length of the line segment from (0,0) to this point.
	 */
	public function get length():Number 
	{
		return getLength() ;	
	}
	
	/**
	 * Sets the length of the line segment from (0,0) to this point.
	 */
	public function set length(n:Number):Void 
	{
		setLength(n) ;	
	}

	/**
	 * The horizontal coordinate of the point.
	 */
	public var x:Number ;

	/**
	 * The vertical coordinate of the point.
	 */
	public var y:Number ;

	/**
	 * Transform the coordinates of this point to used absolute value for the x and y properties.
	 */
	public function abs():Void 
	{
		x = Math.abs(x) ;
		y = Math.abs(y) ;
	}
	
	/**
	 * Returns a new Point reference with the absolute value of the coordinates of this Point object.
	 * @return a new Point reference with the absolute value of the coordinates of this Point object.
	 */
	public function absNew():Point 
	{
		return clone().abs() ;
	}

	/**
	 * Returns the angle value between this Point object and the specified Point passed in arguments.
	 * @return the angle value between this Point object and the specified Point passed in arguments.
	 */
	public function angleBetween(p:Point):Number 
	{
		var dp:Number = dot(p) ;
		var l:Number = getLength() ;
		var a:Number = dp / (l * l) ;
		return Trigo.acosD(a) ;
	}
	
	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	public function clone() 
	{
		return new Point(x, y) ;
	}
	
	/**
	 * Returns the deep copy of this object.
	 * @return the deep copy of this object.
	 */
	public function copy() 
	{
		return new Point(x, y) ;
	}

	/**
	 * Returns the cross value of the current Point object with the Point passed in argument.
	 */
	public function cross(p:Point):Number 
	{
		return ( x * p.y ) - (y * p.x) ;
	}

	/**
	 * Returns the distance between p1 and p2 the 2 Points reference passed in argument.
	 */
	static public function distance(p1:Point, p2:Point):Number 
	{
		return p1.subtractNew(p2).getLength() ;
	}
	
	/**
	 * Returns the dot value of the current Point and the specified Point passed in argument.
	 * @return the dot value of the current Point and the specified Point passed in argument.
	 */
	public function dot(p:Point):Number 
	{
		return (x * p.x) + (y * p.y) ;
	}
	
	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		return (o instanceof Point && o.x == x && o.y == y) ;
	}
	
	/**
	 * Returns the angle value of this Point object.
	 * @return the angle value of this Point object.
	 */
	public function getAngle():Number 
	{
		return Trigo.atan2D(y, x) ;
	}
	
	/**
	 * Returns the direction of this Point.
	 * @return the direction of this Point.
	 * @see {@link normalize}.
	 */
	public function getDirection():Point 
	{
		return clone().normalize() ;
	}
	
	/**
	 * Returns the length of the line segment from (0,0) to this point.
	 * @return the length of the line segment from (0,0) to this point.
	 */
	public function getLength():Number 
	{
		return Math.sqrt(x * x + y * y) ;
	}

	static public function getMiddle(p1:Point, p2:Point):Point 
	{
		return new Point( ( p1.x + p2.x) / 2 , (p1.y + p2.y) / 2) ;
	}
	
	public function getNormal():Point 
	{
		return new Point(-y , x) ;
	}

	public function getProjectionLength(p:Point):Number 
	{
		var l:Number = p.dot(p) ;
		return (l==0) ? 0 : Math.abs(dot(p)/l) ;
	}

	static public function interpolate(p1:Point, p2:Point, f:Number):Point 
	{
		return new Point( p2.x + f * (p1.x - p2.x) , p2.y + f * (p1.y - p2.y) ) ;
	}
	
	public function isPerpTo(p:Point):Boolean 
	{
		return dot(p) == 0 ;
	}

    public function max(p:Point):Point 
    {
        return new Point( Math.max(x, p.x), Math.max(y, p.y) ) ;
    }

	public function min(p:Point):Point 
	{
        return new Point( Math.min(x , p.x) , Math.min(y, p.y) ) ;
    }

	public function negate():Void 
	{
		x = - x ;
		y = - y ;
	}

	public function negateNew():Point 
	{
		return new Point(-x , -y) ;
	}
	
	public function normalize(thickness:Number):Void 
	{
		var l:Number = getLength() ;
		if (l > 0) {
			l = thickness / l ;
			x *= l ;
			y *= l ;
		}
	}

	public function offset(dx:Number, dy:Number):Void 
	{
		x += dx ;
		y += dy ;
	}

	public function plus(p:Object):Void 
	{
		x += p.x ;
		y += p.y ;
	}

	public function plusNew(p:Object):Point 
	{
		return new Point (x + p.x, y + p.y) ;
	}

	/**
	 * Converts a pair of polar coordinates to a Cartesian point coordinate.
	 */
	static public function polar(len:Number, angle:Number):Point 
	{
		return new Point(len * Math.cos(angle), len * Math.sin(angle)) ;
	}
	
	public function project( p:Point ):Point 
	{
		var l:Number = p.dot(p) ;
		if( l == 0) return clone() ;
		else return scaleNew( dot(p) / l ) ;
	}
	
	public function reset(x:Number, y:Number):Void 
	{
		x = x ;
		y = y ;
	}
	
	public function rotate(angle:Number):Void 
	{
		var ca:Number = Trigo.cosD (angle) ;
		var sa:Number = Trigo.sinD (angle) ;
		var rx:Number = x * ca - y * sa ;
		var ry:Number = x * ca + y * sa ;
		x = rx ;
		y = ry ;
	}

	public function rotateNew(angle:Number):Point 
	{
		var p:Point = new Point(x, y) ;
		p.rotate (angle) ;
		return p ;
	}

	public function scale(n:Number):Void 
	{
		x *= n ;
		y *= n ;
	}

	public function scaleNew(s:Number):Point 
	{
		return new Point( x * s , y * s ) ;
	}

	public function setAngle(n:Number):Void 
	{
		var r:Number = getLength() ;
		x = r * Trigo.cosD(n) ;
		y = r * Trigo.sinD(n) ;
	}
	
	public function setLength (n:Number) : Void 
	{
		var r:Number = getLength() ;
		if (isNaN(r) && r !=0) scale ( n / r ) ;
		else x = r ;
	}
	
	public function subtract(p:Object):Void 
	{
		x -= p.x ;
		y -= p.y ;
	}
	
	public function subtractNew(p:Point):Point 
	{
		return new Point(x - p.x, y - p.y) ;
	}

	public function swap(p:Point):Void 
	{
		var tx:Number = x ;
		var ty:Number = y ;
		x = p.x ;
		y = p.y ;
		p.x = tx ;
		p.y = ty ;
	}

	/**
	 * Returns a flash.geom.Point reference of this Point object.
	 * @return a flash.geom.Point reference of this Point object.
	 */
	public function toFlash():flash.geom.Point
	{
		return new flash.geom.Point(x,y) ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		return "new Point(" + x + "," + y + ")" ;
	}

	/**
	 * Returns the string representation of the object.
	 * @return the string representation of the object.
	 */ 
	public function toString():String 
	{
		return "("+ (x||0) + ","+ (y||0) + ")" ;
	}

	// ----o Static Private -  MTASC HACK - Macromedia FP8 Compatibility
	
	static private var __init:Boolean ;
	static private function initialize():Boolean 
	{
		if (__init) return false ;
		else {
			__init = true ;
			Point.prototype["add"] = Point.prototype.plusNew ;
			return true ;
		}
	}
	
	static private var __hack__:Boolean = Point.initialize() ;
	
}