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

/**Bezier

	AUTHOR
	
		Name : Bezier
		Package : asgard.geom
		Version : 1.0.0.0
		Date :  2006-01-07
		Author : eKameleon
		URL : http://www.ekameleon.net

	CONSTRUCTOR
	
		private

	METHOD SUMMARY

		- static split(p0:Point, p1:Point, p2:Point, p3:Point):Object
		
		- static getCubicDerivative(c0:Number, c1:Number, c2:Number, c3:Number, t:Number):Number
		
		- static getCubicPt(c0:Number, c1:Number, c2:Number, c3:Number, t:Number):Number
		
		- static getCubicTgt(p0:Point, p1:Point, p2:Point, p3:Point, t:Number):Object
 
	SEE ALSO
	
		Line, Point
 
 	THANKS
		
		Robert Penner : http://www.robertpenner.com
		Timothee Groleau : http://timotheegroleau.com/Flash/articles/cubic_bezier/bezier_lib.as
 
----------------*/

import asgard.geom.Line ;
import asgard.geom.Point ;

class asgard.geom.Bezier {
	
	// ----o Constructor
		
	private function Bezier() {
		//
	}

	//  ------o Public Methods

	static public function split(p0:Point, p1:Point, p2:Point, p3:Point):Object {
		var p01:Point = Line.getMiddle(p0, p1) ;
		var p12:Point = Line.getMiddle(p1, p2);
		var p23:Point = Line.getMiddle(p2, p3);
		var p02:Point = Line.getMiddle(p01, p12);
		var p13:Point = Line.getMiddle(p12, p23);
		var p03:Point = Line.getMiddle(p02, p13);
		return {
			b0: {a:p0,  b:p01, c:p02, d:p03} ,
			b1: {a:p03, b:p13, c:p23, d:p3 }  
		} ;
	}
	
	static public function getCubicDerivative(c0:Number, c1:Number, c2:Number, c3:Number, t:Number):Number {
		var g:Number = 3 * (c1 - c0) ;
		var b:Number = (3 * (c2 - c1)) - g ;
		var a:Number = c3 - c0 - b - g ;
		return ( 3*a*t*t + 2*b*t + g ) ;
	}

	static public function getCubicPt(c0:Number, c1:Number, c2:Number, c3:Number, t:Number):Number {
		var ts:Number = t*t ;
		var g:Number = 3 * (c1 - c0);
		var b:Number = (3 * (c2 - c1)) - g;
		var a:Number = c3 - c0 - b - g;
		return ( a*ts*t + b*ts + g*t + c0 ) ;
	}

	static public function getCubicTgt(p0:Point, p1:Point, p2:Point, p3:Point, t:Number):Object {
		var p = {};
		p.x = getCubicPt(p0.x, p1.x, p2.x, p3.x, t);
		p.y = getCubicPt(p0.y, p1.y, p2.y, p3.y, t);
		var v = {};
		v.x = getCubicDerivative(p0.x, p1.x, p2.x, p3.x, t);
		v.y = getCubicDerivative(p0.y, p1.y, p2.y, p3.y, t);
		var l = Line.getVectorLine(p, v);
		return { p : p , l : l } ;
	}

}