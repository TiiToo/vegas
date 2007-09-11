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
 * Converts an {@code Array} to an iterator.
 * <p><b>Example :</b></p>
 * {@code
 * import vegas.data.iterator.ArrayIterator ;
 * import vegas.data.iterator.Iterator ;
 * 
 * var ar:Array = ["item1", "item2", "item3", "item4"] ;
 * var it:Iterator = new ArrayIterator(ar) ;
 * 
 * while (it.hasNext())
 * {
 *     trace (it.next()) ;
 * }
 * 
 * trace ("--- it reset") ;
 * 
 * it.reset() ;
 * while (it.hasNext()) 
 * {
 *     trace (it.next() + " : " + it.key()) ;
 * }
 * 
 * trace ("--- it seek 2") ;
 * 
 * it.seek(2) ;
 * while (it.hasNext())
 * {
 *     trace (it.next()) ;
 * }
 * 
 * trace ("---") ;
 * 
 * }
 * @author eKameleon
 */
if (vegas.data.iterator.ArrayIterator == undefined) 
{
	
	/**
	 * Creates a new ArrayIterator instance.
	 * @param a the array to enumerate with the iterator.
	 */
	vegas.data.iterator.ArrayIterator = function ( ar /*Array*/ ) 
	{ 
		this._a = ar ;
		this._k = -1 ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.data.iterator.ArrayIterator.extend(vegas.core.CoreObject) ;

	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iteration has more elements.
	 */	
	vegas.data.iterator.ArrayIterator.prototype.hasNext = function () 
	{
		return (this._k < this._a.length -1) ;
	}

	/**
	 * Returns the current key of the internal pointer of the iterator (optional operation).
	 * @return the current key of the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.ArrayIterator.prototype.key = function() 
	{
		return this._k ;
	}
	
	/**
	 * Returns the next element in the iteration.
	 * @return the next element in the iteration.
	 */
	vegas.data.iterator.ArrayIterator.prototype.next = function () 
	{
		return this._a[++this._k] ;
	}

	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 */
	vegas.data.iterator.ArrayIterator.prototype.remove = function() 
	{
		this._a.splice(this._k--, 1) ;
	}

	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.ArrayIterator.prototype.reset = function() 
	{
		this._k = -1 ;
	}
	
	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.ArrayIterator.prototype.seek = function (n) 
	{
		var l = this._a.length ;
		if ( n <-1 ) 
		{
			n = -1 ;
		}
		else if ( n > l ) 
		{
			n = l ;
		}
		this._k = n ;
	}
	
}