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

import pegas.geom.Quaternion;
import pegas.geom.Vector;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestQuaternion extends TestCase 
{
	
	function TestQuaternion(name:String) 
	{
		super(name);
	}
	
	public var q:Quaternion;
	
	public function setUp():Void
	{
		q = new Quaternion(10, 20, 30, 40) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( q, "QUAT_00_01 - constructor is null") ;
		assertTrue( q instanceof Quaternion , "QUAT_00_02 - constructor is an instance of Quaternion.") ;
	}
	
	public function testInherit()
	{
		assertTrue( q instanceof Vector , "QUAT_01 - inherit Vector failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(q.hashCode()) , "QUAT_02 - hashCode failed : " + q.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( q.toSource() , "new pegas.geom.Quaternion(10,20,30,40)", "QUAT_03 - toSource failed : " + q.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( q.toString() , "[Quaternion:{10,20,30,40}]", "QUAT_04 - toString failed : " + q.toString() ) ;
	}
	
	public function testX():Void
	{
		assertEquals( q.x , 10, "QUAT_05 - x property failed : " + q.x ) ;
	}
	
	public function testY():Void
	{
		assertEquals( q.y , 20, "QUAT_06 - y property failed : " + q.y ) ;
	}

	public function testZ():Void
	{
		assertEquals( q.z , 30, "QUAT_07 - z property failed : " + q.z ) ;
	}

	public function testW():Void
	{
		assertEquals( q.w , 40, "QUAT_08 - w property failed : " + q.w ) ;
	}

	public function testClone():Void
	{
		var clone:Quaternion = q.clone() ;
		clone.x = 100 ;
		clone.y = 200 ;
		clone.z = 300 ;
		clone.w = 400 ;
		assertTrue( clone instanceof Quaternion , "QUAT_09 - clone method failed, must return a Quaternion reference." ) ;
		assertFalse( q.x == clone.x, "QUAT_09 - clone property failed, q.x:" + q.x + " must be different of clone.x:" + clone.x ) ;
		assertFalse( q.y == clone.y, "QUAT_09 - clone property failed, q.y:" + q.y + " must be different of clone.x:" + clone.y ) ;
		assertFalse( q.z == clone.z, "QUAT_09 - clone property failed, q.z:" + q.z + " must be different of clone.z:" + clone.z ) ;
		assertFalse( q.w == clone.w, "QUAT_09 - clone property failed, q.w:" + q.w + " must be different of clone.w:" + clone.w ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Quaternion = q.copy() ;
		copy.x = 100 ;
		copy.y = 200 ;
		copy.z = 300 ;
		copy.w = 400 ;
		assertTrue( copy instanceof Quaternion , "QUAT_10 - copy method failed, must return a Quaternion reference." ) ;
		assertFalse( q.x == copy.x, "QUAT_09 - copy property failed, q.x:" + q.x + " must be different of copy.x:" + copy.x ) ;
		assertFalse( q.y == copy.y, "QUAT_09 - copy property failed, q.y:" + q.y + " must be different of copy.x:" + copy.y ) ;
		assertFalse( q.z == copy.z, "QUAT_09 - copy property failed, q.z:" + q.z + " must be different of copy.z:" + copy.z ) ;
		assertFalse( q.w == copy.w, "QUAT_09 - copy property failed, q.w:" + q.w + " must be different of copy.w:" + copy.w ) ;
	}

	public function testEquals():Void
	{
		var qe:Quaternion = new Quaternion(10, 20, 30, 40, 50) ;
		assertTrue( q.equals(qe) , "QUAT_10 - equals method failed.") ;
	}

}