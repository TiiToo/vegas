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

/**  AbstractSet

	AUTHOR
	
		Name : AbstractSet
		Package : vegas.data.set
		Version : 1.0.0.0
		Date : 2005-04-17
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR

		private constructor

	METHOD SUMMARY
	
		- clear()
		
		- contains(o)
		
		- containsAll(c:Collection)
		
		- get(id)
		
		- indexOf(o)
		
		- insert(o)
		
		- insertAll(c:Collection)
		
		- isEmpty()
		
		- iterator()
		
		- remove()
		
		- removeAll(c:Collection)
		
		- retainAll(c:Collection)
		
		- size():Number
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String
		
	INHERIT
		
		CoreObject → AbstractCollection → AbstractSet
	
	IMPLEMENTS 
	
		Set, Collection, ISerializable, IFormattable, IHashable
	
**/

import vegas.data.Collection;
import vegas.data.collections.AbstractCollection;
import vegas.data.iterator.Iterator;
import vegas.data.Set;

class vegas.data.set.AbstractSet extends AbstractCollection implements Set {

	// ----o Constructor

	private function AbstractSet(ar) {
		super(ar);
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
		if (o == this) return true ;
		if ( ! (o instanceof Set) ) {
			return false ;
		}
		var c:Collection = Collection(o) ;
		if (c.size() != size()) return false ;
		return this.containsAll(c) ;
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
	
	public function removeAll(c:Collection):Boolean {
		var b:Boolean = false ;
		if (size() > c.size()) {
			var it:Iterator = c.iterator() ;
			while (it.hasNext()) {
				b = remove(it.next()) ;
			}
		} else {
			var it:Iterator = iterator() ;
			while (it.hasNext()) {
				if (c.contains(it.next())) {
					it.remove() ;
					b = true ;
				}
			}
			
		}
		return b ;
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
}