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
 * Converts an object to an iterator.
 * <p><b>Example :</b></p>
 * {@code
 * var o = {} ;
 * for (var i = 0 ; i<5; i++)
 * {
 *     o["prop"+i] = "item"+i ;
 * }
 * 
 * var it = new vegas.data.iterator.ObjectIterator(o) ;
 * trace ("-- object iterator") ;
 * 
 * while (it.hasNext())
 * {
 *     var next = it.next() ;
 *     var index = it.index() ;
 *     var key = it.key() ;
 *     trace ("it >> " + index + " :: " + key + " : " + next) ;
 * }
 * 
 * trace ("-- it seek 1") ;
 * 
 * it.seek(1) ;
 * 
 * while (it.hasNext())
 * {
 *     it.next() ;
 *     trace ("it remove : " + it.remove()) ;
 * }
 * 
 * trace ("-- it reset") ;
 * 
 * it.reset() ;
 * 
 * while (it.hasNext())
 * {
 *     var next = it.next() ;
 *     var index = it.index() ;
 *     var key = it.key() ;
 *     trace ("it >> " + index + " :: " + key + " : " + next) ;
 * }
 * }
 * @author eKameleon
 */
if (vegas.data.iterator.ObjectIterator == undefined) 
{

	/**
	 * Creates a new ObjectIterator instance.
	 */
	vegas.data.iterator.ObjectIterator = function ( o /*Object*/ ) 
	{ 
		this._o = o ;
		this._a = new Array ;
		this._k = -1 ;
		for (var each in o) if ( typeof(o[each]) != "function") this._a.push(each) ;
		this._len = this._a.length ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.iterator.ObjectIterator.extend(vegas.core.CoreObject) ;

	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iteration has more elements.
	 */	
	proto.hasNext = function () 
	{
		return this._k < (this._len-1)  ;
	}

	/**
	 * Returns the current index of the internal pointer of the iterator (optional operation).
	 * @return the current index of the internal pointer of the iterator (optional operation).
	 */
	proto.index = function () 
	{
		return this._k ;
	}

	/**
	 * Returns the current key value of the internal pointer of the iterator (optional operation).
	 * @return the current key value of the internal pointer of the iterator (optional operation).
	 */
	proto.key = function() 
	{
		return this._a[this._k] ;
	}

	/**
	 * Returns the next element in the iteration.
	 * @return the next element in the iteration.
	 */
	proto.next = function () 
	{
		return this._o[ this._a[++this._k] ]  ;
	}

	/**
	 * Removes from the object the last element returned by the iterator (optional operation).
	 */
	proto.remove = function() 
	{
		var p /*String*/ = this._a[this._k] ;
		this._a.splice(this._k--, 1) ;
		delete this._o[p] ;
		this._len -- ;
		return p ;
	}

	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	proto.reset = function() 
	{
		this._k = -1 ;
	}

	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	proto.seek = function (n) 
	{
		this._k = vegas.util.MathsUtil.clamp(n-1, -1, this._len-1) ;
	}
	
	/**
	 * @private
	 */
	proto._a = null ;
	
	/**
	 * @private
	 */
	proto._k = null ;
	
	delete proto ;
	
}