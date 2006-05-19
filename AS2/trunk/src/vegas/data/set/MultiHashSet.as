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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**	MultiHashSet

	AUTHOR

		Name : MultiHashSet
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2006-05-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var m:MultiHashSet = new MultiHashSet( m:Map ) ;
	
	ARGUMENTS
	
		m : copies the input map creating an independant copy
		
	METHOD SUMMARY
	
		- clear()
		
		- clone()
		
		- containsKey(key)
		
		- containsValue()
		
		- createCollection():Collection
		
			Creates a new instance of the map value Collection container.
			This method can be overridden to use your own collection type.
			
		- get(key)
		
		- getkeys()
		
		- getValues()
		
		- isEmpty():Boolean
		
		- iterator([key]) 
		
		- keyIterator()
				
		- put(key, value)
		
			Adds the value to the collection associated with the specified key.
		
		- putCollection(key, collection:Collection)
		
		- putAll(map:Map) 
		
		- remove(key, [value]) 
		
			If value is undefined; removes all values associated with the specified key.
			
			If value is defined, removes a specific value from map.
		
		- size():Number
		
		- toSource():String
		
		- toString():String
		
		- totalSize():Number
		
		- values()
		
			Gets a collection containing all the values in the map.
		
		- valueIterator()
			
			get a iterator to browse collections in MultiMap
	
	INHERIT
	
		CoreObject → HashMap → MultiHashMap → MultiHashSet  
	
	IMPLEMENTS
	
		ICloneable, Iterable, Map, MultiMap, ISerializable, IFormattable
	
**/

import vegas.data.Collection;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.map.HashMap;
import vegas.data.map.MultiHashMap;
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.errors.UnsupportedOperation;

class vegas.data.set.MultiHashSet extends MultiHashMap implements Set {

	// ----o Construtor
	
	public function MultiHashSet() {
		_map = new HashMap() ;
		if (arguments[0] instanceof Map) {
			var m:Map = arguments[0].clone() ;
			if (m) putAll(m) ;
		}
	}

	// ----o Public Methods	

	/**
	 * This clears each collection in the map, and so may be slow.
	 */
	public function clear():Void {
		_map.clear() ;
	}

	/**
	 * Creates a new instance of the map value Collection container.
	 * This method can be overridden to use your own collection type.
	 */
	/*override*/ public function createCollection():Collection {
		return new HashSet() ;	
	}

	/**
	 * Clones the map.
	 */
	/*override*/ public function clone() {
		var m:MultiHashSet = new MultiHashSet() ;
		var vItr:Iterator = valueIterator() ;
		var kItr:Iterator = keyIterator() ;
		while (kItr.hasNext()) {
			var key = kItr.next() ;
			var value = vItr.next() ;
			m.putCollection(key, value) ;
		}
		return m ;
	}

	/**
	 * Checks whether the map contains the value specified .
	 */
	public function contains(o):Boolean {
		return containsValue(o) ;
	}

	/**
	 * This method always throws an {@code UnsupportedOperation}
	 * because this method is not supported by this Set.
	 *
	 * @throws UnsupportedOperationException
	 */
	public function insert(o) : Boolean {
		throw new UnsupportedOperation("This MultiHashSet does not support the insert() method.") ;
	}

	/**
	 * Adds the value to the collection associated with the specified key.
	 */
	/*override*/ public function put(key, value) {
		if (!containsKey(key)) _map.put(key , createCollection()) ;
		var b:Boolean = _map.get(key).insert(value) ;
		return b ? value : null ;
	}

	/**
	 * Adds a collection of values to the collection associated with the specified key.
	 */
	/*override*/ public function putCollection(key, c:Collection):Void {
		if (!containsKey(key)) {
			_map.put(key , createCollection()) ;
		}
		_map.get(key).insertAll(c) ;
	}
	
	/**
	 * Removes a specific value from map.
	 * Note : Use Set implementation and not Map implementation !
	 */
	/*override*/ public function remove( /* key, value*/ ):Boolean {
		var len:Number = arguments.length ;
		if (len == 2) {
			var value = arguments[1] ;
			var c:Collection = _map.get(arguments[0]) ;
			var b:Boolean = c.remove(value) ;
			return b ;
		} else {
			return (_map.remove(arguments[1]) != null) ;
		}
	}
	
	/**
	 * This returns an array containing the combination of values from all keys.
	 */
	function toArray() : Array {
		return getValues() ;
	}

}