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

import vegas.util.ObjectUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestObjectUtil extends TestCase 
{

	function TestObjectUtil(name : String) 
	{
		super(name);
	}
	
	public function testClone():Void
	{
		var o:Object = {} ;
		assertEquals(ObjectUtil.clone(o), o , "O_U_01 - static clone failed.") ;
	}

	public function testCopy():Void
	{
		var o1:Object = { prop1:[2, 3, 4] , prop2:"hello world"} ;
		var o2:Object = { prop1:[2, 3, 4], prop2:"hello world"} ;
		assertEquals( o1, o2 , "O_U_02_01 - static copy failed.") ;
	}
	
	public function testHasProperty():Void
	{
		var o:Object = { prop1:1 , prop2:"hello world"} ;
		assertTrue( ObjectUtil.hasProperty(o, "prop1"), "B_U_03_01 - static hasProperty failed." ) ;
		assertFalse( ObjectUtil.hasProperty(o, "prop3"), "B_U_03_02 - static hasProperty failed." ) ;

	}
	
	public function testIsEmpty():Void
	{
		var o1:Object = { prop1:1 , prop2:"hello world"} ;
		var o2:Object = {} ;
		assertFalse( ObjectUtil.isEmpty(o1) , "B_U_04_01 - static isEmpty failed." ) ;
		assertTrue ( ObjectUtil.isEmpty(o2) , "B_U_04_02 - static isEmpty failed." ) ;
	}


	public function testMemberwiseClone():Void
	{
		var o1:Object = { prop1:1 , prop2:"hello world"} ;
		var o2:Object = ObjectUtil.memberwiseClone(o1) ;
		assertEquals(o1, o2, "B_U_05 - static memberwiseClone failed." ) ;
	}
	
	public function testReferenceEquals():Void
	{
		var o1:Object = { prop1:1 , prop2:"hello world"} ;
		var o2:Object = {} ;
		assertTrue  ( ObjectUtil.referenceEquals(o1, o1) , "B_U_06_01 - static referenceEquals failed." ) ;
		assertFalse ( ObjectUtil.referenceEquals(o1, o2) , "B_U_06_02 - static referenceEquals failed." ) ;
	}

	public function testToBoolean():Void 
	{
		var o:Object = { prop1:1 , prop2:"hello world"} ;
		assertEquals( ObjectUtil.toBoolean(o), true,  "B_U_07 - static toBoolean failed." ) ;
	}

	public function testToNumber():Void 
	{
		var o:Object = { prop1:1 , prop2:"hello world"} ;
		assertEquals( ObjectUtil.toNumber(o), NaN,  "B_U_08 - static toNumber failed." ) ;
    }

	public function testToObject():Void
	{
		assertTrue( ObjectUtil.toObject(2) instanceof Number, "B_U_09 - static toObject failed." ) ;
    }
  	 
}