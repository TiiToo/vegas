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

import pegas.geom.Matrix;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestMatrix extends TestCase 
{
	
	function TestMatrix(name:String) 
	{
		super(name);
	}
	
	public var m:Matrix;
	
	public function setUp():Void
	{
		m = new Matrix(4, 3) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( m, "MATRIX_00_01 - constructor is null") ;
		assertTrue( m instanceof Matrix , "MATRIX_00_02 - constructor is an instance of Matrix.") ;
	}
	
	public function testInherit()
	{
		assertTrue( m instanceof CoreObject , "MATRIX_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(m.hashCode()) , "MATRIX_02 - hashCode failed : " + m.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( m.toSource() , "new pegas.geom.Matrix(4,3,[[undefined,undefined,undefined],[undefined,undefined,undefined],[undefined,undefined,undefined],[undefined,undefined,undefined]])", "MATRIX_03 - toSource failed : " + m.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( m.toString() , "[Matrix:{4,3}]", "MATRIX_04 - toString failed : " + m.toString() ) ;
	}
	
	public function testR():Void
	{
		assertEquals( m.r , 4, "MATRIX_05 - r property failed : " + m.r ) ;
	}
	
	public function testC():Void
	{
		assertEquals( m.c , 3, "MATRIX_06 - c property failed : " + m.c ) ;
	}

	public function testClone():Void
	{
		var clone:Matrix = m.clone() ;
		assertTrue( clone instanceof Matrix , "MATRIX_09_01 - clone method failed, must return a Matrix reference." ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Matrix = m.copy() ;
		assertTrue( copy instanceof Matrix , "MATRIX_10_01 - copy method failed, must return a Matrix reference." ) ;
	}
	
	public function testEquals():Void
	{
		var ve:Matrix = new Matrix(4,3) ;
		assertTrue( m.equals(ve) , "MATRIX_11 - equals method failed.") ;
	}

	
}