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

/**	TreeMap

	!!!! EN CONSTRUCTION !!!!

	Name : TreeMap
	Package : vegas.data.map
	Version : 1.0.0.0
	Date :  2005-11-13
	Author : ekameleon
	URL : http://www.ekameleon.net
	Mail : vegas@ekameleon.net

	!!!! EN CONSTRUCTION !!!!
	
	IMPLEMENTS
	
		ICloneable, Iterable, SortedMap, IFormattable

**/

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IComparator;
import vegas.data.Entry;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.SortedMap;
import vegas.errors.NoSuchElementError;

class vegas.data.map.TreeMap extends CoreObject implements SortedMap, ICloneable, Iterable {

	// ----o Construtor
	
	public function TreeMap ( comp:IComparator , map) {
		_comparator = comp ;
		if (map instanceof SortedMap) {
			_comparator = map.comparator ;
			//
		} else if (map instanceof Map) {
			putAll(map) ;
		}
	}
	
	// ----o Public Methods	

	public function clear():Void {
		_modCount++ ;
        _size = 0 ;
        _root = null ;
	}
	
	public function comparator():IComparator {
		return _comparator ;
	}
	
	public function containsKey( key ):Boolean {
		return _getEntry(key) != null ;
	}
	
	public function containsValue( value ):Boolean {
		return 
			_rootEntry == null 
			? false 
			: value == null ? _valueSearchNull(_rootEntry) : _valueSearchNonNull(_rootEntry, value) ;
	}

	public function firstKey() {
		return _key(firstEntry()) ;
	}
	
	public function get(key) {

	}
	
	public function getKeys():Array {
		
	}
	
	public function getValues():Array {
		
	}

	public function heapMap(toKey):SortedMap {
		
	}
	
	public function isEmpty():Boolean {
		
	}
	
	public function iterator():Iterator {
		
	}

	public function keyIterator():Iterator {
		
	}

	public function lastKey() {
		return _key(lastEntry()) ;
	}
	
	public function put(key, value) {
		
	}
	
	public function putAll(m:Map):Void {
		
	}

	public function remove(key) {
		
	}
	
	public function size():Number {
		return _size ;
	}

	public function subMap(fromKey, toKey):SortedMap {
		
	}
	
	public function tailMap(fromKey):SortedMap {
		
	}

	public function toString():String {
		
	}
	
	// ----o Private Properties
	
	private var _comparator:IComparator ;
	private var _modCount:Number = 0 ;
	private var _rootEntry:Entry = null ;
	private var _size:Number = 0 ;
	
	// ----o Private Methods
	
	private function decrementSize():Void {
		_modCount ++ ;
		_size -- ;
	}
	
	private function _getEntry(key):Entry {
        var p:Entry = _rootEntry ;
		var k = key ;
        while (p != null) {
            var cmp:Number = compare(k, p.key) ;
            if (cmp == 0) return p ;
            else if (cmp < 0) p = p.left ;
            else p = p.right ;
        }
        return null ;
    }
	
	private function incrementSize():Void {
		_modCount ++ ;
		_size ++ ;
	}
	
	private function _key(e:Entry) {
        if (e==null) throw new NoSuchElementError() ;
        return e.key ;
    }
	
	private function _valueSearchNull(n:Entry):Boolean {
        if (n.getValue() == null) return true ;
        return (n.left  != null && _valueSearchNull(n.left)) ||
               (n.right != null && _valueSearchNull(n.right)) ;
    }

    private function _valueSearchNonNull(n:Entry, value):Boolean {
        if (value == n.getValue()) return true ;
        return  (n.left  != null && valueSearchNonNull(n.left, value)) ||
				(n.right != null && _valueSearchNonNull(n.right, value));
    }
	
	
}