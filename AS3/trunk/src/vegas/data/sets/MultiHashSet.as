package vegas.data.sets
{
	
	import vegas.data.Collection ;
	import vegas.data.iterator.Iterator ;
	import vegas.data.Map;
	import vegas.data.map.MultiHashMap;
	import vegas.data.Set;
	import vegas.data.sets.HashSet ;

	import vegas.errors.UnsupportedOperation ;

	import vegas.util.Copier ;

	public class MultiHashSet extends MultiHashMap implements Set
	{
		
		// ----o Constructor
		
		public function MultiHashSet(m:Map=null)
		{
			super(m) ;
			_internalSet = new HashSet() ;
		}
		
		// ----o Public Methods

		override public function clear():void
		{
			super.clear() ;
			_internalSet.clear() ;
		}
		

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
		
		
		public function contains(o:*):Boolean
		{
			
			var value:* = o ;
			
			var it:Iterator = __map.iterator() ;
			
			while (it.hasNext()) 
			{
				var cur:* = it.next() ;
				if (cur == null) continue ;
				if (cur.contains(value)) 
				{
					return true;
				}
			}
			return false ;
		}
		
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
			while (kItr.hasNext()) {
				var key:* = Copier.copy(kItr.next()) ;
				var value:* = Copier.copy(vItr.next()) ;
				m.putCollection(key, value) ;
			}
			return m ;
		}

		/**
		 * Creates a new instance of the map value Collection(Set) container.
		 * This method can be overridden to use your own collection type.
		 */
		override public function createCollection():Collection {
			return new HashSet() ;	
		}

		override public function get(key:*):*
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the get() method, use getSet().") ;
			return null ;
		}

		public function getSet( key:* ):Set 
		{
			return super.get(key) ;
		}

		public function indexOf(o:*, fromIndex:uint=0):int
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the indexOf() method.") ;
			return 0;
		}
		
		/**
		 * Not Supported operation with MultiHashSet
		 * @param o:*
		 * @return Boolean
		 * @throw UnsupportedOperation
		 */		
		public function insert(o:*):Boolean
		{
			throw new UnsupportedOperation("This MultiHashSet does not support the insert() method.") ;
			return null ;
		}

		/**
		 * Adds the value to the Set associated with the specified key.
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
		 * Removes a specific value from all the map.
		 */
		override public function removeByKey( key:*=null, value:*=null ):*
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
		
		public function toArray():Array
		{
			return getValues() ;
		}

		// ----o Private Properties
		
		private var _internalSet:HashSet ;

	}
}