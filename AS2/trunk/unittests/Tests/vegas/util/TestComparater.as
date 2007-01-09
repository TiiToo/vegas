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

import vegas.data.list.LinkedList;
import vegas.util.Comparater;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestComparater extends TestCase 
{

	function TestComparater(name : String) 
	{
		super(name);
	}

	public function setUp():Void
	{
		
	}
	
	public function testCompare():Void
	{
		// undefined
		
		assertTrue( Comparater.compare(undefined, undefined) , "COMP_01_01 - static compare failed" ) ;
		
		// null
		
		assertTrue( Comparater.compare(null, null) , "COMP_01_02 - static compare failed" ) ;
		
		// IEquality
		
		var list1:LinkedList = new LinkedList() ;
		list1.insert("item1") ;
		list1.insert("item2") ;
		
		var list2:LinkedList = new LinkedList() ;
		list2.insert("item3") ;
		list2.insert("item4") ;
		
		assertTrue( Comparater.compare(list1, list1.clone()) , "COMP_01_03 - static compare failed" ) ;
		assertFalse( Comparater.compare(list1, list2) , "COMP_01_04 - static compare failed" ) ;
		
		// Array
		
		assertTrue( Comparater.compare([1, 2], [1, 2]) , "COMP_01_05 - static compare([1, 2],[1, 2]) failed with Array." ) ;
		assertFalse( Comparater.compare([1, 2], [1, 3]) , "COMP_01_06 - static compare([1, 2],[1, 3]) failed with Array" ) ;

		// Boolean
		
		assertTrue( Comparater.compare(true, true) , "COMP_01_07 - static compare(true, true) failed" ) ;
		assertTrue( Comparater.compare(false, false) , "COMP_01_08 - static compare(false, false) failed" ) ;
		assertFalse( Comparater.compare(false, true) , "COMP_01_09 - static compare(true, false) failed" ) ;
		assertFalse( Comparater.compare(true, false) , "COMP_01_10 - static compare(false, true) failed" ) ;

		// Date
		
		var d1:Date = new Date(2006,1,12) ;
		var d2:Date = new Date(2005,2,24) ;
		
		assertTrue( Comparater.compare(d1, d1) , "COMP_01_11 - static compare(d1, d1) failed with Date." ) ;
		assertFalse( Comparater.compare(d1, d2) , "COMP_01_12 - static compare(d1, d2) failed with Date." ) ;

		// Error
		
		var e1:Error = new Error("hello") ;
		var e2:Error = new Error("world") ;
		
		assertTrue( Comparater.compare(e1, e1) , "COMP_01_13 - static compare(e1, e1) failed with Error." ) ;
		assertFalse( Comparater.compare(e1, e2) , "COMP_01_14 - static compare(e1, e2) failed with Error." ) ;

		// Function
		
		var f1:Function = function() { return true ; } ;
		var f2:Function = function() { return false ; } ;
		
		assertTrue( Comparater.compare(f1, f1) , "COMP_01_15 - static compare failed with Function." ) ;
		assertFalse( Comparater.compare(f1, f2) , "COMP_01_16 - static compare failed with Function." ) ;

		// Number
		
		assertTrue( Comparater.compare(1, 1) , "COMP_01_17 - static compare failed with Number." ) ;
		assertFalse( Comparater.compare(1, 2) , "COMP_01_18 - static compare failed with Number." ) ;

		// Object
		
		var o1:Object = { prop1:"value1", prop2:"value2" } ;
		var o2:Object = { prop1:"value1", prop2:"value2" } ;
		var o3:Object = {} ;
		assertTrue( Comparater.compare(o1, o1) , "COMP_01_19 - static compare failed with Object." ) ;
		assertTrue( Comparater.compare(o1, o2) , "COMP_01_20 - static compare failed with Object." ) ;
		assertFalse( Comparater.compare(o1, o3) , "COMP_01_21 - static compare failed with Object." ) ;

		// String
		
		assertTrue( Comparater.compare("hello", "hello") , "COMP_01_22 - static compare failed with String." ) ;
		assertFalse( Comparater.compare("hello", "world") , "COMP_01_23 - static compare failed with String." ) ;

	}

	public function testArrayCompare():Void
    {
		assertTrue( Comparater.arrayCompare([1, 2], [1, 2]) , "COMP_02_01 - static arrayCompare([1, 2],[1, 2]) failed with Array." ) ;
		assertFalse( Comparater.arrayCompare([1, 2], [1, 3]) , "COMP_02_02 - static arrayCompare([1, 2],[1, 3]) failed with Array" ) ;
    }

	public function testBooleanCompare():Void
    {
		assertTrue( Comparater.booleanCompare(true, true) , "COMP_03_01 - static booleanCompare(true, true) failed" ) ;
		assertTrue( Comparater.booleanCompare(false, false) , "COMP_03_02 - static booleanCompare(false, false) failed" ) ;
		assertFalse( Comparater.booleanCompare(false, true) , "COMP_03_03 - static booleanCompare(true, false) failed" ) ;
		assertFalse( Comparater.booleanCompare(true, false) , "COMP_03_04 - static booleanCompare(false, true) failed" ) ;
    }

	public function testDateCompare():Void
	{
		var d1:Date = new Date(2006,1,12) ;
		var d2:Date = new Date(2005,2,24) ;
		
		assertTrue( Comparater.dateCompare(d1, d1) , "COMP_04_01 - static dateCompare(d1, d1) failed with Date." ) ;
		assertFalse( Comparater.dateCompare(d1, d2) , "COMP_04_02 - static dateCompare(d1, d2) failed with Date." ) ;
	}
	
	public function testErrorCompare():Void
	{
		var e1:Error = new Error("hello") ;
		var e2:Error = new Error("world") ;
		
		assertTrue( Comparater.errorCompare(e1, e1) , "COMP_05_01 - static errorCompare(e1, e1) failed with Error." ) ;
		assertFalse( Comparater.errorCompare(e1, e2) , "COMP_05_02 - static errorCompare(e1, e2) failed with Error." ) ;
	}
	
	public function testFunctionCompare():Void
	{
		var f1:Function = function() { return true ; } ;
		var f2:Function = function() { return false ; } ;
		
		assertTrue( Comparater.functionCompare(f1, f1) , "COMP_06_01 - static functionCompare failed with Function." ) ;
		assertFalse( Comparater.functionCompare(f1, f2) , "COMP_06_02 - static functionCompare failed with Function." ) ;
	}

	public function testNumberCompare():Void
	{
		assertTrue( Comparater.numberCompare(1, 1) , "COMP_07_01 - static numberCompare failed with Number." ) ;
		assertFalse( Comparater.numberCompare(1, 2) , "COMP_07_02 - static numberCompare failed with Number." ) ;
		assertTrue( Comparater.numberCompare(NaN, NaN) , "COMP_07_032 - static numberCompare failed with Number." ) ;
	}
	
	public function testObjectCompare():Void
	{
		var o1:Object = { prop1:"value1", prop2:"value2" } ;
		var o2:Object = { prop1:"value1", prop2:"value2" } ;
		var o3:Object = {} ;
		assertTrue( Comparater.objectCompare(o1, o1) , "COMP_08_01 - static objectCompare failed with Object." ) ;
		assertTrue( Comparater.objectCompare(o1, o2) , "COMP_08_02 - static objectCompare failed with Object." ) ;
		assertFalse( Comparater.objectCompare(o1, o3) , "COMP_08_03 - static objectCompare failed with Object." ) ;
	}
	
	public function testStringCompare():Void
    {
		assertTrue( Comparater.stringCompare("hello", "hello") , "COMP_09_01 - static stringCompare failed with String." ) ;
		assertTrue( Comparater.stringCompare("", "") , "COMP_09_02 - static stringCompare failed with String." ) ;
		assertFalse( Comparater.stringCompare("hello", "world") , "COMP_09_03 - static stringCompare failed with String." ) ;
    }

}