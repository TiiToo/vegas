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

/*	MultiHashMap

	AUTHOR

		Name : MultiHashMap
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2006-07-11
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
	
		CoreObject → MultiHashMap
	
	IMPLEMENTS
	
		ICloneable, ICopyable, IFormattable, IHashable, ISerializable, Iterable, Map, MultiMap

	EXAMPLE
	
		import vegas.data.map.HashMap;
		import vegas.data.map.MultiHashMap;
		import vegas.data.iterator.Iterator;
		
		var hash:HashMap = new vegas.data.map.HashMap() ;
		hash.put("key1", "valueD1") ;
		hash.put("key2", "valueD2") ;
		hash.put("key3", "valueD3") ;

		trace ("--- user map argument in constructor") ;
		var map:MultiHashMap = new vegas.data.map.MultiHashMap(hash) ;
		
		map.put("key1", "valueA1") ;
		map.put("key1", "valueA2") ;
		map.put("key1", "valueA3") ;
		map.put("key2", "valueB1") ;
		map.put("key2", "valueB2") ;
		map.put("key3", "valueC1") ;
		map.put("key3", "valueC2") ;
		
		trace("> map toString : " + map) ;
		trace("> map toSource : " + map.toSource()) ;
		
		trace(" ") ;
		
		trace ("> key1 : " + map.get("key1")) ;
		trace ("> key2 : " + map.get("key2")) ;
		trace ("> key3 : " + map.get("key3")) ;
				
		trace ("\r--- different size") ;
		
		trace ("> map size : " + map.size()) ;
		trace ("> map totalSize : " + map.totalSize()) ;
		
		trace( "\r--- removeByKey 'key' : 'valueA2' " ) ;
		trace ("> remove in 'key1' the value 'valueA2' : " + map.removeByKey("key1", "valueA2")) ;
		trace ("> map totalSize : " + map.totalSize()) ;
		
		trace ("\r--- remove a value in key1 >> " + map.get("key1")) ;
		
		trace ("\r--- use a key iterator : key1") ;
		var it:Iterator = map.iteratorByKey("key1") ;
		while(it.hasNext()) {
			trace ("\t :: " + it.next()) ;
		}
			
		trace ("\r--- putCollection key2 in key1") ;
		map.putCollection("key1", map.get("key2")) ;
		trace ("key1 >> " + map.get("key1")) ;
			
		trace ("\r--- clone MultiMap") ;
		var clone:MultiHashMap = map.clone() ;
		clone.remove("key1") ;
				
		trace ("map size : " + map.totalSize()) ;
		trace ("clone size : " + clone.totalSize()) ;

*/

// TODO Finir !!!! + Test

