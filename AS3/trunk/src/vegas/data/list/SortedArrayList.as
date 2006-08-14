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

/* SortedArrayList [Interface]

    AUTHOR

    	Name : SortedArrayList
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
		
		- ensureCapacity( capacity:uint ):void 
		
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
    
	    CoreObject → AbstractCollection → SimpleCollection → AbstractList → ArrayList → SortedArrayList
    
    IMPLEMENTS
    
        Collection, ICloneable, IComparer, ICopyable, IFormattable, ISerialzable, Iterable, List

**/

package vegas.data.list
{

	import vegas.core.IComparator;
	import vegas.core.IComparer;
	import vegas.data.Collection ;
	import vegas.util.Copier ;
	import vegas.util.Serializer;
	
	public class SortedArrayList extends ArrayList implements IComparer
	{

		// ----o Constructor

		public function SortedArrayList(init:*, comp:IComparator=null, opt:uint=0)
		{
			super(init);
			comparator = comp ;
			options = opt ;
		}
		
		// ----o Public Methods
	
		override public function clone():*
		{
			return new SortedArrayList(toArray(), comparator, options) ;
		}

		override public function copy():*
		{
			return new SortedArrayList(Copier.copy(toArray()), Copier.copy(comparator), Copier.copy(options)) ;
		}

		override public function insert(o:*):Boolean 
		{
			var b:Boolean = super.insert(o) ;
			_sort() ;
			return b ;
		}	

		override public function insertAll(c:Collection):Boolean 
		{
			var b:Boolean = super.insertAll(c) ;
			_sort() ;
			return b ;
		}
	
		override public function insertAt(id:uint, o:*):void
		{
			insertAt(id, o) ;
			_sort() ;
		}

		override public function insertAllAt(id:uint, c:Collection):Boolean 
		{
			var b:Boolean = super.insertAllAt(id, c) ;
			_sort() ;
			return b ;
		}

			
		public function sort( compare:*=null , opts:uint=0 ):Array  
		{
			if ( compare == null) return null ;
			var f:Function ;
			if (compare is IComparator) 
			{
				f = compare.compare ;
			}
			else if (compare is Function)
			{
				f = compare ;
			}
			else
			{
				return null ;
			}
			return _a.sort(f , opts) ;
		}
	
		public function sortOn( fieldName:*, opts:*=null ):Array  
		{
			return _a.sortOn(fieldName, opts) ;
		}
	
		override public function toSource(...arguments:Array):String {
			return Serializer.getSourceOf(this, [toArray(), comparator, options] ) ;
		}
		
		// ----o Virtual Properties

		public function get comparator():IComparator 
		{
			return _comparator ;
		}
		
		public function set comparator(comp:IComparator):void 
		{
			_comparator = comp ;
			_sort() ;
		}

		public function get options():uint {
			return _options ;
		}
	
		public function set options(o:*):void{
			_options = o ;
			_sort() ;
		}
		
		// ----o Private Properties
		
		private var _comparator:IComparator ;
		private var _options:* ;

		// ----o Private Methods
	
		private function _sort():void {
			sort( _comparator.compare , _options) ;
		}

	}
}