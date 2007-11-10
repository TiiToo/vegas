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
import pegas.geom.Bezier;
import pegas.geom.Line;
import pegas.geom.Vector2;

/**
 * This pen draw a bezier line curve in a MovieClip reference.
 * @author eKameleon
 */
class pegas.draw.BezierPen extends AbstractPen 
{

	/**
	 * Creates a new BezierPen instance.
	 */
	public function BezierPen(target:MovieClip, isNew:Boolean) 
	{
		initialize( target, isNew ) ;
	}

	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	public function clone() 
	{
		return new BezierPen( _target ) ;
	}
	
	/**
	 * Draw the bezier shape.
	 */
	public function draw(p1:Vector2, p2:Vector2, p3:Vector2, p4:Vector2, tolerance:Number):Void 
	{
		drawPoints( p1, p2, p3, p4, tolerance ) ;
	}

	public function drawCubicBezier(p0:Vector2, p1:Vector2, p2:Vector2, p3:Vector2, nSegment:Number, moveto:Boolean):Number 
	{
		if (nSegment < 2) 
		{
			nSegment = 4 ;
		}
		var nextT ; 
		var total:Number = 0 ; 
		var tStep:Number = 1 / nSegment ;
		var curT:Object  = {
			p : p0 ,
			l : Line.getLine( p0, p1 ) 
		} ;
		if (moveto) 
		{
			moveTo( p0.x, p0.y );
		}
		for (var i:Number = 1 ; i <= nSegment ; i++) 
		{
			nextT = Bezier.getCubicTgt( p0, p1, p2, p3, i * tStep ) ;
			total += sliceCubicBezierSegment( p0, p1, p2, p3, (i - 1) * tStep, i * tStep, curT, nextT, 0 ) ;
			curT = nextT ; 
		}
		return total ;
	}

	public function drawCubicBezier2(p0, p1, p2, p3):Void 
	{
		var pA:Vector2 = Line.getPointOnSegment( p0, p1, 3 / 4 );
		var pB:Vector2 = Line.getPointOnSegment( p3, p2, 3 / 4 );
		var dx:Number = (p3.x - p0.x) / 16 ;
		var dy:Number = (p3.y - p0.y) / 16 ;
		var pc_1:Vector2 = Line.getPointOnSegment( p0, p1, 3 / 8 );
		var pc_2:Vector2 = Line.getPointOnSegment( pA, pB, 3 / 8 );
		pc_2.x -= dx;
		pc_2.y -= dy;
		var pc_3 = Line.getPointOnSegment( pB, pA, 3 / 8 );
		pc_3.x += dx;
		pc_3.y += dy;
		var pc_4:Vector2 = Line.getPointOnSegment( p3, p2, 3 / 8 );
		var pa_1:Vector2 = Line.getMiddle( pc_1, pc_2 );
		var pa_2:Vector2 = Line.getMiddle( pA, pB );
		var pa_3:Vector2 = Line.getMiddle( pc_3, pc_4 );
		curveTo( pc_1.x, pc_1.y, pa_1.x, pa_1.y );
		curveTo( pc_2.x, pc_2.y, pa_2.x, pa_2.y );
		curveTo( pc_3.x, pc_3.y, pa_3.x, pa_3.y );
		curveTo( pc_4.x, pc_4.y, p3.x, p3.y );
	}

	public function drawCubicBezierSpline(p0:Vector2, p1:Vector2, p2:Vector2, p3:Vector2):Void 
	{
		var mid:Vector2 = Line.getMiddle( p1, p2 ) ;
		curveTo( p1.x, p1.y, mid.x, mid.y );
		curveTo( p2.x, p2.y, p3.x, p3.y );
	}

