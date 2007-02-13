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
import vegas.data.stack.SimpleStack;
import vegas.data.stack.TypedStack;
import vegas.util.AbstractTypeable;

/**
 * @author eKameleon
 */
class Tests.vegas.data.stack.TestTypedStack extends TestCase 
{
	
	function TestTypedStack(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var c:TypedStack ;
		try
		{
			c = new TypedStack() ;
		}
		catch(e:Error)
		{
			assertEquals(e.toString(), "[IllegalArgumentError] TypedStack constructor failed, the argument 'type' must not be 'null' or 'undefined'.", "TYPED_CO_01_00 - constructor throw error failed : " + e.toString()) ;	
		}
		c = new TypedStack(String, new SimpleStack()) ;
		assertNotNull( c, "TYPED_STACK_01_01 - constructor is null") ;
		assertTrue( c instanceof TypedStack , "TYPED_STACK_01_02 - constructor is an instance of TypedStack.") ;
	}
	
	public function testInherit()
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack()) ;
		assertTrue( c instanceof AbstractTypeable , "TYPED_STACK_02 - inherit AbstractTypeable failed.") ;
	}	

	public function testHashCode():Void
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack()) ;
		assertFalse( isNaN(c.hashCode()) , "TYPED_STACK_03 - hashCode failed : " + c.hashCode() ) ;
	}

	public function testToSource():Void
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		assertEquals( c.toSource() , 'new vegas.data.stack.TypedStack(String,new vegas.data.stack.SimpleStack(["item1","item2","item3"]))', "TYPED_STACK_04 - toSource failed : " + c.toSource() ) ;
	}

	public function testToString():Void
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		assertEquals( c.toString() , "{item3,item2,item1}", "TYPED_STACK_05 - toString failed : " + c.toString() ) ;
	}

	public function testClear():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		c.clear() ;
		assertTrue( c.isEmpty(), "TYPED_STACK_06 - clear failed.") ;
	}

	public function testClone():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		var clone = c.clone() ;
		assertTrue(clone instanceof TypedStack, "TYPED_STACK_07_01 - clone failed : " + clone ) ;
		assertTrue(clone.getType() == String, "TYPED_STACK_07_02 - clone failed : " + clone ) ;
	}

	public function testIsEmpty():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack()) ;
		assertTrue( c.isEmpty() , "TYPED_STACK_08_01 - isEmpty failed : " + c) ;
		c.push("item1") ;
		assertFalse( c.isEmpty() , "TYPED_STACK_08_02 - isEmpty failed : " + c) ;
    }
	
	public function testIterator():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		var it:Iterator = c.iterator() ;
		assertTrue(it.hasNext(), "TYPED_STACK_09_01 - iterator failed with hasNext() method : " + c) ;
		assertEquals(it.next(), "item3", "TYPED_STACK_09_02 - iterator failed with next() method : " + c) ;
	}
	
	public function testPeek():Void
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		assertEquals( c.peek() , "item3", "TYPED_STACK_10_01 - peek failed : " + c.peek) ;
	}

	public function testPop():Void
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		var clone:SimpleStack = c.clone() ;
		assertEquals( clone.pop() , "item3", "TYPED_STACK_11_01 - pop failed : " + clone) ;
		assertEquals( clone.size() , 2, "TYPED_STACK_11_02 - pop failed : " + clone) ;
	}

	public function testPush():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2"])) ;
		var clone:SimpleStack = c.clone() ;
		clone.push("item3") ;
		assertEquals( clone.size() , 3, "TYPED_STACK_12_01 - push failed : " + clone) ;
		assertEquals( clone.peek() , "item3", "TYPED_STACK_12_02 - push failed : " + clone) ;
		var isThrow:Boolean = false ;
		try
		{
			clone.push(1) ;
		}
		catch( e:Error )
		{
			isThrow = true ;
		}
		assertTrue( isThrow , "TYPED_STACK_13_02 - push failed with a String type and push a Number object.") ;
	}

	public function testSearch(o):Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2"])) ;
		assertEquals( c.search("item1") , 0, "SIMP_STACK_12_01 - search failed c.search('item1') : " + c.search("item1")) ;
		assertEquals( c.search("item2") , 1, "SIMP_STACK_12_02 - search failed c.search('item2') : " + c.search("item2")) ;
		assertEquals( c.search("item3") , -1, "SIMP_STACK_12_03 - search failed c.search('item3') : " + c.search("item3")) ;
	}
	
	public function testSetType():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		var clone:TypedStack = c.clone() ;
		assertEquals(c.getType(), clone.getType(), "TYPED_STACK_10 - s method failed." ) ;
	}

	public function testSize():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		var size:Number = c.size() ;
		assertEquals(size, 3, "TYPED_STACK_10 - size method failed : " + size) ;
	}
	
	public function testToArray():Void 
	{
		var c:TypedStack = new TypedStack(String, new SimpleStack(["item1","item2","item3"])) ;
		var ar:Array = c.toArray() ;
		assertTrue(ar instanceof Array, "TYPED_STACK_11_01 - toArray method failed : " + ar) ;
		assertEquals(ar.length, 3, "TYPED_STACK_11_02 - toArray method failed : " + ar) ;
	}

}