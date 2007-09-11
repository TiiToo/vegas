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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Linked list implementation of the List and Queue interface. 
 * <p>Implements all optional list operations, and permits all elements (including null).</p>
 * <p>In addition to implementing the List interface, the {@code LinkedList} class provides uniformly named methods to get, remove and insert an element at the beginning and end of the list.</p>
 * <p>These operations allow linked lists to be used as a stack, queue, etc.</p>
 * <p><b>Example :</b></p>
 * {@code
 * LinkedList = vegas.data.list.LinkedList ;
 * SimpleCollection = vegas.data.collections.SimpleCollection ;
 * 
 * var c1 = new SimpleCollection() ;
 * c1.insert("item0") ;
 * c1.insert("item1") ;
 * c1.insert("item2") ;
 * c1.insert("item3") ;
 * c1.insert("item4") ;
 * c1.insert("item5") ;
 * c1.insert("item6") ;
 * c1.insert("item7") ;
 * c1.insert("item8") ;
 * c1.insert("item9") ;
 * 
 * trace("c1 : " + c1) ;
 * 
 * var c2 = new SimpleCollection() ;
 * c2.insert("item7") ;
 * c2.insert("item8") ;
 * 
 * trace("c2 : " + c1) ;
 * 
 * var list = new LinkedList(c1) ;
 * trace ("list toSource : " + list.toSource()) ;
 * 
 * trace ("-----") ;
 * 
 * trace ("create list : " + list) ;
 * trace("list.contains('item1') : " + list.contains("item1") ) ;
 * 
 * list.insertAt(2,'test')
 * trace("list.insertAt(2,'test')" + list ) ;
 * 
 * list.removeAt(2) ;
 * trace ("list.removeAt(2) : " + list) ;
 * 
 * list.remove("item4") ;
 * trace ("list.remove('item4') : " + list) ;
 * 
 * list.removeFirst() ;
 * trace ("list.removeFirst() : " + list) ;
 * 
 * list.removeLast() ;
 * trace ("list.removeLast() : " + list) ;
 * 
 * list.removesAt(1, 4) ;
 * trace ("list.removesAt(1, 4) : " + list) ;
 * 
 * list.removeRange(1, 3) ;
 * trace ("list.removeRange(1, 3) : " + list) ;
 * 
 * trace ("-----") ;
 * 
 * list.insertAllAt(0, c2) ;
 * trace ("list.insertAllAt(0, c2) : " + list) ;
 * 
 * trace ("--- ListIterator") ;
 * 
 * var it = list.listIterator() ;
 * var i = 0 ;
 * while (it.hasNext())
 * {
 *     it.next() ;
 *     it.set("element" + i++) ;
 * }
 * trace (">> " + list) ;
 * 
 * trace ("---") ;
 * 
 * var it = list.listIterator(list.size()) ;
 * while(it.hasPrevious())
 * {
 *     trace (it.previous()) ;
 * }
 * 
 * //*
 * trace ("-----") ;
 * 
 * list.insertFirst("begin") ;
 * trace ("list.insertFirst('begin') : " + list) ;
 * 
 * list.insertLast("end") ;
 * trace ("list.insertLast('end') : " + list) ;
 * 
 * trace ("list.getFirst() : " + list.getFirst()) ;
 * trace ("list.getLast() : " + list.getLast()) ;
 * 
 * list.removeFirst() ;
 * trace ("list.removeFirst() : " + list) ;
 * 
 * list.removeLast() ;
 * trace ("list.removeLast() : " + list) ;
 * 
 * trace ("---- clear") ;
 * 
 * list.clear() ;
 * 
 * trace("list.size() : " + list.size()) ;
 * trace("list.isEmpty : " + list.isEmpty() ) ;
 *  
 * }
 * @author eKameleon
 * @version 1.0.0.0
 */
