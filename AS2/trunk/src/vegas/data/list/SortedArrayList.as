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

/* ----------  SortedArrayList

	AUTHOR

		Name : SortedArrayList
		Package : vegas.data.list
		Version : 1.0.0
		Date : 2005-04-27
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new SortedArrayList() ;
	
	PROPERTY SUMMARY
	
		- comparator:IComparator
		
		- options:Number
	
	METHOD SUMMARY

		- clear()
		
		+ clone()
		
		- contains(o)
		
		- containsAll(c:Collection)
		
		- ensureCapacity(n:Number)
		
		- get(id)
		
		+ getIComparator():IComparator
		
		+ getOptions()
		
		- indexOf(o)
		
		- insert(o)
		
		- insertAll(c:Collection)
		
		- insertAt(id, o)
		
		- insertAllAt (id, c:Collection)
		
		- isEmpty()
		
		- iterator()
		
		- lastIndexOf(o) 
		
		- listIterator()
		
		- remove()
		
		- removeAll(c:Collection)
		
		- removeAt(id)
		
		- removesAt(id, len)
		
		- removeRange(from, to) : Removes from this List all of the elements whose index is between fromIndex, inclusive and toIndex, exclusive.
		
		- retainAll(c:Collection)
		
		- setAt(id, o)
		
		+ setIComparator(comp:IComparator):Void
		
		+ setOptions(o):Void
		
		+ sort(compare, options)
		
		+ sortOn(fieldName, options)
		
		- size()
		
		- subList(from, to) : return a list
				
		- toArray():Array
		
		+ toSource():String
		
		- toString():String

	INHERIT 

		AbstractCollection
			|
			SimpleCollection 
				|
				ArrayList 
					|
					AbstractList 
						| 
						AbstractCollection
		
	IMPLEMENTS
	
		ICloneable, Collection, List, ISerializable, IFormattable
	
	TODO : 2005-11-08 add comparator and options R/W properties and auto comparator in insert's methods.
	
	TODO : see equals method !!

	TODO : 2006-01-05 test toSource() method !

----------  */

import vegas.core.IComparator;
import vegas.data.Collection;
import vegas.data.list.ArrayList;
import vegas.util.serialize.Serializer;

class vegas.data.list.SortedArrayList extends ArrayList {
	
	// ----o Constructor

	public function SortedArrayList(o, comp:IComparator, opt:Number) {
		super(o) ;
		setIComparator(comp) ;
		setOptions(opt) ;
	}
	
	// ----o Public Methods
		
	public function clone() {
		return new SortedArrayList(toArray) ;
	}

	public function insert(o):Boolean {
		var b:Boolean = super.insert(o) ;
		_sort() ;
		return b ;
	}	

	public function insertAll(c:Collection):Boolean {
		var b:Boolean = super.insertAll(c) ;
		_sort() ;
		return b ;
	}
	
	public function insertAt(id:Number, o):Void {
		super.insertAt(id, o) ;
		_sort() ;
	}

	public function insertAllAt(id:Number, c:Collection):Boolean {
		var b:Boolean = super.insertAllAt(id, c) ;
		_sort() ;
		return b ;
	}

	public function getIComparator():IComparator {
		return _comparator ;
	}

	public function getOptions() {
		return _options ;
	}
		
	public function setIComparator(comp:IComparator):Void {
		_comparator = comp ;
	}
	
	public function setOptions(o):Void {
		_options = o ;
	}
	
	public function sort( compare , options:Number ):Array  {
		if (typeof(compare) != "function") return null ;
		if (options) _options = options ;
		var compareFunc:Function = (compare instanceof IComparator) ? compare.compare : compare ;
		return _a.sort(compareFunc , _options) ;
	}
	
	public function sortOn( fieldName, options ):Array  {
		if (options) _options = options ;
		return _a.sortOn(fieldName, options) ;
	}
	
	/*override*/ public function toSource(indent:Number, indentor:String):String {
		var sA:String = Serializer.toSource(toArray()) ;
		var sB:String = Serializer.toSource(_comparator) ;
		var sC:String = Serializer.toSource(_options) ;
		return Serializer.getSourceOf(this, [sA, sB, sC] ) ;
	}
	
	// ----o Virtual Properties
	
	public function get comparator():IComparator {
		return getIComparator() ;
	}
	
	public function set comparator(comp:IComparator):Void {
		setIComparator(comp) ;
	}
	
	public function get options() {
		return getOptions() ;
	}
	
	public function set options(o):Void {
		setOptions(o) ;
	}
	
	// ----o Private Properties
	
	private var _comparator:IComparator ;
	private var _options ;
	
	// ----o Private Methods
	
	private function _sort():Void {
		sort( _comparator.compare , _options) ;
	}
	
}