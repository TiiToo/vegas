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
import vegas.data.Bag;
import vegas.data.bag.AbstractBag;
import vegas.data.bag.HashBag;
import vegas.data.Collection;
import vegas.data.collections.SimpleCollection;
import vegas.data.iterator.Iterator;
import vegas.data.Set;
import vegas.util.TypeUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.data.bag.TestHashBag extends TestCase 
{
	
	function TestHashBag(name : String) 
	{
		super(name);
	}
	
	public var b:HashBag ;
	
	public function setUp():Void
	{
		b = new HashBag() ;
		b.insert("item1") ;
		b.insert("item1") ;
		b.insert("item2") ;
		b.insert("item2") ;
		b.insert("item2") ;
		b.insert("item3") ;
	}
	
	public function testConstructor()
	{
		assertNotNull( b, "HASH_BAG_01_01 - constructor is null") ;
		assertTrue( b instanceof HashBag , "HASH_BAG_01_02 - constructor is an instance of HashBag.") ;
	}
	
	public function testInherit()
	{
		assertTrue( b instanceof CoreObject , "HASH_BAG_02 - inherit CoreObject failed.") ;
	}	

	public function testHashCode():Void
	{
		assertFalse( isNaN(b.hashCode()) , "HASH_BAG_03 - hashCode failed : " + b.hashCode() ) ;
	}

	public function testToSource():Void
	{
		assertEquals( b.toSource() , 'new vegas.data.bag.HashBag(new vegas.data.list.ArrayList(["item1","item1","item2","item2","item2","item3"]))', "HASH_BAG_04 - toSource failed : " + b.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( b.toString() , "{2:item1,3:item2,1:item3}", "HASH_BAG_05 - toString failed : " + b.toString() ) ;
	}

	public function testClear():Void 
	{
		var bag:AbstractBag = new HashBag() ;
		bag.insert("item1") ;
		bag.insert("item1") ;
		bag.clear() ;
		assertTrue( bag.isEmpty(), "HASH_BAG_06 - clear failed.") ;
	}

	public function testClone():Void 
	{
		var clone = b.clone() ;
		assertTrue(clone instanceof HashBag, "HASH_BAG_07 - clone failed : " + clone ) ;
	}

	public function testContains():Void 
	{
		assertTrue(b.contains("item1"), "HASH_BAG_08 - contains failed.") ;
	}

	public function testContainsAll():Void 
	{
		var c:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		var bag:Bag = new HashBag() ;
		bag.insertAll(c) ;
		assertTrue(bag.containsAll(c), "HASH_BAG_09 - containsAll failed.") ;
	}
	
	public function testContainsAllInBag():Void 
	{
		var bag:Bag = new HashBag() ;
		
		var c1:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		bag.insertAll(c1) ;
		assertFalse( b.containsAllInBag(bag) , "HASH_BAG_10_01 - containsAllInBag failed.") ;

		var c2:Collection = new SimpleCollection( ["item1", "item1", "item2", "item2", "item2", "item3"] ) ;
		bag.clear() ;
		bag.insertAll(c2) ;
		assertTrue( b.containsAllInBag(bag) , "HASH_BAG_10_02 - containsAllInBag failed.") ;
	}

	public function testGet():Void
	{
		try
		{
			b.get() ;
			fail("HASH_BAG_11_01 - get method failed.") ;
		}
		catch(e:Error)
		{
			assertEquals(
				e.toString() , 
				"[UnsupportedOperation] The 'get' method is unsupported with a bag object.", 
				"HASH_BAG_11_02 - get method failed : " + e.toString()
			) ;	
		}
	}

	public function testGetCount():Void
	{
       assertEquals( b.getCount("item1"), 2, "HASH_BAG_12_01 - getCount method failed : " + b.getCount("item1")) ;
       assertEquals( b.getCount("item2"), 3, "HASH_BAG_12_02 - getCount method failed : " + b.getCount("item2")) ;
       assertEquals( b.getCount("item3"), 1, "HASH_BAG_12_03 - getCount method failed : " + b.getCount("item3")) ;
       assertEquals( b.getCount(), 0, "HASH_BAG_12_04 - getCount method failed : " + b.getCount()) ;
	}

	public function testGetModCount():Void 
	{
		assertTrue( TypeUtil.typesMatch(b.getModCount(), Number), "HASH_BAG_13 - getModCount method failed : " + b.getModCount()) ;
	}

	public function testInsert():Void 
	{
		var bag:Bag = new HashBag() ;
		bag.insert("item1") ;
		assertEquals(bag.size(), 1, "HASH_BAG_14 - insert method failed : " + bag) ;
	}

	public function testInsertAll():Void 
	{
		var bag:Bag = new HashBag() ;
		var c:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		bag.insertAll(c) ;
		assertEquals( bag.size() , 5, "HASH_BAG_15 - insertAll failed : " + bag) ;
	}

	public function testInsertCopies():Void 
	{
		var bag:Bag = new HashBag() ;
		bag.insertCopies("item2", 2) ;
		assertEquals( bag.getCount("item2") , 2, "HASH_BAG_16 - insertCopies failed : " + bag) ;
	}
	
	public function testIsEmpty():Void 
	{
		var bag:Bag = new HashBag() ;
		assertTrue( bag.isEmpty() , "HASH_BAG_17 - isEmpty failed : " + bag) ;
    }
	
	public function testIterator():Void 
	{
		var it:Iterator = b.iterator() ;
		assertTrue(it.hasNext(), "HASH_BAG_18_01 - iterator failed with hasNext() method : " + b) ;
		assertEquals(it.next(), "item1", "HASH_BAG_18_02 - iterator failed with next() method : " + b) ;
	}

	public function testRemove():Void 
	{
		var bag:Bag = new HashBag() ;
		bag.insert("item1") ;
		bag.insertCopies("item2", 2) ;
		bag.remove("item1") ;
		bag.remove("item2") ;
		assertEquals( bag.getCount("item1"), 0, "HASH_BAG_19_01 - remove method failed : " + b) ;
		assertEquals( bag.getCount("item2"), 0, "HASH_BAG_19_02 - remove method failed : " + b) ;
	}

	public function testRemoveAll():Void 
	{
		var bag:Bag = new HashBag() ;
		var c:SimpleCollection = new SimpleCollection( ["item1", "item2", "item2"] ) ;
		bag.insertAll(c) ;
		bag.removeAll( c ) ;
		assertTrue( bag.isEmpty(), "HASH_BAG_20 - removeAll(" + c + ") method failed : " + b) ;
    }

	public function testRemoveCopies():Void 
	{
		var bag:Bag = new HashBag() ;
		var c:SimpleCollection = new SimpleCollection( ["item1", "item2", "item2"] ) ;
		bag.insertAll(c) ;
		bag.removeCopies( "item2", 1 ) ;
		assertEquals( bag.getCount("item2"), 1, "HASH_BAG_21 - removeCopies('item2', 1) method failed : " + b) ;
	}

	public function testRetainAll():Void 
	{
		var bag:Bag = new HashBag() ;
		var c1:Collection = new SimpleCollection( ["item2", "item3"] ) ;
		var c2:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		bag.insertAll(c2) ;
		var result:Boolean = bag.retainAll(c1) ;
		assertTrue( result, "HASH_BAG_22 - retainAll("+ c1 + ") method failed : " + result) ;
	}

	public function testRetainAllInBag():Void 
	{
		var c1:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		var c2:Collection = new SimpleCollection( ["item2", "item3"] ) ;
		
		var bag1:HashBag = new HashBag() ;
		bag1.insertAll(c1) ;
		
		var bag2:HashBag = new HashBag() ;
		bag2.insertAll(c2) ;
		
		var result:Boolean = bag1.retainAllInBag(bag2) ;
		assertTrue( result, "HASH_BAG_23 - retainAllInBag method failed : " + result) ;
    }

	public function testSize():Void 
	{
		var size:Number = b.size() ;
		assertEquals(size, 6, "HASH_BAG_24 - size method failed : " + size) ;
	}
	
	public function testToArray():Void 
	{
		var ar:Array = b.toArray() ;
		assertTrue(ar instanceof Array, "HASH_BAG_25_01 - toArray method failed : " + ar) ;
		assertEquals(ar.length, 6, "HASH_BAG_25_02 - toArray method failed : " + ar) ;
	}

	public function testUniqueSet():Void
	{
		var s:Set = b.uniqueSet() ;
		assertTrue(s instanceof Set, "HASH_BAG_26_01 - uniqueSet method failed : " + s) ;
		assertEquals(s.size(), 3, "HASH_BAG_26_02 - uniqueSet method failed : " + s) ;
	}

}