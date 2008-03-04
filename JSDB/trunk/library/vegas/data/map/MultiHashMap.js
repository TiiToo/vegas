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
 * The default implementation of the {@code MultiMap} interface.
 * <p><b>Example :</b></p>
 * {@code
 * var map1 = new vegas.data.map.HashMap() ;
 * map1.put("key1", "valueD1") ;
 * map1.put("key2", "valueD2") ;
 * 
 * trace ("--- user map argument in constructor") ;
 * var map = new vegas.data.map.MultiHashMap(map1) ;
 * trace ("init map : " + map) ;
 * trace("map toSource : " + map.toSource()) ;
 * trace ("--- put values in MultiMap") ;
 * 
 * map.put("key1", "valueA1") ;
 * map.put("key1", "valueA2") ;
 * map.put("key1", "valueA3") ;
 * map.put("key2", "valueB1") ;
 * map.put("key2", "valueB2") ;
 * map.put("key3", "valueC1") ;
 * map.put("key3", "valueC2") ;
 * 
 * trace ("key1 >> " + map.get("key1")) ;
 * trace ("key2 >> " + map.get("key2")) ;
 * trace ("key3 >> " + map.get("key3")) ;
 * 
 * trace ("\r--- toString MultiMap") ;
 * trace (map) ;
 * 
 * map.remove("key1", "valueA2") ;
 * trace ("\r--- remove a value in key1 >> " + map.get("key1")) ;
 * 
 * trace ("\r--- use a key iterator : key1") ;
 * var it = map.iterator("key1") ;
 * while(it.hasNext()) 
 * {
 *     trace ("\t :: " + it.next()) ;
 * }
 * 
 * trace ("\r--- putCollection key2 in key1") ;
 * map.putCollection("key1", map.get("key2")) ;
 * trace ("key1 >> " + map.get("key1")) ;
 * 
 * trace ("\r--- different size") ;
 * trace ("map size : " + map.size()) ;
 * trace ("map totalSize : " + map.totalSize()) ;
 * 
 * trace ("\r--- clone MultiMap") ;
 * var clone = map.clone() ;
 * clone.remove("key1") ;
 * 
 * trace ("map size : " + map.totalSize()) ;
 * trace ("clone size : " + clone.totalSize()) ;
 * } 
 * @author eKameleon
 * @see MultiMap
 */
