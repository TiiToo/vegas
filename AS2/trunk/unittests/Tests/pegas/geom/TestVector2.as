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

import pegas.geom.Vector2;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestVector2 extends TestCase 
{
	
	function TestVector2(name:String) 
	{
		super(name);
	}
	
	public var v:Vector2;
	
	public function setUp():Void
	{
		v = new Vector2(10, 20) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( v, "VECT_00_01 - constructor is null") ;
		assertTrue( v instanceof Vector2 , "VECT_00_02 - constructor is an instance of Vector2.") ;
	}
	
	public function testInherit()
	{
		assertTrue( v instanceof CoreObject , "VECT_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(v.hashCode()) , "VECT_02 - hashCode failed : " + v.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( v.toSource() , "new pegas.geom.Vector2(10,20)", "VECT_03 - toSource failed : " + v.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( v.toString() , "[Vector2:{10,20}]", "VECT_04 - toString failed : " + v.toString() ) ;
	}
	
	public function testX():Void
	{
		assertEquals( v.x , 10, "VECT_05 - x property failed : " + v.x ) ;
	}
	
	public function testY():Void
	{
		assertEquals( v.y , 20, "VECT_06 - y property failed : " + v.y ) ;
	}

	public function testClone():Void
	{
		var clone:Vector2 = v.clone() ;
		clone.x = 100 ;
		clone.y = 200 ;
		assertTrue( clone instanceof Vector2 , "VECT_09_01 - clone method failed, must return a Vector2 reference." ) ;
		assertFalse( v.x == clone.x, "VECT_09_02 - clone property failed, v.x:" + v.x + " must be different of clone.x:" + clone.x ) ;
		assertFalse( v.y == clone.y, "VECT_09_03 - clone property failed, v.y:" + v.y + " must be different of clone.y:" + clone.y ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Vector2 = v.copy() ;
		copy.x = 100 ;
		copy.y = 200 ;
		assertTrue( copy instanceof Vector2 , "VECT_10_01 - copy method failed, must return a Vector2 reference." ) ;
		assertFalse( v.x == copy.x, "VECT_10_02 - copy property failed, v.x:" + v.x + " must be different of copy.x:" + copy.x ) ;
		assertFalse( v.y == copy.y, "VECT_10_03 - copy property failed, v.y:" + v.y + " must be different of copy.y:" + copy.y ) ;
	}
	
	public function testEquals():Void
	{
		var ve:Vector2 = new Vector2(10, 20) ;
		assertTrue( v.equals(ve) , "VECT_11 - equals method failed.") ;
	}

	
}