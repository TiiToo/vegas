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

/**	PriorityQueue

	AUTHOR

		Name : PriorityQueue
		Package : eka.src.queue
		Version : 0.0.0.0
		Date :  2005-11-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR

		- new PriorityQueue(ar:Array)  
		- new PriorityQueue(comparator:IComparator, ar:Array)  ;
	
	METHODS
	
		- clear()
		
		- comparator()
		
			return the queue comparator
		
		- element()
		
		- enqueue(o, priority)
		
		- dequeue()
		
		- isQueue()
		
		- iterator()
	
	INHERIT
	
		AbstractCollection > LinearQueue
	
	IMPLEMENTS

		ICloneable, Collection, Queue
	
**/

import vegas.core.IComparator;
import vegas.data.queue.LinearQueue;
import vegas.errors.IllegalArgumentError;

class vegas.data.queue.PriorityQueue extends LinearQueue {

	// ----o Constructor
	
	public function PriorityQueue() {
		var l:Number = arguments.length ;
		if (l > 0) {
			var arg = arguments[0] ;
			if (arg instanceof IComparator) {
				_comparator = arg ;
				arg = arguments[1] ;
			}  else if (arg instanceof Array) {
				constructor.apply(this, arg) ;				
			}
		} else {
			throw new IllegalArgumentError("PriorityQueue in constructor arguments must not be 'null' or 'undefined'") ;
		}
	}

	// ----o Public Methods

	public function clone() {
		return new PriorityQueue(_comparator);
	}
	
	public function comparator():IComparator {
		return _comparator ;
	}
	
	public function enqueue(o):Boolean {
		var isEnqueue:Boolean = super.enqueue(o) ;
		if ( isEnqueue && _comparator ) {
			_a.sort(_comparator.compare) ;
		}
		return isEnqueue ;
	}
	

	// ----o Private Properties
	
	private var _comparator:IComparator = null ;
	
}