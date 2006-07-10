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

/* PriorityQueue

	AUTHOR
	
		Name : PriorityQueue
		Package : vegas.data.queue
		Version : 1.0.0.0
		Date : 2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- clear():void
		
		- clone():*
		
		- comparator():IComparator

		- contains(o:*):Boolean
		
		- copy():*
		
		- dequeue():Boolean 
		
		- element():* 
		
		- enqueue(o:*):Boolean
		
		- get(id:uin):*
		
		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- peek():*
		
		- poll():*
		
		- remove(o):Boolean
		
		- size():uint
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCollection → SimpleCollection → LinearQueue → PriorityQueue

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IFormattable, IHashable, ISerialzable, Iterable, Queue

*/

package vegas.data.queue
{
	
	import vegas.core.IComparator;
	import vegas.errors.IllegalArgumentError;
	import vegas.util.Copier ;
	
	public class PriorityQueue extends LinearQueue
	{
		
		// ----o Constructor
		
		/**
		 * PriorityQueue constructor
		 * 
		 * 		var q:Queue = new PriorityQueue() ;
		 * 		var q:Queue = new PriorityQueue( comparator:IComparator=null , ar:Array:null ) ;
		 * 
		 */
		public function PriorityQueue(comparator:IComparator=null, ar:Array=null)
		{
			super(ar) ;
			_comparator = comparator ;
			if (size() > 0) _sort() ;
		}
		
		// ----o Public Methods
	
		override public function clone():* 
		{
			return new PriorityQueue(comparator(), toArray());
		}
	
		public function comparator():IComparator {
			return _comparator ;
		}
		
		override public function copy():* 
		{
			return new PriorityQueue(comparator(), Copier.copy(toArray())) ;
		}
		
		override public function enqueue(o:*):Boolean {
			var isEnqueue:Boolean = super.enqueue(o) ;
			if ( isEnqueue && _comparator != null ) {
				_sort() ;
			}
			return isEnqueue ;
		}
		
		// ----o Private Properties
	
		private var _comparator:IComparator = null ;
		
		// ----o Protected Methods
		
		protected function _sort():void 
		{
			if (size() && _comparator != null) {
				_a.sort(_comparator.compare, Array.NUMERIC) ;
			}
		}
		
	}
}