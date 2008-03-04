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
 * The root interface in the collection hierarchy. A collection represents a group of objects, known as its elements. Some collections allow duplicate elements and others do not. Some are ordered and others unordered. 
 * @author eKameleon
 */
if (vegas.data.Collection == undefined) 
{
	
	/**
	 * Creates a new Collection instance.
	 */
	vegas.data.Collection = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.Collection.extend(vegas.core.CoreObject) ;

	/**
	 * Removes all of the elements from this collection (optional operation).
	 */
	proto.clear = function ()/*Void*/ 
	{
		//
	}

	/**
	 * Returns a shallow copy of this collection (optional operation)
	 */
	proto.clone = function () 
	{
		//
	}

	/**
	 * Returns {@code true} if this collection contains the specified element.
	 * @return {@code true} if this collection contains the specified element.
	 */
	proto.contains = function (o)/*Boolean*/ 
	{
		//
	}
	
	/**
	 * Returns the element from this collection at the passed index.
	 */
	proto.get = function (id/*Number*/) 
	{
		//
	}

	/**
	 * Ensures that this collection contains the specified element (optional operation).
	 */
	proto.insert = function (o)/*Boolean*/ 
	{
		//
	}

	/**
	 * Returns {@code true} if this collection contains no elements.
	 * @return {@code true} if this collection is empty else {@code false}.
	 */
	proto.isEmpty = function ()/*Boolean*/ 
	{
		//
	}


	/**
	 * Returns an iterator over the elements in this collection.
	 */
	proto.iterator = function ()/*Iterator*/ 
	{
		//
	}

	/**
	 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
	 */
	proto.remove = function (o)/*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the number of elements in this collection.
	 */
	proto.size = function ()/*Number*/ 
	{
		//
	}

	/**
	 * Returns an array containing all of the elements in this collection.
	 */
	proto.toArray = function ()/*Array*/ 
	{
		//
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function ()/*String*/ 
	{
		//
	}
	
	delete proto ;

}