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

/** Line

	AUTHOR
	
		Name : Line
		Package : asgard.geom
		Version : 1.0.0.0
		Date :  2005-05-17
		Author : eKameleon
		URL : http://www.ekameleon.net

	CONSTRUCTOR
	
		var l:Line = new Line(p_a:Number, p_b:Number, p_c:Number) ;

	PROPERTY SUMMARY
	
		- a:Number
		
		- b:Number
		
		- c:Number

	METHOD SUMMARY

		- clone()
		
		- static distance(p1:Point, p2:Point):Number
			return the distance between two points	
		
		- equals(o):Boolean
		
		- static getLine(p1:Point, p2:Point):Line
			Gets a line equation as two properties (a,b) such that (y = a*x + b) for any x
			or a unique c property such that (x = c) for all y
			The function takes two points as parameter, p0 and p1 containing two properties x and y
		
		- static getLineCross(l1:Line, l2:Line):Point
			return a point (x,y) that is the intersection of two lines
			a line is defined either by a and b parameters such that (y = a*x + b) for any x
			or a single parameter c such that (x = c) for all y	
			
		- static getMiddle(p1:Point, p2:Point):Point
			return the middle of a segment define by two points
		
		- static getPointOnSegment(p1:Point, p2:Point, ratio:Number):Point
			return a point on a segment [p1, p2] which distance from p1 is ratio of the length [p1, p2]
				
		- static getVectorLine(p:Point, v:Point):Line
			Gets a line equation as two properties (a,b) such that (y = a*x + b) for any x
			or a unique c property such that (x = c) for all y
			The function takes two parameters, a point p(x,y) through which the line passes
			and a direction vector v(x,y)
		
 		- toSource():String
		
		- toString():String

 
  	IMPLEMENTS

		ICloneable, IEquality, IHashable, ISerializable, IFormattable
		
	SEE ALSO
	
		Point
 
	THANKS
		
		Timothee Groleau >> http://timotheegroleau.com/Flash/articles/cubic_bezier/bezier_lib.as

----------------*/

import asgard.geom.Point;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IEquality;
import vegas.core.ISerializable;
import vegas.util.serialize.Serializer;

class asgard.geom.Line extends CoreObject implements ICloneable, IEquality, ISerializable {
	
	// ----o Constructor
	
	public function Line(p_a:Number, p_b:Number, p_c:Number) {
		a = p_a ;
		b = p_b ;
		c = p_c ;
	}
	
	// ----o Public Properties
	
	public var a:Number ;
	public var b:Number ;
	public var c:Number ;
	
	//  ------o Public Methods

	public function clone() {
		return new Line(a, b, c) ;
	}

	static public function distance(p1:Point, p2:Point):Number {
		return Point.distance(p1, p2) ;
	}
	
	public function equals(o):Boolean {
		return (o instanceof Line && o.a == a && o.b == b && o.c == c) ;
	}

	static public function getLine(p1:Point, p2:Point):Line {
		var x0:Number = p1.x;
		var y0:Number = p1.y;
		var x1:Number = p2.x;
		var y1:Number = p2.y;
		var l:Line = new Line() ;
		if (x0 == x1) {
			if (y0 == y1) l = null ;
			else l.c = x0 ; // Otherwise, the line is a vertical line
		} else {
			l.a = (y0 - y1) / (x0 - x1) ;
			l.b = y0 - (l.a * x0) ;
		}
		return l ;
	}

	static public function getLineCross(l1:Line, l2:Line):Point {
		if ( !l1 || !l2 ) return null ;
		var a0:Number = l1.a ;
		var b0:Number = l1.b ;
		var c0:Number = l1.c ;
		var a1:Number = l2.a ;
		var b1:Number = l2.b ;
		var c1:Number = l2.c ;
		var u:Number ;
		if ( !c0 && !c1 ) {
			if (a0 == a1) return null ; 
			u = (b1 - b0) / (a0 - a1);		
			return new Point (u , a0 * u + b0 ) ;
		} else {
			if (c0) {
				if (c1) return null ;
				else return new Point (c0, (a1*c0)+b1) ;
			} 
			else if (c1) return new Point(c1, (a0*c1) + b0) ;
		}
	}
	
	static public function getMiddle(p1:Point, p2:Point):Point {
		return Point.getMiddle(p1,p2) ;
	}
	
	static public function getPointOnSegment(p1:Point, p2:Point, ratio:Number):Point {
		return new Point ( p1.x + ((p2.x - p1.x) * ratio) , p1.y + ((p2.y - p1.y) * ratio) ) ;
	}
	
	static public function getVectorLine(p:Point, v:Point):Line {
		var l:Line = new Line() ;
		var x:Number = p.x;
		var vx = v.x ;
		if (vx == 0) l.c = x ;
		else {
			l.a = v.y / vx ;
			l.b = p.y - (l.a * x);
		}
		return l ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = Serializer.toSource(a) ;
		var sourceB:String = Serializer.toSource(b) ;
		var sourceC:String = Serializer.toSource(c) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB, sourceC]) ;
	}
	
	public function toString():String {
		return "[a:" + (isNaN(a) ? 0 : a) + ", b:" + (isNaN(b) ? 0 : b) + ", c:" + (isNaN(c) ? 0 : c) + ")" ;
	}

}