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

/** ArrayList

	AUTHOR

		Name : ArrayList
		Package : vegas.data.list
		Version : 1.0.0.0
		Date : 2005-04-27
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- clear()
		
		- clone()
		
		- contains(o)
		
		- containsAll(c:Collection)
		
		- ensureCapacity(n:Number)
		
		- get(id)
		
		- indexOf(o)
		
		- insert(o)
		
		- insertAll(c:Collection)
		
		- insertAllAt (id, c:Collection)
		
		- insertAt(id, o)
		
		- isEmpty():Boolean
	
		- iterator():Iterator
		
		- lastIndexOf(o) 
		
		- listIterator()
		
		- remove()
		
		- removeAll(c:Collection)
		
		- removeAt(id)
		
		- removesAt(id, len)
		
		- removeRange(from, to) : Removes from this List all of the elements whose index is between fromIndex, inclusive and toIndex, exclusive.
		
		- retainAll(c:Collection)
		
		- setAt(id, o)
		
		- size():Number
		
		- subList(from, to) : return a list
		
		- toArray():Array
		
		- toSource():String	
		
		- toString():String

	INHERIT 

		CoreObject → AbstractCollection → AbstractList → ArrayList
	

	IMPLEMENTS
	
		ICloneable, Collection, List, ISerializable, IFormattable
	
**/

import vegas.data.Collection;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.data.list.AbstractList;

class vegas.data.list.ArrayList extends AbstractList {
	
	// ----o Constructor

	function ArrayList() {
		var arg = arguments[0] ;
		if (arg instanceof Array) {
			var it:Iterator = new ArrayIterator(arg) ;
			while (it.hasNext()) insert(it.next()) ;
		} else if (arg instanceof Collection) {
			var it:Iterator = arg.iterator() ;
			while (it.hasNext()) insert(it.next()) ;
		} else if (typeof (arg) == "number") {
			_a.length = arg ;
		}
	}

	// ----o Public Methods
	
	public function clone() {
		return new ArrayList(toArray()) ;
	}
	
	public function ensureCapacity(n:Number):Void {
		_a.length = n ;
	}
	
	
}