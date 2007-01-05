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

import vegas.errors.ArgumentOutOfBoundsError;
import vegas.util.ArrayUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestArrayUtil extends TestCase 
{

	function TestArrayUtil(name : String) 
	{
		super(name);
	}
	
	public function testClone():Void
	{
		var ar:Array = [2, 3, 4] ;
		var clone:Array = ArrayUtil.clone(ar) ;
		assertTrue(clone instanceof Array, "AU_01_01 - static clone failed") ;
		clone[0] = "test" ;
		assertFalse(ar[0] == clone[0], "AU_01_02 - static clone failed") ;
	}

	public function testContains():Void
	{
		var ar:Array = [2, 3, 4] ;
		var result:Boolean ;
		result = ArrayUtil.contains(ar, 3) ;
		assertTrue(result, "AU_02_01 - static contains failed") ;
		result = ArrayUtil.contains(ar, "hello") ;
		assertFalse(result, "AU_02_02 - static contains failed") ;
	}
	
	public function testCopy():Void
	{
		var ar:Array = [ [2, 3, 4], [5, 6, 7], [8, 9, 10]] ;
		var copy:Array = ArrayUtil.copy(ar) ;
		assertTrue(ar[0][1] == copy[0][1], "AU_03_01 - static copy failed, ar:" + ar + ", copy:" + copy) ;
		assertFalse(ar[0] == copy[0], "AU_03_01 - static copy failed, ar:" + ar + ", copy:" + copy) ;
	}

	public function testEvery():Void
	{
	 	var isBigEnough:Function = function (element, index, array) 
	 	{
			return (element >= 10);
		} ;
	 	var passed:Boolean ;
	 	
	 	passed = ArrayUtil.every([12, 5, 8, 130, 44], isBigEnough) ; // passed is false
	 	assertFalse(passed, "AU_04_01 - static every failed : " + passed) ;
	 	
	 	passed = ArrayUtil.every([12, 54, 18, 130, 44], isBigEnough); // passed is true
	 	assertTrue(passed, "AU_04_01 - static every failed : " + passed) ;
	}
	
	public function testFilter():Void
	{
		var isBigEnough:Function = function(element, index, array) 
		{
			return (element >= 10) ;
		} ;
		var ar:Array = [12, 5, 8, 130, 44] ;
	 	var filtered:Array = ArrayUtil.filter(ar, isBigEnough);
	 	assertEquals(filtered, [12, 130, 44], "AU_04_01 - static every failed, ar:" + ar + ", filtered:" + filtered) ;
	}
	
	public function testForEach():Void
	{
		var stack:Array = [] ;
		var printElt:Function = function(element, index, array) 
		{
	 		stack.push("[" + index + "] is " + element); // assumes print is already defined
		} ;
		ArrayUtil.forEach([2, 5, 9], printElt);
		assertEquals(stack[0], "[0] is 2", "AU_05_01 - static forEach failed, stack:" + stack) ;
		assertEquals(stack[1], "[1] is 5", "AU_05_01 - static forEach failed, stack:" + stack) ;
		assertEquals(stack[2], "[2] is 9", "AU_05_01 - static forEach failed, stack:" + stack) ;
	}
	
	public function testFromArguments():Void
	{
		var stack:Array = new Array() ;
		var method:Function = function( /*args*/ ) 
		{
	 		stack = ArrayUtil.fromArguments(stack, arguments) ;
		} ;
		method("arg1", "arg2") ;
		assertEquals( stack, ["arg1", "arg2"], "AU_06 - static fromArguments failed, stack:" + stack) ;
	}
	
	public function testIndexOf():Void
	{
		var ar:Array = [2, 3, 4, 5] ;
		assertEquals(ArrayUtil.indexOf(ar, 2), 0, "AU_07_01 static indexOf failed.") ; 
		assertEquals(ArrayUtil.indexOf(ar, 4, 1, 2), 2, "AU_07_02 static indexOf failed.") ; 
		try
		{
			ArrayUtil.indexOf(ar, 4, -1) ;
		}
		catch(e:Error)
		{
			assertTrue(e instanceof ArgumentOutOfBoundsError, "AU_07_03 static indexOf failed.") ;	
		}
		try
		{
			ArrayUtil.indexOf(ar, 4, 50) ;
		}
		catch(e:Error)
		{
			assertTrue(e instanceof ArgumentOutOfBoundsError, "AU_07_04 static indexOf failed.") ;	
		}
	}
	
	public function testInitialize():Void
	{
		var ar:Array = ArrayUtil.initialize(10, "hello") ;
		assertEquals(ar.length, 10, "AU_08_01 static initialize failed : " + ar) ;
		var l:Number = ar.length ;
		for (var i:Number = 0 ; i<l ; i++)
		{
			assertEquals(ar[i], "hello", "AU_08_01_" + i + " static initialize failed : " + ar) ;	
		}
	}
	
	public function testLastIndexOf():Void
	{
		var ar:Array = [2, 3, 4, 2, 5] ;
		var index:Number = ArrayUtil.lastIndexOf(ar, 2) ;
		assertEquals(index, 3, "AU_09 - static lastIndexOf failed : " + ar) ;	
	}
	
	public function testMap():Void
	{
		var makeUpperCase:Function = function( element )
	 	{
	 		return element.toUpperCase() ;
		} ;
	  
		var ar:Array = ["hello", "WorlD", "Yoo"] ;
		var uppers = ArrayUtil.map(ar, makeUpperCase) ;
		assertEquals(uppers, ["HELLO", "WORLD", "YOO"], "AU_10_01 static map() failed : " + uppers) ;
		assertEquals(ar, ["hello", "WorlD", "Yoo"], "AU_10_02 static map() failed : " + ar) ;		
	}
	
	public function testPierce():Void
	{
		var ar:Array = [0, 1, 2, 3, 4];
		var result ;
		result = ArrayUtil.pierce( ar, 1 ) ;
		assertEquals(result, 1, "AU_11_01 static pierce() failed : " + result) ;
		result = ArrayUtil.pierce( ar, 1 , true) ;
		assertEquals( result, [0, 3, 4], "AU_11_02 static pierce() failed : " + result ) ;
	}
	
	public function testSome():Void
	{
		var isBigEnough:Function = function (element, index, array) 
	 	{
	 		return (element >= 10);
		} ;
	 	var passed:Boolean ;
	 	
	 	passed = ArrayUtil.some([2, 5, 8, 1, 4], isBigEnough)  ;
	 	assertFalse(passed, "AU_12_01 static some() failed : " + passed) ;
	 	
	 	passed = ArrayUtil.some([12, 5, 8, 1, 4], isBigEnough) ;
	 	assertTrue(passed, "AU_12_01 static some() failed : " + passed) ;
	}
	
	public function testShuffle():Void
	{
		var ar:Array = [2, 3, 4, 5] ;
		var shuffle:Array = ArrayUtil.shuffle(ar) ;
		assertEquals(shuffle.length, 4, "AU_13_01 static shuffle() failed : " + shuffle) ;
	}
	
	public function testToString():Void
	{
		var ar:Array = [2, 3, 4] ;
		var result:String ;
		result = ArrayUtil.toString(ar) ;
		assertEquals(result, "2,3,4", "AU_13_01 static toString() failed.") ;
		result = ArrayUtil.toString(ar, "|") ;
		assertEquals(result, "2|3|4", "AU_13_01 static toString() failed.") ;
	}
	
}