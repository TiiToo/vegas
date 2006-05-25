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

/** AbstractList

	AUTHOR

		Name : AbstractList
		Package : vegas.data.list
		Version : 1.0.0.0
		Date : 2005-04-17
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS

		- indexOf(o)
		
		- insertAt(id, o)
		
		- insertAllAt (id, c:Collection)
		
		- lastIndexOf(o) 
		
		- listIterator()
		
		- removeAt(id)
		
		- removesAt(id, len)
		
		- removeRange(from, to) : Removes from this List all of the elements whose index is between fromIndex, inclusive and toIndex, exclusive.
		
		- setAt(id, o)
		
		- subList(from, to) : return a list
	
	
	INHERIT 

		CoreObject > AbstractCollection > AbstractList


	METHODS
	
		- clear()
		
		- contains(o)
		
		- containsAll(c:Collection)
		
		- get(id)
		
		- insert(o)
		
		- insertAll(c:Collection)
		
		- isEmpty()
		
		- iterator()
		
		- remove()
		
		- removeAll(c:Collection)
		
		- retainAll(c:Collection)
		
		- size()
		
		- toArray()
		
		- toString()

	INHERIT 

		CoreObject → AbstractCollection → AbstractList
		
**/

// TODO BUG :: problème avec héritage direct de la classe SimpleCollection !  
// Pour le moment j'ai changé l'héritage en ciblant directement AbstractCollection...

import vegas.data.Collection;
import vegas.data.collections.AbstractCollection;
import vegas.data.iterator.Iterator;
import vegas.data.List;
import vegas.data.list.ListIterator;
import vegas.data.list.ListItr;
import vegas.errors.IndexOutOfBoundsError;

class vegas.data.list.AbstractList extends AbstractCollection implements List {
	
	// ----o Constructor

	public function AbstractList(ar:Array) {
		super(ar) ;
	}

	// ----o Public Methods
	
	public function containsAll(c:Collection):Boolean {
		var it:Iterator = c.iterator() ;
		while(it.hasNext()) {
			if ( ! contains(it.next()) ) return false ;
		}
		return true ;
	}

	public function equals(o):Boolean {
		return false ;
	}

	public function getModCount():Number {
		return _modCount ;
	}
	
	public function insertAt(id:Number, o):Void {
		if (id<0 || id>size()) throw new IndexOutOfBoundsError() ;
		_a.splice(id, 0, o) ;
	}
	
	public function insertAll(c:Collection):Boolean {
		if (c.size() > 0) {
			var it:Iterator = c.iterator() ;
			while(it.hasNext()) insert(it.next()) ;
			return true ;
		} else {
			return false ;
		}
	}
	
	public function insertAllAt(id:Number, c:Collection):Boolean {
		if (id <0 || id > size()) return false ;
		var aC:Array = c.toArray() ;
		var aB = _a.slice(0, id) ;
		var aE = _a.slice(id) ;
		_a = aB.concat(aC, aE) ;
		return true ;
	}
		
	public function lastIndexOf(o):Number {
		var l:Number = _a.length ;
		while (--l > -1) if (_a[l] == o) return l ;
		return -1 ;
	}

	public function listIterator():ListIterator { 
		var li:ListIterator = new ListItr(this) ;
		var n:Number = arguments[0] ;
		if (typeof (n) == "number") li.seek(n) ;
		return li ;
	}

	public function removeAll(c:Collection):Boolean {
		var b:Boolean = false ;
		var it:Iterator = iterator() ;
		while (it.hasNext()) {
			if ( c.contains(it.next()) ) {
				it.remove() ;
				b = true ;
			}
		}
		return b ;
	}
	
	public function removeAt(id:Number) {
		return removesAt(id, 1) ;
	}

	public function removesAt(id:Number, len:Number) {
		var d:Number = len - id ;
		var old = _a.slice(id, d) ;
		_a.splice(id, len);
		return old ; 
	}
	
	public function removeRange(from:Number , to:Number):Void {
		if (from == undefined) return ;
		var it:ListIterator = listIterator(from) ;
		var l:Number = to - from ;
		for (var i:Number = 0 ; i<l ; i++) {
			it.next() ; 
			it.remove() ;
		}
	}

	public function retainAll(c:Collection):Boolean {
		var b:Boolean = false ;
		var it:Iterator = iterator() ;
		while(it.hasNext()) {
			if ( ! c.contains(it.next()) ) {
				it.remove() ;
				b = true ;
			}
		}
		return b ;
	}

	public function setAt(id:Number, o):Void {
		if (_a[id] == undefined) return ;
		_a[id] = o ;
	}

	public function setModCount(n:Number):Void {
		_modCount = n ;
	}
	
	public function subList(begin:Number, end:Number):List {
		var l:List = new AbstractList() ;
		var it:ListIterator = listIterator() ;
		var d:Number = (end - begin) + 1 ; 
		for (var i:Number = begin ; i<= d ; i++) {
			l.insert(it.next()) ;
		}
		return l ;
	}

	// ----o Private Properties
	
	private var _modCount:Number = 0 ;
	
}