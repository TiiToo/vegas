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
 * An iterator page by page over an array who return an new array of elements.
 * If the step size value is {@code 1} the next and previous methods returns the single value element in the data array.
 * <p><b>Example :</b></p>
 * {@code
 * var ar = [1, 2, 3, 4, 5, 6, 7, 8] ;
 * 
 * var it = new vegas.data.iterator.PageByPageIterator(2, ar) ;
 *
 * var next = function()
 * {
 *     if (!it.hasNext())
 *     {
 *         it.reset() ;
 *     }
 *     var next = it.next()
 *     trace( "> " + next + " : " + it.currentPage() ) ;
 * }
 * 
 * var prev = function()
 * {
 *     if ( !it.hasPrevious())
 *     {
 *         it.lastPage() ;
 *     }
 *     var prev = it.previous() ;
 *     trace( "> " + prev + " : " + it.currentPage() ) ;
 * }
 * 
 * next() ;
 * next() ;
 * next() ;
 * next() ;
 * next() ;
 * prev() ;
 * 
 * }
 * @author eKameleon
 */
if (vegas.data.iterator.PageByPageIterator == undefined) 
{
	
	/**
	 * @requires vegas.util.MathsUtil
	 */
	require("vegas.util.MathsUtil") ;
	
	/**
	 * Creates a new PageByPageIterator.
	 * @param stepSize the step size value.
	 * @param data the array to enumerate.
	 * @throws UnsupportedOperation if the data array is empty.
	 */
	vegas.data.iterator.PageByPageIterator = function ( stepSize /*Number*/ , data  /*Array*/ ) 
	{ 
		var len /*Number*/ = data.length ;
		if (len > 0)
		{
			this._data = data ;
			this._key = 0 ;
			this._currentPage = 0 ;
			this._step = (stepSize > 1) ? stepSize : vegas.data.iterator.PageByPageIterator.DEFAULT_STEP ; 
			this._pageCount =  Math.ceil( len / this._step ) ;
		}
		else
		{
			throw new vegas.errors.UnsupportedOperation( this + " constructor failed, data length not must be empty." ) ;
		}
	}

	/**
	 * @extends vegas.data.iterator.OrderedIterator
	 */
	vegas.data.iterator.PageByPageIterator.extend( vegas.data.iterator.OrderedIterator  ) ;

	/**
	 * The default step value in all the PageByPageIterators.
	 */
	vegas.data.iterator.PageByPageIterator.DEFAULT_STEP /*Number*/ = 1 ;

	/**
	 * Returns the current page value.
	 * @return the number of the current page.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.currentPage = function () /*Number*/ 
	{
		return this._currentPage ;
	}

	/**
	 * Returns the step size of this PageByPageIterator.
	 * @return the step size of this PageByPageIterator.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.getStepSize = function() /*Number*/
	{
		return this._step ;
	}

	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iterator has more elements.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.hasNext = function () 
	{
		return this._key < this._pageCount ;
	}

	/**
	 * Checks to see if there is a previous element that can be iterated to.
	 * @return {@code true} if the iterator has more elements.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.hasPrevious = function () 
	{
		return this._key > 1 ;
	}

	/**
	 * Returns the current page number.
	 * @return the current page number.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.key = function() 
	{
		return this._currentPage ;
	}

	/**
	 * Seek the iterator in the last page of this object.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.lastPage = function() /*void*/
	{
		this.seek( this._pageCount + 1 ) ;
	}

	/**
	 * Returns the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
	 * @return the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.next = function () 
	{
		var index /*Number*/ = this._step * this._key++ ;
		this._currentPage = this._key ;
		if ( this._step > 1 )
		{
			return this._data.slice( index, index + this._step ) ;
		}
		else
		{
			return this._data[ index ] ;
		}
	}

	/**
	 * Returns the numbers of page of this iterator.
	 * @return the numbers of page of this iterator.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.pageCount = function() 
	{
		return this._pageCount ;
	}

	/**
	 * Returns the previous Array page of elements or the previous element in the Array if the getStepSize() value is 1.
	 * @return the previous element from the collection.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.previous = function () 
	{
		this._currentPage -- ;
		this._key -- ;
		var index /*Number*/ = this._step * ( this._key - 1 ) ;
		if (this._step > 1)
		{
			return this._data.slice(index, index + this._step) ;
		}
		else
		{
			return this._data[ index ] ;	
		}
	}

	/**
	 * Unsupported operation in a PageByPageIterator.
	 * @throws UnsupportedOperation the method remove() in this iterator is unsupported. 
	 */
	vegas.data.iterator.PageByPageIterator.prototype.remove = function() 
	{
		throw new vegas.errors.UnsupportedOperation(this + " remove method is unsupported by this instance.") ;
	}

	/**
	 * Resets the key pointer of the iterator.
	 */
	vegas.data.iterator.PageByPageIterator.prototype.reset = function() 
	{
		this._key = 0 ;
		this._currentPage = 0 ;
	}
	
	/**
	 * Seek the key pointer of the iterator.
	 */	
	vegas.data.iterator.PageByPageIterator.prototype.seek = function ( n ) 
	{
		this._key = vegas.util.MathsUtil.clamp( n++, 0, this._pageCount + 1 ) ;
		this._currentPage = this._key ;
	}

}