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

/* ------- AbstractBag

	AUTHOR
	
		Name : AbstractBag
		Package : vegas.data.bag
		Version : 1.0.0.0
		Date :  2005-11-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS
	
		- clear()
		
		- contains(o)
		
		+ containsAll(c:Collection):Boolean
		
			(Violation)  Returns true if the bag contains all elements in the given collection, respecting cardinality.
		
		+ containsAllInBag(b:Bag)
		
		- hashCode():Number
		
		+ insertAll(c:Collection):Boolean 
		
		+ insertCopies(o, i:Number):Boolean 
			
			Add i copies of the given object to the bag and keep a count.
			
		+ getCount(o):Number 
		
			Return the number of occurrences (cardinality) of the given object currently in the bag.
		
		- get(id:Number)
		
			throw UnsupportedOperation
		
		- insert(o):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		+ removeAll(c:Collection):Boolean
		
			(Violation)  Remove all elements represented in the given collection, respecting cardinality.
		
		+ removeCopies(o, i:Number):Boolean
		
			Remove the given number of occurrences from the bag.
		
		+ retainAll(c:Collection):Boolean
		
			(Violation)  Remove any members of the bag that are not in the given collection, respecting cardinality.
		
		+ retainAllInBag(b:Bag):Boolean
		
		- size():Number

		- toArray():Array
		
		- toSource():String
		
		- toString():String
		
		+ uniqueSet():Set
		
			The Set of unique members that represent all members in the bag.

	IMPLEMENTS
	
		Bag, Collection

	TODO TypedBag

----------  */

import vegas.core.CoreObject;
import vegas.core.types.Int;
import vegas.data.Bag;
import vegas.data.bag.BagFormat;
import vegas.data.bag.BagIterator;
import vegas.data.bag.HashBag;
import vegas.data.Collection;
import vegas.data.iterator.Iterator;
import vegas.data.List;
import vegas.data.list.ArrayList;
import vegas.data.Map;
import vegas.data.map.MapUtil;
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.errors.IllegalArgumentError;
import vegas.errors.UnsupportedOperation;
import vegas.util.serialize.Serializer;

class vegas.data.bag.AbstractBag extends CoreObject implements Bag {

	// ----o Constructor

	private function AbstractBag( m:Map ) {
		if (m) _setMap(m) ;
	}
	
	// ----o Public Methods

	public function clear():Void {
		_mods ++ ;
		_map.clear() ;
		_total = 0 ;
	}

	public function clone() {
		return new AbstractBag(_map.clone()) ;
	}

	public function contains(o):Boolean {
		return _map.containsKey(o);
	}

	public function containsAll(c:Collection):Boolean {
		return containsAllInBag(new HashBag(c)) ;
	}
	
	public function containsAllInBag(b:Bag):Boolean {
		var result:Boolean = true ;
		var i:Iterator = b.uniqueSet().iterator() ;
        while (i.hasNext()) {
			var current = i.next();
            var contains:Boolean = getCount(current) >= b.getCount(current) ;
            result = result && contains ;
        }
        return result;
	}
	
	public function get(id:Number) {
		throw new UnsupportedOperation ;
	}

	public function getCount(o):Number {
        var result:Number = 0;
        var count:Number = MapUtil.getNumber(_map, o);
        if (count != null) {
            result = count ;
        }
        return result;
	}

	public function getModCount():Number {
		return _mods ;
	}
	
	public function insert(o):Boolean {
		
		return insertCopies(o, 1) ;
		
	}
	
	public function insertAll(c:Collection):Boolean {
		var changed:Boolean = false;
        var i:Iterator = c.iterator() ;
		var added:Boolean ;
        while (i.hasNext()) {
			added = insert(i.next());
            changed = changed || added ;
        }
        return changed;
	}

	public function insertCopies(o, nCopies:Number):Boolean {
		_mods++ ;
        if (nCopies > 0) {
            var count:Number = nCopies + getCount(o) ;
            _map.put(o, new Int(count));
            _total += nCopies;
            return count == nCopies ;
        } else {
            return false;
        }
	}
	
	public function isEmpty():Boolean {
		return _map.isEmpty() ;
    }
	
	public function iterator():Iterator {
		return new BagIterator(this, _extractList().iterator()) ;
	}


	public function remove(o):Boolean {
		return removeCopies(o, getCount(o));
	}
	
	public function removeAll(c:Collection):Boolean {
        var result:Boolean = false ;
        if (c != null) {
            var i:Iterator = c.iterator() ;
            while (i.hasNext()) {
				var next = i.next() ;
                var changed:Boolean = removeCopies(next, 1) ;
                result = result || changed ;
            }
        }
        return result ;
    }

	public function removeCopies(o, nCopies:Number):Boolean {
		_mods++;
        var result:Boolean = false;
        var count:Number = getCount(o) ;
        if (nCopies <= 0) result = false;
        else if (count > nCopies) {
            _map.put(o, new Int(count - nCopies)) ;
            result = true ;
            _total -= nCopies ;
        } else { // count > 0 && count <= i  
            result = (_map.remove(o) != null) ; // need to remove all
            _total -= count ;
        }
        return result;
	}

	public function retainAll(c:Collection):Boolean {
		return retainAllInBag(new HashBag(c));
	}

	public function retainAllInBag(b:Bag):Boolean {
        var result:Boolean = false ;
        var excess:Bag = new HashBag() ;
        var i:Iterator = uniqueSet().iterator() ;
        while (i.hasNext()) {
            var cur = i.next() ;
            var count1:Number = getCount(cur) ;
            var count2:Number = b.getCount(cur) ;
            if ( 1 <= count2 && count2 <= count1) {
                excess.insertCopies(cur, count1 - count2) ;
            } else {
                excess.insertCopies(cur, count1) ;
            }
        }
        if (!excess.isEmpty()) result = removeAll(excess) ;
        return result;
    }

	public function size():Number {
		return _total ;
	}
	
	
	public function toArray():Array {
		return _extractList().toArray();
	}

	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(_map)]) ;
	}
	
	public function toString():String {
		return (new BagFormat()).formatToString(this) ;
	}

	public function uniqueSet():Set {
		return new HashSet(_map.getKeys()) ;
	}

	// ----o Private Properties

	private var _map:Map = null ;	
	private var _mods:Number = 0 ;
	private var _total:Number = 0 ;
	
	// ----o Private Methods
	
	private function _calcTotalSize():Number {
        _total = _extractList().size() ;
        return _total ;
    }

	private function _extractList():List {
        var result:List = new ArrayList() ;
        var i:Iterator  = uniqueSet().iterator();
        while (i.hasNext()) {
            var current = i.next() ;
			var l:Number = getCount(current) ;
            while (--l > -1) result.insert(current);
        }
        return result ;
    }

	private function _getMap():Map {
		return _map ;
	}
	
	private function _setMap(m:Map):Void {
		if (m == null || m.isEmpty() == false) {
            throw new IllegalArgumentError() ; // "The map must be non-null and empty"
        }
        _map = m ;
	}

}