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

import pegas.geom.Ray;
import pegas.geom.Vector3;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestRay extends TestCase 
{
	
	function TestRay(name:String) 
	{
		super(name);
	}
	
	public var r:Ray;
	
	public function setUp():Void
	{
		r = new Ray() ;
	}
	
	public function testConstructor()
	{
		assertNotNull( r, "RAY_00_01 - constructor is null") ;
		assertTrue( r instanceof Ray , "RAY_00_02 - constructor is an instance of Ray.") ;
	}
	
	public function testInherit()
	{
		assertTrue( r instanceof CoreObject , "RAY_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(r.hashCode()) , "RAY_02 - hashCode failed : " + r.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( r.toSource() , "new pegas.geom.Ray(new pegas.geom.Vector3(0,0,0),new pegas.geom.Vector3(0,0,0))", "RAY_03 - toSource failed : " + r.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( r.toString() , "[Ray:[Vector3:{0,0,0}] + t * [Vector3:{0,0,0}]]", "RAY_04 - toString failed : " + r.toString() ) ;
	}
	
	public function testP():Void
	{
		assertEquals( r.p , new Vector3(), "RAY_05 - p property failed : " + r.p ) ;
	}
	
	public function testV():Void
	{
		assertEquals( r.v , new Vector3(), "RAY_06 - v property failed : " + r.v ) ;
	}

	public function testQ():Void
	{
		assertEquals( r.q , new Vector3(), "RAY_06 - q property failed : " + r.q ) ;
	}

	public function testClone():Void
	{
		var clone:Ray = r.clone() ;
		assertTrue( clone instanceof Ray , "RAY_09_01 - clone method failed, must return a Ray reference." ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Ray = r.copy() ;
		assertTrue( copy instanceof Ray , "RAY_10_01 - copy method failed, must return a Ray reference." ) ;
	}
	
	public function testEquals():Void
	{
		var ve:Ray = new Ray() ;
		assertTrue( r.equals(ve) , "RAY_11 - equals method failed.") ;
	}

	
}