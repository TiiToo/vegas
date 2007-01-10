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

import pegas.geom.Vector3;
import pegas.geom.Vertex;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestVertex extends TestCase 
{
	
	function TestVertex(name:String) 
	{
		super(name);
	}
	
	public var v:Vertex;
	
	public function setUp():Void
	{
		v = new Vertex(10, 20, 30, 100, 200, 300) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( v, "VERTEX_00_01 - constructor is null") ;
		assertTrue( v instanceof Vertex, "VERTEX_00_02 - constructor is an instance of Vertex.") ;
	}
	
	public function testInherit()
	{
		assertTrue( v instanceof Vector3 , "VERTEX_01 - inherit Vector3 failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(v.hashCode()) , "VERTEX_02 - hashCode failed : " + v.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( v.toSource() , "new pegas.geom.Vertex(10,20,30,100,200,300)", "VERTEX_03 - toSource failed : " + v.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( v.toString() , "[Vertex:{x:10,y:20,z:30,tx:100,ty:200,tz:300}]", "VERTEX_04 - toString failed : " + v.toString() ) ;
	}

	public function testSX():Void
	{
		assertEquals( v.sx , 0, "VERTEX_05 - sx property failed : " + v.sx ) ;
	}
	
	public function testSY():Void
	{
		assertEquals( v.sy , 0, "VERTEX_06 - sy property failed : " + v.sy ) ;
	}
	
	public function testTX():Void
	{
		assertEquals( v.tx , 100, "VERTEX_08 - tx property failed : " + v.tx ) ;
	}
	
	public function testTY():Void
	{
		assertEquals( v.ty , 200, "VERTEX_09 - ty property failed : " + v.ty ) ;
	}

	public function testTZ():Void
	{
		assertEquals( v.tz , 300, "VERTEX_10 - tz property failed : " + v.tz ) ;
	}

	public function testWX():Void
	{
		assertEquals( v.wx , 100, "VERTEX_11 - wx property failed : " + v.wx ) ;
	}
	
	public function testWY():Void
	{
		assertEquals( v.wy , 200, "VERTEX_12 - wy property failed : " + v.wy ) ;
	}

	public function testWZ():Void
	{
		assertEquals( v.wz , 300, "VERTEX_13 - wz property failed : " + v.wz ) ;
	}

	public function testX():Void
	{
		assertEquals( v.x , 10, "VERTEX_14 - x property failed : " + v.x ) ;
	}
	
	public function testY():Void
	{
		assertEquals( v.y , 20, "VERTEX_15 - y property failed : " + v.y ) ;
	}

	public function testZ():Void
	{
		assertEquals( v.z , 30, "VERTEX_07 - z property failed : " + v.z ) ;
	}
	
	public function testGetTransformVector3():Void
	{
		var tv:Vector3 = v.getTransformVector3() ;
		assertTrue(tv instanceof Vector3, "VERTEX_16_01 - getTransformVector3() method failed.") ;
		assertEquals(tv.x, 100, "VERTEX_16_01 - getTransformVector3() method failed with the x value.") ;
		assertEquals(tv.y, 200, "VERTEX_16_02 - getTransformVector3() method failed with the y value.") ;
		assertEquals(tv.z, 300, "VERTEX_16_03 - getTransformVector3() method failed with the z value.") ;
	}

	public function testGetWorldVector3():Void
	{
		var wv:Vector3 = v.getWorldVector3() ;
		assertTrue(wv instanceof Vector3, "VERTEX_17_01 - getWorldVector3() method failed.") ;
		assertEquals(wv.x, 100, "VERTEX_17_01 - getWorldVector3() method failed with the x value.") ;
		assertEquals(wv.y, 200, "VERTEX_17_02 - getWorldVector3() method failed with the y value.") ;
		assertEquals(wv.z, 300, "VERTEX_17_03 - getWorldVector3() method failed with the z value.") ;
	}

	public function testClone():Void
	{
		var clone:Vertex = v.clone() ;
		clone.x  =  1000 ;
		clone.y  =  2000 ;
		clone.z  =  3000 ;
		clone.sx =  4000 ;
		clone.sy =  5000 ;
		clone.tx =  6000 ;
		clone.ty =  7000 ;
		clone.tz =  8000 ;
		clone.wx =  9000 ;
		clone.wy = 10000 ;
		clone.wz = 11000 ;
		assertTrue( clone instanceof Vertex , "VERTEX_18 - clone method failed, must return a Vertex reference." ) ;
		assertFalse( v.x == clone.x   , "VERTEX_18 - clone property failed, v.x:"  + v.x  + " must be different of clone.x:" + clone.x   ) ;
		assertFalse( v.y == clone.y   , "VERTEX_18 - clone property failed, v.y:"  + v.y  + " must be different of clone.x:" + clone.y   ) ;
		assertFalse( v.z == clone.z   , "VERTEX_18 - clone property failed, v.z:"  + v.z  + " must be different of clone.z:" + clone.z   ) ;
		assertFalse( v.sx == clone.sx , "VERTEX_18 - clone property failed, v.sx:" + v.sx + " must be different of clone.sx:" + clone.sx ) ;
		assertFalse( v.sy == clone.sy , "VERTEX_18 - clone property failed, v.sy:" + v.sy + " must be different of clone.sy:" + clone.sy ) ;
		assertFalse( v.tx == clone.tx , "VERTEX_18 - clone property failed, v.tx:" + v.tx + " must be different of clone.tx:" + clone.tx ) ;
		assertFalse( v.ty == clone.ty , "VERTEX_18 - clone property failed, v.ty:" + v.ty + " must be different of clone.ty:" + clone.ty ) ;
		assertFalse( v.tz == clone.tz , "VERTEX_18 - clone property failed, v.tz:" + v.tz + " must be different of clone.tz:" + clone.tz ) ;
		assertFalse( v.wx == clone.tx , "VERTEX_18 - clone property failed, v.wx:" + v.wx + " must be different of clone.tx:" + clone.wx ) ;
		assertFalse( v.wy == clone.ty , "VERTEX_18 - clone property failed, v.wy:" + v.wy + " must be different of clone.ty:" + clone.wy ) ;
		assertFalse( v.wz == clone.tz , "VERTEX_18 - clone property failed, v.wz:" + v.wz + " must be different of clone.tz:" + clone.wz ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Vertex = v.copy() ;
		copy.x  =  1000 ;
		copy.y  =  2000 ;
		copy.z  =  3000 ;
		copy.sx =  4000 ;
		copy.sy =  5000 ;
		copy.tx =  6000 ;
		copy.ty =  7000 ;
		copy.tz =  8000 ;
		copy.wx =  9000 ;
		copy.wy = 10000 ;
		copy.wz = 11000 ;
		assertTrue( copy instanceof Vertex , "VERTEX_19 - copy method failed, must return a Vertex reference." ) ;
		assertFalse( v.x == copy.x   , "VERTEX_19 - copy property failed, v.x:"  + v.x  + " must be different of copy.x:" + copy.x   ) ;
		assertFalse( v.y == copy.y   , "VERTEX_19 - copy property failed, v.y:"  + v.y  + " must be different of copy.x:" + copy.y   ) ;
		assertFalse( v.z == copy.z   , "VERTEX_19 - copy property failed, v.z:"  + v.z  + " must be different of copy.z:" + copy.z   ) ;
		assertFalse( v.sx == copy.sx , "VERTEX_19 - copy property failed, v.sx:" + v.sx + " must be different of copy.sx:" + copy.sx ) ;
		assertFalse( v.sy == copy.sy , "VERTEX_19 - copy property failed, v.sy:" + v.sy + " must be different of copy.sy:" + copy.sy ) ;
		assertFalse( v.tx == copy.tx , "VERTEX_19 - copy property failed, v.tx:" + v.tx + " must be different of copy.tx:" + copy.tx ) ;
		assertFalse( v.ty == copy.ty , "VERTEX_19 - copy property failed, v.ty:" + v.ty + " must be different of copy.ty:" + copy.ty ) ;
		assertFalse( v.tz == copy.tz , "VERTEX_19 - copy property failed, v.tz:" + v.tz + " must be different of copy.tz:" + copy.tz ) ;
		assertFalse( v.wx == copy.tx , "VERTEX_19 - copy property failed, v.wx:" + v.wx + " must be different of copy.tx:" + copy.wx ) ;
		assertFalse( v.wy == copy.ty , "VERTEX_19 - copy property failed, v.wy:" + v.wy + " must be different of copy.ty:" + copy.wy ) ;
		assertFalse( v.wz == copy.tz , "VERTEX_19 - copy property failed, v.wz:" + v.wz + " must be different of copy.tz:" + copy.wz ) ;
	}

	public function testEquals():Void
	{
		var ve:Vector3 = new Vertex(10, 20, 30, 100, 200, 300) ;
		assertTrue( v.equals(ve) , "VERTEX_20 - equals method failed.") ;
	}

}