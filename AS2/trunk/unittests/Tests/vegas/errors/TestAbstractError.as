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

import Tests.vegas.errors.ConcreteAbstractError;

import vegas.errors.AbstractError;
import vegas.errors.ErrorElement;
import vegas.logging.ILogger;
import vegas.logging.LogEventLevel;

/**
 * @author eKameleon
 */
class Tests.vegas.errors.TestAbstractError extends TestCase 
{

	function TestAbstractError(name : String) 
	{
		super(name);
	}
	
	public var e:ConcreteAbstractError ;
	
	public var element:ErrorElement ;
	
	public function setUp():Void
	{
		element = new ErrorElement() ;
		e = new ConcreteAbstractError("my error", element) ; // use a concrete class of the AbstractError class.
	}
	
	public function testConstructor()
	{
		assertNotNull( e, "AE_00_01 - constructor is null") ;
		assertTrue( e instanceof ConcreteAbstractError , "AE_00_02 - constructor is an instance of ConcreteAbstractError.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof AbstractError , "AE_01 - inherit AstractError failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "AE_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( e.toString() , "[ConcreteAbstractError] my error", "AE_03 - toString failed : " + e.toString() ) ;
	}

	public function testErrorElement():Void
	{
		assertEquals( e.errorElement , element , "AE_04 - errorElement property failed : " + e.errorElement) ;	
	}

	public function testMessage():Void
	{
		assertEquals( e.message , "my error" , "AE_05 - message property failed : " + e.message) ;	
	}
	
	public function testName():Void
	{
		assertEquals( e.name , "ConcreteAbstractError" , "AE_06 - name property failed : " + e.name) ;	
	}

	public function testLog():Void
	{
		// TODO create a log target specific to receive logs in Unit tests !! 
	}
	
	public function testGetLogger():Void
	{
		var logger:ILogger = e.getLogger() ;
		assertNotNull( logger , "AE_08_01 - getLogger method failed, the logger not must be 'null' or 'undefined'.") ;
		assertTrue( logger instanceof ILogger , "AE_08_02 - getLogger method failed, the logger must be an instance or implementation of the interface ILogger.") ;
	}
	
	public function testGetLevel():Void
	{
		assertEquals( e.getLevel() , LogEventLevel.ERROR , "AE_09 - getLevel method failed : " + e.getLevel()) ;
	}

}