if (vegas.data.map.MultiHashMap == undefined) 
{

	/**
	 * @requires vegas.data.map.HashMap
	 */
	require("vegas.data.map.HashMap") ;

	/**
	 * Creates a new MultiHashMap instance.
	 */
	vegas.data.map.MultiHashMap = function ( m /*Map*/ ) 
	{ 
		this._map = new vegas.data.map.HashMap() ;
		if (m != undefined) 
		{
			this.putAll( m ) ;
		}
	}

	/**
	 * @extends vegas.data.map.HashMap 
	 */
	proto = vegas.data.map.MultiHashMap.extend(vegas.data.map.HashMap) ;

	/**
	 * Removes all elements in this map.
	 */
	proto.clear = function () 
	{
		this._map.clear() ;
	}

	/**
	 * Creates a new instance of the map value Collection container.
	 * This method can be overridden to use your own collection type.
	 * @return a new instance of the map value Collection container.
	 */
	proto.createCollection = function () /*Collection*/ 
	{
		return new vegas.data.collections.SimpleCollection() ;	
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () 
	{
		var m = new vegas.data.map.MultiHashMap() ;
		var vItr = this.valueIterator() ;
		var kItr = this.keyIterator() ;
		while (kItr.hasNext()) 
		{
			var key = kItr.next() ;
			var value = vItr.next() ;
			m.putCollection(key, value) ;
		}
		return m ;
	}

	/**
	 * Checks whether the map contains the key specified.
	 */
	proto.containsKey = function ( key ) /*Boolean*/ 
	{
		return this._map.containsKey(key) ;
	}

	/**
	 * Checks whether the map contains the value specified or at the specified key contains the value.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var b:Boolean = map.containsValue(key, value) ;
	 * var b:Boolean = map.containsValue(value) ;
	 * }
	 * @return {@code true} if the map contains the specified value. 
	 */
	proto.containsValue = function ( value ) /*Boolean*/ 
	{
		var len = arguments.length ;
		if (len == 2) 
		{
			var value = arguments[0] ;
			var it = this._map.iterator() ;
			while (it.hasNext()) 
			{
				var cur = it.next() ;
				if (cur.contains(value)) return true;
			}
		} 
		else if (len == 1) 
		{
			return (this.get(arguments[0])).contains(arguments[1]) ;
		}
		return false ;
	}
	
	/**
	 * Gets the collection mapped to the specified key. This method is a convenience method to typecast the result of get(key).
	 * @return the collection mapped to the specified key
	 */
	proto.get = function (key) 
	{
		return this._map.get(key) ;
	}

	/**
	 * Checks whether the map contains the key specified .
	 */
	proto.getKeys = function () /*Array*/ 
	{
		return this._map.getKeys() ;
	}
	
	/**
	 * This returns an array containing the combination of values from all keys.
	 * @return returns an array containing the combination of values from all keys.
	 */
	proto.getValues = function () /*Array*/ 
	{
		var ar = [] ;
		var it = this._map.iterator() ;
		while (it.hasNext()) 
		{
			var next = it.next() ;
			if (next instanceof vegas.data.Collection ) 
			{
				ar = ar.concat( next.toArray() ) ;
			}
			else
			{
				ar = ar.concat( next ) ;
			}
		}
		return ar ;
	}

	/**
	 * Returns whether this MultiHashSet contains any mappings.
	 * @return {@code true} if this MultiHashMap contains any mappings else {@code false}
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return _map.isEmpty() ;
	}
	
	/**
	 * Gets an iterator for the collection mapped to the specified key.
	 */
	proto.iterator = function ( /*key*/ ) /*Iterator*/ 
	{
		var key = arguments[0] ;
		if (key != undefined) 
		{
			var c = this._map.get(key) ;
			if ( c != null )
			{
				return this._map.get(key).iterator() ;
			}
			else
			{
				return null ;
			}
		}
		else 
		{
			return this._map.iterator() ;
		}
	}

	/**
	 * Gets an iterator for the map to iterate keys.
	 */
	proto.keyIterator = function () /*Iterator*/ 
	{
		return this._map.keyIterator() ;
	}

	/**
	 * Adds the value to the collection associated with the specified key.
	 */
	proto.put = function (key, value) 
	{
		if (this.containsKey(key) == false) 
		{
			this._map.put(key , this.createCollection()) ;
		}
		var b = this._map.get(key).insert(value) ;
		return b ? value : null ;
	}

	/**
	 * Override superclass to ensure that MultiMap instances are correctly handled.
	 */
	proto.putAll = function ( m /*Map*/ ) 
	{
		if (m.size() > 0) 
		{
			var it = m.iterator() ;
			while (it.hasNext()) 
			{
				var value = it.next() ;
				var key = it.key() ;
				if (value instanceof vegas.data.Collection) 
				{
					this.putCollection(key, value) ;
				}
				else 
				{
					this.put(key, value) ;
				}
			}
		}
	}

	/**
	 * Adds a collection of values to the collection associated with the specified key.
	 */
	proto.putCollection = function (key, co /*Collection*/ ) 
	{
		if (this.containsKey(key) == false) 
		{
			this._map.put(key , this.createCollection()) ;
		}
		this._map.get(key).insertAll(co) ;
	}

	/**
	 * Removes a specific value from map.
	 * @param key the key to remove in the map
	 * @param value (optional) if this value is defined removes a specific value from map else removes all values associated with the specified key.
	 * @return the removed value.
	 */
	proto.remove = function (key, value) 
	{
		if (key == undefined) return null ;
		if (key != undefined && value != undefined) 
		{
			var c = this._map.get(key) ;
			var b = c.remove(value) ;
			return (b) ? value : null ;
		}
		else 
		{
			return this._map.remove(key) ;
		}
	}

	/**
	 * Returns the size of the collection mapped to the specified key.
	 * @return the size of the collection mapped to the specified key.
	 */
	proto.size = function () /*Number*/ 
	{
		return this._map.size() ;
	}

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function (indent, indentor) /*String*/ 
	{
		return "new " + this.getConstructorPath() + "(" + this._map.toSource() + ")" ;
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function () 
	{
		return (new vegas.data.map.MultiMapFormat()).formatToString(this) ;
	}

	/**
	 * Gets the total size of the map by counting all the values.
	 */
	proto.totalSize = function() /*Number*/ 
	{
		var result /*Number*/ = 0 ;
		var it = this._map.iterator() ;
		while (it.hasNext()) 
		{
			result += (it.next()).size() || 0 ;
		}
		return result ;
	}

	/**
	 * Returns a Collection of all values in the MultiHashMap.
	 * @return a Collection of all values in the MultiHashMap.
	 */
	proto.values = function () /*Collection*/ 
	{
		var ar /*Array*/ = this.getValues() ;
		return new vegas.data.collections.SimpleCollection(ar) ;
	}

	/**
	 * Returns the iterator of all values in the MultiHashMap.
	 * @return the iterator of all values in the MultiHashMap.
	 */
	proto.valueIterator = function () /*Iterator*/ 
	{
		return new vegas.data.iterator.ArrayIterator(this._map.getValues()) ;
	}
	
	delete proto ;
	
}