if (vegas.data.list.LinkedList == undefined) 
{

	/**
	 * Creates a new LinkedList instance.
	 * @constructor
	 */
	vegas.data.list.LinkedList = function (  c /*Collection*/ ) 
	{ 
		this._header = new vegas.data.list.LinkedListEntry(null, null, null) ;
		this._header.next = this._header.previous = this._header ;	
		
		if (c != null && c.size() > 0)
		{
			this.insertAll(c) ;
		}
		
	}
	
	// Inherit
	vegas.data.list.LinkedList.extend(vegas.core.CoreObject) ;

	/**
	 * Removes all of the elements from this queue (optional operation).
	 */
	vegas.data.list.LinkedList.prototype.clear = function() /*void*/
	{
		var e /*LinkedListEntry*/ = this._header.next ;
        while (e != this._header) 
        {
            var next /*LinkedListEntry*/ = e.next;
            e.next = e.previous = null;
            e.element = null;
            e = next ;
        }
		this._header.next = this._header.previous = this._header ;
		this._size = 0 ;
		this._modCount++ ;
	}

	/**
	 * Returns the shallow copy of this queue.
	 */
	vegas.data.list.LinkedList.prototype.clone = function() 
	{
		var list /*LinkedList*/ = new vegas.data.list.LinkedList() ;
		for ( var e /*LinkedListEntry*/ = this._header.next ; e != this._header ; e = e.next )
		{
            list.insert( e.element ) ;
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
    vegas.data.list.LinkedList.prototype.contains = function ( o ) /*Boolean*/
    {
        return this.indexOf(o) != -1 ;
    }

	/**
	 * Returns {@code true} if this collection contains the specified element.
	 * @return {@code true} if this collection contains the specified element.
	 */
	vegas.data.list.LinkedList.prototype.containsAll = function( c /*Collection*/ ) /*Boolean*/ 
	{
		var it /*Iterator*/ = c.iterator() ;
		while(it.hasNext())
		{
			if ( ! this.contains( it.next() ) )
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
   	vegas.data.list.LinkedList.prototype.dequeue = function() /*Boolean*/ 
   	{
		if ( this._size == 0 )
		{
			return false ;
		}
		return this.removeFirst() != null ;
	}

    /**
     * Retrieves, but does not remove, the head (first element) of this list.
     * @return the head of this queue.
     * @throws NoSuchElementException if this queue is empty.
     */
   	vegas.data.list.LinkedList.prototype.element = function() 
    {
        return this.getFirst();
    }
    
    /**
     * Adds the specified element as the tail (last element) of this list.
     * @param o the element to add.
     * @return {@code true} if the element in inserted in the list.
     */
    vegas.data.list.LinkedList.prototype.enqueue = function( o ) /*Boolean*/ 
    {
        return this.insert(o);
    }
    
	/**
	 * Indicates whether some other object is "equal to" this one.
	 */
	vegas.data.list.LinkedList.prototype.equals = function(o) /*Boolean*/ 
	{
		
		if (o == null)
		{
			return false ;
		}
		if ( ! o instanceof vegas.data.list.LinkedList )
		{
			return false ;
		}
		else
		{
			
			if ( o.size() != this.size())
			{
				return false ;	
			} 
			
			var i1 /*Iterator*/ = this.iterator() ;
			var i2 /*Iterator*/ = o.iterator() ;
			
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
	vegas.data.list.LinkedList.prototype.get = function( id /*Number*/ ) 
	{
		var i /*ListIterator*/ = this.listIterator(id) ;
		try 
		{
	 	   return i.next() ;
		} 
		catch( e /*NoSuchElementError*/ ) 
		{
	   		throw new vegas.errors.IndexOutOfBoundsError("LinkedList 'get' method failed, index:" + id ) ;
		}
	}
	
    /**
     * Returns the first element in this list.
     * @return the first element in this list.
     * @throws NoSuchElementException if this list is empty.
     */
	vegas.data.list.LinkedList.prototype.getFirst = function()
	{
		if (this._size == 0)
		{
			throw new vegas.errors.NoSuchElementError("LinkedList getFirstList method failed, the list is empty.") ;	
		}
		return this._header.next.element ;
	}
	
	/**
	 * Returns the header entry of this list.
	 */
	vegas.data.list.LinkedList.prototype.getHeader = function() /*LinkedListEntry*/
	{
		return this._header ;	
	}
	
	/**
	 * Returns the last element in the list.
	 * @return the last element in the list.
	 * @throws NoSuchElementException if this list is empty.
	 */
	vegas.data.list.LinkedList.prototype.getLast = function()
	{
		if (this._size == 0)
		{
			throw new vegas.errors.NoSuchElementError("LinkedList getLast method failed, the list is empty.") ;		
		}
		return this._header.previous.element ;
	}
	
	/**
	 * This method is used by the {@code LinkedListIterator} class only.
	 */
	vegas.data.list.LinkedList.prototype.getModCount = function() /*Number*/
	{
		return this._modCount ;	
	}

    /**
     * Returns the index in this list of the first occurrence of the specified element, or -1 if the List does not contain this element.
     * @param o element to search for.
     * @return the index in this list of the first occurrence of the specified element, or -1 if the list does not contain this element.
     */
	vegas.data.list.LinkedList.prototype.indexOf = function( o ) /*Number*/
	{
		var index /*Number*/ = 0 ;
        if ( o == null ) 
        {
            for ( var e /*LinkedListEntry*/ = this._header.next ; e != this._header ; e = e.next) 
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
            for ( var e /*LinkedListEntry*/ = this._header.next ; e != this._header ; e = e.next ) 
            {
            	if (o.hasOwnProperty("equals") && o["equals"] instanceof Function)
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
	vegas.data.list.LinkedList.prototype.insert = function( o ) /*Boolean*/
	{
		this._insertBefore( o, this._header ) ;
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
	vegas.data.list.LinkedList.prototype.insertAll = function( c /*Collection*/ ) /*Boolean*/
	{
		return this.insertAllAt( this._size , c ) ;	
	}

	/**
	 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
	 */
    vegas.data.list.LinkedList.prototype.insertAllAt = function ( index /*Number*/, c /*Collection*/ ) /*Boolean*/
    {
		
		if (index < 0 || index > this._size)
		{
			throw new vegas.errors.IndexOutOfBoundsError("LinkedList insertAllAt method failed, index:"+index+ ", size: " + this._size + "." ) ;
		}
        
        if (c instanceof vegas.data.Collection)
        {
         
        	var a /*Array*/ = c.toArray() ;
        	var l /*Number*/ = a.length ;
			        
        	if (l == 0)
        	{
	            return false;
        	}
			
			this._modCount ++ ;
			
        	var successor /*LinkedListEntry*/ = (index == this._size) ? this._header : this._entry(index) ;
        	var predecessor /*LinkedListEntry*/ = successor.previous ;
        	
			for ( var i /*Number*/ = 0 ; i < l ; i++) 
			{
            	var e /*LinkedListEntry*/ = new vegas.data.list.LinkedListEntry( a[i] , successor, predecessor ) ;
            	predecessor.next = e ;
            	predecessor = e ;
        	}
	
        	successor.previous = predecessor ;
	
        	this._size += l ;
	
        	return true;
	
	    }
    
    }

	/**
	 * Inserts the specified element at the specified position in this list (optional operation).
     * @param id index at which the specified element is to be inserted.
     * @param o element to be inserted.
	 */
	vegas.data.list.LinkedList.prototype.insertAt = function( id /*Number*/, o ) /*void*/ 
	{
		var i /*ListIterator*/ = this.listIterator(id) ;
		i.insert(o);
	}

    /**
     * Inserts the given element at the beginning of this list.
     * @param o the element to be inserted at the beginning of this list.
     */
	vegas.data.list.LinkedList.prototype.insertFirst = function( o ) /*void*/
	{
		this._insertBefore( o, this._header.next ) ;	
	}

    /**
     * Appends the given element to the end of this list.  
     * @param o the element to be inserted at the end of this list.
     */
	vegas.data.list.LinkedList.prototype.insertLast = function( o ) /*void*/
	{
		this._insertBefore(o , this._header) ;	
	}
	
	/**
	 * Returns {@code true} if this queue contains no elements.
	 * @return {@code true} if this queue is empty else {@code false}.
	 */
	vegas.data.list.LinkedList.prototype.isEmpty = function() /*Boolean*/ 
	{
		return this._size == 0 ;	
	}

	/**
	 * Returns the iterator of this object.
	 */
	vegas.data.list.LinkedList.prototype.iterator = function() /*Iterator*/ 
	{
		return this.listIterator() ;
	}

   /**
     * Returns the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     * @param o element to search for.
     * @return the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     */
    vegas.data.list.LinkedList.prototype.lastIndexOf = function( o ) /*Number*/ 
    {
        var index /*Number*/ = this._size ;
        if ( o == null ) 
        {
            for (var e /*LinkedListEntry*/ = this._header.previous ; e != this._header ; e = e.previous) 
            {
                index--;
                if ( e.element == null )
                {
                    return index ;
                }
            }
        } 
        else 
        {
            for (var e /*LinkedListEntry*/ = this._header.previous ; e != this._header ; e = e.previous ) 
            {
                index-- ;
                if (o.hasOwnProperty("equals") && o["equals"] instanceof Function)
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
	vegas.data.list.LinkedList.prototype.listIterator = function() /*ListIterator*/ 
	{
		var index /*Number*/ = (arguments[0] > 0) ? arguments[0] : 0 ;
		return new vegas.data.iterator.LinkedListIterator( index , this ) ;
	}

    /**
     * Retrieves, but does not remove, the head (first element) of this list.
     * @return the head of this queue, or {@code null} if this queue is empty.
     */
    vegas.data.list.LinkedList.prototype.peek = function() 
    {
        if ( this._size == 0 )
        {
            return null;
        }
        return this.getFirst() ;
    }

    /**
     * Retrieves and removes the head (first element) of this list.
     * @return the head of this queue, or {@code null} if this queue is empty.
     */
    vegas.data.list.LinkedList.prototype.poll = function() 
    {
        if ( this._size == 0 )
        {
            return null;
        }
        return this.removeFirst() ;
    }

    /**
     * Removes the first occurrence of the specified element in this list.  
     * If the list does not contain the element, it is unchanged.
     * @param o element to be removed from this list, if present.
     * @return <tt>true</tt> if the list contained the specified element.
     */
    vegas.data.list.LinkedList.prototype.remove = function( o ) /*Boolean*/ 
    {
    	
        if ( o == null ) 
        {
            for ( var e /*LinkedListEntry*/ = this._header.next ; e != this._header ; e = e.next ) 
            {
                if ( e.element == null ) 
                {
                    this._removeEntry(e) ;
                    return true;
                }
            }
        } 
        else 
        {
        	
            for ( var e /*LinkedListEntry*/ = this._header.next ; e != this._header ; e = e.next ) 
            {
            	if ( o instanceof IEquality )
            	{
            		if (o.hasOwnProperty("equals") && o["equals"] instanceof Function)
                	{
	                    this._removeEntry(e);
                    	return true;
                	}
            	}
            	else 
				{ 	
                	if ( o == e.element ) 
                	{
	                    this._removeEntry(e);
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
	vegas.data.list.LinkedList.prototype.removeAll = function( c /*Collection*/ ) /*Boolean*/ 
	{
		if (c instanceof vegas.data.Collection)
		{
			
			var result /*Boolean*/ = true ;
			var i /*Iterator*/ = c.iterator() ;
			while( i.hasNext() )
			{
				var b /*Boolean*/ = this.remove( i.next()) ;
				if ( !b )
				{
					result = false ;
				}
			}
			return result ;
		}
		else
		{
			return false ;
		}
	}

    /**
     * Removes an element at the specified position in this list. 
     * This implementation first gets a list iterator pointing to the indexed element (with {@code listIterator(index)}). 
     * Then, it removes the element with <b>ListIterator</b> remove method.
     * @param  id index of the element to be removed from the List.
     */
	vegas.data.list.LinkedList.prototype.removeAt = function( id /*Number*/ ) 
	{
		return this._removeEntry( this._entry(id) ) ;
	}
	
    /**
     * Removes the specified count of elements at the specified position in this list.
     * @param  id index of the first element to be removed from the List.
     * @return len the number of elements that was removed from the list.
     */
	vegas.data.list.LinkedList.prototype.removesAt = function ( id /*Number*/, len /*Number*/ ) 
	{
		this.removeRange(id , id + len) ;
	}

    /**
     * Removes and returns the first element from this list.
     * @return the first element from this list.
     * @throws NoSuchElementException if this list is empty.
     */
	vegas.data.list.LinkedList.prototype.removeFirst = function()
	{
		return this._removeEntry( this._header.next );
	}
	
    /**
     * Removes and returns the last element from this list.
     * @return the last element from this list.
     * @throws NoSuchElementException if this list is empty.
     */
	vegas.data.list.LinkedList.prototype.removeLast = function()
	{
		return this._removeEntry( this._header.previous );
	}

	/**
	 * Removes from this list all the elements that are contained between the specific {@code from} and the specific {@code to} position in this list (optional operation).
	 */
	vegas.data.list.LinkedList.prototype.removeRange = function( from /*Number*/, to /*Number*/ ) /*void*/ 
	{
		if (isNaN(from)) 
		{
			return ;
		}
		
		var it /*ListIterator*/ = this.listIterator(from) ;
		var l /*Number*/ = to - from ;
		for (var i /*Number*/ = 0 ; i<l ; i++) 
		{
			it.next() ; 
			it.remove() ;
		}
	}
	
	/**
	 * Retains only the elements in this list that are contained in the specified collection (optional operation).
	 */
	vegas.data.list.LinkedList.prototype.retainAll = function ( c /*Collection*/ ) /*Boolean*/ 
	{
		var b /*Boolean*/ = true ;
		var it /*Iterator*/ = this.iterator() ;
		while(it.hasNext())
		{
			var next = it.next() ;
			if ( !c.contains( next ) )
			{
				it.remove() ;
			} 
		}
		return c.size() == this.size() ;
	}

    /**
     * Replaces the element at the specified position in this list with the specified element.
     * @param id index of element to replace.
     * @param o element to be stored at the specified position.
     * @return the element previously at the specified position.
     */
	vegas.data.list.LinkedList.prototype.setAt = function( id /*Number*/, o )
	{
		var i /*ListIterator*/ = this.listIterator( id ) ;
		try 
		{
	    	var old = i.next() ;
	    	i.set(o) ;
	    	return old ;
		}
		catch( e /*NoSuchElementError*/ ) 
		{
	    	throw new vegas.errors.IndexOutOfBoundsError("LinkedList setAt method failed, index:" + id ) ;
		}
	}

	/**
	 * Returns the number of elements in this list.
	 * @return the number of elements in this list.
	 */
	vegas.data.list.LinkedList.prototype.size = function() /*Number*/
	{
		return this._size ;	
	}

	/**
	 * Returns a subList of the LinkedList. The subList is an ArrayList instance.
	 */
	vegas.data.list.LinkedList.prototype.subList = function( fromIndex /*Number*/, toIndex /*Number*/ ) /*List*/ 
	{
		var l /*List*/ = new vegas.data.list.ArrayList() ;
		var it /*ListIterator*/ = this.listIterator(fromIndex) ;
		var d /*Number*/ = (toIndex - fromIndex) + 1 ; 
		for (var i /*Number*/ = fromIndex ; i<= d ; i++) 
		{
			l.insert(it.next()) ;
		}
		return l ;
	}

    /**
     * Returns an array containing all of the elements in this list in the correct order.
     * @return an array containing all of the elements in this list in the correct order.
     */
    vegas.data.list.LinkedList.prototype.toArray = function() /*Array*/ 
    {
		var ar /*Array*/ = new Array( this._size ) ;
        var i /*Number*/ = 0 ;
		for ( var e /*LinkedListEntry*/ = this._header.next ; e != this._header ; e = e.next )
		{
			ar[i++] = e.element ;
		}
		return ar ;
    }

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	vegas.data.list.LinkedList.prototype.toSource = function() /*String*/ 
	{
		var internalSource /*String*/ = new vegas.data.collections.SimpleCollection(this.toArray()).toSource() ;
		return "new vegas.data.list.LinkedList(" + internalSource + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	vegas.data.list.LinkedList.prototype.toString = function() /*String*/ 
	{
		return (new vegas.data.collections.CollectionFormat()).formatToString(this) ;	
	}

	/**
	 * Return the indexed entry.
	 * @private
	 */
	vegas.data.list.LinkedList.prototype._entry = function ( index /*Number*/ ) /*LinkedListEntry*/
	{
		if (index < 0 || index >= this._size)
		{
			throw new vegas.errors.IndexOutOfBoundsError("LinkedList private '_entry' method failed, index:" + index + ", size:" + this._size + "." ) ;
		}
		var e /*LinkedListEntry*/ = this._header ;
		if ( index < (this._size >> 1))
		{
			
			for (var i /*Number*/ = 0 ; i<= index ; i++)
			{
				e = e.next ;
			}
		}
		else
		{
			for (var i /*Number*/ = this._size ; i > index ; i--)
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
	 * @private
	 */
	vegas.data.list.LinkedList.prototype._insertBefore = function( o , e /*LinkedListEntry*/ ) /*LinkedListEntry*/
	{
		var newEntry /*LinkedListEntry*/ = new vegas.data.list.LinkedListEntry( o, e, e.previous ) ;
		newEntry.previous.next = newEntry ;
		newEntry.next.previous = newEntry ;
		this._size ++ ;
		this._modCount ++ ;
		return newEntry ;
	}

   	/**
     * Removes an Entry in the list.
     * @private
     */
    vegas.data.list.LinkedList.prototype._removeEntry = function( e /*LinkedListEntry*/ )
    {
    	if (e == this._header)
    	{
    		throw new vegas.errors.NoSuchElementError(this + " removeEntry method failed.");
    	}
    	var result = e.element ;
    	e.previous.next = e.next;
		e.next.previous = e.previous;
        e.next = e.previous = null ;
        e.element = null ;
		this._size-- ;
		this._modCount++ ;
        return result ;
    }

	/**
	 * The internal header of this list.
	 * @private
	 */
	vegas.data.list.LinkedList.prototype._header /*LinkedListEntry*/ = null  ;
	
	/**
	 * The mod count value.
	 * @private
	 */
	vegas.data.list.LinkedList.prototype._modCount /*Number*/ = 0 ;
	
	/**
	 * The internal size of the list.
	 * @private
	 */
	vegas.data.list.LinkedList.prototype._size /*Number*/ = 0 ;

}