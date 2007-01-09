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
import vegas.data.iterator.Iterator;
import vegas.data.iterator.ListIterator;
import vegas.data.list.ArrayList;
import vegas.data.list.LinkedList;
import vegas.data.list.LinkedListEntry;
import vegas.errors.IndexOutOfBoundsError;

/**
 * @author eKameleon
 */
class Tests.vegas.data.list.TestLinkedList extends TestCase 
{
	
	/**
	 * Creates a new TestLinkedList instance.
	 */
	function TestLinkedList(name : String) 
	{
		super(name);
	}
	
	public var list:LinkedList ;
	
	public function setUp():Void
	{
		list = new vegas.data.list.LinkedList() ;
	}
	
	public function testConstructor():Void 
	{
		assertNotNull( list , "LINKED_LIST_01_01 - constructor failed, the instance not must be null." ) ;
		assertTrue (list instanceof LinkedList, "LINKED_LIST_01_02 - constructor failed isn't an instance of LinkedList.") ;
	}

	public function testInherit():Void 
	{
		assertTrue( list instanceof vegas.core.CoreObject , "LINKED_LIST_02 - inherit vegas.core.CoreObject failed." ) ;
	}

	public function testHashCode():Void 
	{
		assertFalse( isNaN(list.hashCode()) , "LINKED_LIST_03 - hashCode failed." ) ;
	}

	public function testClear():Void 
	{
		var clone = list.clone() ;
		clone.insert("item1") ;
		clone.insert("item2") ;
		clone.clear() ;
		assertEquals( clone.size() , 0, "LINKED_LIST_04 - clear method failed." ) ;
	}

	public function testClone():Void 
	{
		var clone = list.clone() ;
		clone.insert("item1") ;
		clone.insert("item2") ;
		assertEquals( clone.size() , 2, "LINKED_LIST_05_01 - clone failed - not equals size." ) ;
		assertTrue( clone instanceof vegas.data.list.LinkedList, "LINKED_LIST_05_02 - clone failed - not instanceof LinkedList." ) ;
	}

	public function testContains():Void 
	{
		var clone = list.clone() ;
		clone.insert("item1") ;
		clone.insert("item2") ;
		var b1:Boolean = clone.contains("item1") ;
		var b2:Boolean = clone.contains("item3") ;
		assertTrue ( b1, "LINKED_LIST_06_01 - contains failed - 'item1' is in the list : " + b1 ) ;
		assertFalse( b2, "LINKED_LIST_06_02 - contains failed - 'item3' isn't in the list : " + b2 ) ;
	}

	public function testContainsAll():Void 
	{
		var clone:LinkedList = list.clone() ;
		var c1:SimpleCollection = new SimpleCollection( ["item1", "item3"] ) ;
		var c2:SimpleCollection = new SimpleCollection( ["item1", "item5"] ) ;
		clone.insert("item1") ;
		clone.insert("item2") ;
		clone.insert("item3") ;
		var b1:Boolean = clone.containsAll(c1) ;
		var b2:Boolean = clone.containsAll(c2) ;
		assertTrue ( b1, "LINKED_LIST_07_01 : containsAll(" + c1 + ") failed : " + b1 ) ;
		assertFalse( b2, "LINKED_LIST_07_02 : containsAll(" + c2 + ") failed : " + b2 ) ;
	}
	
