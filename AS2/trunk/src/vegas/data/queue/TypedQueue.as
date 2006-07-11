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

/**	TypedQueue

	AUTHOR

		Name : TypedQueue
		Package : vegas.data.queue
		Version : 1.0.0.0
		Date :  2005-10-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var ta:TypedQueue = new TypedQueue( type:Function , queue:Queue) 

	METHOD SUMMARY
	
		- clear():Void
		
		- dequeue() : removes the head of this queue and return true if removes.
		
		- element() : Retrieves, but does not remove, the head of this queue.
		
		- enqueue(o) : Inserts the specified element into this queue, if possible and return true.
		
		- getType() : return the type of the TypedQueue
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- peek() : Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
		
		- poll() : Retrieves and removes the head of this queue.
		
		- setType(type:Function) : set the type and clear TypedArray
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		AbstractTypeable

	IMPLEMENTS 

		Queue, Typeable, Validator

*/

import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Queue;
import vegas.errors.IllegalArgumentError;
import vegas.util.AbstractTypeable;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.data.queue.TypedQueue extends AbstractTypeable implements Iterable, Queue {

	// ----o Construtor
	
	public function TypedQueue(type:Function, queue:Queue) {
		super(type) ;
		if (!queue) throw new IllegalArgumentError() ; // "Argument 'queue' must not be 'null' or 'undefined'.
		_queue = queue ;
		if (_queue.size() > 0) {
			var it:Iterator = _queue.iterator() ;
			while (it.hasNext()) validate(it.next()) ;
		}
	}
	
	// ----o Public Methods	

	public function clear():Void {
		_queue.clear() ;
	}

	public function clone() {
		return new TypedQueue(_type, _queue.clone()) ;
	}

	public function dequeue():Boolean {
		return _queue.dequeue() ;
	}

	public function element() {
		return _queue.element() ;
	}
	
	public function enqueue(o):Boolean {
		validate(o) ;
		return _queue.enqueue(o) ;  
	} 

	public function isEmpty():Boolean {
		return _queue.isEmpty() ;
	}

	public function iterator():Iterator {
		return _queue.iterator() ;
	}

	public function peek() {
		return _queue.peek() ;
	}
	
	public function poll() {
		return _queue.poll() ;
	}

	public function setType(type:Function):Void {
		super.setType(type) ;
		_queue.clear() ;
	}

	public function size():Number {
		return _queue.size() ;
	}

	public function toArray():Array {
		return _queue.toArray() ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = TypeUtil.toString(_type) ;
		var sourceB:String = Serializer.toSource(_queue) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function toString():String {
		return _queue.toString() ;
	}

	// -----o Private Properties
	
	private var _queue:Queue ;

}