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
 * Converts a {@code Map} to an iterator.
 * @author eKameleon
 */
if (vegas.data.map.MapIterator == undefined) 
{

	/**
	 * Creates a new MapIterator instance.
	 * @param m the Map reference of this iterator. 
	 */
	vegas.data.map.MapIterator = function ( map /*Map*/ ) 
	{ 
		this._m = map ;
		this._i = new vegas.data.iterator.ArrayIterator( map.getKeys() ) ;
		this._k = null ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.map.MapIterator.extend(vegas.core.CoreObject) ;
	
	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iteration has more elements.
	 */	
	proto.hasNext = function () 
	{
		return this._i.hasNext() ;
	}

	/**
	 * Returns the current key of the internal pointer of the iterator (optional operation).
	 * @return the current key of the internal pointer of the iterator (optional operation).
	 */
	proto.key = function() 
	{
		return this._k ;
	}

	/**
	 * Returns the next element in the iteration.
	 * @return the next element in the iteration.
	 */
	proto.next = function () 
	{
		this._k = this._i.next() ;
		return this._m.get(this._k) ;
	}

	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 */
	proto.remove = function() 
	{
		this._i.remove() ;
		return this._m.remove(this._k) ;
	}

	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	proto.reset = function() 
	{
		this._i.reset() ;
	}

	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */	
	proto.seek = function (n) 
	{
		throw new vegas.errors.UnsupportedOperationError("The 'seek' method is unsupported in MapIterator object.") ;
	}
	
	delete proto ;
	
}