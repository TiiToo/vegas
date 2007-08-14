package vegas.data.sets
{
	import vegas.data.Collection;
	import vegas.data.Map;
	import vegas.data.Set;
	import vegas.data.iterator.Iterator;
	import vegas.data.map.MultiHashMap;
	import vegas.data.sets.HashSet;
	import vegas.errors.UnsupportedOperation;
	import vegas.util.Copier;
	
	/**
	 * The MultiHashSet is a MutliHashMap that contains no duplicate elements in a specified key.
	 * @author eKameleon
	 * @see MultiMap
	 */
	public class MultiHashSet extends MultiHashMap implements Set
	{
		
		/**
		 * Creates a new MultiHashSet instance.
		 */
	 	public function MultiHashSet(m:Map=null)
		{
			super(m) ;
			_internalSet = new HashSet() ;
		}
		
		/**
	 	 * This clears each collection in the map, and so may be slow.
		 */
		override public function clear():void
		{
			super.clear() ;
			_internalSet.clear() ;
		}
		
		/**
		 * Returns the shallow copy of this object.
		 * @return the shallow copy of this object.
		 */
		override public function clone():*
		{
			var m:MultiHashSet = new MultiHashSet() ;
			var kItr:Iterator = keyIterator() ;
			var vItr:Iterator = valueIterator() ;
			while (kItr.hasNext()) {
				var key:* = kItr.next() ;
				var value:* = vItr.next() ;
				m.putCollection(key, value) ;
			}
			return m ;
		}
		
		/**
		 * Checks whether the map contains the value specified .
		 * @param o the object to search in this instance.
		 * @return {@code true} if the MultiHashSet container the passed-in object.
		 */
		public function contains(o:*):Boolean
		{
			
			var value:* = o ;
			
			var it:Iterator = __map.iterator() ;
			
			while (it.hasNext()) 
			{
				var cur:Collection = it.next() ;
				if (cur == null) continue ;
				if (cur.contains(value)) 
				{
					return true;
				}
			}
			return false ;
		}
	
		/**
		 * Checks whether the map contains the value specified with the specified key.
		 * @param key the specified key in the MultiHashSet to search the value.
		 * @param value the object to search in this instance.
		 * @return {@code true} if the MultiHashSet container the passed-in object.
	 	 */
		public function containsByKey(key:*, value:*):Boolean
		{
			var s:Set = getSet(key) ;
			if (s == null) 
			{
				return false ;
			}
			else 
			{
				return s.contains( value ) ;
			}
		}

		override public function copy():*
		{
			var m:MultiHashSet = new MultiHashSet() ;
			var vItr:Iterator = valueIterator() ;
			var kItr:Iterator = keyIterator() ;
			while (kItr.hasNext()) 
			{
				var key:*   = Copier.copy(kItr.next()) ;
				var value:* = Copier.copy(vItr.next()) ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Creates a new instance of the map value Collection(Set) container.
		 * This method can be overridden to use your own collection type.
		 */
		override public function createCollection():Collection 
		{
			return new HashSet() ;	
		}

		/**
		 * This method is unsupported, use getSet method.
		 * @throws UnsupportedOperation the MultiHashSet does not support the get() method, use getSet()
		 */
		override public function get(key:*):*
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the get() method, use getSet().") ;
			return null ;
		}

		/**
		 * Returns the Set defined in the map with the specified key.
		 * @param key the key in the map 
		 * @return the Set defined in the map with the specified key.
		 */
		public function getSet( key:* ):Set 
		{
			return super.get(key) ;
		}

		/**
		 * This method always throws an {@code UnsupportedOperation} because this method is not supported by this Set.
		 * @throw UnsupportedOperation the MultiHashSet instance does not support the indexOf() method.
		 */		
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the indexOf() method.") ;
			return 0;
		}
		
		/**
		 * This method always throws an {@code UnsupportedOperation} because this method is not supported by this Set.
		 * @param o an object to insert in the MultiHashSet.
		 * @return nothing (null)
		 * @throw UnsupportedOperation the MultiHashSet instance does not support the insert() method.
		 */		
		public function insert(o:*):Boolean
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the insert() method.") ;
			return null ;
		}

		/**
		 * Adds the value to the Set associated with the specified key.
		 * @return {@code true} if the value is inserted in the object.
		 */
		override public function put(key:*, value:*):*
		{
			if(_internalSet.contains(value)) 
			{
				return false ;
			}
			if (!containsKey(key)) 
			{
				__map.put(key , createCollection()) ;
			}
			var b:Boolean = __map.get(key).insert(value) ;
			return _internalSet.insert(value) ;
		}

		/**
		 * Adds a collection of values to the collection associated with the specified key.
		 */
		override public function putCollection(key:*, c:Collection):void {
			if (!containsKey(key)) 
			{
				__map.put(key , createCollection()) ;
			}
			var s:HashSet = __map.get(key) ;
			var it:Iterator = c.iterator() ;
			var value:* ;
			while(it.hasNext()) 
			{
				value = it.next() ;
				if (_internalSet.insert(value)) 
				{
					s.insert(value) ;
				}	
			}
		}

		/**
		 * Removes a specific value from map with a specific key.
		 */
		override public function remove(o:*):*
		{
			var s:Set = __map.get(o) ;
			if (s != null) 
			{
				var it:Iterator = s.iterator() ;
				while(it.hasNext()) 
				{
					_internalSet.remove(it.next()) ;
				}
				__map.remove(o) ;
				return true ;
			}
			else 
			{
				return false ;	
			}
		}
		   
		/**
		 * Removes a specific value from map with the specific passed-in key value.
		 * <p><b>Note :</b> Use Set implementation and not Map implementation !</p>
		 */
		override public function removeByKey( key:*, value:* ):*
		{
			
			var c:Collection = __map.get(key) ;
			if (c == null) return null ;
			if (c.remove(value))
			{
				return _internalSet.remove(value) ;
			}
			else 
			{
				return null ;
			}
			
		}

		/**
		 * Returns an array containing the combination of values from all keys.
	 	 * @return an array containing the combination of values from all keys.
		 */
		public function toArray():Array
		{
			return getValues() ;
		}

		private var _internalSet:HashSet ;

	}
}