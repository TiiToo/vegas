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
import vegas.errors.ErrorElement;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.TestErrorElement extends TestCase 
{

	function TestErrorElement(name : String) 
	{
		super(name);
	}
	
	public var e:ErrorElement ;
	
	public function setUp():Void
	{
		e = new ErrorElement(this, "setUp", ["arg1", "arg2"], "TestErrorElement.as", 44, false) ;
	}	

	public function testConstructor()
	{
		assertNotNull( e, "ER_ELMT_00_01 - constructor is null") ;
		assertTrue( e instanceof ErrorElement , "ER_ELMT_00_02 - constructor is an instance of ErrorElement.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof CoreObject , "ER_ELMT_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "ER_ELMT_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( e.toString() , "[ErrorElement]", "ER_ELMT_03 - toString failed : " + e.toString() ) ;
	}

	public function testEquals():Void 
	{
		var test:ErrorElement = new ErrorElement(this, "setUp", ["arg1", "arg2"], "TestErrorElement.as", 44, false) ;
		var result:Boolean = e.equals(test) ;
		assertTrue( result , "ER_ELMT_04 - equals method failed : " + result ) ;
	}
	
	public function TestGetArguments():Void 
	{
		assertEquals(e.getArguments(), ["arg1", "arg2"], "ER_ELMT_05 - getArguments method failed : " + e.getArguments()) ;
	}
	
	public function TestGetConstructorName():Void 
	{
		assertEquals(e.getConstructorName(), "TestErrorElement", "ER_ELMT_06 - getConstructorName method failed : " + e.getConstructorName()) ;
	}
	
	public function TestGetConstructorPath():Void 
	{
		assertEquals(e.getConstructorPath(), "Tests.vegas.errors.TestErrorElement", "ER_ELMT_07 - getConstructorPath method failed : " + e.getConstructorPath()) ;
	}
	
	public function TestGetFileName():Void 
	{
		assertEquals(e.getFileName(), "TestErrorElement.as", "ER_ELMT_08 - getFileName method failed : " + e.getFileName()) ;
	}

	public function TestGetLineNumber():Void 
	{
		assertEquals(e.getLineNumber(), 44, "ER_ELMT_09 - getLineNumber method failed : " + e.getLineNumber()) ;
	}
	
	public function TestGetMethodName():Void 
	{
		assertEquals(e.getMethodName(), "setUp", "ER_ELMT_10 - getMethodName method failed : " + e.getMethodName()) ;
	}
	
	public function TestGetThrower():Void 
	{
		assertEquals(e.getThrower(), this, "ER_ELMT_11 - getThrower method failed.") ;
	}

	public function TestIsNativeMethod():Void
	{
		assertFalse(e.isNativeMethod(), "ER_ELMT_12 - isNativeMethod method failed : " + e.isNativeMethod()) ;
	} 

}