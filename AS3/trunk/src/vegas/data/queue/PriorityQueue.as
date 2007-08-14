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

package vegas.data.queue
{
	import vegas.core.IComparator;
	import vegas.core.IComparer;
	import vegas.util.Copier;
	
	/**
	 * 
	 */
	public class PriorityQueue extends LinearQueue implements IComparer
	{
		
		/**
		 * PriorityQueue constructor
		 * 
		 * 		var q:Queue = new PriorityQueue() ;
		 * 		var q:Queue = new PriorityQueue( comparator:IComparator=null , ar:Array:null ) ;
		 * 
		 */
		public function PriorityQueue(comp:IComparator=null, ar:Array=null)
		{
			super(ar) ;
			comparator = comp ;
			if (size() > 0) _sort() ;
		}
		
		// ----o Public Methods
	
		override public function clone():* 
		{
			return new PriorityQueue(comparator, toArray());
		}
	
		public function get comparator():IComparator {
			return _comparator ;
		}

		public function set comparator(comp:IComparator):void {
			_comparator = comp ;
			_sort() ;
		}
		
		override public function copy():* 
		{
			return new PriorityQueue(comparator, Copier.copy(toArray())) ;
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