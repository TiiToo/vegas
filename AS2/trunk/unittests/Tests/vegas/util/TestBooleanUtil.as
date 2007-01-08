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

import vegas.util.BooleanUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestBooleanUtil extends TestCase 
{

	function TestBooleanUtil(name : String) 
	{
		super(name);
	}
	
	public function testClone():Void
	{
		assertTrue(BooleanUtil.clone(true), "B_U_01_01 - static clone failed.") ;
		assertFalse(BooleanUtil.clone(false), "B_U_01_02 - static clone failed.") ;
	}

	public function testCopy():Void
	{
		assertTrue(BooleanUtil.copy(true), "B_U_02_01 - static copy failed.") ;
		assertFalse(BooleanUtil.copy(false), "B_U_02_02 - static copy failed.") ;
	}
	
	public function testEquals():Void
	{
		assertTrue( BooleanUtil.equals(true, true), "B_U_03_01 - static equals failed." ) ;
		assertTrue( BooleanUtil.equals(false, false), "B_U_03_02 - static equals failed." ) ;
		assertFalse( BooleanUtil.equals(true, false), "B_U_03_03 - static equals failed." ) ;
		assertFalse( BooleanUtil.equals(false, true), "B_U_03_04 - static equals failed." ) ;
	}

	public function testToBoolean():Void 
	{
		assertEquals( BooleanUtil.toBoolean(true), true,  "B_U_04_01 - static toBoolean failed." ) ;
		assertEquals( BooleanUtil.toBoolean(false), false,  "B_U_04_02 - static toBoolean failed." ) ;
	}

	public function testToNumber():Void 
	{
		assertEquals( BooleanUtil.toNumber(true), 1,  "B_U_05_01 - static toNumber failed." ) ;
		assertEquals( BooleanUtil.toNumber(false), 0,  "B_U_05_02 - static toNumber failed." ) ;
    }

	public function testToObject():Void
	{
		assertTrue( BooleanUtil.toObject(true) instanceof Boolean, "B_U_06_01 - static toObject failed." ) ;
		assertTrue( BooleanUtil.toObject(false) instanceof Boolean, "B_U_06_02 - static toObject failed." ) ;
    }

  	public function testToSource():Void
  	{
		assertEquals( BooleanUtil.toSource(true), "true",  "B_U_07_01 - static toSource failed." ) ;
		assertEquals( BooleanUtil.toSource(false), "false",  "B_U_07_02 - static toSource failed." ) ;
  	}
  	 
}