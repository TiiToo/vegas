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

/* AbstractList [Interface]

    AUTHOR

    	Name : AbstractList
    	Package : vegas.data
    	Version : 1.0.0.0
    	Date :  2006-07-08
    	Author : ekameleon
    	URL : http://www.ekameleon.net
    	Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():Void
		
		- clone():*
		
		- containsAll(c:Collection):Boolean
		
		- copy():*
		
		- contains(o:*):Boolean
		
		- containsAll(c:Collection):Boolean
		
		- get(key:*):*
		
		- indexOf(o:*):int
		
		- insert(o:*):Boolean
		
		- insertAll(c:Collection):Boolean
		
		- insertAllAt(id:uint, c:Collection):Boolean
		
		- insertAt(id:uint, o:*):void
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- lastIndexOf(o:*):int
		
		- listIterator():ListIterator
		
		- remove(o):Boolean
		
		- removeAll(c:Collection):Boolean

		- retainAll(c:Collection):Boolean

		- removeAt(id:uint):*
		
		- retainAll(c:Collection):Boolean
		
		- setAt(id:uint, o:*):void
		
		- size():Number
		
		- subList(fromIndex:uint, toIndex:uint):List
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

    INHERIT
    
	    CoreObject → AbstractCollection → SimpleCollection → AbstractList
    
    IMPLEMENTS
    
        Collection, ICloneable, ICopyable, IEquality, IFormattable, ISerialzable, Iterable, List

**/

package vegas.data.list
{
	
	import vegas.data.Collection ;
	import vegas.data.collections.SimpleCollection;
	import vegas.data.iterator.ListIterator;
	import vegas.data.List;
	import vegas.errors.IndexOutOfBoundsError ;
	import vegas.errors.IllegalArgumentError ;

	public class AbstractList extends SimpleCollection implements List
	{
		
		// ----o Constructor
		
		public function AbstractList( ar:Array=null )
		{
			super(ar);
		}
		
		// ----o Public Methods
		
		// TODO implements all equals methods in ADT
		public function equals(o:*):Boolean {
			return false ;
		}

		public function getModCount():Number {
			return _modCount ;
		}
		
		public function insertAllAt(id:uint, c:Collection):Boolean 
		{
			if (id <0 || id > size()) return false ;
			var aC:Array = c.toArray() ;
			var aB:Array = _a.slice(0, id) ;
			var aE:Array = _a.slice(id) ;
			_a = aB.concat(aC, aE) ;
			return true ;
		}
		public function insertAt(id:uint, o:*):void 
		{
			if (id<0 || id>size()) {
				throw new IndexOutOfBoundsError() ;
			}
			_a.splice(id, 0, o) ;
		}

		public function lastIndexOf(o:*):int 
		{
			return _a.lastIndexOf(o) ;
		}
	
		public function listIterator( position:uint=0 ):ListIterator 
		{
			var li:ListIterator = new ListItr(this) ;
			li.seek(position) ;
			return li ;
		}
	
		public function removeAt(id:uint):* 
		{
			return removesAt(id, 1) ;
		}

		public function removeRange(from:uint , to:uint):void {
			if (from == 0) return ;
			var it:ListIterator = listIterator(from) ;
			var l:Number = to - from ;
			for (var i:Number = 0 ; i<l ; i++) {
				it.next() ; 
				it.remove() ;
			}
		}

		public function removesAt(id:uint, len:uint):* {
			var d:uint = len - id ;
			var old:* = _a.slice(id, d) ;
			_a.splice(id, len);
			return old ; 
		}
	
		public function setAt(id:uint, o:*):void 
		{
			if (_a[id] === undefined) return ;
			_a[id] = o ;
		}

		public function setModCount(n:uint):void
		{
			_modCount = n ;
		}
	
		public function subList(begin:uint, end:uint):List 
		{
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
	

	
}

import vegas.core.CoreObject ;

import vegas.data.Collection ;
import vegas.data.List ;
import vegas.data.list.AbstractList ;
import vegas.data.iterator.ListIterator ;

import vegas.errors.ConcurrentModificationError ;
import vegas.errors.IllegalArgumentError ;
import vegas.errors.IllegalStateError ;
import vegas.errors.IndexOutOfBoundsError ;
import vegas.errors.NoSuchElementError ;

import vegas.util.MathsUtil ;

class ListItr extends CoreObject implements ListIterator {

	// ----o Construtor
	
	function ListItr( li:List ) {
		if (!li) 
		{
			throw new IllegalArgumentError(this + " constructor, 'list' must not be 'null' nor 'undefined'.") ;
		}
		_list = li ;
		_key = 0 ;
		_listast = -1 ;
		_expectedModCount = AbstractList(_list).getModCount() ;
	}

	// ----o Public Methods
	
	public function checkForComodification():void {
		var l:AbstractList = AbstractList(_list) ;
	   	if (l.getModCount() != _expectedModCount) 
   		{
	    	throw new ConcurrentModificationError(this + " modification impossible.") ;
    	}
	}
	
	public function hasNext():Boolean 
	{
		return _key < _list.size() ;
	}

	public function hasPrevious():Boolean 
	{ 
		return _key != 0 ;
	}

	public function insert(o:*):void {
		checkForComodification() ;
		try {
			_list.insertAt(_key++, o) ;
			_listast = -1 ;
			_expectedModCount = AbstractList(_list).getModCount() ;
		} 
		catch (e:ConcurrentModificationError) 
		{
			throw e ;
		}	
	}

	public function key():*
	{
		return _key ;
	}

	public function next():* {
		if (hasNext()) 
		{
			var next:* = _list.get(_key) ;
			_listast = _key ;
			_key++ ;
			return next ;
		}
		else 
		{	
			throw new NoSuchElementError() ;
		}
	}
	
	public function nextIndex():uint 
	{
		return _key ;
	}
		
	public function previous():*
	{
		checkForComodification() ;
		try {
			var i:Number = _key - 1 ;
			var prev:* = _list.get(i) ;
			_listast = _key  = i ;
			return prev ;
		}
		catch(e:IndexOutOfBoundsError) 
		{
			checkForComodification();
			throw new NoSuchElementError() ;
		}
	}

	public function previousIndex():int 
	{
		return _key - 1 ;
	}

	public function remove():*
	{
		if (_listast == -1) throw new IllegalStateError() ;
		checkForComodification() ;
		try {
			_list.removeAt(_listast) ;
			if (_listast < _key) _key -- ;
			_listast = -1 ;
			_expectedModCount = AbstractList(_list).getModCount() ;
		} catch (e:ConcurrentModificationError) {
			throw new ConcurrentModificationError() ;
		}
	}	

	public function reset():void {
		_key = 0 ;
	}

	public function seek(position:*):void {
		_key = MathsUtil.clamp(position, 0, _list.size()) ;
		_listast = _key - 1 ;
	}

	public function set(o:*):void
	{
		if (_listast == -1) throw new IllegalStateError() ;
		checkForComodification() ;
		try {
			_list.setAt(_listast, o) ;
			_expectedModCount = AbstractList(_list).getModCount() ;
		}
		catch (e:ConcurrentModificationError) 
		{
			throw e ;
		}
	}	

	// ----o Private Properties
	
	private var _list:List ;
	private var _key:uint ;
	private var _listast:int ;
	private var _expectedModCount:Number ;

}