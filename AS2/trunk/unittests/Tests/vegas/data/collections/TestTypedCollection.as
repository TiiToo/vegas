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

import vegas.data.collections.SimpleCollection;
import vegas.data.collections.TypedCollection;
import vegas.data.iterator.Iterator;
import vegas.util.AbstractTypeable;

/**
 * @author eKameleon
 */
class Tests.vegas.data.collections.TestTypedCollection extends TestCase 
{
	
	/**
	 * Creates a new TestCoreObject instance.
	 */
	function TestTypedCollection(name : String) 
	{
		super(name);
	}
	
	public function setUp():Void
	{
		
	}
	
	public function testConstructor()
	{
		var c:TypedCollection ;
		try
		{
			c = new TypedCollection() ;
		}
		catch(e:Error)
		{
			assertEquals(e.toString(), "[IllegalArgumentError] [type Object] constructor failed, the argument 'type' must not be 'null' or 'undefined'.", "TYPED_CO_01_00 - constructor is null") ;	
		}
		c = new TypedCollection(String, new SimpleCollection()) ;
		assertNotNull( c, "TYPED_CO_01_01 - constructor is null") ;
		assertTrue( c instanceof TypedCollection , "TYPED_CO_01_02 - constructor is an instance of TypedCollection.") ;
	}
	
	public function testInherit()
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection()) ;
		assertTrue( c instanceof AbstractTypeable , "TYPED_CO_02 - inherit AbstractTypeable failed.") ;
	}	

	public function testHashCode():Void
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection()) ;
		assertFalse( isNaN(c.hashCode()) , "TYPED_CO_03 - hashCode failed : " + c.hashCode() ) ;
	}

	public function testToSource():Void
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		assertEquals( c.toSource() , 'new vegas.data.collections.TypedCollection(String,new vegas.data.collections.SimpleCollection(["item1","item2","item3"]))', "TYPED_CO_04 - toSource failed : " + c.toSource() ) ;
	}

	public function testToString():Void
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		assertEquals( c.toString() , "{item1,item2,item3}", "TYPED_CO_05 - toString failed : " + c.toString() ) ;
	}

	public function testClear():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		c.clear() ;
		assertTrue( c.isEmpty(), "TYPED_CO_06 - clear failed.") ;
	}

	public function testClone():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		var clone = c.clone() ;
		assertTrue(clone instanceof TypedCollection, "TYPED_CO_07_01 - clone failed : " + clone ) ;
		assertTrue(clone.getType() == String, "TYPED_CO_07_02 - clone failed : " + clone ) ;
	}

	public function testContains():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		assertTrue(c.contains("item1"), "TYPED_CO_08 - contains failed.") ;
	}

	public function testGet():Void
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		assertEquals(c.get(0), "item1", "TYPED_CO_09 - get failed.") ;
	}

	public function testInsert():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		c.insert("item4") ;
		assertEquals(c.size(), 4, "TYPED_CO_14 - insert method failed : " + c) ;
	}

	public function testIsEmpty():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection()) ;
		assertTrue( c.isEmpty() , "TYPED_CO_17 - isEmpty failed : " + c) ;
    }
	
	public function testIterator():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		var it:Iterator = c.iterator() ;
		assertTrue(it.hasNext(), "TYPED_CO_18_01 - iterator failed with hasNext() method : " + c) ;
		assertEquals(it.next(), "item1", "TYPED_CO_18_02 - iterator failed with next() method : " + c) ;
	}

	public function testRemove():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		c.remove("item2") ;
		assertEquals( c.size(), 2, "TYPED_CO_19_01 - remove method failed : " + c) ;
	}

	public function testSize():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		var size:Number = c.size() ;
		assertEquals(size, 3, "TYPED_CO_24 - size method failed : " + size) ;
	}
	
	public function testToArray():Void 
	{
		var c:TypedCollection = new TypedCollection(String, new SimpleCollection(["item1","item2","item3"])) ;
		var ar:Array = c.toArray() ;
		assertTrue(ar instanceof Array, "TYPED_CO_25_01 - toArray method failed : " + ar) ;
		assertEquals(ar.length, 3, "TYPED_CO_25_02 - toArray method failed : " + ar) ;
	}

}