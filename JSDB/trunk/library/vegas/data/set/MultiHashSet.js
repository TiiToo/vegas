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
 * The MultiHashSet is a MutliHashMap that contains no duplicate elements in a specified key.
 * <p><b>Example :</b></p>
 * {@code
 * var s = new vegas.data.set.MultiHashSet() ;
 * 
 * trace("----- Test put()") ;
 * 
 * trace("insert key1:valueA1 : " + s.put("key1", "valueA1")) ;
 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
 * trace("insert key1:valueA3 : " + s.put("key1", "valueA3")) ;
 * trace("insert key2:valueA2 : " + s.put("key2", "valueA2")) ;
 * trace("insert key2:valueB1 : " + s.put("key2", "valueB1")) ;
 * trace("insert key2:valueB2 : " + s.put("key2", "valueB2")) ;
 * 
 * trace("size : " + s.size()) ;
 * trace("totalSize : " + s.totalSize()) ;
 * 
 * trace("----- Test contains") ;
 * 
 * trace("contains valueA1 : " + s.contains("valueA1") ) ;
 * trace("contains valueA1 : " + s.contains("valueA1") ) ;
 * trace("contains valueA1 in key1 : " + s.contains("key1", "valueA1") ) ;
 * trace("contains valueA1 in key2 : " + s.contains("key2", "valueA1") ) ;
 * 
 * trace("---- Test toArray") ;
 * 
 * trace("s.toArray : " + s.toArray()) ;
 * 
 * trace("---- Test remove(key, value)") ;
 * 
 * trace("remove key1:valueA2 : " + s.remove("key1", "valueA2")) ;
 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
 * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
 * 
 * trace("---- Test remove(key)") ;
 * 
 * trace("remove key2 : " + s.remove("key2")) ;
 * trace("size : " + s.size()) ;
 * 
 * trace("---- Test putCollection(key, co:Collection)") ;
 * 
 * var co = new vegas.data.collections.SimpleCollection(["valueA1", "valueA4", "valueA1"]) ;
 * s.putCollection("key1", co) ;
 * 
 * trace("s.toString : " + s) ;
 * 
 * }
 * @author eKameleon
 * @see MultiMap
 */
