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
 * An object that maps keys to values. A map cannot contain duplicate keys. Each key can map to at most one value.
 * @author eKameleon
 */
if (vegas.data.Map == undefined) 
{

	/**
	 * Creates a new Map instance.
	 */	
	vegas.data.Map = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.Map.extend(vegas.core.CoreObject) ;

	/**
	 * Removes all mappings from this map (optional operation).
	 */
	proto.clear = function () 
	{
		//
	}
	
	/**
	 * Returns a shallow copy of the map.
	 * @return a shallow copy of the map.
	 */
	proto.clone = function () 
	{
		//
	}
	
	/**
	 * Returns {@code true} if this map contains a mapping for the specified key.
	 */
	proto.containsKey = function ( key ) /*Boolean*/ 
	{
		//
	}

	/**
	 * Returns {@code true} if this map maps one or more keys to the specified value.
	 */
	proto.containsValue = function ( value ) /*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the value to which this map maps the specified key.
	 */
	proto.get = function (key) {
		//
	}

	/**
	 * Returns an array of all the keys in the map.
	 */
	proto.getKeys = function () /*Array*/ 
	{
		//
	}

	/**
	 * Returns an array of all the values in the map.
	 */
	proto.getValues = function () /*Array*/ 
	{
		//
	}

	/**
	 * Returns the index of the specified key in argument.
	 * @param key the key in the map to search.
	 * @return the index of the specified key in argument.
	 */
	proto.indexOfKey = function (key) /*Number*/ 
	{
		//
	}

	/**
	 * Returns the index of the specified value in argument.
	 * @param value the value in the map to search.
	 * @return the index of the specified value in argument.
	 */
	proto.indexOfValue = function (value) /*Number*/ 
	{
		//
	}

	/**
	 * Returns {@code true} if this map contains no key-value mappings.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the values iterator of this map.
	 */
	proto.iterator = function () /*Iterator*/ 
	{
		//
	}

	/**
	 * Returns the keys iterator of this map. 
	 */
	proto.keyIterator = function () /*Iterator*/ 
	{
		//
	}

	/**
	 * Associates the specified value with the specified key in this map (optional operation).
	 */
	proto.put = function (key, value) 
	{
		//
	}

	/**
	 * Copies all of the mappings from the specified map to this map (optional operation).
	 */
	proto.putAll = function (m /*Map*/) 
	{
		//
	}

	/**
	 * Removes the mapping for this key from this map if it is present (optional operation).
	 */
	proto.remove = function (key) 
	{
		//
	}

	/**
	 * Returns the number of key-value mappings in this map.
	 */
	proto.size = function () /*Number*/ 
	{
		//
	}
	
	/**
	 * Returns the eden string representation of this instance.
	 * @return the eden string representation of this instance
	 */
	proto.toSource = function (indent, indentor) /*String*/ 
	{
		//
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function () 
	{
		//
	}
	
	delete proto ;
}