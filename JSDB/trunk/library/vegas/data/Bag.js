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
 * Defines a collection that counts the number of times an object appears in the collection.
 * @author eKameleon
 */
if (vegas.data.Bag == undefined) 
{

	/**
	 * @requires vegas.data.Collection
	 */
	require("vegas.data.Collection") ;

	/**
	 * Creates a new Bag instance.
	 */
	vegas.data.Bag = function() 
	{
		//
	}

	/**
	 * @extends vegas.data.Collection
	 */
	proto = vegas.data.Bag.extend(vegas.data.Collection) ;

	/**
	 * (Violation) Returns true if the bag contains all elements in the given collection, respecting cardinality.
	 */
	proto.containsAll = function (c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Insert all elements represented in the given collection.
	 */
	proto.insertAll = function (c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Add n copies of the given object to the bag and keep a count. 
	 */
	proto.insertCopies = function (o, nCopies/*Number*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the number of occurrences (cardinality) of the given object currently in the bag.
	 */
	proto.getCount = function (o)/*Number*/ 
	{
		//
	}

	/**
	 * (Violation) Removes all elements represented in the given collection, respecting cardinality.
	 */
	proto.removeAll = function (c /*Collection*/ )/*Boolean*/ 
	{
		//
	}

	/**
	 * Removes the given number of occurrences from the bag.
	 */
	proto.removeCopies = function (o, nCopies/*Number*/)/*Boolean*/ 
	{
		
	}

	/**
	 * (Violation) Removes any members of the bag that are not in the given collection, respecting cardinality.
	 */
	proto.retainAll = function (c/*Collection*/)/*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the Set of unique members that represent all members in the bag.
	 */
	proto.uniqueSet = function () /*Set*/ 
	{
		//
	}
	
	delete proto ;
	
}