package vegas.data.map
{
	
	import vegas.core.CoreObject;
	import vegas.data.Collection;
	import vegas.data.Map;
	import vegas.data.MultiMap;
	import vegas.data.collections.SimpleCollection;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.util.Copier;
	import vegas.util.Serializer;

	public class MultiHashMap extends CoreObject implements MultiMap
	{
		
		// ----o Constructor
		
		public function MultiHashMap( m:Map=null )
		{

			_map = new HashMap ;
			if (m == null) return ;
			if (m.size() > 0) 
			{
				var m:Map = m.copy() ;
				putAll(m) ;
			}
			
		}
		
		// ----o Public Methods

		/**
		 * This clears each collection in the map, and so may be slow.
		 */
		public function clear():void 
		{
			_map.clear() ;
		}

		/**
		 * Clones the map.
		 */
		public function clone():* 
		{
			var m:MultiHashMap = new MultiHashMap() ;
			var vItr:Iterator = valueIterator() ;
			var kItr:Iterator = keyIterator() ;
			while (kItr.hasNext()) {
				var key:* = kItr.next() ;
				var value:* = vItr.next() ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Checks whether the map contains the key specified.
		 */
		public function containsKey( key:* ):Boolean 
		{
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
		public function containsValue( value:* ):Boolean 
		{
			var len:uint = arguments.length ;
			if (len == 1) {
				var value:* = arguments[0] ;
				var it:Iterator = _map.iterator() ;
				while (it.hasNext()) {
					var cur:* = it.next() ;
					if (cur.contains(value)) return true;
				}
			} else if (len == 2) {
				return ( get(arguments[0] ).contains(arguments[1]) == true);
			}
			return false ;
		}

		/**
		 * Copy the map.
		 */
		public function copy():* {
			var m:MultiHashMap = new MultiHashMap() ;
			var vItr:Iterator = valueIterator() ;
			var kItr:Iterator = keyIterator() ;
			while (kItr.hasNext()) {
				var key:* = Copier.copy(kItr.next()) ;
				var value:* = Copier.copy(vItr.next()) ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Creates a new instance of the map value Collection container.
		 * This method can be overridden to use your own collection type.
		 */
		public function createCollection():Collection {
			return new SimpleCollection() ;	
		}

		/**
		 * Gets the collection mapped to the specified key. This method is a convenience method to typecast the result of get(key).
		 */
		public function get( key:* ):*
		{
			return _map.get(key) ;
		}

		/**
		 * Checks whether the map contains the key specified .
		 */
		public function getKeys():Array 
		{
			return _map.getKeys() ;
		}
	
		/**
		 * This returns an array containing the combination of values from all keys.
		 */
		public function getValues():Array 
		{
			var result:Array = [] ;
			var values:* = this._map.getValues() ;
			var l:uint = values.length ;
			for (var i:uint = 0 ; i<l ; i++) 
			{
				result = result.concat( values[i].toArray() ) ;
			}
			return result ;
		}

		/**
		 * Returns whether this MultiHashSet contains any mappings.
		 * 
		 * @return {@code true} if this MultiHashSet contains any mappings else {@code false}
		 */
		public function isEmpty():Boolean 
		{
			return _map.isEmpty() ;
		}
	
		/**
		 * Gets an iterator for the MultiHashMap.
		 */
		public function iterator( /*key*/ ):Iterator 
		{
			return _map.iterator() ;
		}

		/**
		 * Gets an iterator for the collection mapped to the specified key.
		 */
		public function iteratorByKey( key:* ):Iterator
		{
			return _map.get(key).iterator() ;
		}

		/**
		 * Gets an iterator for the map to iterate keys.
		 */
		public function keyIterator():Iterator 
		{
			return _map.keyIterator() ;
		}		
	
		/**
		 * Adds the value to the collection associated with the specified key.
		 */
		public function put(key:*, value:*):*
		{
			if (!containsKey(key)) 
			{
				_map.put( key , createCollection() ) ;
			}
			var co:Collection = _map.get(key) ;
			var b:Boolean = co.insert( value ) ;
			return b ? value : null ;
		}	

		/**
		 * Override superclass to ensure that MultiMap instances are correctly handled.
		 */
		public function putAll(map:Map):void
		{
			var it:Iterator = map.iterator() ;
			while (it.hasNext()) 
			{
				var value:* = it.next() ;
				var key:* = it.key() ;
				if (value is Collection) 
				{
					putCollection(key, value) ;
				}
				else 
				{
					put(key, value) ;
				}
			}
		}

		/**
		 * Adds a collection of values to the collection associated with the specified key.
		 */
	    public function putCollection(key:*, c:Collection):void 
	    {
	    	if (!containsKey(key)) 
	    	{
				_map.put(key , createCollection()) ;
			}
			_map.get(key).insertAll(c) ;
	    }
	    
		/**
		 * Removes a specific value from map with a specific key.
		 */
		public function remove(key:*):*
		{
			return _map.remove(key) ;
		}
		   
		/**
		 * Removes a specific value from all the map.
		 */
		public function removeByKey( key:*=null, value:*=null ):*
		{
			
			if (key != null && value != null) 
			{
				
				var c:* = _map.get(key) ;
				var b:Boolean = c.remove(value) ;
				return (b) ? value : null ;
				
			}
			return null ;
			
		}

		/**
		 * Gets the size of the collection mapped to the specified key.
		 */
		public function size():uint
		{
			return _map.size() ;
		}

		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [_map]) ;
		}
	
		override public function toString():String 
		{
			return (new MultiMapFormat()).formatToString(this) ;
		}

    	public function totalSize():uint 
    	{
    		var result:uint = 0 ;
			var it:Iterator = _map.iterator() ;
			while (it.hasNext()) 
			{
				var co:Collection = it.next() ;
				var s:Number = co.size() ;
				result += isNaN(s) ? 0 : s ;
			}
			return result ;
    	}
	
    	public function values():Collection 
    	{
			var ar:Array = getValues() ;
			return new SimpleCollection(ar) ;
    	}
	
	    public function valueIterator():Iterator 
	    {
	    	return new ArrayIterator(_map.getValues()) ;
	    }

		// ----o Private Properties
			
		private var _map:HashMap ;

	}
}