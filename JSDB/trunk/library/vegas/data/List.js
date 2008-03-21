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
 * An ordered collection (also known as a sequence). The user of this interface has precise control over where in the list each element is inserted. The user can access elements by their integer index (position in the list), and search for elements in the list.
 * @author eKameleon
 */
if (vegas.data.List == undefined) 
{

	/**
	 * @requires vegas.data.collections.AbstractCollection
	 */		
	require( "vegas.data.collections.AbstractCollection") ;

	/**
	 * Creates a new List instance.
	 */
	vegas.data.List = function ( ar ) 
	{ 
		vegas.data.collections.AbstractCollection.call(this, ar) ;
	}
	
	/**
	 * @extends vegas.data.collections.AbstractCollection
	 */
	proto = vegas.data.List.extend(vegas.data.collections.AbstractCollection) ;

	/**
	 * Returns {@code true} if this list contains all of the elements of the specified collection.
	 */
	proto.containsAll = function ( c ) /*Boolean*/ 
	{
		
	}

	/**
	 * Indicates whether some other object is "equal to" this one.
	 */
	proto.equals = function (o) /*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the index in this list of the first occurrence of the specified element, or -1 if this list does not contain this element.
	 */
	proto.indexOf = function (o) /*Number*/ 
	{
		//
	}

	/**
	 * Appends all of the elements in the specified collection to the end of this list, in the order that they are returned by the specified collection's iterator (optional operation).
	 */
	proto.insertAll = function (c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
	 */
	proto.insertAllAt = function (id/*Number*/, c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Inserts the specified element at the specified position in this list (optional operation).
	 */
	proto.insertAt = function (id/*Number*/, o)/*Void*/ 
	{
		//
	}

	/**
	 * Returns the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
	 */
	proto.lastIndexOf = function (o)/*Number*/ 
	{
		//
	}

	/**
	 * Returns a list iterator of the elements in this list (in proper sequence).
	 */
	proto.listIterator = function ()/*ListIterator*/ 
	{
		//
	}

	/**
	 * Removes from this list all the elements that are contained in the specified collection (optional operation).
	 */
	proto.removeAll = function (c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Removes the element at the specified position in this list (optional operation).
	 */
	proto.removeAt = function (id/*Number*/) 
	{
		//
	}

	/**
	 * Removes from this list all the elements that are contained between the specific {@code from} and the specific {@code to} position in this list (optional operation).
	 */
	proto.removeRange = function (from/*Number*/, to/*Number*/)/*Void*/ 
	{
		//
	}
	
	/**
	 * Removes from this list all the elements that are contained between the specific {@code id} position and the end of this list (optional operation).
	 */
	proto.removesAt = function (id/*Number*/, len/*Number*/) 
	{
		//
	}

	/**
	 * Retains only the elements in this list that are contained in the specified collection (optional operation).
	 */
	proto.retainAll = function (c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Replaces the element at the specified position in this list with the specified element (optional operation).
	 */
	proto.setAt = function (id/*Number*/, o)/*Void*/ 
	{
		//
	}

	/**
	 * Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
	 */
	proto.subList = function (fromIndex/*Number*/, toIndex/*Number*/)/*List*/
	{
		//
	}
	
	delete proto ;
	
}