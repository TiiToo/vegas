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

import vegas.util.DateUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestDateUtil extends TestCase 
{

	function TestDateUtil(name : String) 
	{
		super(name);
	}
	
	public var d1:Date ;
	public var d2:Date ;
	
	public function setUp():Void
	{
		d1 = new Date(2006, 1, 12) ;
		d2 = new Date(2005, 10, 20) ;
	}
	
	public function testClone():Void
	{
		assertTrue( DateUtil.clone(d1) instanceof Date, "D_U_01_01 - static clone failed.") ;
		assertTrue( DateUtil.clone(d1) == d1, "D_U_01_02 - static clone failed.") ;
		assertEquals(DateUtil.clone(d1), d1, "D_U_01_03 - static copy failed.") ;
	}

	public function testCopy():Void
	{
		assertTrue( DateUtil.copy(d1) instanceof Date, "D_U_02_01 - static copy failed.") ;
		assertFalse( DateUtil.copy(d1) == d1, "D_U_02_02 - static copy failed.") ;
		assertEquals(DateUtil.copy(d1), d1, "D_U_02_03 - static copy failed.") ;
	}
	
	public function testEquals():Void
	{
		assertTrue( DateUtil.equals(d1, d1), "D_U_03_01 - static equals failed." ) ;
		assertTrue( DateUtil.equals(d2, d2), "D_U_03_02 - static equals failed." ) ;
		assertFalse( DateUtil.equals(d1, d2), "D_U_03_03 - static equals failed." ) ;
		assertFalse( DateUtil.equals(d2, d1), "D_U_03_04 - static equals failed." ) ;
	}
 	 
}