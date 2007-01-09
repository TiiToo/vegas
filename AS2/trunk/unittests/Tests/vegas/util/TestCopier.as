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
import vegas.util.Copier;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestCopier extends TestCase 
{

	function TestCopier(name : String) 
	{
		super(name);
	}

	public function testCopy():Void
	{
		// undefined
		
		assertEquals( Copier.copy(undefined), undefined , "COPY_01_01 - static copy failed with undefined." ) ;
		
		// null
		
		assertEquals( Copier.copy(null), null , "COPY_01_02 - static copy failed with null." ) ;
		
		// ICopyable
		
		var list:LinkedList = new LinkedList() ;
		list.insert("item1") ;
		list.insert("item2") ;
		
		assertEquals( Copier.copy(list) , list, "COPY_01_03 - static copy failed with ICopyable." ) ;
		
		// Array
		
		assertEquals( Copier.copy([1, 2]), [1, 2] , "COPY_01_05 - static copy failed with Array." ) ;
		assertEquals( Copier.copy([[1, 2],[2, 3]]), [[1, 2],[2, 3]] , "COPY_01_06 - static copy failed with Array." ) ;

		// Boolean
		
		assertEquals( Copier.copy(true), true , "COPY_01_07 - static copy failed with true value." ) ;
		assertEquals( Copier.copy(false), false , "COPY_01_08 - static copy failed with false value." ) ;

		// Date
		
		var d:Date = new Date(2006,1,12) ;
		assertEquals( Copier.copy(d), d , "COPY_01_09 - static copy failed with Date." ) ;

		// Error
		
		var e:Error = new Error("hello world") ;
		var str:String = (Copier.copy(e)).message ;
		assertEquals( str , "hello world", "COPY_01_10 - static copy failed with Error : " + str ) ;

		// Function
		
		var f:Function = function() { return true ; } ;
		assertTrue( Copier.copy(f) instanceof Function , "COPY_01_11 - static copy failed with Function." ) ;

		// Number
		
		assertEquals( Copier.copy(1), 1 , "COPY_01_12 - static copy failed with Number." ) ;

		// Object
		
		var o1:Object = { prop1:"value1", prop2:"value2" } ;
		var o2:Object = {} ;
		assertEquals( Copier.copy(o1) , o1, "COPY_01_13 - static copy failed with Object." ) ;
		assertEquals( Copier.copy(o2) , o2, "COPY_01_14 - static copy failed with Object." ) ;

		// String
		
		assertEquals( Copier.copy("hello"), "hello" , "COPY_01_15 - static copy failed with String." ) ;

	}



}