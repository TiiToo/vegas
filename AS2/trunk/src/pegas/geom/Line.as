﻿/*

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
 
import pegas.geom.Vector2;
import pegas.util.Vector2Util;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IEquality;
import vegas.util.serialize.Serializer;

/**
 * Defines a linear equation of the form : {@code ax + by = c} with fixed real coefficients a, b and c such that a and b are not both zero.
 * <p><b>Example :</b></p>
 * {@code
 * var l:Line = new Line(10, 20, 5) ;
 * trace(l) ; // {a:10,b:20,c:5}
 * }
 */
class pegas.geom.Line extends CoreObject implements ICloneable, IEquality 
{
	
	/**
	 * Creates a new Line object.
	 * @param a the a component of the Line.
	 * @param b the b component of the Line.
	 * @param c the c component of the Line.
	 */
	public function Line( a:Number, b:Number, c:Number) 
	{
		this.a = a ;
		this.b = b ;
		this.c = c ;
	}
	
	/**
	 * Determinates the a component of the Line.
	 */
	public var a:Number ;

	/**
	 * Determinates the b component of the Line.
	 */
	public var b:Number ;

	/**
	 * Determinates the c component of the Line.
	 */
	public var c:Number ;

	/**
	 * Returns a shallow copy of this instance.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var l1:Line = new Line(10, 20, 30) ;
	 * var l2:Line = l1.clone() ;
	 * }
	 * @return a shallow copy of this instance.
	 */
	public function clone() 
	{
		return new Line(a, b, c) ;
	}

	/**
	 * Returns a deep copy of this instance.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var l1:Line = new Line(10, 20, 30) ;
	 * var l2:Line = l1.copy() ;
	 * }
	 * @return a deep copy of this instance.
	 */
	public function copy()
	{
		return new Line(a, b, c) ;	
	}

	/**
	 * Returns the distance between two vectors.
	 * {@code
	 * var v1:Vector2 = new Vector2(10,20) ;
	 * var v2:Vector2 = new Vector2(40,60) ;
	 * trace(Line.distance(p1,p2) ) ; // 50
	 * }
	 * @return the distance between two vectors.
	 */
	public static function distance( p1:Vector2, p2:Vector2 ):Number 
	{
		return Vector2Util.getDistance(p1, p2) ;
	}

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals( o ):Boolean 
	{
		return (o instanceof Line && o.a == a && o.b == b && o.c == c) ;
	}

	/**
	 * Returns a Line reference defines with the two vectors in argument. 
	 * This line is a line equation as two properties (a,b) such that (y = a*x + b) for any x or a unique c property such that (x = c) for all y.
	 * The function takes two points as parameter, p0 and p1 containing two properties x and y.
	 * @return a line equation as two properties (a,b) such that (y = a*x + b) for any x or a unique c property such that (x = c) for all y.
	 */
	public static function getLine( p1:Vector2, p2:Vector2 ):Line 
	{
		var x0:Number = p1.x;
		var y0:Number = p1.y;
		var x1:Number = p2.x;
		var y1:Number = p2.y;
		var l:Line = new Line() ;
		if (x0 == x1) 
		{
			if (y0 == y1)
			{
				l = null ;
			}
			else 
			{
				l.c = x0 ; // Otherwise, the line is a vertical line
			}
		}
		else 
		{
			l.a = (y0 - y1) / (x0 - x1) ;
			l.b = y0 - (l.a * x0) ;
		}
		return l ;
	}

	/**
	 * Returns a point (x,y) that is the intersection of two lines.
	 * A line is defined either by a and b parameters such that (y = a*x + b) for any x or 
	 * a single parameter c such that (x = c) for all y.
	 * @return a vector (x,y) that is the intersection of two lines.
	 */
	public static function getLineCross(l1:Line, l2:Line):Vector2
	{
		if ( l1 == null || l2 == null ) 
		{
			return null ;
		}
		var a0:Number = l1.a ;
		var b0:Number = l1.b ;
		var c0:Number = l1.c ;
		var a1:Number = l2.a ;
		var b1:Number = l2.b ;
		var c1:Number = l2.c ;
		var u:Number ;
		if ( !c0 && !c1 ) 
		{
			if (a0 == a1) 
			{
				return null ;
			} 
			u = (b1 - b0) / (a0 - a1);		
			return new Vector2 (u , a0 * u + b0 ) ;
		} 
		else 
		{
			if (c0) 
			{
				if (c1) 
				{
					return null ;
				}
				else 
				{
					return new Vector2 (c0, (a1*c0)+b1) ;
				}
			} 
			else if (c1) 
			{
				return new Vector2(c1, (a0*c1) + b0) ;
			}
		}
	}
	
	/**
	 * Returns the middle of a segment define by two points.
	 * @return the middle of a segment define by two points.
	 */
	public static function getMiddle(v1:Vector2, v2:Vector2):Vector2 
	{
		return Vector2Util.getMiddle(v1,v2) ;
	}
	
	/**
	 * Returns a point on a segment [p1, p2] which distance from p1 is ratio of the length [p1, p2].
	 * @return a point on a segment [p1, p2] which distance from p1 is ratio of the length [p1, p2].
	 */
	public static function getPointOnSegment(p1:Vector2, p2:Vector2, ratio:Number):Vector2 
	{
		return new Vector2( p1.x + ((p2.x - p1.x) * ratio) , p1.y + ((p2.y - p1.y) * ratio) ) ;
	}
	
	/**
	 * Returns a line equation as two properties (a,b) such that (y = a*x + b) for any x or a unique c property such that (x = c) for all y.
	 * The function takes two parameters, a point p(x,y) through which the line passes and a direction vector v(x,y).
	 * @return a line equation as two properties (a,b) such that (y = a*x + b) for any x.
	 */
	public static function getVectorLine(p:Vector2, v:Vector2):Line 
	{
		var l:Line = new Line() ;
		var x:Number = p.x;
		var vx = v.x ;
		if (vx == 0) 
		{
			l.c = x ;
		}
		else 
		{
			l.a = v.y / vx ;
			l.b = p.y - (l.a * x);
		}
		return l ;
	}

	/**
	 * Returns the Object representation of this object.
	 * @return the Object representation of this object.
	 */
	public function toObject():Object 
	{
		return { a:a , b:b , c:c } ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		var params:Array = [ Serializer.toSource(a) , Serializer.toSource(b) ] ;
		if ( !isNaN(c) ) 
		{
			params.push( Serializer.toSource(c) ) ;
		}
		return Serializer.getSourceOf(this, params ) ;
	}

	/**
	 * Returns the string representation of the object.
	 * @return the string representation of the object.
	 */ 
	public function toString():String 
	{
		var s:String = "[Line a:" + (isNaN(a) ? 0 : a) + ", b:" + (isNaN(b) ? 0 : b) ;
		if (!isNaN(c))
		{
			s += ", c:" + (isNaN(c) ? 0 : c) ;
		}
		s +=  "]" ;
		return s ;
	}

}