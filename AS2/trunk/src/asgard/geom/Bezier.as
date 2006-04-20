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

/** Bezier

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
 
**/

import asgard.geom.Line;
import asgard.geom.Point;

class asgard.geom.Bezier {
	
	// ----o Constructor
		
	private function Bezier() {
		//
	}

	//  ------o Public Methods

	/**
	 *	Calculer un tableau de points permettant de tracer une courbe Bezier quadratique bouclée ou non sur n-points.
	 */
	public static function createBezier(step:Number,points:Array,precision:Number,boucle:Boolean):Array {
		
		precision= isNaN(precision) ? 0 : precision ;
		if (boucle == undefined) boucle = true ;
		
		var pts:Array = [];
		var nbp:Number = points.length ;
		var i:Number=0 ;
		var lastpoint:Point = null ;
		
		var _p0:Point ;
		var _p1:Point ;
		var _p2:Point ;
		var t:Number ;
		
		var c1,c2, c3, nx, ny, u1:Number ;
		var npoint:Point ;
		
		while (i<nbp){

			_p0 = points[i] ;
			_p1 = (boucle)? points[(i+1)%nbp]:(points[(i+1)])? points[(i+1)]:_p0 ;
			_p2 = (boucle)? points[(i+2)%nbp]:(points[(i+2)])? points[(i+2)]:_p1 ;

			t = 0 ;

			while (t<=1){

				var p0:Point = new Point((_p0.x+_p1.x)/2,(_p0.y+_p1.y)/2);
				var p1:Point = new Point(_p1.x,_p1.y);
				var p2:Point = new Point((_p2.x+_p1.x)/2,(_p2.y+_p1.y)/2);
				
				u1 = 1 - t ;
				c1 = u1 * u1 ;
				c2 = 2 * t * u1 ;
				c3 = t * t ;
			
				nx = c1 * p0.x + c2 * p1.x + c3 * p2.x ;
				ny = c1 * p0.y + c2 * p1.y + c3 * p2.y ;
				
				npoint =new Point(nx,ny);
			
				if (lastpoint!=null) {
					
					if ( Point.distance(lastpoint,npoint) > precision ){
						lastpoint=npoint;
						pts.push(npoint);
					}
				} else {
					lastpoint = npoint ;
					pts.push(npoint) ;
				}

				t+=step ;
			}

			i++ ;
		}
		return pts ;
	}

	/**
	 *	Retourne le barycentre d'une série de points.
	 */
	public static function getBaryCenter(pts:Array):Point {
		var nbp:Number = pts.length ;
		var x:Number=0;
		var y:Number=0;
		while (--nbp>=0){
			x += pts[nbp].x ;
			y += pts[nbp].y ;
		}
		return new Point(x/pts.length,y/pts.length) ;
	}

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