	public function drawPoints( /* p1:Vector2, p2:Vector2, p3:Vector2, p4:Vector2, tolerance:Number */ ):Void 
	{
		if (arguments.length == 1 && arguments[0] instanceof Array) 
		{
			var pts:Array = arguments[0] ;
			moveTo( pts[0].x, pts[0].y );
			for (var i:Number = 0; i < pts.length ;i++)
			{
				lineTo( pts[i].x, pts[i].y );
			}
		} 
		else 
		{
			var p1:Vector2 = arguments[0] ;
			var p2:Vector2 = arguments[1] ;
			var p3:Vector2 = arguments[2] ;
			var p4:Vector2 = arguments[3] ;
			var tolerance:Number = arguments[4] ;
			if (tolerance == undefined) tolerance = 5 ;
			moveTo( p1.x, p1.y );
			_create( p1, p2, p3, p4, Math.pow( tolerance, 2 ) ) ;
		}
	}

	/**
	 * Simulate the bezier pen result with a speed algorithm.
	 */
	public function simulate(p1:Vector2, p2:Vector2, p3:Vector2, p4:Vector2):Void 
	{
		var a,b,c,d,e,f,g,h,i,j:Number ;
		a = (p1.x + p2.x) / 2 ;
		b = (p1.y + p2.y) / 2 ;
		c = (p2.x + p3.x) / 2 ;
		d = (p2.y + p3.y) / 2 ;
		e = (p3.x + p4.x) / 2 ;
		f = (p3.y + p4.y) / 2 ;
		g = (a + c) / 2 ;
		h = (b + d) / 2 ;
		i = (c + e) / 2 ;
		j = (d + f) / 2 ;
		curveTo( a, b, g, h ) ;
		curveTo( c, d, i, j ) ;
		curveTo( e, f, p4.x, p4.y ) ;
	}
	
	/**
	 * Slice a cubic bezier segment and return the value.
	 */
	public function sliceCubicBezierSegment(p0:Vector2, p1:Vector2, p2:Vector2, p3:Vector2, u1, u2, tu1, tu2, recurs:Number):Number 
	{
		var p ;
		if (recurs > 10) 
		{
			p = tu2.p;
			lineTo( p.x, p.y );
			return 1 ;
		}
		var ctrlpt:Vector2 = Line.getLineCross( tu1.l, tu2.l ) ;
		var d:Number = 0 ;
		if ( (ctrlpt == null) || (Line.distance( tu1.p, ctrlpt ) > (d = Line.distance( tu1.p, tu2.p ))) || (Line.distance( tu2.p, ctrlpt ) > d) ) 
		{
			var result:Number = 0 ;
			var uMid:Number = (u1 + u2) / 2 ;
			var tuMid = Bezier.getCubicTgt( p0, p1, p2, p3, uMid ) ;
			result += sliceCubicBezierSegment( p0, p1, p2, p3, u1, uMid, tu1, tuMid, recurs + 1 ) ;
			result += sliceCubicBezierSegment( p0, p1, p2, p3, uMid, u2, tuMid, tu2, recurs + 1 ) ;
			return result ;
		} 
		else 
		{
			p = tu2.p ;
			curveTo( ctrlpt.x, ctrlpt.y, p.x, p.y ) ;
			return 1 ;
		}
	}

	/**
	 * @private
	 */
	private function _create(a:Vector2, b:Vector2, c:Vector2, d:Vector2, k:Number):Void 
	{
		var l1:Line = Line.getLine( a, b ) ;
		var l2:Line = Line.getLine( c, d ) ;
		var s:Vector2 = Line.getLineCross( l1, l2 ) ;
		var dx:Number = (a.x + d.x + s.x * 4 - (b.x + c.x) * 3) * .125 ;
		var dy:Number = (a.y + d.y + s.y * 4 - (b.y + c.y) * 3) * .125 ;
		if (dx * dx + dy * dy > k) 
		{
			var halves = Bezier.split( a, b, c, d ) ;
			var b0 = halves.b0 ;
			var b1 = halves.b1 ;
			_create( a, b0.b, b0.c, b0.d, k ) ;
			_create( b1.a, b1.b, b1.c, d, k ) ;
		} 
		else 
		{
			curveTo( s.x, s.y, d.x, d.y ) ;
		}
	}
}