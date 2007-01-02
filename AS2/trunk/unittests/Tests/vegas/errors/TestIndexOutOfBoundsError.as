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
import vegas.errors.IndexOutOfBoundsError;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.TestIndexOutOfBoundsError extends TestCase 
{

	function TestIndexOutOfBoundsError(name : String) 
	{
		super(name);
	}
	
	public var e:IndexOutOfBoundsError ;
	
	public function setUp():Void
	{
		e = new IndexOutOfBoundsError("my error") ;
	}	

	public function testConstructor()
	{
		assertNotNull( e, "ID_OUT_OF_BOUND_ER_00_01 - constructor is null") ;
		assertTrue( e instanceof IndexOutOfBoundsError , "ID_OUT_OF_BOUND_ER_00_02 - constructor is an instance of IndexOutOfBoundsError.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof FatalError , "ID_OUT_OF_BOUND_ER_01 - inherit FatalError failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "ID_OUT_OF_BOUND_ER_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( e.toString() , "[IndexOutOfBoundsError] my error", "ID_OUT_OF_BOUND_ER_03 - toString failed : " + e.toString() ) ;
	}

	public function testMessage():Void
	{
		assertEquals( e.message , "my error" , "ID_OUT_OF_BOUND_ER_05 - message property failed : " + e.message) ;	
	}
	
	public function testName():Void
	{
		assertEquals( e.name , "IndexOutOfBoundsError" , "ID_OUT_OF_BOUND_ER_06 - name property failed : " + e.name) ;	
	}

}