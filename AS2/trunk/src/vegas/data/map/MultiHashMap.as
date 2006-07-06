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

/**	MultiHashMap

	AUTHOR

		Name : MultiHashMap
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2005-10-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var m:MultiHashMap = new MultiHashMap( m:Map ) ;
	
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
	
		CoreObject → HashMap → MultiHashMap
	
	IMPLEMENTS
	
		ICloneable, Iterable, Map, MultiMap, ISerializable, IFormattable
	
**/

// TODO finir les tests car il y a des problèmes !!

import vegas.core.IFormattable;
import vegas.data.Collection;
import vegas.data.collections.SimpleCollection;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.map.HashMap;
import vegas.data.map.MultiMapFormat;
import vegas.data.MultiMap;
import vegas.util.serialize.Serializer;

class vegas.data.map.MultiHashMap extends HashMap implements Iterable, MultiMap, IFormattable {

	// ----o Construtor
	
	public function MultiHashMap() {
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
	public function createCollection():Collection {
		return new SimpleCollection() ;	
	}

	/**
	 * Clones the map.
	 */
	public function clone() {
		var m:MultiHashMap = new MultiHashMap() ;
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
	 * Checks whether the map contains the key specified.
	 */
	public function containsKey( key ):Boolean {
		return _map.containsKey( key ) ;
	}

	/**
	 * Checks whether the map contains the value specified or at the specified key contains the value.
	 * @example
	 * <code>
	 * 		var b:Boolean = map.containsValue(key, value) ;
	 * 		
	 * 		var b:Boolean = map.containsValue(value) ;
	 * </code>
	 */
	public function containsValue( value ):Boolean {
		var len:Number = arguments.length ;
		if (len == 1) {
			var value = arguments[0] ;
			var it:Iterator = _map.iterator() ;
			while (it.hasNext()) {
				var cur = it.next() ;
				if (cur.contains(value)) return true;
			}
		} else if (len == 2) {
			return ( get(arguments[0] ).contains(arguments[1]) == true);
		}
		return false ;
	}

	/**
	 * Gets the collection mapped to the specified key. This method is a convenience method to typecast the result of get(key).
	 */
	public function get( key ) /*Collection*/ {
		return _map.get(key) ;
	}

	/**
	 * Checks whether the map contains the key specified .
	 */
	public function getKeys():Array {
		return _map.getKeys() ;
	}
	
	/**
	 * This returns an array containing the combination of values from all keys.
	 */
	public function getValues():Array {
		var result:Array = [] ;
		var values = this._map.getValues() ;
		var l:Number = values.length ;
		for (var i:Number = 0 ; i<l ; i++) {
			result = result.concat( values[i].toArray() ) ;
		}
		return result ;
	}

	/**
	 * Returns whether this MultiHashSet contains any mappings.
	 * 
	 * @return {@code true} if this MultiHashSet contains any mappings else {@code false}
	 */
	public function isEmpty():Boolean {
		return _map.isEmpty() ;
	}
	
	/**
	 * Gets an iterator for the collection mapped to the specified key.
	 */
	public function iterator( /*key*/ ):Iterator {
		var key = arguments[0] ;
		if (key) {
			return _map.get(key).iterator() ;
		} else {
			return _map.iterator() ;
		}
	}

	/**
	 * Gets an iterator for the map to iterate keys.
	 */
	public function keyIterator():Iterator {
		return _map.keyIterator() ;
	}

	/**
	 * Adds the value to the collection associated with the specified key.
	 */
	public function put(key, value) {
		if (!containsKey(key)) _map.put(key , createCollection()) ;
		var b:Boolean = _map.get(key).insert(value) ;
		return b ? value : null ;
	}

	/**
	 * Override superclass to ensure that MultiMap instances are correctly handled.
	 */
	public function putAll(map:Map):Void {
		var it:Iterator = map.iterator() ;
		while (it.hasNext()) {
			var value = it.next() ;
			var key = it.key() ;
			if (value instanceof Collection) {
				putCollection(key, value) ;
			} else {
				put(key, value) ;
			}
		}
	}
	
	/**
	 * Adds a collection of values to the collection associated with the specified key.
	 */
	public function putCollection(key, c:Collection):Void {
		if (!containsKey(key)) {
			_map.put(key , createCollection()) ;
		}
		_map.get(key).insertAll(c) ;
	}
	
	/**
	 * Removes a specific value from map.
	 */
	public function remove(key /*, value*/ ) {
		var value = arguments[1] ;
		if (key && value) {
			var c:Collection = _map.get(key) ;
			var b:Boolean = c.remove(value) ;
			return (b) ? value : null ;
		} else {
			return _map.remove(key) ;
		}
	}
	
	/**
	 * Gets the size of the collection mapped to the specified key.
	 */
	public function size():Number {
		return _map.size() ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = Serializer.toSource(_map) ;
		return Serializer.getSourceOf(this, [sourceA]) ;
	}
	
	public function toString():String {
		return (new MultiMapFormat()).formatToString(this) ;
	}

	/**
	 * Gets the total size of the map by counting all the values.
	 */
	public function totalSize():Number {
		var result:Number = 0 ;
		var it:Iterator = _map.iterator() ;
		while (it.hasNext()) {
			result += (it.next().size() || 0) ;
		}
		return result ;
	}

	public function values():Collection {
		var ar:Array = getValues() ;
		return new SimpleCollection(ar) ;
	}

	public function valueIterator():Iterator {
		return new ArrayIterator(_map.getValues()) ;
	}

	// ----o Private Properties
	
	private var _map:HashMap ;
	
}