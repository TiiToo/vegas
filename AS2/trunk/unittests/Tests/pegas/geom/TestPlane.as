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

import pegas.geom.Plane;
import pegas.geom.Vector;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestPlane extends TestCase 
{
	
	function TestPlane(name:String) 
	{
		super(name);
	}
	
	public var p:Plane;
	
	public function setUp():Void
	{
		p = new Plane(10, 20, 30, 40) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( p, "PLANE_00_01 - constructor is null") ;
		assertTrue( p instanceof Plane, "PLANE_00_02 - constructor is an instance of Plane.") ;
	}
	
	public function testInherit()
	{
		assertTrue( p instanceof CoreObject , "PLANE_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(p.hashCode()) , "PLANE_02 - hashCode failed : " + p.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( p.toSource() , "new pegas.geom.Plane(10,20,30,40)", "PLANE_03 - toSource failed : " + p.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( p.toString() , "[Plane:{10,20,30,40}]", "PLANE_04 - toString failed : " + p.toString() ) ;
	}

	public function testA():Void
	{
		assertEquals( p.a , 10, "PLANE_05 - a property failed : " + p.a ) ;
	}

	public function testB():Void
	{
		assertEquals( p.b , 20, "PLANE_06 - b property failed : " + p.b ) ;
	}
	
	public function testC():Void
	{
		assertEquals( p.c , 30, "PLANE_07 - c property failed : " + p.c ) ;
	}
	
	public function testD():Void
	{
		assertEquals( p.d , 40, "PLANE_08 - d property failed : " + p.d ) ;
	}

	public function testClone():Void
	{
		var clone:Plane = p.clone() ;
		clone.a = 100 ;
		clone.b = 200 ;
		clone.c = 300 ;
		clone.d = 400 ;
		assertTrue( clone instanceof Plane , "PLANE_09 - clone method failed, must return a Plane reference." ) ;
		assertFalse( p.a == clone.a, "PLANE_09 - clone property failed, p.a:" + p.a + " must be different of clone.a:" + clone.a ) ;
		assertFalse( p.b == clone.b, "PLANE_09 - clone property failed, p.b:" + p.b + " must be different of clone.b:" + clone.b ) ;
		assertFalse( p.c == clone.c, "PLANE_09 - clone property failed, p.c:" + p.c + " must be different of clone.c:" + clone.c ) ;
		assertFalse( p.d == clone.d, "PLANE_09 - clone property failed, p.d:" + p.d + " must be different of clone.d:" + clone.d ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Plane = p.copy() ;
		copy.a = 100 ;
		copy.b = 200 ;
		copy.c = 300 ;
		copy.d = 400 ;
		assertTrue( copy instanceof Plane , "PLANE_10 - copy method failed, must return a Plane reference." ) ;
		assertFalse( p.a == copy.a, "PLANE_10 - copy property failed, p.a:" + p.a + " must be different of copy.a:" + copy.a ) ;
		assertFalse( p.b == copy.b, "PLANE_10 - copy property failed, p.b:" + p.b + " must be different of copy.b:" + copy.b ) ;
		assertFalse( p.c == copy.c, "PLANE_10 - copy property failed, p.c:" + p.c + " must be different of copy.c:" + copy.c ) ;
		assertFalse( p.d == copy.d, "PLANE_10 - copy property failed, p.d:" + p.d + " must be different of copy.d:" + copy.d ) ;
	}
	
	public function testEquals():Void
	{
		var pe:Plane = new Plane(10, 20, 30, 40) ;
		assertTrue( p.equals(pe) , "PLANE_11 - equals method failed.") ;
	}

	// FIXME : finish test of the setPlane method

	/*
	public function testSetPlane():Void
	{
		var v0:Vector = new Vector(0,0,0) ;
		var v1:Vector = new Vector(10,20,30) ;
		var v2:Vector = new Vector(50,100,150) ;
		var pl:Plane = new Plane() ;
		pl.setPlane(v0, v1, v2) ;
		assertTrue(false, "PLANE_11 - setPlane method failed : " + pl + " / " + pl.test) ;	
	}
	*/
	
}