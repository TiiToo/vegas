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

import vegas.core.CoreObject;
import vegas.data.iterator.ListIterator;
import vegas.data.list.LinkedList;
import vegas.data.list.LinkedListEntry;
import vegas.errors.ConcurrentModificationError;
import vegas.errors.IllegalArgumentError;
import vegas.errors.IllegalStateError;
import vegas.errors.IndexOutOfBoundsError;
import vegas.errors.NoSuchElementError;
import vegas.errors.UnsupportedOperation;

/**
 * Converts a {@code LinkedList} to a specific {@code ListIterator}.
 * @author eKameleon
 */
class vegas.data.iterator.LinkedListIterator extends CoreObject implements ListIterator
{

	/**
	 * Creates a new ListItr instance.
	 */
	function LinkedListIterator( index:Number , list:LinkedList )
	{
		
		if (list == null)
		{
			throw new IllegalArgumentError(this + " constructor failed, the list passed in argument not must be 'null' or 'undefined'.") ;	
		}
		
		_list = list ;
		
		_lastReturned = _list.getHeader() ;
		_expectedModCount = _list.getModCount() ;
		
		var size:Number = _list.size() ;
		
		if (index < 0 || index > size)
	    {
	    	throw new IndexOutOfBoundsError(this + " constructor failed, index:" + index + ", size:" + size + "." ) ;
	    }
		
		if ( index < ( size >> 1 ) ) 
	    {
			
			_next = _list.getHeader().next ;
			
			for ( _nextIndex = 0 ; _nextIndex < index ; _nextIndex ++ )
			{
			    _next = _next.next ;
			}
	    } 
	    else 
	    {
			_next = _list.getHeader()  ;
			for ( _nextIndex = size ; _nextIndex > index ; _nextIndex-- )
			{
				_next = _next.previous ;
			}
		}
		
	}

	/**
	 * This method check the comodification of the LinkedList and test if the iterator is valid and can continue to process.
	 */
	public function checkForComodification() 
	{
	    if ( _list.getModCount() != _expectedModCount )
	    {
			trace( new ConcurrentModificationError(this + " check for comodification failed." ) ) ;
		}
    }


	/**
	 * Returns {@code true} if the iteration has more elements.
	 */	
	public function hasNext():Boolean 
	{
		return _nextIndex != _list.size() ;
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
	public function hasPrevious():Boolean 
	{
		 return _nextIndex != 0 ;
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
	public function insert( o ):Void 
	{
		
		// FIXME bug ??
		
	    checkForComodification();
	    _lastReturned = _list.getHeader() ;
	    _list._insertBefore(o, _next) ;
	    _nextIndex ++ ;
	    _expectedModCount ++ ;
	}

	/**
	 * Unsupported operation in this iterator, uses nextIndex() and previousIndex() method.
	 */
	public function key() 
	{
		throw new UnsupportedOperation(this + " 'key' method is unsupported.") ;
		return null ;
	}

	/**
	 * Returns the next element in the iteration.
	 */
	public function next() 
	{
		checkForComodification();
		
	    if ( _nextIndex == _list.size() )
	    {
			throw new NoSuchElementError(this + " 'next' method failed.");
	    }

	    _lastReturned = _next ;
	    _next = _next.next ;
	    _nextIndex ++ ;
	    
	    return _lastReturned.element ;
	}

	/**
	 * Returns the index of the element that would be returned by a subsequent call to next.
	 */
	public function nextIndex() : Number 
	{
		return _nextIndex ; 
	}

	/**
	 * Returns the previous element in the collection.
	 */
	public function previous() 
	{
	    if (nextIndex == 0)
	    {
			throw new NoSuchElementError(this + " 'previous' method failed.");
	    }

	    _lastReturned = _next = _next.previous ;
	    _nextIndex-- ;
	    checkForComodification();
	    return _lastReturned.element ;
	}

	/**
	 * Returns the index of the element that would be returned by a subsequent call to previous.
	 */
	public function previousIndex() : Number 
	{
		return _nextIndex - 1 ;
	}

	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 */
	public function remove() 
	{
		checkForComodification() ;
        var lastNext:LinkedListEntry = _lastReturned.next;
		try 
		{
            _list._removeEntry( _lastReturned ) ;
        }
        catch ( e:NoSuchElementError ) 
        {
			throw new IllegalStateError( this + " 'remove' method failed.") ;
		}
	    if ( _next == _lastReturned)
	    {
			_next = lastNext ;
	    }
		else
		{
			_nextIndex--;
		}
	    _lastReturned = _list.getHeader() ;
	    _expectedModCount++;
	}

	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	public function reset() : Void 
	{
		// TODO Finish the reset method of the LinkedListIterator. 
	}

	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	public function seek(n : Number) : Void 
	{
		// TODO Finish the seek method of the LinkedListIterator.
	}

	/**
	 * Replaces the last element returned by next or previous with the specified element (optional operation).
	 */
	public function set( o ):Void 
	{
		
		if (_lastReturned == _list.getHeader())
		{
			throw new IllegalStateError(this + " 'set' method failed.");
		}
	    
	    checkForComodification();
	    _lastReturned.element = o ;
	    
	}

	private var _lastReturned:LinkedListEntry;
	private var _list:LinkedList ;
	private var _next:LinkedListEntry ;
	private var _nextIndex:Number ;
	private var _expectedModCount:Number ;

}