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
 * Converts a {@code LinkedList} to a specific {@code ListIterator}.
 * <p><b>Example :</b></p>
 * {@code
 * LinkedList =  ;
 * var list = new vegas.data.list.LinkedList() ;
 * list.insert("item1") ;
 * list.insert("item2") ;
 * list.insert("item3") ;
 * var it = list.listIterator(2) ;
 * trace(it.hasPrevious() + " : " + it.previous()) ; // true : item2
 * }
 * @author eKameleon
 */
if (vegas.data.iterator.LinkedListIterator == undefined) 
{

	/**
	 * Creates a new LinkedListIterator instance.
	 */
	vegas.data.iterator.LinkedListIterator = function ( index /*Number*/ , list /*LinkedList*/ ) 
	{ 
		if (list == null)
		{
			throw new vegas.errors.IllegalArgumentError( this + " constructor failed, the list passed in argument not must be 'null' or 'undefined'." ) ;	
		}
		
		this._list = list ;
		
		this._lastReturned = this._list.getHeader() ;
		this._expectedModCount = this._list.getModCount() ;
		
		var size /*Number*/ = this._list.size() ;
		
		if (index < 0 || index > size)
	    {
	    	throw new vegas.errors.IndexOutOfBoundsError(this + " constructor failed, index:" + index + ", size:" + size + "." ) ;
	    }
		
		if ( index < ( size >> 1 ) ) 
	    {
			
			this._next = this._list.getHeader().next ;
			
			for ( this._nextIndex = 0 ; this._nextIndex < index ;this._nextIndex ++ )
			{
			    this._next = this._next.next ;
			}
	    } 
	    else 
	    {
			this._next = this._list.getHeader()  ;
			for ( this._nextIndex = size ; this._nextIndex > index ; this._nextIndex-- )
			{
				this._next = this._next.previous ;
			}
		}
	}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.iterator.LinkedListIterator.extend(vegas.core.CoreObject) ;

	/**
	 * This method check the comodification of the LinkedList and test if the iterator is valid and can continue to process.
	 */
	proto.checkForComodification = function() 
	{
	    if ( this._list.getModCount() != this._expectedModCount )
	    {
			throw new vegas.errors.ConcurrentModificationError(this + " check for comodification failed." ) ;
		}
    }
    
	/**
	 * Returns {@code true} if the iteration has more elements.
	 */	
	proto.hasNext = function() /*Boolean*/ 
	{
		return this._nextIndex != this._list.size() ;
	}

	/**
	 * Checks to see if there is a previous element that can be iterated to.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var list:LinkedList = new LinkedList() ;
	 * list.insert("item1") ;
	 * list.insert("item2") ;
	 * list.insert("item3") ;
	 * var it:ListIterator = list.listIterator(2) ;
	 * trace( it.hasPrevious() ) ;
	 * }
	 */
	proto.hasPrevious = function() /*Boolean*/ 
	{
		 return this._nextIndex != 0 ;
	}

	/**
	 * Inserts the specified element into the list (optional operation).
	 * <p><b>Example :</b></p>
	 * {@code
	 * var list:LinkedList = new LinkedList() ;
	 * list.insert("item1") ;
	 * list.insert("item2") ;
	 * list.insert("item3") ;
	 * 
	 * var it:ListIterator = list.listIterator(1) ;
	 * it.insert("item0") ;
	 * 
	 * trace(list) ;
	 * }
	 * <p><b>Attention :</b> Dont' use this method in a loop with hasPrevious() and previous() method.</p> 
	 */
	proto.insert = function( o ) /*void*/
	{
	    this.checkForComodification();
	    this._lastReturned = this._list.getHeader() ;
	    this._list._insertBefore(o, this._next) ;
	    this._nextIndex ++ ;
	    this._expectedModCount ++ ;
	}

	/**
	 * Unsupported operation in this iterator, uses nextIndex() and previousIndex() method.
	 */
	proto.key = function() 
	{
		throw new vegas.errors.UnsupportedOperation(this + " 'key' method is unsupported.") ;
		return null ;
	}

	/**
	 * Returns the next element in the iteration.
	 */
	proto.next = function() 
	{
		this.checkForComodification();
		
	    if ( this._nextIndex == this._list.size() )
	    {
			throw new vegas.errors.NoSuchElementError(this + " 'next' method failed.");
	    }

	    this._lastReturned = this._next ;
	    this._next = this._next.next ;
	    this._nextIndex ++ ;
	    
	    return this._lastReturned.element ;
	}

	/**
	 * Returns the index of the element that would be returned by a subsequent call to next.
	 */
	proto.nextIndex = function() /*Number*/ 
	{
		return this._nextIndex ; 
	}

	/**
	 * Returns the previous element in the collection.
	 */
	proto.previous = function() 
	{
	    if (this._nextIndex == 0)
	    {
			throw new vegas.errors.NoSuchElementError(this + " 'previous' method failed.");
	    }

	    this._lastReturned = this._next = this._next.previous ;
	    this._nextIndex-- ;
	    this.checkForComodification();
	    return this._lastReturned.element ;
	}

	/**
	 * Returns the index of the element that would be returned by a subsequent call to previous.
	 */
	proto.previousIndex = function() /*Number*/ 
	{
		return this._nextIndex - 1 ;
	}

	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 */
	proto.remove = function() 
	{
		this.checkForComodification() ;
        var lastNext/*LinkedListEntry*/ = this._lastReturned.next;
		try 
		{
           this._list._removeEntry( this._lastReturned ) ;
        }
        catch ( e /*NoSuchElementError*/ ) 
        {
			throw new vegas.errors.IllegalStateError( this + " 'remove' method failed.") ;
		}
	    if ( this._next == this._lastReturned)
	    {
			this._next = lastNext ;
	    }
		else
		{
			this._nextIndex--;
		}
	    this._lastReturned = this._list.getHeader() ;
	    this._expectedModCount++;
	}

	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	proto.reset = function() /*void*/ 
	{
		// TODO Finish the reset method of the LinkedListIterator. 
	}

	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	proto.seek = function(n /*Number*/ ) /*Void*/ 
	{
		// TODO Finish the seek method of the LinkedListIterator.
	}

	/**
	 * Replaces the last element returned by next or previous with the specified element (optional operation).
	 */
	proto.set = function( o ) /*Void*/ 
	{
		
		if (this._lastReturned == this._list.getHeader())
		{
			throw new vegas.errors.IllegalStateError(this + " 'set' method failed.");
		}
	    
	    this.checkForComodification();
	    this._lastReturned.element = o ;
	    
	}

	/**
	 * The last list entry returned.
	 */
	proto._lastReturned /*LinkedListEntry*/ = null ;
	
	/**
	 * The list reference of this iterator.
	 */
	proto._list /*LinkedList*/ = null ;

	/**
	 * The next entry.
	 */
	proto._next /*LinkedListEntry*/ = null ;
	
	/**
	 * The previous entry.
	 */
	proto._nextIndex /*Number*/ = null ;
	
	/**
	 * The internal expected mod count value.
	 */
	proto._expectedModCount /*Number*/ = null ;
	
	delete proto ;
	
}