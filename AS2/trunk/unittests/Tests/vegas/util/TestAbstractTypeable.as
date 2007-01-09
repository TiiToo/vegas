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

import Tests.vegas.util.ConcreteAbstractTypeable;

import vegas.core.CoreObject;
import vegas.errors.TypeMismatchError;
import vegas.util.AbstractTypeable;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestAbstractTypeable extends TestCase
{
	
	function TestAbstractTypeable( name:String ) 
	{
		super(name);
	}

	public var o:ConcreteAbstractTypeable ;
	
	public function setUp():Void
	{
		o = new ConcreteAbstractTypeable( String ) ;
	}

	public function TestConstructor():Void 
	{
		assertNotNull( o, "A_TYP_01_01 constructor failed." ) ;
		assertTrue( o instanceof AbstractTypeable, "A_TYP_01_02 constructor failed." ) ;
	}

	public function TestInherit():Void 
	{
		assertTrue( o instanceof CoreObject, "A_TYP_02 constructor failed." ) ;
	}

	public function testGetType():Void 
	{
		assertEquals( o.getType(), String , "A_TYP_03_01 getType failed.") ;
	}

	public function testSetType():Void 
	{
		o.setType(Number) ;
		assertEquals( o.getType(), Number , "A_TYP_04_01 setType failed.") ;
		o.setType(String) ;
	}

	public function testSupports():Void
	{
		assertTrue( o.supports("hello") , "A_TYP_05_01 supports failed.") ;
		assertFalse( o.supports(2) , "A_TYP_05_02 supports failed.") ;
	}

	public function testValidate():Void 
	{
		try 
		{
			o.supports( "string" ) ;
			
		}
		catch(e)
		{
			fail("A_TYP_06_01 validate failed.") ;	
		}
		var isCatch:Boolean = false ;
		try
		{
			o.supports( 2 ) ;
		}
		catch(e:Error)
		{
			assertTrue(!e instanceof TypeMismatchError, "A_TYP_06_02 validate failed.") ;
		}
		finally
		{
			isCatch = true ;	
		}
		assertTrue( isCatch , "A_TYP_06_03 validate failed : " + isCatch) ;
	}
	

}