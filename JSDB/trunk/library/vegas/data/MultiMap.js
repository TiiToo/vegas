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
 * Maps multiple values to keys.
 * @author eKameleon
 */
if (vegas.data.MultiMap == undefined) 
{

	/**
	 * Creates a new MultiMap instance.
	 */
	vegas.data.MultiMap = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.data.Map
	 */
	proto = vegas.data.MultiMap.extend(vegas.data.Map) ;

	/**
	 * Adds the specified collection to the set of values associated with the specified key in this map (optional operation).
	 */
	proto.putCollection = function (key, c/*Collection*/) /*void*/ 
	{
		//
	}

	/**
	 * Returns the total count of elements in all the collection in the MultiMap.
	 * @return the total count of elements in all the collection in the MultiMap.
	 */
	proto.totalSize = function () /*Number*/ 
	{
		//
	}

	/**
	 * Returns a collection of all values associated with all the keys in this map.
	 * @return a collection of all values associated with all the keys in this map.
	 */
	proto.values = function () /*Collection*/
	{
		//
	}

	/**
	 * Returns an iterator fo all the values in the map.
	 * @return an iterator fo all the values in the map.
	 */
	proto.valueIterator = function () /*Iterator*/
	{
		//
	}
	
	delete proto ;

}