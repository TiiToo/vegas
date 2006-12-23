/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import buRRRn.ASTUce.TestCase;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestCoreObject extends TestCase 
{
	
	/**
	 * Creates a new TestCoreObject instance.
	 */
	function TestCoreObject(name : String) 
	{
		super(name);
	}
	
	public var o:CoreObject ;
	
	public function setUp():Void
	{
		o = new CoreObject() ;
	}
	
	public function testConstructor()
	{
		assertNotNull( o, "CO_00_01 - constructor is null") ;
		assertTrue( o instanceof CoreObject , "CO_00_02 - constructor is an instance of CoreObject.") ;
	}
	
	public function testInherit()
	{
		assertTrue( o instanceof Object , "CO_01 - inherit Object failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(o.hashCode()) , "CO_02 - hashCode failed : " + o.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( o.toSource() , "new vegas.core.CoreObject()", "CO_03 - toSource failed : " + o.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( o.toString() , "[CoreObject]", "CO_04 - toString failed : " + o.toString() ) ;
	}

}