	public function testDequeue():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.insert("item1") ;
		clone.insert("item2") ;
		var b:Boolean = clone.dequeue() ;
		assertTrue ( b, "LINKED_LIST_08 : dequeue() failed : " + b ) ;
	}

	public function testElement():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.insert("item1") ;
		clone.insert("item2") ;
		var e = clone.element() ;
		assertEquals ( e, "item1", "LINKED_LIST_09 : element() failed : " + e ) ;
	}

	public function testEnqueue():Void 
	{
	
		var l:LinkedList = list.clone() ;
		l.enqueue("item1") ;
		
		var b:Boolean = l.enqueue("item2") ;
		assertTrue ( b, "LINKED_LIST_10_01 : enqueue() failed : " + b ) ;
		
		var size:Number = l.size() ;
		assertEquals ( size , 2, "LINKED_LIST_10_02 : enqueue() failed, the size of the list isn't good : " + size ) ;
		
		var first = l.getFirst() ;
		assertEquals ( first, "item1", "LINKED_LIST_10_03 : enqueue() failed the first item isn't the good element : " + first ) ;
	
		var last = l.getLast() ;
		assertEquals ( last, "item2", "LINKED_LIST_10_04 : enqueue() failed the last item isn't the good element : " + last ) ;
		
	}

	public function testEquals():Void 
	{
	
		var list1:LinkedList = new LinkedList() ;
		list1.enqueue("item1") ;
		list1.enqueue("item2") ;
	
		var list2:LinkedList = new LinkedList() ;
		list2.enqueue("item1") ;
		list2.enqueue("item2") ;
	
		var b:Boolean = list1.equals(list2) ;
		
		assertTrue ( b, "LINKED_LIST_11 : equals() failed, the 2 lists are different : " + list1 + " and " + list2 ) ;
	}

	public function testGet():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.enqueue("item1") ;
		clone.enqueue("item2") ;
		var e = clone.get(1) ;
		assertEquals ( e, "item2" , "LINKED_LIST_12 : get() failed at the index 1 the value is : " + e) ;
	}

	public function testGetFirst():Void 
	{
		var l:LinkedList = new LinkedList() ;
		l.enqueue("item1") ;
		l.enqueue("item2") ;
		var e = l.getFirst() ;
		assertEquals ( e, "item1" , "LINKED_LIST_13 : getFirst() failed at the first index the value is : " + e) ;
	}

	public function testGetHeader():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.enqueue("item1") ;
		clone.enqueue("item2") ;
		var h = clone.getHeader() ;
		assertTrue ( h instanceof LinkedListEntry , "LINKED_LIST_14 : getHeader() failed : " + h) ;
	}

	public function testGetLast():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.enqueue("item1") ;
		clone.enqueue("item2") ;
		var e = clone.getLast() ;
		assertEquals ( e, "item2" , "LINKED_LIST_15 : getLast() failed at the last index the value is : " + e) ;
	}

	public function testGetModCount():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.enqueue("item1") ;
		clone.enqueue("item2") ;
		var count = clone.getModCount() ;
		assertEquals ( count, 2 , "LINKED_LIST_16 : getModCount() failed.") ;
	}

	public function testIndexOf():Void 
	{
		var clone:LinkedList = list.clone() ;
		clone.enqueue("item1") ;
		clone.enqueue("item2") ;
		var index:Number = clone.indexOf("item2") ;
		assertEquals ( index, 1 , "LINKED_LIST_17 : indexOf('item2') in " + list + " failed : " + index) ;
	}

	public function testInsert():Void 
	{
	
		var clone:LinkedList = list.clone() ;
		clone.insert("item1") ;
	
		var b:Boolean = clone.insert("item2") ;
		assertTrue ( b, "LINKED_LIST_18_01 : insert() failed : " + b ) ;
	
		var size:Number = clone.size() ;
		assertEquals ( size , 2, "LINKED_LIST_18_02 : insert() failed, the size of the list isn't good : " + size ) ;
	
		var first = clone.getFirst() ;
		assertEquals ( first, "item1", "LINKED_LIST_18_03 : insert() failed the first item isn't the good element : " + first ) ;

		var last = clone.getLast() ;
		assertEquals ( last, "item2", "LINKED_LIST_18_04 : insert() failed the last item isn't the good element : " + last ) ;
		
	}

	public function testInsertAll():Void 
	{
		var l:LinkedList = new vegas.data.list.LinkedList() ;
		var c:SimpleCollection = new SimpleCollection( ["item1", "item2", "item3"] ) ;
		var b:Boolean = l.insertAll(c) ;
		assertTrue ( b, "LINKED_LIST_19 : insertAll(" + c + ") failed : " + b ) ;
	}	

	public function testInsertAllAt():Void 
	{
		var c:SimpleCollection = new SimpleCollection( ["item1", "item2", "item3"] ) ;
		var l = new vegas.data.list.LinkedList() ;
		l.insert("item0") ;
		var b:Boolean = l.insertAllAt(1, c) ;
		assertTrue ( b, "LINKED_LIST_20 : insertAllAt(" + 1 + "," + c + ") failed : " + b ) ;
	}

	public function testInsertAt():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item0") ;
		l.insert("item2") ;
		l.insertAt(1, "item1") ;
		var item = l.get(1) ;
		assertEquals( item, "item1", "LINKED_LIST_21 : insertAt(" + 1 + ",'item1') failed." ) ;
	}

	public function testInsertFirst():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item2") ;
		l.insertFirst("item1") ;
		var item = l.get(0) ;
		assertEquals( item, "item1", "LINKED_LIST_22 : insertFirst('item1') failed : " + item ) ;
	}

	public function testInsertLast():Void 
	{
		var l = list.clone() ;
		l.insert("item1") ;
		l.insertLast("item2") ;
		var item = l.get(1) ;
		assertEquals( item, "item2", "LINKED_LIST_23 : insertLast('item2') failed : " + item ) ;
	}

	public function testIsEmpty():Void 
	{
		assertTrue( list.isEmpty() , "LINKED_LIST_24_01 : isEmpty() failed, list size : " + list.size()) ;
		var clone:LinkedList = list.clone() ;
		clone.insert("item1") ;
		assertFalse( clone.isEmpty() , "LINKED_LIST_24_02  : isEmpty() failed, list size : " + clone.size()) ;
	}

	public function testIterator():Void 
	{
		var l:LinkedList = new LinkedList() ;
		var it:Iterator ;
		it = list.iterator() ;
		assertFalse( it.hasNext() , "LINKED_LIST_25_01 : iterator() failed.") ;
		list.insert("item1") ;
		it = list.iterator() ;
		assertTrue( it.hasNext() , "LINKED_LIST_25_02 : iterator() failed.") ;
		assertEquals( it.next() , "item1", "LINKED_LIST_25_03 : iterator() failed.") ;
		assertFalse( it.hasNext() , "LINKED_LIST_25_04 : iterator() failed.") ;
	}

	public function testLastIndexOf():Void 
	{
		var l:LinkedList = new vegas.data.list.LinkedList() ;
		l.enqueue("item1") ;
		l.enqueue("item2") ;
		l.enqueue("item3") ;
		l.enqueue("item4") ;
		var index:Number = l.lastIndexOf("item3") ;
		assertEquals ( index, 2 , "LINKED_LIST_26 : lastIndexOf('item3') in " + list + " failed : " + index) ;
	}

	public function testListIterator():Void 
	{
		var l:LinkedList = new LinkedList() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		var it:ListIterator = l.listIterator(2) ;
		assertTrue( it.hasPrevious() , "LINKED_LIST_27_01 - listIterator() failed : " + it.hasPrevious() ) ;
		var isCatch:Boolean = false ;
		try
		{
			it = l.listIterator(15) ;
		}
		catch(e:Error)
		{
			assertTrue( e instanceof IndexOutOfBoundsError, "LINKED_LIST_27_02 - listIterator() failed : " + e) ;
			isCatch = true ;
		}
		assertTrue( isCatch, "LINKED_LIST_27_03 - listIterator() failed, is catch ? : " + isCatch) ;
	}
	
	public function testPeek():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		var e = l.peek() ;
		assertEquals( e, "item1", "LINKED_LIST_28_01 : peek() failed : " + e ) ;
		assertEquals( l.size(), 3, "LINKED_LIST_28_02 : peek() failed, the list size change : " + l.size() ) ;
	}

	public function testPoll():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
	
		var e = l.poll() ;
		assertEquals( e, "item1", "LINKED_LIST_28_01 : poll() failed : " + e ) ;
		assertEquals( l.size(), 2, "LINKED_LIST_28_02 : peek() failed, the list size must change : " + l.size() ) ;
	}

	public function testRemove():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		var b:Boolean = l.remove("item2") ;
		assertTrue( b, "LINKED_LIST_29_01, remove failed : " + b) ;
		assertEquals( l.size(), 2, "LINKED_LIST_29_02 : remove() failed, the list size must change : " + l.size() ) ;
	}

	public function testRemoveAll():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
	
		var b:Boolean ;
	
		b = l.removeAll() ;
		assertFalse( b, "LINKED_LIST_30_01, removeAll failed : " + b) ;
		
		b = l.removeAll(new SimpleCollection( ["item1", "item2"] ) ) ;
		
		assertTrue( b, "LINKED_LIST_30_02, removeAll failed : " + b) ;
		assertEquals( l.size(), 1, "LINKED_LIST_30_03, removeAll() failed, the list size must change : " + l.size() ) ;
	}

	public function testRemoveAt():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		var b:Boolean = l.removeAt(1) ;
		assertTrue( b, "LINKED_LIST_31_01, removeAt(" + 1 + ") failed : " + b) ;
	}

	public function testRemovesAt():Void 
	{
		var l:LinkedList = new LinkedList() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		l.insert("item4") ;
		l.insert("item5") ;
		l.removesAt(1, 3) ;
		assertEquals( l.size(), 2, "LINKED_LIST_32, removesAt(" + 1 + "," + 3 + ") failed : " + l) ;
	}
	
	public function testRemoveFirst():Void
	{
		var l:LinkedList = new LinkedList() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		l.insert("item4") ;
		l.insert("item5") ;
		var result = l.removeFirst() ;
		assertEquals( l.size(), 4, "LINKED_LIST_33_01, removeFirst() failed, the size of the list failed : " + l) ;
		assertEquals( result, "item1", "LINKED_LIST_33_02, removeFirst() failed : " + result) ;
	}
	
	public function testRemoveLast():Void
	{
		var l:LinkedList = new LinkedList() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		l.insert("item4") ;
		l.insert("item5") ;
		var result = l.removeLast() ;
		assertEquals( l.size(), 4, "LINKED_LIST_34_01, removeLast() failed, the size of the list failed : " + l) ;
		assertEquals( result, "item5", "LINKED_LIST_34_02, removeLast() failed : " + result) ;
	}

	public function testRemoveRange():Void
	{
		var list1:LinkedList = new LinkedList() ;
		list1.insert("item1") ;
		list1.insert("item2") ;
		list1.insert("item3") ;
		list1.insert("item4") ;
		list1.insert("item5") ;
		
		list1.removeRange(2, 4) ;
		
		var list2:LinkedList = new LinkedList() ;
		list2.insert("item1") ;
		list2.insert("item2") ;
		list2.insert("item5") ;
		
		assertEquals( list1.size(), 3, "LINKED_LIST_35_01, removeRange() failed, the size of the list failed : " + list1) ;
		assertEquals( list1, list2, "LINKED_LIST_35_02, removeRange() failed : " + list1) ;
	}

	public function testRetainAll():Void 
	{
		var l:LinkedList = new LinkedList() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		l.insert("item4") ;
		l.insert("item5") ;
		var c:SimpleCollection = new SimpleCollection( ["item2", "item4"] ) ;
		var b:Boolean = l.retainAll( c ) ;
		assertTrue( b, "LINKED_LIST_33, retainAll(" + c + ") failed : " + l + ", result : " + b) ;
	}

	public function testSetAt():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		var old = l.setAt( 1, "ITEM2" ) ;
		assertEquals( old, "item2", "LINKED_LIST_34_01, setAt(" + 1 + "," + "ITEM2" + ") failed the old value : " + old) ;
	}

	public function testSize():Void
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		var size:Number = l.size() ;
		assertEquals( size, 2, "LINKED_LIST_35, size() failed : " + size) ;
	}

	public function testSubList():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		l.insert("item4") ;
		l.insert("item5") ;
		var sub = l.subList(1, 3) ;
		assertTrue( sub instanceof ArrayList, "LINKED_LIST_36_01, subList() failed : " + sub) ;
		assertEquals( sub.size() , 3, "LINKED_LIST_36_02, subList() failed, the size of the subList no corresponding : " + sub) ;
	}

	public function testToArray():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		l.insert("item3") ;
		l.insert("item4") ;
		l.insert("item5") ;
		var ar:Array = l.toArray() ;
		assertTrue( ar instanceof Array, "LINKED_LIST_37_01, toArray() failed : " + ar) ;
		assertEquals( ar.length , l.size(), "LINKED_LIST_37_02, toArray() failed, the size of the subList no corresponding : " + ar.length) ;
	}

	public function testToSource():Void
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		var source:String = l.toSource() ;
		assertEquals( source, 'new vegas.data.list.LinkedList(new vegas.data.collections.SimpleCollection(["item1","item2"]))', "LINKED_LIST_38, toSource() failed : " + source) ;
	}

	public function testToString():Void 
	{
		var l:LinkedList = list.clone() ;
		l.insert("item1") ;
		l.insert("item2") ;
		var source:String = l.toString() ;
		assertEquals( source, '{item1,item2}', "LINKED_LIST_39, toString() failed : " + source) ;
	}

}