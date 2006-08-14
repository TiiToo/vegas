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

/* AbstractBag

	AUTHOR
	
		Name : AbstractBag
		Package : vegas.data.bag
		Version : 1.0.0.0
		Date :  2005-11-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():*
		
		- contains(o:*):Boolean
		
		+ containsAll(c:Collection):Boolean
		
			(Violation)  Returns true if the bag contains all elements in the given collection, respecting cardinality.
		
		+ containsAllInBag(b:Bag):Boolean
		
		- hashCode():Number
		
		+ insertAll(c:Collection):Boolean 
		
		+ insertCopies(o, i:Number):Boolean 
			
			Add i copies of the given object to the bag and keep a count.
			
		+ getCount(o:*):uint
		
			Return the number of occurrences (cardinality) of the given object currently in the bag.
		
		- get(key:*):*
		
			throw UnsupportedOperation
		
		- insert(o:*):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o:*):*
		
		+ removeAll(c:Collection):Boolean
		
			(Violation)  Remove all elements represented in the given collection, respecting cardinality.
		
		+ removeCopies(o:*, i:uint):Boolean
		
			Remove the given number of occurrences from the bag.
		
		+ retainAll(c:Collection):Boolean
		
			(Violation)  Remove any members of the bag that are not in the given collection, respecting cardinality.
		
		+ retainAllInBag(b:Bag):Boolean
		
		- size():uint

		- toArray():Array
		
		- toSource():String
		
		- toString():String
		
		+ uniqueSet():Set
		
			The Set of unique members that represent all members in the bag.

 	INHERIT
	
		CoreObject → AbstractBag

	IMPLEMENTS
	
		Bag, Collection, ICloneable, ICopyable, IFormattable, ISerialzable, Iterable

*/

