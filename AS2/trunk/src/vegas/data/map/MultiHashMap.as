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

/* ------- 	MultiHashMap

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
	
		HashMap
	
	IMPLEMENTS
	
		ICloneable, Iterable, Map, MultiMap, ISerializable, IFormattable
	
----------  */

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
		_map = new HashMap ;
		if (arguments[0] instanceof Map) {
			var m:Map = arguments[0].clone() ;
			if (m) putAll(m) ;
		}
	}

	// ----o Public Methods	
	
	public function clear():Void {
		_map.clear() ;
	}

	public function clone() {
		var m:MultiHashMap = new MultiHashMap ;
		var vItr:Iterator = valueIterator() ;
		var kItr:Iterator = keyIterator() ;
		while (kItr.hasNext()) {
			var key = kItr.next() ;
			var value = vItr.next() ;
			m.putCollection(key, value) ;
		}
		return m ;
	}

	public function containsKey( key ):Boolean {
		return _map.containsKey( key ) ;
	}

	public function containsValue( value ):Boolean {
		var it:Iterator = _map.iterator() ;
		while (it.hasNext()) {
			var cur = it.next() ;
			if (cur.contains(value)) return true;
		}
		return false ;
	}

	public function get(key) /*Collection*/ {
		return _map.get(key) ;
	}

	public function getKeys():Array {
		return _map.getKeys() ;
	}
	
	public function getValues():Array {
		var ar:Array = [] ;
		var it:Iterator = _map.iterator() ;
		while (it.hasNext()) {
			ar.concat(it.next().getValues()) ;
		}
		return ar ;
	}

	public function isEmpty():Boolean {
		return _map.isEmpty() ;
	}
	
	public function iterator( /*key*/ ):Iterator {
		var key = arguments[0] ;
		if (key) {
			return _map.get(key).iterator() ;
		} else {
			return _map.iterator() ;
		}
	}

	public function keyIterator():Iterator {
		return _map.keyIterator() ;
	}

	public function put(key, value) {
		if (!containsKey(key)) _map.put(key , new SimpleCollection) ;
		var b:Boolean = _map.get(key).insert(value) ;
		return b ? value : null ;
	}
	
	public function putCollection(key, c:Collection):Void {
		if (!containsKey(key)) {
			_map.put(key , new SimpleCollection) ;
		}
		_map.get(key).insertAll(c) ;
	}
	
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