if (vegas.data.set.MultiHashSet == undefined) 
{
		
	// TODO unit tests.

	/**
	 * Creates a new MultiHashSet instance.
	 */
	vegas.data.set.MultiHashSet = function ( m /*Map*/ ) 
	{ 
		vegas.data.map.MultiHashMap.call(this, m) ;
		this._internalSet = new vegas.data.set.HashSet() ;
	}

	/**
	 * @requires vegas.data.map.MultiHashMap
	 */
	proto = vegas.data.set.MultiHashSet.extend(vegas.data.map.MultiHashMap) ;

	/**
	 * This clears each collection in the map, and so may be slow.
	 */
	proto.clear = function () 
	{
		this._map.clear() ;
		this._internalSet.clear() ;
	}

	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	proto.clone = function () 
	{
		var m = new vegas.data.map.MultiHashSet() ;
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
	 * Checks whether the map contains the value specified .
	 * @param o the object to search in this instance.
	 * @return {@code true} if the MultiHashSet container the passed-in object.
	 */
	proto.contains = function (o) /*Boolean*/ 
	{
		var len /*Number*/ = arguments.length ;
		if (len == 1) 
		{
			var value = arguments[0] ;
			var it /*Iterator*/ = this.iterator() ;
			while (it.hasNext()) 
			{
				var cur = it.next() ;
				if (cur.contains(value)) 
				{
					return true ;
				}
			}
		} 
		else if (len == 2) 
		{
			var set = this.getSet( arguments[0] ) ; // TODO test this fix
			if  (set != null)
			{
				return set.contains( arguments[1] ) == true ;
			}
		}
		return false ;
	}

	/**
	 * Creates a new instance of the map value Collection container.
	 * This method can be overridden to use your own collection type.
	 */
	/*override*/ proto.createCollection = function () /*Collection*/ 
	{
		return new vegas.data.set.HashSet() ;	
	}

	/**
	 * This method is unsupported, use getSet method.
	 * @param a number
	 * @throws UnsupportedOperation the MultiHashSet does not support the get() method, use getSet()
	 */
	proto.get = function ( id ) 
	{
		throw new vegas.errors.UnsupportedOperation( "The MultiHashSet does not support the get() method, use getSet().") ;
		return null ;
	}

	/**
	 * Returns the Set defined in the map with the specified key.
	 * @param key the key in the map 
	 * @return the Set defined in the map with the specified key.
	 */
	proto.getSet = function ( key ) /*Set*/ 
	{
		return this._map.get(key) ;
	}

	/**
	 * Adds the value to the Set associated with the specified key.
	 * @return {@code true} if the value is inserted in the object.
	 */
	proto.put = function (key, value) /*Boolean*/ 
	{
		if( this._internalSet.contains(value) ) 
		{
			return false ;
		}
		if (!this.containsKey(key)) 
		{
			this._map.put(key , this.createCollection()) ;
		}
		var b /*Boolean*/ = this._map.get(key).insert(value) ;
		return this._internalSet.insert(value) ;
	}

	/**
	 * Adds a collection of values to the collection associated with the specified key.
	 * @param key The key to insert elements
	 * @param c A Collection of elements to insert in the Map.
	 * @throws vegas.errors.NullPointerError if the passed-in key argument is null.
	 * @throws vegas.errors.NullPointerError if the passed-in Collection argument is null.
	 * @throws vegas.errors.ClassCastError if the passed-in collection argument isn't a Collection implementation object.
	 */
	proto.putCollection = function (key, c /*Collection*/ ) /*void*/ 
	{
		
		if ( key == null )
		{
			throw new vegas.errors.NullPointerError( this + " putCollection failed if the passed-in key is null.") ;
		}
		if ( c == null )
		{
			throw new vegas.errors.NullPointerError( this + " putCollection failed if the passed-in Collection is null.") ;
		}
		if ( ! c instanceof vegas.data.Collection )
		{
			throw new vegas.errors.ClassCastError( this + " putCollection failed if the passed-in collection argument isn't a Collection implementation object.") ;
		}
	
		if ( !this.containsKey( key ) ) 
		{
			this._map.put(key , this.createCollection()) ;
		}
		var s /*HashSet*/   = this._map.get(key) ;
		var it /*Iterator*/ = c.iterator() ;
		var value ;
		while(it.hasNext()) 
		{
			value = it.next() ;
			if (this._internalSet.insert(value)) 
			{
				s.insert(value) ;
			}	
		}
	}

	/**
	 * Removes a specific value from the map.
	 * <p><b>Note :</b> Use Set implementation and not Map implementation !</p>
	 */
	proto.remove = function (key, value) /*Boolean*/  
	{
		var len /*Number*/ = arguments.length ;
		var key ;
		var value ;
		if (len == 2) 
		{
			key   = arguments[0] ;
			value = arguments[1] ;
			var c /*Collection*/ = this._map.get(key) ;
			var b /*Boolean*/ = c.remove(value) ;
			return this._internalSet.remove(value) ;
		}
		else 
		{
			key = arguments[0] ;
			var s /*Set*/ = this._map.get(key) ;
			if (s) 
			{
				var it /*Iterator*/ = s.iterator() ;
				while(it.hasNext()) 
				{
					this._internalSet.remove(it.next()) ;
				}
				this._map.remove(key) ;
				return true ;
			} 
			else 
			{
				return false ;	
			}
		}
	}

	/**
	 * Returns an array containing the combination of values from all keys.
	 * @return an array containing the combination of values from all keys.
	 */
	proto.toArray = function() /*Array*/ 
	{
		return this.getValues() ;
	}
	
	delete proto ;
	
}
