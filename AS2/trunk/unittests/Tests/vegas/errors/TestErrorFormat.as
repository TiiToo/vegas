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
import vegas.core.IFormat;
import vegas.errors.ErrorFormat;
import vegas.errors.FatalError;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.TestErrorFormat extends TestCase 
{

	function TestErrorFormat(name : String) 
	{
		super(name);
	}
	
	public var e:ErrorFormat ;
	
	public function setUp():Void
	{
		e = new ErrorFormat(  ) ;
	}	

	public function testConstructor()
	{
		assertNotNull( e, "ER_FORM_00_01 - constructor is null") ;
		assertTrue( e instanceof ErrorFormat , "ER_FORM_00_02 - constructor is an instance of ErrorFormat.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof CoreObject , "ER_FORM_01 - inherit CoreObject failed.") ;
	}
	
	public function testImplement()
	{
		assertTrue( e instanceof IFormat , "ER_FORM_01 - inherit CoreObject failed.") ;
	}		
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "ER_FORM_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( e.toString() , "[ErrorFormat]", "ER_FORM_03 - toString failed : " + e.toString() ) ;
	}

	public function testFormatToString():Void
	{
		var format:String = e.formatToString(new FatalError("hello")) ;
		assertEquals( format , "[FatalError] hello" , "ER_FORM_04 - formatToString failed : " + format) ;
	}

}