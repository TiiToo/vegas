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

import vegas.data.collections.AbstractCollection;
import vegas.data.iterator.Iterator;
import vegas.data.stack.SimpleStack;

/**
 * @author eKameleon
 */
class Tests.vegas.data.stack.TestSimpleStack extends TestCase 
{
	
	function TestSimpleStack(name : String) 
	{
		super(name);
	}
	
	public var c:SimpleStack ;
	
	public function setUp():Void
	{
		c = new SimpleStack(["item1", "item2"]) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( c, "SIMP_STACK_01_01 - constructor is null") ;
		assertTrue( c instanceof SimpleStack , "SIMP_STACK_01_02 - constructor is an instance of SimpleStack.") ;
	}
	
	public function testInherit()
	{
		assertTrue( c instanceof AbstractCollection , "SIMP_STACK_02 - inherit AbstractCollection failed.") ;
	}	

	public function testHashCode():Void
	{
		assertFalse( isNaN(c.hashCode()) , "SIMP_STACK_03 - hashCode failed : " + c.hashCode() ) ;
	}

	public function testToSource():Void
	{
		assertEquals( c.toSource() , 'new vegas.data.stack.SimpleStack(["item1","item2"])', "SIMP_STACK_04 - toSource failed : " + c.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( c.toString() , "{item2,item1}", "SIMP_STACK_05 - toString failed : " + c.toString() ) ;
	}

	public function testClone():Void 
	{
		var clone = c.clone() ;
		assertTrue(clone instanceof SimpleStack, "SIMP_STACK_06_01 - clone failed : " + clone ) ;
		assertEquals(clone.size() , c.size() , "SIMP_STACK_06_02 - clone failed : " + clone ) ;
	}

	public function testGet():Void
	{
		assertEquals(c.get(0), "item2", "SIMP_STACK_07 - get failed.") ;
	}

	public function testIterator():Void 
	{
		var it:Iterator = c.iterator() ;
		assertTrue(it.hasNext(), "SIMP_STACK_08_01 - iterator failed with hasNext() method : " + c) ;
		assertEquals(it.next(), "item2", "SIMP_STACK_08_02 - iterator failed with next() method : " + c) ;
	}
	
	public function testPeek():Void 
	{
		assertEquals( c.peek() , "item2", "SIMP_STACK_09_01 - peek failed : " + c.peek) ;
	}

	public function testPop():Void 
	{
		var clone:SimpleStack = c.clone() ;
		assertEquals( clone.pop() , "item2", "SIMP_STACK_10_01 - pop failed : " + clone) ;
		assertEquals( clone.size() , 1, "SIMP_STACK_10_02 - pop failed : " + clone) ;
	}

	public function testPush():Void 
	{
		var clone:SimpleStack = c.clone() ;
		clone.push("item3") ;
		assertEquals( clone.size() , 3, "SIMP_STACK_11_01 - push failed : " + clone) ;
		assertEquals( clone.peek() , "item3", "SIMP_STACK_11_02 - push failed : " + clone) ;
	}

	public function testSearch():Void 
	{
		assertEquals( c.search("item1") , 0, "SIMP_STACK_12_01 - search failed c.search('item1') : " + c.search("item1")) ;
		assertEquals( c.search("item2") , 1, "SIMP_STACK_12_02 - search failed c.search('item2') : " + c.search("item2")) ;
		assertEquals( c.search("item3") , -1, "SIMP_STACK_12_03 - search failed c.search('item3') : " + c.search("item3")) ;
	}

	public function testToArray():Void 
	{
		var ar:Array = c.toArray() ;
		assertTrue(ar instanceof Array, "SIMP_STACK_13_01 - toArray method failed : " + ar) ;
		assertEquals(ar.length, 2, "SIMP_STACK_13_02 - toArray method failed : " + ar) ;
	}

}