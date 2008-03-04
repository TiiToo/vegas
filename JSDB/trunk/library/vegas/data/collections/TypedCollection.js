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
 * TypedCollection is a wrapper for Collection instances that ensures that only values of a specific type can be added to the wrapped collection.
 * <p><b>Example :</b></p>
 * {@code
 * var ar = ["item1", "item2", "item3"] ;
 * var co1 = new vegas.data.collections.TypedCollection(ar) ;
 * var co2 = new vegas.data.collections.TypedCollection(["item2", "item3"]) ;
 * var co3 = new vegas.data.collections.TypedCollection(["item5", "item3"]) ;
 * 
 * trace ("co1 : " + co1) ;
 * trace ("co1.toSource : " + co1.toSource()) ;
 * trace ("co1.constainsAll(co2) : " + co1.containsAll(co2)) ;
 * trace ("co1.retainAll(co2) : " + co1.retainAll(co2)) ;
 * trace ("co1 : " + co1) ;
 * trace ("co1.insertAll(co3) : " + co1.insertAll(co3)) ;
 * trace ("co1.removeAll(co2) : " + co1.removeAll(co2)) ;
 * trace ("co1 : " + co1) ;
 * }
 * @author eKameleon
 */
if (vegas.data.collections.TypedCollection == undefined) 
{

	/**
	 * @requires vegas.util.AbstractTypeable
	 */
	require("vegas.util.AbstractTypeable") ;

	/**
	 * Creates a new TypedCollection.
	 * @throws IllegalArgumentError if the specified collection in argument is {@code null} or {@code undefined} 
	 */
	vegas.data.collections.TypedCollection = function ( type /*Function*/ , co /*Collection*/ ) 
	{ 
		vegas.util.AbstractTypeable.call(this, type) ;
		if ( !(co instanceof vegas.data.Collection) || co == null ) 
		{
			throw new vegas.events.IllegalArgumentError("TypedCollection constructor, argument 'co' must be a Collection or not be 'null' or 'undefined'") ;
		}
		if (co.size() > 0) 
		{
			var it = co.iterator() ;
			while ( it.hasNext() ) 
			{
				this.validate( it.next() ) ;
			}
		}
		this._co = co ;
	}

	/**
	 * @requires vegas.util.AbstractTypeable
	 */
	proto = vegas.data.collections.TypedCollection.extend(vegas.util.AbstractTypeable) ;

	/**
	 * Removes all of the elements from this collection (optional operation).
	 */
	proto.clear = function () 
	{
		this._co.clear() ;
	}

	/**
	 * Returns a shallow copy of this collection.
	 * @return a shallow copy of this collection.
	 */
	proto.clone = function () 
	{
		return new vegas.data.collections.TypedCollection(this.getType(), this._co.clone()) ;
	}

	/**
	 * Returns {@code true} if this collection contains the specified element.
	 * @return {@code true} if this collection contains the specified element.
	 */
	proto.contains = function (o) /*Boolean*/ 
	{
		return this._co.contains(o) ;
    }

	/**
	 * Returns the element from this collection at the passed index.
	 */
	proto.get = function (id /*Number*/) 
	{
		return this._co.get(id) ;
	}

	/**
	 * Inserts an elements into the Collection.
	 */
	proto.insert = function (o) /*Boolean*/ 
	{
		this.validate(o) ;
		return this._co.insert(o) ;
    }

	/**
	 * Returns {@code true} if this collection contains no elements.
	 * @return {@code true} if the collection is empty else {@code false}.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._co.isEmpty() ;
	}

	/**
	 * Returns an iterator over the elements in this collection.
	 * @return an iterator over the elements in this collection.
	 */
	proto.iterator = function () /*Iterator*/ 
	{
		return this._co.iterator() ;
	}

	/**
	 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
	 */
	proto.remove = function (o) /*Boolean*/ 
	{
		return this._co.remove(o);
    }

	/**
	 * Sets the type of the ITypeable object.
	 */
	proto.setType = function (type /*Function*/) /*void*/ 
	{
		vegas.util.AbstractTypeable.prototype.setType.call(this, type) ;
		this._co.clear() ;
	}

	/**
	 * Returns the number of elements in this collection.
	 */
	proto.size = function ()/*Number*/ 
	{
		return this._co.size() ;
	}

	/**
	 * Returns an array containing all of the elements in this collection.
	 * @return an array representation of all the elements in this wrapped collection.
	 */
	proto.toArray = function ()/*Array*/ 
	{
		return this._co.toArray() ;
	}

	/**
	 * Returns the Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function (indent/*Number*/, indentor/*String*/)/*String*/ 
	{
		var sourceA/*String*/ = vegas.util.TypeUtil.toString(this._type) ;
		var sourceB/*String*/ = this._co.toSource() ;
		return "new " + this.getConstructorPath() + "(" + sourceA + "," + sourceB + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	proto.toString = function ()/*String*/ 
	{
		return this._co.toString() ;
	}
	
	delete proto ;
	
}