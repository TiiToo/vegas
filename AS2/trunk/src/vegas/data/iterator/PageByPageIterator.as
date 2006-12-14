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
import vegas.data.iterator.OrderedIterator;
import vegas.errors.UnsupportedOperation;
import vegas.util.MathsUtil;

/**
 * An iterator page by page over an array who return an new array of elements.
 * @author eKameleon
 */
class vegas.data.iterator.PageByPageIterator extends CoreObject implements OrderedIterator 
{
	
	/**
	 * Creates a new PageByPageIterator.
	 * @throws UnsupportedOperation if the data array is empty.
	 */
	public function PageByPageIterator( stepSize:Number, data:Array )
	{
		super();
		var len:Number = data.length ;
		if (len > 0)
		{
			_data = data ;
			_key = 0 ;
			_currentPage = 0 ;
			_step = (stepSize > 1) ? stepSize : DEFAULT_STEP ; 
			_pageCount =  Math.ceil(len / _step) ;
			
		}
		else
		{
			throw new UnsupportedOperation(this + " constructor failed, data length not must be empty") ;
		}
		
	}

	static public var DEFAULT_STEP:Number = 1 ;

	/**
	 * Returns the current page value.
	 * @return the number of the current page.
	 */
	public function currentPage():Number
	{
		return _currentPage ;
	}

	/**
	 * Checks to see if there is a previous element that can be iterated to.
	 * @return true if the iterator has more elements.
	 */
	public function hasPrevious() : Boolean 
	{
		return _key > 1 ;
	}

	/**
	 * Returns true if the iteration has more elements.
	 * @return true if the iterator has more elements.
	 */
	public function hasNext() : Boolean 
	{
		return _key < _pageCount ;
	}

	/**
	 * Returns the current page number.
	 */
	public function key() 
	{
		return _currentPage ;
	}

	/**
	 * Gets the next page of elements.
	 */
	public function next() 
	{
		if (hasNext())
		{
			var index:Number = _step * _key++ ;
			_currentPage = _key ;
			var next:Array = _data.slice(index, index + _step) ;
			return next ;
		}
		else
		{
			return null ;
		} 
	}

	/**
	 * Returns the numbers of page of this iterator.
	 */
	public function pageCount():Number
	{
		return _pageCount ;	
	}

	/**
	 * Gets the previous element from the collection.
	 */
	public function previous() 
	{
		if (hasPrevious())
		{
			_currentPage -- ;
			_key -- ;
			var index:Number = _step * (_key-1) ;
			var prev:Array = _data.slice(index, index + _step) ;
			return prev ;
		}
		else
		{
			return null ;
		} 
	}

	/**
	 * Unsupported operation in a PageByPageIterator.
	 * @throws UnsupportedOperation
	 */
	public function remove() 
	{
		throw new UnsupportedOperation(this + " remove method is unsupported by this instance.") ;
	}

	/**
	 * Reset the key pointer of the iterator.
	 */
	public function reset():Void 
	{
		_key = 0 ;
		_currentPage = 0 ;
	}

	/**
	 * Seek the key pointer of the iterator.
	 */
	public function seek(n : Number):Void 
	{
		_key = MathsUtil.clamp( n, 0, (_pageCount-1) ) ;
		_currentPage = _key ;
	}

	/**
	 * The currentPage value.
	 */
	private var _currentPage:Number ;

	/**
	 * The data to iterate.
	 */
	private var _data:Array ;

	/**
	 * The current key of the iterator. 
	 */
	private var _key:Number ;
	
	/**
	 * Count of pages.
	 */
	private var _pageCount:Number ;
		
	/**
	 * The numbers of lines in a page.
	 */
	private var _step:Number ;
	
}