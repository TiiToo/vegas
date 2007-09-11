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
 * This class provides a skeletal implementation of the List interface to minimize the effort required to implement this interface.
 * @author eKameleon
 */
if (vegas.data.list.AbstractList == undefined) 
{

	/**
	 * Creates a new AbstractList instance.
	 */
	vegas.data.list.AbstractList = function ( ar /*Array*/ ) 
	{ 
		vegas.data.List.call(this, ar) ;
		this._modCount /*Number*/ = 0 ;
	}

	/**
	 * @extends vegas.data.List
	 */
	proto = vegas.data.list.AbstractList.extend(vegas.data.List) ;

	/**
	 * Returns {@code true} if this collection contains the specified element.
	 * @return {@code true} if this collection contains the specified element.
	 */
	proto.containsAll = function ( c /*Collection*/ ) /*Boolean*/ 
	{
		try 
		{
			if (c instanceof vegas.data.Collection) 
			{
				var it /*Iterator*/ = c.iterator() ;
				while(it.hasNext()) 
				{
					if ( ! this.contains(it.next()) ) return false ;
				}
				return true ;
			}
			else 
			{
				throw new Error( this.getConstructorName() + ".constainsAll('" + c + "') Illegal Argument, is not a Collection") ;
			}
		}
		catch (e) 
		{
			//
		}
		return fae ; 
	}

	/**
	 * Indicates whether some other object is "equal to" this one.
	 */
	proto.equals = function (o) /*Boolean*/ 
	{
		return false ;
	}

	/**
	 * This method is used by the {@code ListItr} class only.
	 */
	proto.getModCount = function() /*Number*/ 
	{
		return this._modCount ;
	}

    /**
     * Inserts the specified element at the specified position in this list (optional operation).
     * @param id index at which the specified element is to be inserted.
     * @param o element to be inserted.
     */
	proto.insertAt = function(id/*Number*/, o)/*Void*/ 
	{
		if (id<0 || id>size()) 
		{
			throw new Error(this.getConstructorName() + ".insertAt('" + id + "') : IndexOutOfBoundsError") ;
		}
		this._a.splice(id, 0, o) ;
	}
	
    /**
     * Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator.
     * The behavior of this operation is undefined if the specified collection is modified while the operation is in progress.  
     * @param c the elements to be inserted into this list.
     * @return {@code true} if this list changed as a result of the call.
     */
	proto.insertAll = function(c/*Collection*/) /*Boolean*/ 
	{
		try 
		{
			if (c instanceof vegas.data.Collection) 
			{
				if (c.size() > 0) 
				{
					var it /*Iterator*/ = c.iterator() ;
					while(it.hasNext()) 
					{
						this.insert(it.next()) ;
					}
					return true ;
				}
			}
			else 
			{
				throw new vegas.errors.IllegalArgumentError( this.getConstructorName() + ".insertAll('" + c + "'), argument is not a Collection") ;
			}
		} 
		catch (e) 
		{
			trace(e.toString()) ;
		}	
		return false ;
	}


	/**
	 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
	 */
	proto.insertAllAt = function(id /*Number*/, c/*Collection*/) /*Boolean*/ 
	{
		try 
		{
			if( c instanceof vegas.data.Collection ) 
			{
				if (id <0 || id > this.size()) return false ;
				var aC/*Array*/ = c.toArray() ;
				var aB = this._a.slice(0, id) ;
				var aE = this._a.slice(id) ;
				this._a = aB.concat(aC, aE) ;
				return true ;
			}
			else 
			{
				throw new Error( this.getConstructorName() + ".insertAllAt('" + c + "') Illegal Argument, is not a Collection") ;
			}
		} 
		catch(e) 
		{
			trace(e.toString()) ;
		}	
		return false ;
	}


    /**
     * Returns the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     * @param o element to search for.
     * @return the index in this list of the last occurrence of the specified element, or -1 if the list does not contain this element.
     */
	proto.lastIndexOf = function(o) /*Number*/ 
	{
		var l/*Number*/ = this._a.length ;
		while (--l > -1) 
		{
			if (this._a[l] == o) return l ;
		}
		return -1 ;
	}

	/**
	 * Returns a list iterator of the elements in this list (in proper sequence).
	 * @return a list iterator of the elements in this list (in proper sequence).
	 */
	proto.listIterator = function() /*ListIterator*/ 
	{ 
		var li /*ListIterator*/ = new vegas.data.iterator.ListItr(this) ;
		var n /*Number*/ = arguments[0] ;
		if (typeof (n) == "number" || n instanceof Number) 
		{
			li.seek(n) ;
		}
		return li ;
	}

	/**
	 * Removes all elements defined in the specified Collection in the list.
	 * @return {@code true} if all elements are find and remove in the list.
	 */
	proto.removeAll = function(c/*Collection*/)/*Boolean*/ 
	{
		var b/*Boolean*/ = false ;
		var it/*Iterator*/ = this.iterator() ;
		while (it.hasNext()) 
		{
			if ( c.contains(it.next()) ) 
			{
				it.remove() ;
				b = true ;
			}
		}
		return b ;
	}

    /**
     * Removes an element at the specified position in this list.
     * @param  id index of the element to be removed from the List.
     */
	proto.removeAt = function(id/*Number*/) 
	{
		return this.removesAt(id, 1) ;
	}

	/**
	 * Removes from this list all the elements that are contained between the specific {@code from} and the specific {@code to} position in this list (optional operation).
	 */
	proto.removeRange = function(from /*Number*/ , to/*Number*/) /*Void*/ 
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
     * Removes the specified count of elements at the specified position in this list.
     * @param  id index of the first element to be removed from the List.
     * @return len the number of elements that was removed from the list.
     */
	proto.removesAt = function(id/*Number*/, len/*Number*/) 
	{
		var d /*Number*/ = len - id ;
		var old = this._a.slice(id, d) ;
		this._a.splice(id, len);
		return old ; 
	}

	/**
	 * Retains only the elements in this list that are contained in the specified collection (optional operation).
	 */
	proto.retainAll = function(c/*Collection*/) /*Boolean*/ 
	{
		
		var b /*Boolean*/ = false ;
		
		try 
		{
			
			if( c instanceof vegas.data.Collection ) 
			{
				
				var it /*Iterator*/ = this.iterator() ;
				while(it.hasNext()) 
				{
					if ( ! c.contains(it.next()) ) 
					{
						it.remove() ;
						b = true ;
					}
				}
				
			} 
			else 
			{
				throw new Error( this.getConstructorName() + ".retainAll('" + c + "') Illegal Argument, is not a Collection") ;
			}
		} 
		catch(e) 
		{
			trace(e.toString()) ;
		}	
			
		return b ;
	}

    /**
     * Replaces the element at the specified position in this list with the specified element.
     * @param id index of element to replace.
     * @param o element to be stored at the specified position.
     * @return the element previously at the specified position.
     */
	proto.setAt = function(id/*Number*/, o) /*Boolean*/ 
	{
		if (this._a[id] == undefined) 
		{
			return false ;
		}
		else 
		{
			this._a[id] = o ;
			return true ;
		}
	}

	/**
	 * Sets the modCount property of this list.
	 */
	proto.setModCount = function(n/*Number*/) /*Void*/ 
	{
		this._modCount = n ;
	}

	/**
	 * Returns a subList of the LinkedList. The subList is an ArrayList instance.
	 * @return a subList of the LinkedList. The subList is an ArrayList instance.
	 */
	proto.subList = function(begin /*Number*/ , end/*Number*/)/*List*/ 
	{
		var list /*List*/ = new vegas.data.list.ArrayList() ;
		var it/*ListIterator*/ = this.listIterator() ;
		var d /*Number*/ = (end - begin) + 1 ; 
		for (var i/*Number*/ = begin ; i<= d ; i++) 
		{
			list.insert(it.next()) ;
		}
		return list ;
	}
	
	delete proto ;
	
}