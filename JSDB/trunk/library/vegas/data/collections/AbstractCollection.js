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
 * This class provides a skeletal implementation of the {@code Collection} interface, to minimize the effort required to implement this interface.
 * <p><b>Example :</b></p>
 * {@code
 * var ar = ["item1", "item2", "item3"]
 * var co = new vegas.data.collections.AbstractCollection(ar) ;
 * co.insert("item4") ;
 * trace ("co : " + co) ;
 * trace ("co.toSource : " + co.toSource()) ;
 * trace ("co get 2 : " + co.get(2)) ;
 * 
 * var it = co.iterator() ;
 * while(it.hasNext()) 
 * {
 *     trace (it.next() + " : " + it.key()) ;
 * }
 * 
 * trace ("co indexOf 'item1' : " + co.indexOf("item2")) ;
 * co.clear() ;
 * trace ("co isEmpty : " + co.isEmpty()) ;
 * trace ("co size : " + co.size()) ;
 * }
 * @extends vegas.data.Collection
 * @author eKameleon
 */
if (vegas.data.collections.AbstractCollection == undefined) 
{

	/**
	 * Creates a new AbstractCollection.
	 * @param ar (optional) an array to fill the collection.
	 */
	vegas.data.collections.AbstractCollection = function ( ar /*Array*/ ) 
	{ 
		if (arguments.length > 0 && arguments[0] instanceof Array) 
		{
			this._a = [].concat(arguments[0]) ;
		}
		else 
		{
			this._a = [] ;
		}
	}

	/**
	 * @requires vegas.data.Collection
	 */
	vegas.data.collections.AbstractCollection.extend(vegas.data.Collection) ;
	
	/**
	 * Removes all of the elements from this collection (optional operation).
	 */
	vegas.data.collections.AbstractCollection.prototype.clear = function () 
	{
		this._a.splice(0) ;
	}

	/**
	 * Returns a shallow copy of this collection (optional operation).
	 * <p>Overrides this method in the concrete class.</p>
	 */
	vegas.data.collections.AbstractCollection.prototype.clone = function () 
	{
		return new vegas.data.collections.AbstractCollection(this._a) ; // override this method
	}

	/**
	 * Returns {@code true} if this collection contains the specified element.
	 * @return {@code true} if this collection contains the specified element.
	 */
	vegas.data.collections.AbstractCollection.prototype.contains = function (o) 
	{
		return this._a.contains(o) ;
	}

	/**
	 * Returns the element from this collection at the passed index.
	 */
	vegas.data.collections.AbstractCollection.prototype.get = function (id /*Number*/ ) { 
		return this._a[id] ;
	}
	
	/**
	 * Returns the index of an element in the collection.
	 * @return the index of an element in the collection.
	 */
	vegas.data.collections.AbstractCollection.prototype.indexOf = function ( o ) /*Number*/ 
	{
		return this._a.indexOf(o) ;
	}

	/**
	 * Ensures that this collection contains the specified element (optional operation).
	 */
	vegas.data.collections.AbstractCollection.prototype.insert = function ( o ) /*Boolean*/ 
	{ 
		if (o == undefined) return false ;
		this._a.push(o) ;
		return true ;
	}

	/**
	 * Returns {@code true} if this collection contains no elements.
	 * @return {@code true} if this collection contains no elements.
	 */
	vegas.data.collections.AbstractCollection.prototype.isEmpty = function () /*Boolean*/ 
	{ 
		return this._a.length == 0 ;
	}

	/**
	 * Returns an iterator over the elements in this collection.
	 * @return an Iterator over the elements in this collection.
	 * @see Iterator
	 * @see Iterable
	 */
	vegas.data.collections.AbstractCollection.prototype.iterator = function () /*Iterator*/ 
	{
		return new vegas.data.iterator.ArrayIterator(this._a) ;
	}

	/**
	 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
	 */
	vegas.data.collections.AbstractCollection.prototype.remove = function (o) /*Boolean*/ 
	{
		var it = this.iterator() ;
		if (o == null) 
		{
			while(it.hasNext()) 
			{
				if (it.next() == null) 
				{
					it.remove() ;
					return true ;
				}
			}
		}
		else 
		{
			while (it.hasNext()) 
			{
				if (o == it.next() ) 
				{
					it.remove() ;
					return true ;
				}
			}
		}
		return false ;
	}

	/**
	 * Returns the number of elements in this collection.
	 * @return the number of elements in this collection.
	 */
	vegas.data.collections.AbstractCollection.prototype.size = function () /*Number*/ 
	{
		return this._a.length ;
	}

	/**
	 * Returns an array containing all of the elements in this collection.
	 * @return an array containing all of the elements in this collection.
	 */
	vegas.data.collections.AbstractCollection.prototype.toArray = function () /*Array*/ 
	{
		return this._a.concat() ;
	}

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	vegas.data.collections.AbstractCollection.prototype.toSource = function (indent/*Number*/, indentor/*String*/) /*String*/ 
	{
		return "new " + vegas.util.ConstructorUtil.getPath(this) + "(" + this._a.toSource() + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	vegas.data.collections.AbstractCollection.prototype.toString = function () /*String*/ 
	{
		return (new vegas.data.collections.CollectionFormat()).formatToString(this) ;
	}
	
}