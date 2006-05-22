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
import vegas.data.map.MultiHashMap;
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.errors.UnsupportedOperation;

class vegas.data.set.MultiHashSet extends MultiHashMap implements Set {

	// ----o Construtor
	
	public function MultiHashSet() {
		super(arguments[0]) ;
		_internalSet = new HashSet() ;
	}

	// ----o Public Methods	

	/**
	 * This clears each collection in the map, and so may be slow.
	 */
	public function clear():Void {
		super.clear() ;
		_internalSet.clear() ;
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
	 * Creates a new instance of the map value Collection(Set) container.
	 * This method can be overridden to use your own collection type.
	 */
	/*override*/ public function createCollection():Collection {
		return new HashSet() ;	
	}

	public function get( id:Number ) {
		throw new UnsupportedOperation("This MultiHashSet does not support the get() method, use getSet().") ;
		return null ;
	}

	public function getSet( key ) /*Set*/ {
		return super.get(key) ;
	}


	/**
	 * This method always throws an {@code UnsupportedOperation}
	 * because this method is not supported by this Set.
	 *
	 * @throws UnsupportedOperationException
	 */
	public function insert(o):Boolean {
		throw new UnsupportedOperation("This MultiHashSet does not support the insert() method.") ;
		return null ;
	}

	/**
	 * Adds the value to the Set associated with the specified key.
	 */
	/*override*/ public function put(key, value):Boolean {
		if(_internalSet.contains(value)) return false ;
		if (!containsKey(key)) {
			_map.put(key , createCollection()) ;
		}
		var b:Boolean = _map.get(key).insert(value) ;
		return _internalSet.insert(value) ;
	}

	/**
	 * Adds a collection of values to the collection associated with the specified key.
	 */
	/*override*/ public function putCollection(key, c:Collection):Void {
		if (!containsKey(key)) {
			_map.put(key , createCollection()) ;
		}
		var s:HashSet = _map.get(key) ;
		var it:Iterator = c.iterator() ;
		var value ;
		while(it.hasNext()) {
			value = it.next() ;
			if (_internalSet.insert(value)) {
				s.insert(value) ;
			}	
		}
	}
	
	/**
	 * Removes a specific value from map.
	 * Note : Use Set implementation and not Map implementation !
	 */
	/*override*/ public function remove( o /* key, value*/ ):Boolean {
		var len:Number = arguments.length ;
		var key ;
		var value ;
		if (len == 2) {
			key = arguments[0] ;
			value = arguments[1] ;
			var c:Collection = _map.get(key) ;
			var b:Boolean = c.remove(value) ;
			return _internalSet.remove(value) ;
		} else {
			key = arguments[0] ;
			var s:Set = _map.get(key) ;
			if (s) {
				var it:Iterator = s.iterator() ;
				while(it.hasNext()) {
					_internalSet.remove(it.next()) ;
				}
				_map.remove(key) ;
				return true ;
			} else {
				return false ;	
			}
			
		}
	}
	
	/**
	 * This returns an array containing the combination of values from all keys.
	 */
	function toArray():Array {
		return getValues() ;
	}

	// ----o Private Properties
	
	private var _internalSet:HashSet ;

}