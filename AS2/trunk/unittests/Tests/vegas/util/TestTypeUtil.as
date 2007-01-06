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
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.util.TypeUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestTypeUtil extends TestCase 
{

	function TestTypeUtil(name : String) 
	{
		super(name);
	}
	
	public function testConstants():Void
	{
		assertEquals(TypeUtil.BOOLEAN   , "boolean"   , "TYP_U_01_01 - constant failed." ) ;
		assertEquals(TypeUtil.COLOR     , "color"     , "TYP_U_01_02 - constant failed." ) ;
		assertEquals(TypeUtil.DATE      , "date"      , "TYP_U_01_03 - constant failed." ) ;
		assertEquals(TypeUtil.ERROR     , "error"     , "TYP_U_01_04 - constant failed." ) ;
		assertEquals(TypeUtil.FUNCTION  , "function"  , "TYP_U_01_05 - constant failed." ) ;
		assertEquals(TypeUtil.MOVIECLIP , "movieclip" , "TYP_U_01_06 - constant failed." ) ;
		assertEquals(TypeUtil.NULL      , "null"      , "TYP_U_01_07 - constant failed." ) ;
		assertEquals(TypeUtil.NUMBER    , "number"    , "TYP_U_01_08 - constant failed." ) ;
		assertEquals(TypeUtil.OBJECT    , "object"    , "TYP_U_01_09 - constant failed." ) ;
		assertEquals(TypeUtil.STRING    , "string"    , "TYP_U_01_10 - constant failed." ) ;
		assertEquals(TypeUtil.UNDEFINED , "undefined" , "TYP_U_01_11 - constant failed." ) ;
		assertEquals(TypeUtil.XML       , "xml"       , "TYP_U_01_12 - constant failed." ) ;
	}
	
	public function testCompare():Void
	{
		assertTrue( TypeUtil.compare( "hello", "world" ) , "TYP_U_02_01 - static compare failed.") ;
		assertFalse( TypeUtil.compare( "hello", 2 ) , "TYP_U_02_02 - static compare failed.") ;
	}
	
	public function testIsExplicitInstanceOf():Void
	{
		assertTrue( TypeUtil.isExplicitInstanceOf( "hello", String ) , "TYP_U_03_01 - static isExplicitInstanceOf failed.") ;
		assertTrue( TypeUtil.isExplicitInstanceOf( new CoreObject(), CoreObject ) , "TYP_U_03_02 - static isExplicitInstanceOf failed.") ;
		assertTrue( TypeUtil.isExplicitInstanceOf( new CoreObject(), IHashable) , "TYP_U_03_03 - static isExplicitInstanceOf failed.") ;
		assertTrue( TypeUtil.isExplicitInstanceOf( new CoreObject(), IFormattable) , "TYP_U_04_03 - static isExplicitInstanceOf failed.") ;
	}
	
	public function testIsInstanceOf():Void
	{
		assertFalse( TypeUtil.isInstanceOf( "hello", String ) , "TYP_U_04_01 - static isInstanceOf failed.") ;
		assertTrue( TypeUtil.isInstanceOf( new String("hello"), String ) , "TYP_U_04_02 - static isInstanceOf failed.") ;
		assertTrue( TypeUtil.isInstanceOf( new CoreObject(), CoreObject ) , "TYP_U_04_03 - static isInstanceOf failed.") ;
		assertTrue( TypeUtil.isInstanceOf( new CoreObject(), Object ) , "TYP_U_04_04 - static isInstanceOf failed.") ;
	}
	
	public function testIsPrimivite():Void
	{
		assertTrue( TypeUtil.isPrimitive( 1 ) , "TYP_U_05_01 - static isPrimitive failed.") ;
		assertTrue( TypeUtil.isPrimitive( true ) , "TYP_U_05_02 - static isPrimitive failed.") ;
		assertTrue( TypeUtil.isPrimitive( "hello" ) , "TYP_U_05_03 - static isPrimitive failed.") ;
		assertFalse( TypeUtil.isPrimitive( new String("hello") ) , "TYP_U_05_04 - static isPrimitive failed.") ;
		assertFalse( TypeUtil.isPrimitive( new CoreObject() ) , "TYP_U_05_05 - static isPrimitive failed.") ;
	}
	
	public function testIsTypeOf():Void
	{
		assertTrue( TypeUtil.isTypeOf( 1 , "number" ) , "TYP_U_06_01 - static isTypeOf failed.") ;
		assertTrue( TypeUtil.isTypeOf( new CoreObject() , "object" ) , "TYP_U_06_02 - static isTypeOf failed.") ;
	}
	
	public function testTypesMatch():Void
	{
		assertTrue( TypeUtil.typesMatch( 1 , Number ) , "TYP_U_07_01 - static typesMatch failed.") ;
		assertTrue( TypeUtil.typesMatch( "hello", String ) , "TYP_U_07_02 - static typesMatch failed.") ;
		assertTrue( TypeUtil.typesMatch( new String("hello"), String ) , "TYP_U_07_03 - static typesMatch failed.") ;
		assertTrue( TypeUtil.typesMatch( new CoreObject(), CoreObject ) , "TYP_U_07_04 - static typesMatch failed.") ;
	}
	
	public function testToString():Void
	{
		assertEquals( TypeUtil.toString( null ) , "null", "TYP_U_08_01 - static toString failed.") ;
		assertEquals( TypeUtil.toString( undefined ) , "undefined", "TYP_U_08_02 - static toString failed.") ;
		assertEquals( TypeUtil.toString( CoreObject ) , "vegas.core.CoreObject", "TYP_U_08_03 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Array ) , "Array", "TYP_U_08_04 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Boolean ) , "Boolean", "TYP_U_08_05 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Color ) , "Color", "TYP_U_08_06 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Date ) , "Date", "TYP_U_08_07 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Error ) , "Error", "TYP_U_08_08 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Number ) , "Number", "TYP_U_08_09 - static toString failed.") ;
		assertEquals( TypeUtil.toString( String ) , "String", "TYP_U_08_10 - static toString failed : " +  TypeUtil.toString( String )) ;
		
		// TODO : bug with XML type in TypeUtil.toString() method !
		// assertEquals( TypeUtil.toString( XML ) , "XML", "TYP_U_08_11 - static toString failed : " + TypeUtil.toString( XML )) ;
		
		assertEquals( TypeUtil.toString( XMLNode ) , "XMLNode", "TYP_U_08_12 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Function ) , "Function", "TYP_U_08_13 - static toString failed.") ;
		assertEquals( TypeUtil.toString( Object ) , "Object", "TYP_U_08_14 - static toString failed.") ;
	}
	
}