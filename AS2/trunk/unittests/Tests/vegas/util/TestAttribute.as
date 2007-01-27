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

import vegas.util.Attribute;
import vegas.util.AttributeType;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestAttribute extends TestCase 
{

	function TestAttribute(name : String) 
	{
		super(name);
	}

	public var a:Attribute ;

	public function setUp():Void
	{
		a = new Attribute(true, true, true) ;
	}

	public function testConstructor():Void 
	{
		assertNotNull( a , "ATTR_01_01 - constructor failed, the instance not must be null." ) ;
		assertTrue (a instanceof Attribute, "ATTR_01_02 - constructor failed isn't an instance of Attribute.") ;
	}

	public function testInherit():Void 
	{
		assertTrue( a instanceof vegas.core.CoreObject , "ATTR_02 - inherit vegas.core.CoreObject failed." ) ;
	}

	public function testHashCode():Void 
	{
		assertFalse( isNaN(a.hashCode()) , "ATTR_03 - hashCode failed." ) ;
	}

	public function testDontEnum():Void
	{
		assertTrue( a.dontEnum, "ATTR_04 - dontEnum property failed") ;
	}
	
	public function testDontDelete():Void
	{
		assertTrue(a.dontDelete, "ATTR_05 - dontDelete property failed") ;
	}
	
	public function testReadOnly():Void
	{
		assertTrue(a.readOnly, "ATTR_06 - readOnly property failed") ;
	}

	public function testGetAttribute():Void
	{
		var o:Object = { prop1:"value1" , prop2:"value2" } ;
		var a:Attribute ;
		
		a = Attribute.getAttribute(o, "prop1") ;
		assertFalse(a.dontEnum, "ATTR_07_01 - getAttribute failed : " + a.toString()) ;
		assertFalse(a.dontDelete, "ATTR_07_02 - getAttribute failed : " + a.toString()) ;
		assertFalse(a.readOnly, "ATTR_07_03 - getAttribute failed : " + a.toString()) ;

		_global.ASSetPropFlags(o, ["prop1"], 1, 0) ;
		a = Attribute.getAttribute(o, "prop1") ;
		assertTrue(a.dontEnum, "ATTR_07_04 - getAttribute failed : " + a.toString()) ;
		assertFalse(a.dontDelete, "ATTR_07_05 - getAttribute failed : " + a.toString()) ;
		assertFalse(a.readOnly, "ATTR_07_06 - getAttribute failed : " + a.toString()) ;

		_global.ASSetPropFlags(o, ["prop1"], 7, 1) ;
		a = Attribute.getAttribute(o, "prop1") ;
		assertTrue(a.dontEnum, "ATTR_07_04 - getAttribute failed : " + a.toString()) ;
		assertTrue(a.dontDelete, "ATTR_07_05 - getAttribute failed : " + a.toString()) ;
		assertTrue(a.readOnly, "ATTR_07_06 - getAttribute failed : " + a.toString()) ;
		
	}

	public function testIsDontDelete():Void
	{
		var o:Object = { prop1:"value1" , prop2:"value2" } ;
		assertFalse( Attribute.isDontDelete(o, "prop1") , "ATTR_08_01 - isDontDelete failed." ) ;
		_global.ASSetPropFlags(o, ["prop1"], 7, 1) ;
		assertTrue( Attribute.isDontDelete(o, "prop1"), "ATTR_08_02 - isDontDelete failed.") ;
	}

	public function testIsDontEnum():Void
	{
		var o:Object = { prop1:"value1" , prop2:"value2" } ;
		assertFalse( Attribute.isDontEnum(o, "prop1") , "ATTR_09_01 - isDontEnum failed." ) ;
		_global.ASSetPropFlags(o, ["prop1"], 7, 1) ;
		assertTrue( Attribute.isDontEnum(o, "prop1"), "ATTR_09_02 - isDontEnum failed.") ;
	}

	public function testIsReadOnly():Void
	{
		var o:Object = { prop1:"value1" , prop2:"value2" } ;
		assertFalse( Attribute.isReadOnly(o, "prop1") , "ATTR_10_01 - isReadOnly failed." ) ;
		_global.ASSetPropFlags(o, ["prop1"], 7, 1) ;
		assertTrue( Attribute.isReadOnly(o, "prop1"), "ATTR_10_02 - isReadOnly failed.") ;
	}
	
	public function testSetAttribute():Void
	{
		var o:Object ;
		
		o = { prop1:"value1" , prop2:"value2" } ;
		Attribute.setAttribute(o, "prop1", AttributeType.DONT_ENUM, AttributeType.NONE) ;
		assertTrue( Attribute.isDontEnum(o, "prop1"), "ATTR_11_01 - setAttribute failed.") ;

		o = { prop1:"value1" , prop2:"value2" } ;
		Attribute.setAttribute(o, "prop1", AttributeType.DELETE_ONLY , AttributeType.NONE) ;
		assertTrue( Attribute.isDontEnum(o, "prop1"), "ATTR_11_02 - setAttribute failed.") ;
		assertFalse( Attribute.isDontDelete(o, "prop1"), "ATTR_11_03 - setAttribute failed.") ;
		assertFalse( Attribute.isReadOnly(o, "prop1"), "ATTR_11_04 - setAttribute failed.") ;
		
	}
	
	public function testToString():Void
	{
		assertEquals(a.toString(), "[Attribute:readOnly,dontDelete,dontEnum]", "ATTR_13 - valueOf failed : " + a.toString()) ;	
	}
	
	public function testValueOf():Void
	{
		assertEquals(a.valueOf(), 7, "ATTR_13 - valueOf failed : " + a.valueOf()) ;	
	}

}