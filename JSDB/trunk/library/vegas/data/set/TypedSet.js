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
 * TypedSet is a wrapper for Set instances that ensures that only values of a specific type can be added to the wrapped Set.
 * <p><b>Example :</b></p>
 * {@code
 * var namespace = vegas.data.set ;
 * var s = new namespace.HashSet([6, 12]) ;
 * 
 * trace ("set insert 12 : " + s.insert(12)) ;
 * trace ("set insert 24 : " + s.insert(24)) ;
 * trace ("set insert 48 : " + s.insert(48)) ;
 * 
 * var ts = new namespace.TypedSet(Number, s) ;
 * 
 * trace ("typed set >> " + ts) ;
 * trace ("typed set toSource : " + ts.toSource()) ;
 * trace ("ts insert true : " + ts.insert(true)) ;
 * }
 * @author eKameleon
 */
if (vegas.data.set.TypedSet == undefined) 
{

	/**
	 * @requires vegas.util.AbstractTypeable
	 */
	require("vegas.util.AbstractTypeable") ;

	/**
	 * Creates a new TypedSet instance.
	 */
	vegas.data.set.TypedSet = function ( type /*Function*/ , set /*Set*/ ) 
	{ 
		this.__constructor__.call(this, type) ;
		if (set == null) 
		{
			throw new vegas.errors.IllegalArgumentError("TypedSet constructor, argument 'set' must not be 'null' or 'undefined'") ;
		}
		if (set.size && set.size() > 0) 
		{
			var it = set.iterator() ;
			while ( it.hasNext() ) 
			{
				this.validate(it.next()) ;
			}
		}
		this._set = set ;
	}

	/**
	 * @extends vegas.util.AbstractTypeable
	 */
	proto = vegas.data.set.TypedSet.extend(vegas.util.AbstractTypeable) ;

	/**
	 * Removes all of the elements from this Set (optional operation).
	 */
	proto.clear = function () 
	{
		this._set.clear() ;
	}

	/**
	 * Returns a shallow copy of this Set (optional operation).
	 * @return a shallow copy of this Set (optional operation).
	 */
	proto.clone = function () 
	{
		return new vegas.data.set.TypedSet(this.getType(), this._set) ;
	}

	/**
	 * Returns {@code true} if this Set contains the specified element.
	 * @return {@code true} if this Set contains the specified element.
	 */
	proto.contains = function (o) /*Boolean*/ 
	{
		return this._set.contains(o) ;
	}

	/**
	 * Returns an element in the set at the specified position.
	 * @param id the position of the element in the Set.
	 * @return the value of the specified element in the Set.
	 */
	proto.get = function (id /*Number*/ )
	{
		return this._set.get(id) ;
	}

	/**
	 * Adds the specified element to this set if it is not already present.
	 * @param o the object to insert in the Set.
	 */
	proto.insert = function(o) /*Boolean*/ 
	{
		this.validate(o) ;
		return this._set.insert(o) ;
	}

	/**
	 * Returns {@code true} if this set contains no elements.
	 * @return {@code true} if this set contains no elements.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._set.isEmpty() ;
	}

	/**
	 * Returns an iterator over the elements in this set.
	 * @return an iterator over the elements in this set.
	 */
	proto.iterator = function ()/*Iterator*/ 
	{
		return this._set.iterator() ;
	}

	/**
	 * Removes the specified element from this set if it is present.
	 */
	proto.remove = function(o) 
	{
		return this._set.remove(o) ;
	}

	/**
	 * Sets the type of the ITypeable object.
	 * @param type the type function use to restrict all elements in this Set.
	 */
	proto.setType = function (type /*Function*/) /*Void*/ 
	{
		this.__constructor__.prototype.setType.call(this, type) ;
		this._set.clear() ;
	}

	/**
	 * Returns the number of elements in this set (its cardinality).
	 * @return the number of elements in this set (its cardinality).
	 */
	proto.size = function ()/*Number*/ 
	{
		return this._set.size() ;
	}

	/**
	 * Returns the array representation of all the elements of this Set.
	 * @return the array representation of all the elements of this Set.
	 */
	proto.toArray = function ()/*Array*/ 
	{
		return this._set.toArray() ;
	}

	/**
	 * Returns a eden String representation of this object.
	 * @return a string representation the source code of the object.
	 */
	proto.toSource = function (indent/*Number*/, indentor/*String*/)/*String*/ 
	{
		var sourceA /*String*/ = vegas.util.TypeUtil.toString(this._type) ;
		var sourceB /*String*/ = this._set.toSource() ;
		return "new " + this.getConstructorPath() + "(" + sourceA + "," + sourceB + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function () /*String*/ 
	{
		return this._set.toString() ;
	}
	
	delete proto ;
	
}