package vegas.data.bag
{

	import vegas.core.CoreObject ;	

	import vegas.data.Bag;
	import vegas.data.bag.BagFormat ;
	import vegas.data.bag.HashBag ;
	import vegas.data.Collection;
	import vegas.data.iterator.BagIterator;
	import vegas.data.iterator.Iterator;
	import vegas.data.List ;
	import vegas.data.list.ArrayList ;
	import vegas.data.Map ;
	import vegas.data.map.MapUtil ;
	import vegas.data.Set ;
	import vegas.data.sets.HashSet ;

	import vegas.errors.IllegalArgumentError;
	import vegas.errors.UnsupportedOperation;
	
	import vegas.util.Serializer;	

	public class AbstractBag extends CoreObject implements Bag
	{
		
		// ----o Constructor
		
		public function AbstractBag( m:Map )
		{
			if (m != null) _setMap(m) ;
		}
		
		// ----o Public Methods
     
		public function clear():void 
		{
			_mods ++ ;
			_map.clear() ;
			_total = 0 ;
		}
	 
		public function clone():*
		{
			return null ;
		}
     
		public function copy():*
		{
			return null ;
		}
	 
		public function contains(o:*):Boolean 
		{
			return _map.containsKey(o);
		}
     
	 
	    public function containsAll(c:Collection):Boolean 
	    {
	    	return containsAllInBag(new HashBag(c)) ;
	    }
     
		public function containsAllInBag(b:Bag):Boolean 
		{
			var result:Boolean = true ;
			var i:Iterator = b.uniqueSet().iterator() ;
	        while (i.hasNext()) {
				var current:* = i.next();
	            var contains:Boolean = getCount(current) >= b.getCount(current) ;
	            result = result && contains ;
	        }
	        return result;
		}
	
		public function get(key:*):*
		{
			throw new UnsupportedOperation(this + " 'get' method is unsupported.") ;
		}

		public function getCount(o:*):uint
		{
        	var result:uint = 0;
	        var count:uint = MapUtil.getNumber(_map, o);
	        if (! isNaN(count))
	        {
	            result = count ;
	        }
	        return result;
		}

		public function getModCount():uint
		{
			return _mods ;
		}

		public function indexOf(o:*, fromIndex:uint=0):int
		{
			throw new UnsupportedOperation(this + " 'indexOf' method is unsupported.") ;
		}

		public function insert(o:*):Boolean 
		{
		
			return insertCopies(o, 1) ;
		}
			
    	public function insertAll(c:Collection):Boolean 
    	{
    		var changed:Boolean = false;
	        var i:Iterator = c.iterator() ;
			var added:Boolean ;
	        while (i.hasNext()) {
				added = insert(i.next());
	            changed = changed || added ;
	        }
	        return changed;
    	}

    	public function insertCopies(o:*, nCopies:uint):Boolean 
    	{
    		_mods++ ;
	        if (nCopies > 0) 
	        {
    	        var count:uint = nCopies + getCount(o) ;
	            _map.put(o, count);
	            _total += nCopies;
	            return count == nCopies ;
	        }
	        else 
	        {
	            return false;
	        }
    	}

		public function isEmpty():Boolean 
		{
			return _map.isEmpty() ;
    	}
	
		public function iterator():Iterator 
		{
			return new BagIterator(this, _extractList().iterator()) ;
		}

		public function remove(o:*):* 
		{
			return removeCopies(o, getCount(o));
		}

    	public function removeAll(c:Collection):Boolean 
    	{
        	var result:Boolean = false ;
	        if (c != null) {
	            var i:Iterator = c.iterator() ;
    	        while (i.hasNext()) 
    	        {
					var next:* = i.next() ;
	                var changed:Boolean = removeCopies(next, 1) ;
	                result = result || changed ;
	            }
	        }
    	    return result ;
    	}

    	public function removeCopies(o:*, nCopies:uint):Boolean 
    	{
			_mods++;
	        var result:Boolean = false;
	        var count:uint = getCount(o) ;
	        if (nCopies <= 0) result = false;
	        else if (count > nCopies) 
	        {
	            _map.put( o, new int(count - nCopies)) ;
	            result = true ;
	            _total -= nCopies ;
	        }
	        else
	        { // count > 0 && count <= i  
	            result = (_map.remove(o) != null) ; // need to remove all
	            _total -= count ;
	        }
    	    return result;
    	} 

    	public function retainAll(c:Collection):Boolean 
    	{
    		return retainAllInBag(new HashBag(c));
    	}

		public function retainAllInBag(b:Bag):Boolean 
		{
	    	var result:Boolean = false ;
	        var excess:Bag = new HashBag() ;
	        var i:Iterator = uniqueSet().iterator() ;
	        while (i.hasNext()) 
	        {
	            var cur:* = i.next() ;
	            var count1:uint = getCount(cur) ;
	            var count2:uint = b.getCount(cur) ;
	            if ( 1 <= count2 && count2 <= count1) 
	            {
	                excess.insertCopies(cur, count1 - count2) ;
	            }
	            else 
	            {
	                excess.insertCopies(cur, count1) ;
	            }
	        }
	        if (!excess.isEmpty()) 
	        {
	        	result = removeAll(excess) ;
	        }
	        return result;
	    }
	
		public function size():uint
		{
			return _total ;
		}
	
	
		public function toArray():Array 
		{
			return _extractList().toArray();
		}

		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [_map]) ;
		}
	
		override public function toString():String 
		{
			return (new BagFormat()).formatToString(this) ;
		}
		
    	public function uniqueSet():Set 
    	{
    		return new HashSet(_map.getKeys()) ;
    	}

		// ----o Protected Methods

		protected function _calcTotalSize():uint
		{
    	    _total = _extractList().size() ;
	        return _total ;
	    }

		protected function _extractList():List 
		{
        	var result:List = new ArrayList() ;
	        var i:Iterator  = uniqueSet().iterator();
	        while (i.hasNext()) 
	        {
	            var current:* = i.next() ;
				var l:uint = getCount(current) ;
	            while (--l > -1) 
	            {
	            	result.insert(current);
	            }
	        }
	        return result ;
	    }
	
		protected function _getMap():Map 
		{
			return _map ;
		}
	
		protected function _setMap(m:Map):void
		{
			if (m == null || m.isEmpty() == false) 
			{
	            throw new IllegalArgumentError(this + ", the map must be non-null and empty.") ;
	        }
	        _map = m ;
		}
		// ----o Private Properties

		private var _map:Map = null ;	
		private var _mods:uint = 0 ;
		private var _total:uint = 0 ;

	}
}