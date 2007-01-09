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

import vegas.util.ErrorUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestErrorUtil extends TestCase 
{

	function TestErrorUtil(name : String) 
	{
		super(name);
	}
	
	public var e1:Error ;
	public var e2:Error ;
	
	public function setUp():Void
	{
		e1 = new Error("hello") ;
		e2 = new Error("world") ;
	}
	
	public function testClone():Void
	{
		assertTrue( ErrorUtil.clone(e1) instanceof Error, "E_U_01_01 - static clone failed.") ;
		assertEquals( ErrorUtil.clone(e1), e1, "E_U_01_02 - static clone failed.") ;
	}

	public function testCopy():Void
	{
		assertTrue( ErrorUtil.copy(e1) instanceof Error, "E_U_02_01 - static copy failed.") ;
		assertEquals( ErrorUtil.copy(e1), e1, "E_U_02_02 - static copy failed.") ;
		assertFalse( ErrorUtil.copy(e1) == e1, "E_U_02_03 - static copy failed.") ;
	}
	
	public function testEquals():Void
	{
		var er:Error = new Error("hello") ;
		assertTrue( ErrorUtil.equals(e1, e1), "E_U_03_01 - static equals failed." ) ;
		assertTrue( ErrorUtil.equals(e1, er), "E_U_03_02 - static equals failed." ) ;
		assertFalse( ErrorUtil.equals(e1, e2), "E_U_03_03 - static equals failed." ) ;
	}

	public function testToSource():Void
	{
		assertEquals( ErrorUtil.toSource(e1), 'new Error("hello")', "E_U_04_01 - static toSource failed : " + ErrorUtil.toSource(e1)) ;
		assertEquals( ErrorUtil.toSource(e2), 'new Error("world")', "E_U_04_01 - static toSource failed : " + ErrorUtil.toSource(e2)) ;
	}

}