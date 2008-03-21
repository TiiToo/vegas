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
 * Converts a string to an iterator.
 * <p><b>Example :</b></p>
 * {@code
 * import  vegas.data.iterator.Iterator ;
 * import  vegas.data.iterator.StringIterator ;
 * 
 * var s = "coucou?" ;
 * 
 * var it:Iterator = new StringIterator(s) ;
 * it.seek(1) ;
 * while(it.hasNext())
 * {
 *     var char = it.next() ;
 *     trace (it.key() + ' : ' + char) ;
 * }
 * trace (s) ;
 * }
 * @author eKameleon
 */
if (vegas.data.iterator.StringIterator == undefined) 
{
	
	/**
	 * Creates a new StringIterator instance.
	 * @param str the String object to enumerate.
	 */
	vegas.data.iterator.StringIterator = function ( str /*String*/ ) 
	{ 
		this._s = new String(str) ;
		this._k = -1 ;
		this._size = str.length ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.data.iterator.StringIterator.extend(vegas.core.CoreObject) ;

	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iteration has more elements.
	 */	
	vegas.data.iterator.StringIterator.prototype.hasNext = function () 
	{
		return this._k < (this._size-1)  ;
	}

	/**
	 * Returns the current key of the internal pointer of the iterator (optional operation).
	 * @return the current key of the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.StringIterator.prototype.key = function() 
	{
		return this._k ;
	}
	
	/**
	 * Returns the next element in the iteration.
	 * @return the next element in the iteration.
	 */
	vegas.data.iterator.StringIterator.prototype.next = function () 
	{
		return this._s.charAt( ++this._k );
	}

	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 */
	vegas.data.iterator.StringIterator.prototype.remove = function() 
	{
		throw new vegas.errors.UnsupportedOperationError(this + " remove method usupported.") ;
	}
	
	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.StringIterator.prototype.reset = function() 
	{
		this._k = -1 ;
	}
	
	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	vegas.data.iterator.StringIterator.prototype.seek = function (n) 
	{
		this._k = vegas.util.MathsUtil.clamp( n - 1 , -1, this._size - 1 ) ;
	}
	
}