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

import vegas.data.iterator.Iterator;
import vegas.util.StringUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestStringUtil extends TestCase 
{

	function TestStringUtil( name:String ) 
	{
		super(name);
	}
	
	public function setUp():Void
	{

	}
	
	public function testCaseValue():Void
	{
		assertEquals(StringUtil.caseValue("hello") , 0, "S_U_01_01 - static caseValue failed.") ;
		assertEquals(StringUtil.caseValue("HellO") , 1, "S_U_01_01 - static caseValue failed.") ;
	}
	
	public function testClone():Void
	{
		assertEquals(StringUtil.clone("hello world") , "hello world", "S_U_02 - static clone failed.") ;
	}
	
	public function testCompare():Void
	{
		var s1:String = "article" ;
		var s2:String = "blue" ;
		var s3:String = "clower" ;
		var s4:String = "ARTICLE" ;
		assertEquals( StringUtil.compare( s1, s2 ), -1, "S_U_03_01 - static compare failed.") ;
		assertEquals( StringUtil.compare( s1, s3 ), -1, "S_U_03_02 - static compare failed.") ;
		assertEquals( StringUtil.compare( s3, s2 ), 1, "S_U_03_03 - static compare failed.") ;
		assertEquals( StringUtil.compare( s1, s1 ), 0, "S_U_03_04 - static compare failed.") ;
		// ignoreCase
		assertEquals( StringUtil.compare( s1, s4, true ), 0, "S_U_03_04 - static compare failed.") ;
		assertEquals( StringUtil.compare( s1, s4, false ), -1, "S_U_03_04 - static compare failed.") ;
	}

	public function testCompareChars():Void
	{
		var c1:String = "a" ;
		var c2:String = "b" ;
		assertEquals( StringUtil.compareChars( c1, c2 ), -1, "S_U_04_01 - static compareChars failed.") ;
		assertEquals( StringUtil.compareChars( c2, c1 ), 1, "S_U_04_02 - static compareChars failed.") ;
		assertEquals( StringUtil.compareChars( c1, c1 ), 0, "S_U_04_03 - static compareChars failed.") ;
	}

	public function testCompareTo():Void
	{
		var s1:String = "article" ;
		var s2:String = "blue" ;
		var s3:String = "clower" ;
		assertEquals( StringUtil.compareTo( s1, s2 ), -1, "S_U_05_01 - static compareTo failed.") ;
		assertEquals( StringUtil.compareTo( s1, s3 ), -1, "S_U_05_02 - static compareTo failed.") ;
		assertEquals( StringUtil.compareTo( s3, s2 ), 1, "S_U_05_03 - static compareTo failed.") ;
		assertEquals( StringUtil.compareTo( s1, s1 ), 0, "S_U_05_04 - static compareTo failed.") ;
	}

	public function testCopy():Void
	{
		assertEquals(StringUtil.copy("hello world") , "hello world", "S_U_06 - static copy failed.") ;
	}

	public function testEndWith():Void
	{
		assertTrue(StringUtil.endsWith("hello world", "d"), "S_U_07 - static endsWith failed.") ;
	}

	public function testFirstChar():Void
	{
		assertEquals(StringUtil.firstChar("hello world"), "h", "S_U_08 - static firstChar failed.") ;
	}

	public function testIndexOfAny():Void
	{
		var ar:Array = [2, "hello", 5] ;
		assertEquals( StringUtil.indexOfAny("hello world", ar) , 0, "S_U_09_01 - static IndexOfAny failed : " + StringUtil.indexOfAny("hello world", ar)) ;
		assertEquals( StringUtil.indexOfAny("Five = 5", ar) , 7, "S_U_09_01 - static IndexOfAny failed : " + StringUtil.indexOfAny("Five = 5", ar)) ;
		assertEquals( StringUtil.indexOfAny("actionscript is good", ar) , -1, "S_U_09_02 - static IndexOfAny failed : " + StringUtil.indexOfAny("actionscript is good", ar)) ;
	}
	
	public function testInsert():Void
	{
		var result:String ;
		
		result = StringUtil.insert("hello", 0, "a" ) ;
		assertEquals( result, "ahello", "S_U_10_01 - static insert failed : " + result) ;
		
		result = StringUtil.insert("hello", -1, "a" ) ;
		assertEquals( result, "ahello", "S_U_10_02 - static insert failed : " + result) ;

		result = StringUtil.insert("hello", 10, "a" ) ;
		assertEquals( result, "helloa", "S_U_10_03 - static insert failed : " + result) ;

		result = StringUtil.insert("hello", 1, "a" ) ;
		assertEquals( result, "haello", "S_U_10_04 - static insert failed : " + result) ;
		
	}

	public function testIsEmpty():Void
	{
		assertTrue(StringUtil.isEmpty(""), "S_U_11_01 - static isEmpty failed." ) ;
		assertFalse(StringUtil.isEmpty("hello world"), "S_U_11_02 - static isEmpty failed." ) ;
	}

	public function testIterator():Void
	{
		var it:Iterator = StringUtil.iterator("hello") ;
		assertTrue( it.hasNext(), "S_U_12_01 - static iterator failed." ) ;
		assertEquals( it.next(), "h", "S_U_12_02 - static iterator failed." ) ;
		assertEquals( it.next(), "e", "S_U_12_03 - static iterator failed." ) ;
		assertEquals( it.next(), "l", "S_U_12_04 - static iterator failed." ) ;
		assertEquals( it.next(), "l", "S_U_12_05 - static iterator failed." ) ;
		assertEquals( it.next(), "o", "S_U_12_06 - static iterator failed." ) ;
		assertFalse( it.hasNext(), "S_U_12_07 - static iterator failed." ) ;
	}

	public function testLastChar():Void
	{
		assertEquals(StringUtil.lastChar("hello world"), "d", "S_U_13 - static lastChar failed.") ;
	}

	public function testLastIndexOfAny():Void
	{
		var ar:Array = ["2", "5", "o"] ;
		assertEquals( StringUtil.lastIndexOfAny("hello world", ar) , 7, "S_U_14_01 - static lastIndexOfAny failed : " + StringUtil.lastIndexOfAny("hello world", ar)) ;
		assertEquals( StringUtil.lastIndexOfAny("Five = 5", ar) , 7, "S_U_14_02 - static lastIndexOfAny failed : " + StringUtil.lastIndexOfAny("Five = 5", ar)) ;
		assertEquals( StringUtil.lastIndexOfAny("script empty", ar) , -1, "S_U_14_03 - static lastIndexOfAny failed : " + StringUtil.lastIndexOfAny("script empty", ar)) ;
	}
	
	public function testPadLeft():Void
	{
		var result:String ;
		result = StringUtil.padLeft("hello", 8) ;
		assertEquals(result,  "   hello" , "S_U_15_01 - static padLeft failed." ) ;
		result = StringUtil.padLeft("hello", 8, ".") ;
		assertEquals(result, "...hello", "S_U_15_02 - static padLeft failed.") ;	
	}

	public function testPadRight():Void
	{
		var result:String ;
		result = StringUtil.padRight("hello", 8) ;
		assertEquals(result,  "hello   " , "S_U_16_01 - static padRight failed." ) ;
		result = StringUtil.padRight("hello", 8, ".") ;
		assertEquals(result, "hello...", "S_U_16_02 - static padRight failed.") ;	
	}
	
	public function testReplace():Void
	{
		assertEquals(StringUtil.replace("hello world", "hello", "hi"),  "hi world" , "S_U_17 - static replace failed." ) ;
	}

	public function testReverse():Void
	{
		assertEquals( StringUtil.reverse("hello") , "olleh" , "S_U_18 - static reverse failed." ) ;
	}

	public function testSplice():Void
	{
		assertEquals(StringUtil.splice("hello world", 0, 1, "H") , "Hello world", "S_U_19_01 - static splice failed.") ;
		assertEquals(StringUtil.splice("hello world", 6, 0, "life"), "hello lifeworld", "S_U_19_02 - static splice failed.") ;
		assertEquals(StringUtil.splice("hello world", 6, 5, "life"), "hello life", "S_U_19_03 - static splice failed.") ;	
	}

	public function testStartsWith():Void
	{
		assertTrue(  StringUtil.startsWith("hello world", "h"), "S_U_20_01 - static startsWith failed." ) ;
		assertTrue(  StringUtil.startsWith("hello world", "hello") , "S_U_20_02 - static startsWith failed." ) ;
		assertFalse( StringUtil.startsWith("hello world", "a") , "S_U_20_03 - static startsWith failed." ) ;	
	}

	public function testToArray():Void
	{
		var ar:Array = StringUtil.toArray("hello world" ) ;
		assertTrue(ar instanceof Array, "S_U_21_01 - static toArray failed.") ;
		assertEquals(ar.length , 11, "S_U_21_01 - static toArray failed.") ;
	}

	public function testToSource():Void
	{
		var source:String = StringUtil.toSource("hello world") ;
		assertEquals(source , '"hello world"', "S_U_22 - static toSource() failed : " + source) ;
	}

	public function testUcFirst():Void
	{
		assertEquals(StringUtil.ucFirst("hello world"), 'Hello world', "S_U_23 - static ucFirst() failed : " + StringUtil.ucFirst("hello world")) ;
	}
	
	public function testUcWords():Void
	{
		assertEquals(StringUtil.ucWords("hello world"), 'Hello World', "S_U_23 - static ucWords() failed : " + StringUtil.ucWords("hello world")) ;
	}

}
