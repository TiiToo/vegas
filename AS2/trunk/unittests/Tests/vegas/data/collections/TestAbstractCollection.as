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

import Tests.vegas.data.collections.ConcreteAbstractCollection;

import vegas.core.CoreObject;
import vegas.data.Collection;
import vegas.data.collections.AbstractCollection;
import vegas.data.iterator.Iterator;

/**
 * @author eKameleon
 */
class Tests.vegas.data.collections.TestAbstractCollection extends TestCase 
{
	
	function TestAbstractCollection(name : String) 
	{
		super(name);
	}
	
	public var c:ConcreteAbstractCollection ;
	
	public function setUp():Void
	{
		c = new ConcreteAbstractCollection(["item1", "item2"]) ;
		c.insert("item3") ;
	}
	
	public function testConstructor()
	{
		assertNotNull( c, "A_CO_01_01 - constructor is null") ;
		assertTrue( c instanceof ConcreteAbstractCollection , "A_CO_01_02 - constructor is an instance of ConcreteAbstractCollection.") ;
		assertTrue( c instanceof AbstractCollection , "A_CO_01_02 - constructor is an instance of AbstractCollection.") ;
	}
	
	public function testInherit()
	{
		assertTrue( c instanceof CoreObject , "A_CO_02 - inherit CoreObject failed.") ;
	}	

	public function testHashCode():Void
	{
		assertFalse( isNaN(c.hashCode()) , "A_CO_03 - hashCode failed : " + c.hashCode() ) ;
	}

	public function testToSource():Void
	{
		assertEquals( c.toSource() , 'new Tests.vegas.data.collections.ConcreteAbstractCollection(["item1","item2","item3"])', "A_CO_04 - toSource failed : " + c.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( c.toString() , "{item1,item2,item3}", "A_CO_05 - toString failed : " + c.toString() ) ;
	}

	public function testClear():Void 
	{
		var co:AbstractCollection = new ConcreteAbstractCollection() ;
		co.insert("item1") ;
		co.clear() ;
		assertTrue( co.isEmpty(), "A_CO_06 - clear failed.") ;
	}

	public function testClone():Void 
	{
		var clone = c.clone() ;
		assertTrue(clone == null, "A_CO_07 - clone failed : " + clone ) ;
	}

	public function testContains():Void 
	{
		assertTrue(c.contains("item1"), "A_CO_08 - contains failed.") ;
	}

	public function testGet():Void
	{
		assertEquals(c.get(0), "item1", "A_CO_09 - get failed.") ;
	}

	public function testIndexOf():Void
	{
		assertEquals(c.indexOf("item1"), 0, "A_CO_10 - indexOf failed.") ;	
	}

	public function testInsert():Void 
	{
		var co:Collection = new ConcreteAbstractCollection() ;
		co.insert("item1") ;
		assertEquals(co.size(), 1, "A_CO_14 - insert method failed : " + co) ;
	}

	public function testIsEmpty():Void 
	{
		var co:Collection = new ConcreteAbstractCollection() ;
		assertTrue( co.isEmpty() , "A_CO_17 - isEmpty failed : " + co) ;
    }
	
	public function testIterator():Void 
	{
		var it:Iterator = c.iterator() ;
		assertTrue(it.hasNext(), "A_CO_18_01 - iterator failed with hasNext() method : " + c) ;
		assertEquals(it.next(), "item1", "A_CO_18_02 - iterator failed with next() method : " + c) ;
	}

	public function testRemove():Void 
	{
		var co:Collection = new ConcreteAbstractCollection() ;
		co.insert("item1") ;
		co.remove("item1") ;
		assertTrue( co.isEmpty(), "A_CO_19_01 - remove method failed : " + co) ;
	}

	public function testSize():Void 
	{
		var size:Number = c.size() ;
		assertEquals(size, 3, "A_CO_24 - size method failed : " + size) ;
	}
	
	public function testToArray():Void 
	{
		var ar:Array = c.toArray() ;
		assertTrue(ar instanceof Array, "A_CO_25_01 - toArray method failed : " + ar) ;
		assertEquals(ar.length, 3, "A_CO_25_02 - toArray method failed : " + ar) ;
	}

}