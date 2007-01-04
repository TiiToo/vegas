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

import Tests.vegas.data.bag.ConcreteAbstractBag;

import vegas.core.CoreObject;
import vegas.data.Bag;
import vegas.data.bag.AbstractBag;
import vegas.data.Collection;
import vegas.data.collections.SimpleCollection;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.data.Set;
import vegas.util.TypeUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.data.bag.TestAbstractBag extends TestCase 
{
	
	/**
	 * Creates a new TestCoreObject instance.
	 */
	function TestAbstractBag(name : String) 
	{
		super(name);
	}
	
	public var b:ConcreteAbstractBag ;
	
	public function setUp():Void
	{
		b = new ConcreteAbstractBag( new HashMap() ) ;
		b.insert("item1") ;
		b.insert("item1") ;
		b.insert("item2") ;
		b.insert("item2") ;
		b.insert("item2") ;
		b.insert("item3") ;
	}
	
	public function testConstructor()
	{
		assertNotNull( b, "ABAG_01_01 - constructor is null") ;
		assertTrue( b instanceof ConcreteAbstractBag , "ABAG_01_02 - constructor is an instance of ConcreteAbstractBag.") ;
		assertTrue( b instanceof AbstractBag , "ABAG_01_02 - constructor is an instance of AbstractBag.") ;
	}
	
	public function testInherit()
	{
		assertTrue( b instanceof CoreObject , "ABAG_02 - inherit CoreObject failed.") ;
	}	

	public function testHashCode():Void
	{
		assertFalse( isNaN(b.hashCode()) , "ABAG_03 - hashCode failed : " + b.hashCode() ) ;
	}

	public function testToSource():Void
	{
		assertEquals( b.toSource() , 'new Tests.vegas.data.bag.ConcreteAbstractBag(new vegas.data.map.HashMap(["item1","item2","item3"],[new vegas.core.types.Int(2),new vegas.core.types.Int(3),new vegas.core.types.Int(1)]))', "ABAG_04 - toSource failed : " + b.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( b.toString() , "{2:item1,3:item2,1:item3}", "ABAG_05 - toString failed : " + b.toString() ) ;
	}

	public function testClear():Void 
	{
		var bag:AbstractBag = new ConcreteAbstractBag( new HashMap() ) ;
		bag.insert("item1") ;
		bag.insert("item1") ;
		bag.clear() ;
		assertTrue( bag.isEmpty(), "ABAG_06 - clear failed.") ;
	}

	public function testClone():Void 
	{
		var clone = b.clone() ;
		assertTrue(clone == null, "ABAG_07 - clone failed : " + clone ) ;
	}

	public function testContains():Void 
	{
		assertTrue(b.contains("item1"), "ABAG_08 - contains failed.") ;
	}

	public function testContainsAll():Void 
	{
		var c:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		bag.insertAll(c) ;
		assertTrue(bag.containsAll(c), "ABAG_09 - containsAll failed.") ;
	}
	
	public function testContainsAllInBag():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		
		var c1:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		bag.insertAll(c1) ;
		assertFalse( b.containsAllInBag(bag) , "ABAG_10_01 - containsAllInBag failed.") ;

		var c2:Collection = new SimpleCollection( ["item1", "item1", "item2", "item2", "item2", "item3"] ) ;
		bag.clear() ;
		bag.insertAll(c2) ;
		assertTrue( b.containsAllInBag(bag) , "ABAG_10_02 - containsAllInBag failed.") ;
	}

	public function testGet():Void
	{
		try
		{
			b.get() ;
			fail("ABAG_11_01 - get method failed.") ;
		}
		catch(e:Error)
		{
			assertEquals(
				e.toString() , 
				"[UnsupportedOperation] The 'get' method is unsupported with a bag object.", 
				"ABAG_11_02 - get method failed : " + e.toString()
			) ;	
		}
	}

	public function testGetCount():Void
	{
       assertEquals( b.getCount("item1"), 2, "ABAG_12_01 - getCount method failed : " + b.getCount("item1")) ;
       assertEquals( b.getCount("item2"), 3, "ABAG_12_02 - getCount method failed : " + b.getCount("item2")) ;
       assertEquals( b.getCount("item3"), 1, "ABAG_12_03 - getCount method failed : " + b.getCount("item3")) ;
       assertEquals( b.getCount(), 0, "ABAG_12_04 - getCount method failed : " + b.getCount()) ;
	}

	public function testGetModCount():Void 
	{
		assertTrue( TypeUtil.typesMatch(b.getModCount(), Number), "ABAG_13 - getModCount method failed : " + b.getModCount()) ;
	}

	public function testInsert():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		bag.insert("item1") ;
		assertEquals(bag.size(), 1, "ABAG_14 - insert method failed : " + bag) ;
	}

	public function testInsertAll():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		var c:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		bag.insertAll(c) ;
		assertEquals( bag.size() , 5, "ABAG_15 - insertAll failed : " + bag) ;
	}

	public function testInsertCopies():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		bag.insertCopies("item2", 2) ;
		assertEquals( bag.getCount("item2") , 2, "ABAG_16 - insertCopies failed : " + bag) ;
	}
	
	public function testIsEmpty():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		assertTrue( bag.isEmpty() , "ABAG_17 - isEmpty failed : " + bag) ;
    }
	
	public function testIterator():Void 
	{
		var it:Iterator = b.iterator() ;
		assertTrue(it.hasNext(), "ABAG_18_01 - iterator failed with hasNext() method : " + b) ;
		assertEquals(it.next(), "item1", "ABAG_18_02 - iterator failed with next() method : " + b) ;
	}

	public function testRemove():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		bag.insert("item1") ;
		bag.insertCopies("item2", 2) ;
		bag.remove("item1") ;
		bag.remove("item2") ;
		assertEquals( bag.getCount("item1"), 0, "ABAG_19_01 - remove method failed : " + b) ;
		assertEquals( bag.getCount("item2"), 0, "ABAG_19_02 - remove method failed : " + b) ;
	}

	public function testRemoveAll():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		var c:SimpleCollection = new SimpleCollection( ["item1", "item2", "item2"] ) ;
		bag.insertAll(c) ;
		bag.removeAll( c ) ;
		assertTrue( bag.isEmpty(), "ABAG_20 - removeAll(" + c + ") method failed : " + b) ;
    }

	public function testRemoveCopies():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		var c:SimpleCollection = new SimpleCollection( ["item1", "item2", "item2"] ) ;
		bag.insertAll(c) ;
		bag.removeCopies( "item2", 1 ) ;
		assertEquals( bag.getCount("item2"), 1, "ABAG_21 - removeCopies('item2', 1) method failed : " + b) ;
	}

	public function testRetainAll():Void 
	{
		var bag:Bag = new ConcreteAbstractBag( new HashMap() ) ;
		var c1:Collection = new SimpleCollection( ["item2", "item3"] ) ;
		var c2:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		bag.insertAll(c2) ;
		var result:Boolean = bag.retainAll(c1) ;
		assertTrue( result, "ABAG_22 - retainAll("+ c1 + ") method failed : " + result) ;
	}

	public function testRetainAllInBag():Void 
	{
		var c1:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		var c2:Collection = new SimpleCollection( ["item2", "item3"] ) ;
		
		var bag1:ConcreteAbstractBag = new ConcreteAbstractBag( new HashMap() ) ;
		bag1.insertAll(c1) ;
		
		var bag2:ConcreteAbstractBag = new ConcreteAbstractBag( new HashMap() ) ;
		bag2.insertAll(c2) ;
		
		var result:Boolean = bag1.retainAllInBag(bag2) ;
		assertTrue( result, "ABAG_23 - retainAllInBag method failed : " + result) ;
    }

	public function testSize():Void 
	{
		var size:Number = b.size() ;
		assertEquals(size, 6, "ABAG_24 - size method failed : " + size) ;
	}
	
	public function testToArray():Void 
	{
		var ar:Array = b.toArray() ;
		assertTrue(ar instanceof Array, "ABAG_25_01 - toArray method failed : " + ar) ;
		assertEquals(ar.length, 6, "ABAG_25_02 - toArray method failed : " + ar) ;
	}

	public function testUniqueSet():Void
	{
		var s:Set = b.uniqueSet() ;
		assertTrue(s instanceof Set, "ABAG_26_01 - uniqueSet method failed : " + s) ;
		assertEquals(s.size(), 3, "ABAG_26_02 - uniqueSet method failed : " + s) ;
	}

}