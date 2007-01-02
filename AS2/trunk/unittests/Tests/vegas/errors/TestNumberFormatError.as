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

import vegas.errors.FatalError;
import vegas.errors.NumberFormatError;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.TestNumberFormatError extends TestCase 
{

	function TestNumberFormatError(name : String) 
	{
		super(name);
	}
	
	public var e:NumberFormatError ;
	
	public function setUp():Void
	{
		e = new NumberFormatError("my error") ;
	}	

	public function testConstructor()
	{
		assertNotNull( e, "NUM_FORM_ER_00_01 - constructor is null") ;
		assertTrue( e instanceof NumberFormatError , "NUM_FORM_ER_00_02 - constructor is an instance of NumberFormatError.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof FatalError , "NUM_FORM_ER_01 - inherit FatalError failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "NUM_FORM_ER_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( e.toString() , "[NumberFormatError] my error", "NUM_FORM_ER_03 - toString failed : " + e.toString() ) ;
	}

	public function testMessage():Void
	{
		assertEquals( e.message , "my error" , "NUM_FORM_ER_05 - message property failed : " + e.message) ;	
	}
	
	public function testName():Void
	{
		assertEquals( e.name , "NumberFormatError" , "NUM_FORM_ER_06 - name property failed : " + e.name) ;	
	}

}