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

import buRRRn.ASTUce.TestCase;

import pegas.geom.Point;
import pegas.geom.Vector2;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestPoint extends TestCase 
{
	
	function TestPoint(name:String) 
	{
		super(name);
	}
	
	public var p:Point;
	
	public function setUp():Void
	{
		p = new Point(10, 20) ;
	}
	
	public function testConstructor()
	{
		
		assertNotNull( p, "POINT_00_01 - constructor is null") ;
		assertTrue( p instanceof Point , "POINT_00_02 - constructor is an instance of Point.") ;
		
		var p1:Point = new Point() ;
		assertEquals( p1.x , 0 , "POINT_00_03_01 - constructor failed with 0 argument : " + p1) ;
		assertEquals( p1.y , 0 , "POINT_00_03_02 - constructor failed with 0 argument : " + p1) ;
		
		var p2:Point = new Point( p ) ;
		assertEquals( p2.x , 10, "POINT_00_03_03 - constructor failed with the p.x argument : " + p2) ;
		assertEquals( p2.y , 20, "POINT_00_03_04 - constructor failed with the p.y argument : " + p2) ;

		var p3:Point = new Point( 50 , 60 ) ;
		assertEquals( p3.x , 50, "POINT_00_03_05 - constructor failed with the first argument : " + p3) ;
		assertEquals( p3.y , 60, "POINT_00_03_06 - constructor failed with the second argument : " + p3) ;
				
	}
	
	public function testInherit()
	{
		assertTrue( p instanceof CoreObject , "POINT_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(p.hashCode()) , "POINT_02 - hashCode failed : " + p.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( p.toSource() , "new pegas.geom.Point(10,20)", "POINT_03 - toSource failed : " + p.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( p.toString() , "[Point:{10,20}]", "POINT_04 - toString failed : " + p.toString() ) ;
	}
	
	public function testX():Void
	{
		assertEquals( p.x , 10, "POINT_05 - x property failed : " + p.x ) ;
	}
	
	public function testY():Void
	{
		assertEquals( p.y , 20, "POINT_06 - y property failed : " + p.y ) ;
	}

	public function testClone():Void
	{
		var clone:Point = p.clone() ;
		clone.x = 100 ;
		clone.y = 200 ;
		assertTrue( clone instanceof Point , "POINT_09_01 - clone method failed, must return a Vector2 reference." ) ;
		assertFalse( p.x == clone.x, "POINT_09_02 - clone property failed, p.x:" + p.x + " must be different of clone.x:" + clone.x ) ;
		assertFalse( p.y == clone.y, "POINT_09_03 - clone property failed, p.y:" + p.y + " must be different of clone.y:" + clone.y ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Point = p.copy() ;
		copy.x = 100 ;
		copy.y = 200 ;
		assertTrue( copy instanceof Vector2 , "POINT_10_01 - copy method failed, must return a Point reference." ) ;
		assertFalse( p.x == copy.x, "POINT_10_02 - copy property failed, p.x:" + p.x + " must be different of copy.x:" + copy.x ) ;
		assertFalse( p.y == copy.y, "POINT_10_03 - copy property failed, p.y:" + p.y + " must be different of copy.y:" + copy.y ) ;
	}
	
	public function testEquals():Void
	{
		var pe:Point = new Point(10, 20) ;
		assertTrue( p.equals(pe) , "POINT_11 - equals method failed.") ;
	}

	public function testAngle():Void
	{
		assertEquals( String(p.angle) , String(63.434948822922), "POINT_12 - angle property failed : " + p.angle ) ;
	}
	
	public function testLength():Void
	{
		assertEquals( String(p.length), String(22.3606797749979), "POINT_13 - length property failed : " + p.length ) ;
	}
	
	public function testAbs():Void
	{
		var p1:Point = new Point(-10,-10) ;
		p1.abs() ; 
		assertEquals( p1.x , 10, "POINT_14_01 - abs method failed : " + p1 ) ;
		assertEquals( p1.y , 10, "POINT_14_02 - abs method failed : " + p1 ) ;
	}

	public function testAbsNew():Void
	{
		var p1:Point = new Point(-10,-10) ;
		var p2:Point = p1.absNew() ;
		assertFalse( p1 == p2 , "POINT_15_01 - absNew method failed p1 must be different of p2." ) ;
		assertEquals( p2.x , 10, "POINT_15_02 - absNew method failed : " + p2 ) ;
		assertEquals( p2.y , 10, "POINT_15_03 - absNew method failed : " + p2 ) ;
	}

	public function testAngleBetween():Void
	{
		var angle:Number = p.angleBetween(new Point(50, 200)) ;
		assertEquals( String(angle), String(12.5288077091515), "POINT_16 - angleBetween method failed : " + angle ) ;
	}

	public function testCross():Void
	{
		var p1:Point = new Point(10,20) ;
		var p2:Point = new Point(40,60) ;
		assertEquals( p1.cross(p2), -200, "POINT_17 - cross method failed.") ;
	}

	public function testDistance():Void
	{
		var p1:Point = new Point(10,20) ;
		var p2:Point = new Point(40,60) ;
		assertEquals( Point.distance(p1,p2) , 50, "POINT_18 - distance method failed.") ;
	}

	public function testDot():Void
	{
		var p1:Point = new Point(10,20) ;
		var p2:Point = new Point(40,60) ;
		assertEquals( p1.dot(p2) , 1600, "POINT_19 - dot method failed.") ;
	}

	public function testGetAngle():Void
	{
		assertEquals( String(p.getAngle()) , String(63.434948822922), "POINT_20 - getAngle method failed : " + p.getAngle() ) ;
	}

	public function testGetDirection():Void
	{
		var d:Point = p.getDirection() ;
		var r:Point = new Point(0.447213595499958,0.894427190999916) ;
		assertEquals( d, r, "POINT_21 - getDirection method failed : " + d ) ;
	}

	public function testGetLength():Void
	{
		assertEquals( String(p.getLength()), String(22.3606797749979), "POINT_23 - getLength method failed : " + p.getLength() ) ;
	}

	public function testGetMiddle():Void
	{
		var p1:Point = new Point(10,10) ;
		var p2:Point = new Point(20,20) ;
		var middle:Point = Point.getMiddle(p1,p2) ;
		assertEquals( middle, new Point(15,15), "POINT_24 - getMiddle method failed : " + middle ) ;
	}

	public function testGetNormal():Void
	{
		var p:Point = new Point(10,10) ;
		var n:Point = p.getNormal() ;
		assertEquals( n, new Point(-10,10), "POINT_25 - getNormal method failed : " + n ) ;
	}

	public function testGetProjectionLength():Void
	{
		var p1:Point = new Point(10,10) ;
		var p2:Point = new Point(100,200) ;
		var size:Number = p1.getProjectionLength(p2) ;
		assertEquals( size, 0.06, "POINT_26 - getProjectionLength method failed : " + size ) ;
	}
	
	public function testInterpolate():Void
	{
		var p1:Point = new Point(10,10) ;
		var p2:Point = new Point(40,40) ;
		var p3:Point = Point.interpolate( p1 , p2, 0 ) ;
		assertEquals( p3, new Point(40,40), "POINT_27_01 - interpolate method failed : " + p3 ) ;
		p3 = Point.interpolate( p1 , p2, 1 ) ;
		assertEquals( p3, new Point(10,10), "POINT_27_02 - interpolate method failed : " + p3 ) ;
		p3 = Point.interpolate( p1 , p2, 0.5 ) ;
		assertEquals( p3, new Point(25,25), "POINT_27_03 - interpolate method failed : " + p3 ) ;
	}
	
	public function testIsPerpTo():Void
	{
		var p1:Point = new Point(0,10) ;
		var p2:Point = new Point(10,10) ;
		var p3:Point = new Point(10,0) ;
		assertFalse ( p1.isPerpTo(p2) , "POINT_28_01 - isPerpTo method failed." ) ;
		assertTrue  ( p1.isPerpTo(p3) , "POINT_28_02 - isPerpTo method failed." ) ;
	}

	public function testMax():Void
	{
		var p1:Point = new Point(10,100) ;
		var p2:Point = new Point(100,10) ;
		var p3:Point = p1.max(p2) ;
		assertEquals( p3, new Point(100,100), "POINT_29 - max method failed : " + p3 ) ;
	}

	public function testMin():Void
	{
		var p1:Point = new Point(10,100) ;
		var p2:Point = new Point(100,10) ;
		var p3:Point = p1.min(p2) ;
		assertEquals( p3, new Point(10,10), "POINT_30 - min method failed : " + p3 ) ;
	}

	public function testNegate():Void
	{
		var p1:Point = new Point(10,20) ;
		p1.negate() ;
		assertEquals( p1, new Point(-10,-20), "POINT_31 - negate method failed : " + p1 ) ;
	}

	public function testNegateNew():Void
	{
		var p1:Point = new Point(10,20) ;
		var p2:Point = p1.negateNew() ;
		assertEquals( p2, new Point(-10,-20), "POINT_32 - negateNew method failed : " + p2 ) ;
	}
	
	public function testNormalize():Void
	{
		var p1:Point = new Point(0,5) ;
		p1.normalize() ;
		assertEquals( p1, new Point(0,1), "POINT_33 - normalize method failed : " + p1 ) ;
	}
	
	public function testOffset():Void
	{
		var p1:Point = new Point(10,10) ;
		p1.offset(10,10) ;
		assertEquals( p1, new Point(20,20), "POINT_33 - offset method failed : " + p1 ) ;
	}
	
	public function testPolar():Void
	{
		var polar:Point = Point.polar( 5, Math.atan(3/4) ) ;
		assertEquals( polar, new Point(4,3), "POINT_34 - polar method failed : " + polar ) ;
	}

}