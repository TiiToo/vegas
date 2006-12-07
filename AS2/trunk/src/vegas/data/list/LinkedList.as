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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.IEquality;
import vegas.data.Collection;
import vegas.data.collections.CollectionFormat;
import vegas.data.collections.SimpleCollection;
import vegas.data.iterator.Iterator;
import vegas.data.iterator.LinkedListIterator;
import vegas.data.iterator.ListIterator;
import vegas.data.List;
import vegas.data.list.ArrayList;
import vegas.data.list.LinkedListEntry;
import vegas.data.Queue;
import vegas.errors.IndexOutOfBoundsError;
import vegas.errors.NoSuchElementError;
import vegas.util.serialize.Serializer;

/**
 * Linked list implementation of the List and Queue interface. 
 * <p>Implements all optional list operations, and permits all elements (including null).</p>
 * <p>In addition to implementing the List interface, the {@code LinkedList} class provides uniformly named methods to get, remove and insert an element at the beginning and end of the list.</p>
 * <p>These operations allow linked lists to be used as a stack, queue, etc.</p>
 * @author eKameleon
 */
class vegas.data.list.LinkedList implements List, Queue
{

	/**
	 * Creates a new LinkedList.
	 */
	function LinkedList( c:Collection )
	{
		_header = new LinkedListEntry(null, null, null) ;
		_header.next = _header.previous = _header ;	
		if (c != null && c.size() > 0)
		{
			insertAll(c) ;
		}
	}
	
	/**
	 * Removes all of the elements from this queue (optional operation).
	 */
	public function clear():Void
	{
		var e:LinkedListEntry = _header.next;
        while (e != _header) 
        {
            var next:LinkedListEntry = e.next;
            e.next = e.previous = null;
            e.element = null;
            e = next;
        }
		_header.next = _header.previous = _header ;
		_size = 0 ;
		_modCount++ ;
	}
	
