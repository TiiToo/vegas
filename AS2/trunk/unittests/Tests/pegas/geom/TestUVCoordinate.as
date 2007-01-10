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

import pegas.geom.UVCoordinate;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestUVCoordinate extends TestCase 
{
	
	function TestUVCoordinate(name:String) 
	{
		super(name);
	}
	
	public var c:UVCoordinate ;
	
	public function setUp():Void
	{
		c = new UVCoordinate(10, 20) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( c, "UVC_00_01 - constructor is null") ;
		assertTrue( c instanceof UVCoordinate , "UVC_00_02 - constructor is an instance of UVCoordinate.") ;
	}
	
	public function testInherit()
	{
		assertTrue( c instanceof CoreObject , "UVC_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(c.hashCode()) , "UVC_02 - hashCode failed : " + c.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( c.toSource() , "new pegas.geom.UVCoordinate(10,20)", "UVC_03 - toSource failed : " + c.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( c.toString() , "[UVCoordinate:{10,20}]", "UVC_04 - toString failed : " + c.toString() ) ;
	}
	
	public function testU():Void
	{
		assertEquals( c.u , 10, "UVC_05 - u property failed : " + c.u ) ;
	}
	
	public function testV():Void
	{
		assertEquals( c.v , 20, "UVC_06 - v property failed : " + c.v ) ;
	}

	public function testClone():Void
	{
		var clone:UVCoordinate = c.clone() ;
		clone.u = 100 ;
		clone.v = 200 ;
		assertTrue( clone instanceof UVCoordinate , "UVC_09 - clone method failed, must return a UVCoordinate reference." ) ;
		assertFalse( c.u == clone.u, "UVC_09 - clone property failed, v.x:" + c.u + " must be different of clone.x:" + clone.u ) ;
		assertFalse( c.v == clone.v, "UVC_09 - clone property failed, v.y:" + c.v + " must be different of clone.x:" + clone.v ) ;
	}
	
	public function testCopy():Void
	{
		var copy:UVCoordinate = c.copy() ;
		copy.u = 100 ;
		copy.v = 200 ;
		assertTrue( copy instanceof UVCoordinate , "UVC_10 - copy method failed, must return a UVCoordinate reference." ) ;
		assertFalse( c.u == copy.u, "UVC_10 - copy property failed, c.u:" + c.u + " must be different of copy.u:" + copy.u ) ;
		assertFalse( c.v == copy.v, "UVC_10 - copy property failed, c.v:" + c.v + " must be different of copy.v:" + copy.v ) ;
	}
	
	public function testEquals():Void
	{
		var uv:UVCoordinate = new UVCoordinate(10, 20) ;
		assertTrue( c.equals(uv) , "UVC_11 - equals method failed.") ;
	}

	
}