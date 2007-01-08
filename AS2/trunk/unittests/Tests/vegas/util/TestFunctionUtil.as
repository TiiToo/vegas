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

import vegas.util.FunctionUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestFunctionUtil extends TestCase 
{

	function TestFunctionUtil(name : String) 
	{
		super(name);
	}
	
	public var f1:Function ;
	public var f2:Function ;
	
	public function setUp():Void
	{
		f1 = function()
		{
			return true ;
		} ;	
		f2 = function()
		{
			return false ;
		} ;	
	}
	
	public function testClone():Void
	{
		assertTrue( FunctionUtil.clone(f1) instanceof Function, "B_U_01_01 - static clone failed.") ;
		assertTrue( FunctionUtil.clone(f1) == f1, "B_U_01_02 - static clone failed.") ;
	}

	public function testCopy():Void
	{
		assertTrue( FunctionUtil.copy(f1) instanceof Function, "B_U_02_01 - static copy failed.") ;
		assertTrue( FunctionUtil.copy(f1) == f1, "B_U_02_02 - static copy failed.") ;
	}
	
	public function testEquals():Void
	{
		assertTrue( FunctionUtil.equals(f1, f1), "B_U_03_01 - static equals failed." ) ;
		assertTrue( FunctionUtil.equals(f2, f2), "B_U_03_02 - static equals failed." ) ;
		assertFalse( FunctionUtil.equals(f1, f2), "B_U_03_03 - static equals failed." ) ;
		assertFalse( FunctionUtil.equals(f2, f1), "B_U_03_04 - static equals failed." ) ;
	}
 	 
}