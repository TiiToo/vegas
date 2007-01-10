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

import pegas.geom.Matrix4;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestMatrix4 extends TestCase 
{
	
	function TestMatrix4(name:String) 
	{
		super(name);
	}
	
	public var m:Matrix4 ;
	
	public function setUp():Void
	{
		m = new Matrix4() ;
	}
	
	public function testConstructor()
	{
		assertNotNull( m, "MA4_00_01 - constructor is null") ;
		assertTrue( m instanceof Matrix4 , "MA4_00_02 - constructor is an instance of Matrix4.") ;
	}
	
	public function testInherit()
	{
		assertTrue( m instanceof CoreObject , "MA4_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(m.hashCode()) , "MA4_02 - hashCode failed : " + m.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( m.toSource() , "new pegas.geom.Matrix4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)", "MA4_03 - toSource failed : " + m.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( m.toString() , "[Matrix4:[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]", "MA4_04 - toString failed : " + m.toString() ) ;
	}
	
	public function testClone():Void
	{
		var clone:Matrix4 = m.clone() ;
		assertTrue( clone instanceof Matrix4 , "MA4_05_01 - clone method failed, must return a Matrix4 reference." ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Matrix4 = m.copy() ;
		assertTrue( copy instanceof Matrix4 , "MA4_06 - copy method failed, must return a Matrix4 reference." ) ;
	}
	
	public function testEquals():Void
	{
		var ve:Matrix4 = new Matrix4() ;
		assertTrue( m.equals(ve) , "MA4_07 - equals method failed.") ;
	}

	public function testN11():Void
	{
		assertEquals( m.n11, 1, "MA4_08 - n11 property failed : " + m.n11 ) ;
	}

	public function testN12():Void
	{
		assertEquals( m.n12, 0, "MA4_09 - n12 property failed : " + m.n12 ) ;
	}
	
	public function testN13():Void
	{
		assertEquals( m.n13, 0, "MA4_10 - n13 property failed : " + m.n13 ) ;
	}

	public function testN14():Void
	{
		assertEquals( m.n14, 0, "MA4_11 - n14 property failed : " + m.n14 ) ;
	}

	public function testN21():Void
	{
		assertEquals( m.n21, 0, "MA4_08 - n21 property failed : " + m.n21 ) ;
	}

	public function testN22():Void
	{
		assertEquals( m.n22, 1, "MA4_09 - n22 property failed : " + m.n22 ) ;
	}
	
	public function testN23():Void
	{
		assertEquals( m.n23, 0, "MA4_10 - n23 property failed : " + m.n23 ) ;
	}

	public function testN24():Void
	{
		assertEquals( m.n24, 0, "MA4_11 - n24 property failed : " + m.n24 ) ;
	}

	public function testN31():Void
	{
		assertEquals( m.n31, 0, "MA4_12 - n31 property failed : " + m.n31 ) ;
	}

	public function testN32():Void
	{
		assertEquals( m.n32, 0, "MA4_13 - n32 property failed : " + m.n32 ) ;
	}
	
	public function testN33():Void
	{
		assertEquals( m.n33, 1, "MA4_14 - n33 property failed : " + m.n33 ) ;
	}

	public function testN34():Void
	{
		assertEquals( m.n34, 0, "MA4_15 - n34 property failed : " + m.n34 ) ;
	}

	public function testN41():Void
	{
		assertEquals( m.n41, 0, "MA4_12 - n41 property failed : " + m.n41 ) ;
	}

	public function testN42():Void
	{
		assertEquals( m.n42, 0, "MA4_13 - n42 property failed : " + m.n42 ) ;
	}
	
	public function testN43():Void
	{
		assertEquals( m.n43, 0, "MA4_14 - n43 property failed : " + m.n43 ) ;
	}

	public function testN44():Void
	{
		assertEquals( m.n44, 1, "MA4_15 - n44 property failed : " + m.n44 ) ;
	}

}