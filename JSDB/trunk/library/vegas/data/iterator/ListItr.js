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
 * Converts a simple List to a specific ListIterator (Used in AbstractList, ArrayList, SortedArrayList).
 * @author eKameleon
 * @see AbstractList
 * @see ArrayList
 * @see SortedArrayList
 */
if (vegas.data.iterator.ListItr == undefined) 
{

	/**
	 * Creates a new ListItr instance.
	 */
	vegas.data.iterator.ListItr = function ( li /*List*/ ) 
	{ 
				
		try 
		{
			
			if (li instanceof vegas.data.List) 
			{
			
				this._list = li ;
				this._key = 0 ;
				this._listast = -1 ;
				this._expectedModCount = li.getModCount() ;
				
			}
			else 
			{
				throw new vegas.errors.IllegalArgumentError("ListItr constructor, argument is not a List") ;
			}
		
		}
		catch (e) 
		{
			
			trace(e.toString()) ;
			
		}	 
		
	}

	/**
	 * @extends vegas.data.iterator.ListIterator
	 */
	proto = vegas.data.iterator.ListItr.extend(vegas.data.iterator.ListIterator) ;
	
	proto.checkForComodification = function() /*void*/ 
	{
	    if (this._list.getModCount() != this._expectedModCount) {
			throw new vegas.errors.ConcurrentModificationError("check for comodification!!! you can modificate.") ;
		}
	}

	proto.hasNext = function() /*Boolean*/ 
	{
		return this._key < this._list.size() ;
	}	

	proto.hasPrevious = function() /*Boolean*/ 
	{
		return this._key != 0 ;
	}	

	proto.insert = function(o) 
	{
		this.checkForComodification() ;
		try 
		{
			this._list.insertAt(this._key++ , o) ;
			this._listast = -1 ;
			this._expectedModCount = this._list.getModCount() ;
		} 
		catch (e /*Error*/ ) 
		{
			throw new vegas.errors.ConcurrentModificationError("ListItr insert.") ;
		}
	}
	
	proto.key = function () 
	{
		return this._key ;
	}

	proto.next = function() 
	{
		if (this.hasNext()) 
		{
			var next = this._list.get(this._key) ;
			this._listast = this._key ;
			this._key++ ;
			return next ;
		}
		else 
		{
			throw new vegas.errors.NoSuchElementError("ListItr next.") ;
		}
	}

	proto.nextIndex = function() /*Number*/ 
	{
		return this._key ;
	}

	proto.previous = function() 
	{
		this.checkForComodification() ;
		try {
		
			var i /*Number*/ = this._key - 1 ;
			var prev = this._list.get(i) ;
			this._listast = this._key  = i ;
			return prev ;
		
		} catch( e /*Error*/ ) {
			this.checkForComodification();
			throw new vegas.errors.NoSuchElementError("ListItr previous.") ;
		}
	}
	
	proto.previousIndex = function() /*Number*/ 
	{
		return this._key - 1 ;
	}
	
	proto.remove = function () 
	{
		if (this._listast == -1) throw new Error("IllegalStateError") ;
		this.checkForComodification() ;
		try {
			this._list.removeAt(this._listast) ;
			if (this._listast < this._key) this._key -- ;
			this._listast = -1 ;
			this._expectedModCount = this._list.getModCount() ;
		} catch (e /*Error*/ ) {
			throw new vegas.errors.ConcurrentModificationError("ListItr remove.") ;
		}
	}
	
	proto.reset = function () 
	{
		this._key = 0 ;
	}
	
	proto.seek = function (n/*Number*/) 
	{
		this._key = MathsUtil.clamp(n, 0, this._list.size()) ;
		this._listast = this._key - 1 ;
	}
	
	proto.set = function(o) 
	{
		if (this._listast == -1) 
		{
			throw new Error("IllegalStateError") ;
		}
		this.checkForComodification() ;
		try 
		{
			this._list.setAt(this._listast, o) ;
			this._expectedModCount = this._list.getModCount() ;
		}
		catch (e /*Error*/ ) 
		{
			throw new vegas.errors.ConcurrentModificationError("ListItr set.") ;
		}
	}
	
	delete proto ;
	
}