	/**
	 * Returns the shallow copy of this queue.
	 */
	public function clone() 
	{
		var list:LinkedList = new LinkedList(  ) ;
		for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next )
		{
            list.insert(e.element) ;
		}
		return list ;	
	}

   /**
     * Returns {@code true} if this list contains the specified element.
     * <p><b>Example :</b></p>
     * {@code
	 * var list:LinkedList = new LinkedList() ;
	 * list.insert("item1") ;
	 * trace(list.contains( "item1" ) ; // output : true
     * }
     * @param o element whose presence in this list is to be tested.
     * @return {@code true} if this list contains the specified element.
     */
    public function contains( o ):Boolean
    {
        return indexOf(o) != -1 ;
    }
    
	/**
	 * Returns {@code true} if this collection contains the specified element.
	 * @return {@code true} if this collection contains the specified element.
	 */
	function containsAll(c : Collection):Boolean 
	{
		var it:Iterator = c.iterator() ;
		while(it.hasNext())
		{
			if ( ! contains( it.next() ) )
			{
				return false ;	
			} 	
		}
		return true ;
	}
    
	/**
	 * Retrieves and removes the head of this queue.
	 * @return {@code true} if the head of the queue is remove.
	 */
   	public function dequeue():Boolean 
   	{
		if ( _size == 0 )
		{
			return false ;
		}
		return removeFirst() != null ;
	}
    
    /**
     * Retrieves, but does not remove, the head (first element) of this list.
     * @return the head of this queue.
     * @throws NoSuchElementException if this queue is empty.
     */
    public function element() 
    {
        return getFirst();
    }
    
    /**
     * Adds the specified element as the tail (last element) of this list.
     * @param o the element to add.
     * @return {@code true} if the element in inserted in the list.
     */
    public function enqueue( o ):Boolean 
    {
        return insert(o);
    }

	/**
	 * Indicates whether some other object is "equal to" this one.
	 */
	public function equals(o):Boolean 
	{
		
		if (o == null)
		{
			return false ;
		}
		if ( ! o instanceof LinkedList )
		{
			return false ;
		}
		else
		{
			
			if ( LinkedList(o).size() != size())
			{
				return false ;	
			} 
			
			var i1:Iterator = iterator() ;
			var i2:Iterator = LinkedList(o).iterator() ;
			
			while( i1.hasNext() )
			{
				if (i1.next() != i2.next()) 
				{
					return false ;
				}	
			}
			
			return true ;
			
		}
	}

    /**
     * Returns the element at the specified position in this list.
     * @param index index of element to return.
     * @return the element at the specified position in this list.  
     * @throws IndexOutOfBoundsException if the specified index is out of range.
     */
	public function get(id : Number) 
	{
		var i:ListIterator = listIterator(id) ;
		try 
		{
	 	   return( i.next() ) ;
		} 
		catch( e:NoSuchElementError ) 
		{
	   		throw new IndexOutOfBoundsError("LinkedList 'get' method failed, index:" + id ) ;
		}
	}

    /**
     * Returns the first element in this list.
     * @return the first element in this list.
     * @throws NoSuchElementException if this list is empty.
     */
	public function getFirst()
	{
		if (_size == 0)
		{
			throw new NoSuchElementError("LinkedList getFirstList method failed, the list is empty.") ;	
		}
		return _header.next.element ;
	}
	
	/**
	 * Returns the header entry of this list.
	 */
	public function getHeader():LinkedListEntry
	{
		return _header ;	
	}
	
	/**
	 * Returns the last element in the list.
	 * @return the last element in the list.
	 * @throws NoSuchElementException if this list is empty.
	 */
	public function getLast()
	{
		if (_size == 0)
		{
			throw new NoSuchElementError("LinkedList getLast method failed, the list is empty.") ;		
		}
		return _header.previous.element ;
	}
	
	/**
	 * This method is used by the {@code LinkedListIterator} class only.
	 */
	public function getModCount():Number
	{
		return _modCount ;	
	}

    /**
     * Returns the index in this list of the first occurrence of the specified element, or -1 if the List does not contain this element.
     * @param o element to search for.
     * @return the index in this list of the first occurrence of the specified element, or -1 if the list does not contain this element.
     */
	public function indexOf( o ):Number
	{
		var index:Number = 0 ;
        if ( o == null ) 
        {
            for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next) 
            {
                if ( e.element == null )
                {
                    return index ;
                }
                index++ ;
            }
        } 
        else 
        {
            for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next ) 
            {
            	if (o instanceof IEquality)
            	{
                	if (o.equals(e.element))
                	{
                    	return index;
                	}
            	}
            	else
            	{
            		if (o == e.element)
            		{
            			return index ;	
            		}
            	}	
                index++ ;
            }
        }
        return -1 ;
	}

    /**
     * Appends the specified element to the end of this list.
     * @param o element to be appended to this list.
     * @return {@code true} (as per the general contract of {@code Collection.insert}).
     */
	public function insert( o ):Boolean
	{
		_insertBefore( o, _header ) ;
        return true ;
	}

    /**
     * Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator.
     * The behavior of this operation is undefined if the specified collection is modified while the operation is in progress.  
     * (This implies that the behavior of this call is undefined if the specified Collection is this list, and this list is nonempty.)
     * @param c the elements to be inserted into this list.
     * @return {@code true} if this list changed as a result of the call.
     * @throws NullPointerException if the specified collection is null.
     */
	public function insertAll( c:Collection ):Boolean
	{
		return insertAllAt( _size , c ) ;	
	}

	/**
	 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
	 */
    public function insertAllAt( index:Number, c:Collection):Boolean
    {
		
		if (index < 0 || index > _size)
		{
			throw new IndexOutOfBoundsError("LinkedList insertAllAt method failed, index:"+index+ ", size: " + _size + "." ) ;
		}
        
        var a:Array = c.toArray() ;
        var l:Number = a.length ;
        
        if (l == 0)
        {
            return false;
        }
		
		_modCount ++ ;

        var successor:LinkedListEntry = (index == _size) ? _header : _entry(index) ;
        var predecessor:LinkedListEntry = successor.previous ;
        
		for ( var i:Number = 0 ; i < l ; i++) 
		{
            var e:LinkedListEntry = new LinkedListEntry( a[i] , successor, predecessor ) ;
            predecessor.next = e ;
            predecessor = e ;
        }

        successor.previous = predecessor ;

        _size += l ;

        return true;

    }

	/**
	 * Inserts the specified element at the specified position in this list (optional operation).
     * @param id index at which the specified element is to be inserted.
     * @param o element to be inserted.
	 */
	public function insertAt(id:Number, o):Void 
	{
		var i:ListIterator = listIterator(id) ;
		i.insert(o);
	}

    /**
     * Inserts the given element at the beginning of this list.
     * @param o the element to be inserted at the beginning of this list.
     */
	public function insertFirst( o ):Void
	{
		_insertBefore( o, _header.next ) ;	
	}

    /**
     * Appends the given element to the end of this list.  
     * @param o the element to be inserted at the end of this list.
     */
	public function insertLast( o ):Void
	{
		_insertBefore(o , _header) ;	
	}
	
	/**
	 * Returns {@code true} if this queue contains no elements.
	 * @return {@code true} if this queue is empty else {@code false}.
	 */
	public function isEmpty():Boolean 
	{
		return _size == 0 ;	
	}

	/**
	 * Returns the iterator of this object.
	 */
	public function iterator():Iterator 
	{
		return listIterator() ;
	}

    /**
     * Returns the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     * @param o element to search for.
     * @return the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     */
    public function lastIndexOf( o ):Number 
    {
        var index:Number = _size ;
        if (o==null) 
        {
            for (var e:LinkedListEntry = _header.previous; e != _header; e = e.previous) 
            {
                index--;
                if (e.element==null)
                {
                    return index ;
                }
            }
        } 
        else 
        {
            for (var e:LinkedListEntry = _header.previous ; e != _header ; e = e.previous ) 
            {
                index-- ;
                if (o instanceof IEquality)
                {
                	if ( o.equals(e.element) )
                	{
                    	return index;
                	}
                }
                else
                {
                	if (o == e.element)
                	{
                		return index ;
                	}	
                }
            }
        }
        return -1 ;
    }

	/**
	 * Returns a list iterator of the elements in this list (in proper sequence).
	 */
	public function listIterator():ListIterator 
	{
		var index:Number = (arguments[0] > 0) ? arguments[0] : 0 ;
		return new LinkedListIterator( index , this ) ;
	}

    /**
     * Retrieves, but does not remove, the head (first element) of this list.
     * @return the head of this queue, or {@code null} if this queue is empty.
     */
    public function peek() 
    {
        if ( _size == 0 )
        {
            return null;
        }
        return getFirst() ;
    }


    /**
     * Retrieves and removes the head (first element) of this list.
     * @return the head of this queue, or {@code null} if this queue is empty.
     */
    public function poll() 
    {
        if ( _size == 0 )
        {
            return null;
        }
        return removeFirst() ;
    }

    /**
     * Removes the first occurrence of the specified element in this list.  
     * If the list does not contain the element, it is unchanged.
     * @param o element to be removed from this list, if present.
     * @return <tt>true</tt> if the list contained the specified element.
     */
    public function remove( o ):Boolean 
    {
    	
        if ( o == null ) 
        {
            for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next ) 
            {
                if ( e.element == null ) 
                {
                    _removeEntry(e) ;
                    return true;
                }
            }
        } 
        else 
        {
        	
            for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next ) 
            {
            	if ( o instanceof IEquality )
            	{
            		if ( IEquality(o).equals( e.element ) ) 
                	{
	                    _removeEntry(e);
                    	return true;
                	}
            	}
            	else 
				{ 	
                	if ( o == e.element ) 
                	{
	                    _removeEntry(e);
                    	return true;
                	}
				}
            }
        }
        return false;
    }
    

   
	/**
	 * Removes all elements defined in the specified Collection in the list.
	 * @return {@code true} if all elements are find and remove in the list.
	 */
	public function removeAll(c:Collection) : Boolean 
	{
		var result:Boolean = true ;
		var i:Iterator = c.iterator() ;
		while( i.hasNext() )
		{
			var b:Boolean = remove( i.next()) ;
			if ( !b )
			{
				result = false ;
			}
		}
		return result ;
	}

    /**
     * Removes an element at the specified position in this list. 
     * This implementation first gets a list iterator pointing to the indexed element (with {@code listIterator(index)}). 
     * Then, it removes the element with <b>ListIterator</b> remove method.
     * @param  id index of the element to be removed from the List.
     */
	public function removeAt(id : Number) 
	{
		return _removeEntry(_entry(id)) ;
	}

    /**
     * Removes the specified count of elements at the specified position in this list.
     * @param  id index of the first element to be removed from the List.
     * @return len the number of elements that was removed from the list.
     */
	public function removesAt(id:Number, len:Number) 
	{
		removeRange(id , id + len) ;
	}

    /**
     * Removes and returns the first element from this list.
     * @return the first element from this list.
     * @throws NoSuchElementException if this list is empty.
     */
	public function removeFirst()
	{
		return _removeEntry( _header.next );
	}

    /**
     * Removes and returns the last element from this list.
     * @return the last element from this list.
     * @throws NoSuchElementException if this list is empty.
     */
	public function removeLast()
	{
		return _removeEntry( _header.previous );
	}

	/**
	 * Removes from this list all the elements that are contained between the specific {@code from} and the specific {@code to} position in this list (optional operation).
	 */
	public function removeRange(from:Number, to:Number):Void 
	{
		if (from == undefined) 
		{
			return ;
		}
		var it:ListIterator = listIterator(from) ;
		var l:Number = to - from ;
		for (var i:Number = 0 ; i<l ; i++) 
		{
			it.next() ; 
			it.remove() ;
		}
	}

	/**
	 * Retains only the elements in this list that are contained in the specified collection (optional operation).
	 */
	public function retainAll(c : Collection):Boolean 
	{
		var b:Boolean = true ;
		var it:Iterator = iterator() ;
		while(it.hasNext())
		{
			var next = it.next() ;
			if ( !c.contains( next ) )
			{
				remove(next) ;
			} 
		}
		return c.size() == size() ;
	}

    /**
     * Replaces the element at the specified position in this list with the specified element.
     * @param id index of element to replace.
     * @param o element to be stored at the specified position.
     * @return the element previously at the specified position.
     */
	public function setAt(id:Number, o)
	{
		var i:ListIterator = listIterator(id) ;
		try 
		{
	    	var old = i.next() ;
	    	i.set(o) ;
	    	return old ;
		}
		catch( e:NoSuchElementError) 
		{
	    	throw new IndexOutOfBoundsError("LinkedList setAt method failed, index:" + id ) ;
		}
	}

	/**
	 * Returns the number of elements in this list.
	 * @return the number of elements in this list.
	 */
	public function size():Number
	{
		return _size ;	
	}

	/**
	 * Returns a subList of the LinkedList. The subList is an ArrayList instance.
	 */
	function subList(fromIndex : Number, toIndex : Number) : List 
	{
		var l:List = new ArrayList() ;
		var it:ListIterator = listIterator() ;
		var d:Number = (fromIndex - toIndex) + 1 ; 
		for (var i:Number = fromIndex ; i<= d ; i++) 
		{
			l.insert(it.next()) ;
		}
		return l ;
	}

    /**
     * Returns an array containing all of the elements in this list in the correct order.
     * @return an array containing all of the elements in this list in the correct order.
     */
    public function toArray():Array 
    {
		var ar:Array = new Array( _size ) ;
        var i:Number = 0 ;
		for ( var e:LinkedListEntry = _header.next ; e != _header ; e = e.next )
		{
			ar[i++] = e.element ;
		}
		return ar ;
    }

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		return Serializer.getSourceOf(this, [Serializer.toSource(new SimpleCollection(toArray()))]) ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString():String 
	{
		return (new CollectionFormat()).formatToString(this) ;	
	}

	/**
	 * Return the indexed entry.
	 */
	private function _entry( index:Number ):LinkedListEntry
	{
		if (index < 0 || index >= _size)
		{
			throw new IndexOutOfBoundsError("LinkedList private '_entry' method failed, index:" + index + ", size:" + _size + "." ) ;
		}
		var e:LinkedListEntry = _header ;
		if ( index < (_size >> 1))
		{
			
			for (var i:Number = 0 ; i<= index ; i++)
			{
				e = e.next ;
			}
		}
		else
		{
			for (var i:Number = _size ; i > index ; i--)
			{
				e = e.previous ;	
			}
		}
		return e ;
	}
	
	/**
	 * Inserts the given element in the list before the given entry.
	 * This method is "protected" only the LinkedList and the LinkedListIterator must use this method.
	 * @param o the element to be inserted at the beginning of this list.
	 * @param e the entry instance to defined where inserted the element.
	 */
	public function _insertBefore( o , e:LinkedListEntry ):LinkedListEntry
	{
		var newLinkedListEntry:LinkedListEntry = new LinkedListEntry( o, e, e.previous ) ;
		newLinkedListEntry.previous.next = newLinkedListEntry ;
		newLinkedListEntry.next.previous = newLinkedListEntry ;
		_size ++ ;
		return newLinkedListEntry ;
	}

    /**
     * Removes an Entry in the list.
     */
    public function _removeEntry( e:LinkedListEntry )
    {
    	if (e == _header)
    	{
    		throw new NoSuchElementError(this + " removeEntry method failed.");
    	}
    	var result = e.element ;
    	e.previous.next = e.next;
		e.next.previous = e.previous;
        e.next = e.previous = null ;
        e.element = null ;
		_size-- ;
		_modCount++ ;
        return result ;
    }

	/**
	 * The internal header of this list.
	 */
	private var _header:LinkedListEntry ;
	
	/**
	 * The mod count value.
	 */
	private var _modCount:Number = 0 ;
	
	/**
	 * The internal size of the list.
	 */
	private var _size:Number = 0 ;
	
}