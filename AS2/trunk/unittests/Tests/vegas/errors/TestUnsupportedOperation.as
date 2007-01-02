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

import vegas.errors.AbstractError;
import vegas.errors.UnsupportedOperation;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.TestUnsupportedOperation extends TestCase 
{

	function TestUnsupportedOperation(name : String) 
	{
		super(name);
	}
	
	public var e:UnsupportedOperation ;
	
	public function setUp():Void
	{
		e = new UnsupportedOperation("my error") ;
	}	

	public function testConstructor()
	{
		assertNotNull( e, "UNS_OP_00_01 - constructor is null") ;
		assertTrue( e instanceof UnsupportedOperation , "UNS_OP_00_02 - constructor is an instance of UnsupportedOperation.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof AbstractError , "UNS_OP_01 - inherit AbstractError failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "UNS_OP_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( e.toString() , "[UnsupportedOperation] my error", "UNS_OP_03 - toString failed : " + e.toString() ) ;
	}

	public function testMessage():Void
	{
		assertEquals( e.message , "my error" , "UNS_OP_05 - message property failed : " + e.message) ;	
	}
	
	public function testName():Void
	{
		assertEquals( e.name , "UnsupportedOperation" , "UNS_OP_06 - name property failed : " + e.name) ;	
	}

}