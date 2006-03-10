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

/* ------- 	CircularQueue

	AUTHOR

		Name : CircularQueue
		Package : vegas.data.queue
		Version : 1.0.0.0
		Date :  2005-10-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Abstract data type (ADT) http://en.wikipedia.org/wiki/Abstract_data_type
			Concept de programmation objet.
			Type de données d'un objet uniquement manipulables via les
			fonctions définies dans l'objet lui-même.

		a circular bounded queue

	CONSTRUCTOR
	
		var q:CircularQueue = new CircularQueue( qSize ) 

	METHODS
	
		- clear()
		
		- clone()
		
		- dequeue() 
		
			retreive the first element in the queue object, return a boolean.
		
		- element()
		
		- enqueue(o)
		
			enqueue a new element in the queue if the que is not full, return a boolean
		
		- isEmpty()
		
		- isFull()
		
		- iterator()
		
			return a ProtectedIterator
		
		- maxSize():Number
		
		- peek()
		
		- poll()
		
		- size()
		
		- toArray()
		
		- toSource()
		
		- toString()

	IMPLEMENTS
	
		BoundedQueue, Collection, ICloneable, IFormattable, IHashable, ISerializable, Iterable, Queue 
	
----------  */

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.ISerializable;
import vegas.data.BoundedQueue;
import vegas.data.Collection;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.data.iterator.ProtectedIterator;
import vegas.data.queue.QueueFormat;
import vegas.errors.UnsupportedOperation;
import vegas.util.serialize.Serializer;

class vegas.data.queue.CircularQueue extends CoreObject implements BoundedQueue, ICloneable, Collection, ISerializable {

	// ----o Constructor
	
	public function CircularQueue( qSize:Number , ar:Array) {
		_qSize = (qSize || CircularQueue.DEFAULT_SIZE) + 1 ;
		clear() ;
		var l:Number = ar.length ;
		if (l > 0) for (var i:Number = 0 ; i<l ; i++) enqueue(ar[i]) ;
	}
	
	// ----o Static Properties
	
	static public var DEFAULT_SIZE:Number = Number.MAX_VALUE ;

	// ----o Public Methods

	public function clear():Void {
		_queue = new Array(_qSize) ;
		_count = 0 ;
		_rear = 0 ;
		_front = 0 ;
	}

	public function clone() {
		var s:Number = _qSize - 1 ;
		var a:Array = toArray() ;
		return new CircularQueue(s , a) ;
	}

	public function contains(o):Boolean {
		var l:Number = _queue.length ;
		for (var i:Number = 0 ; i<l ; i++) if (_queue[i] == o) return true ;
		return false ; 
	}

	public function dequeue():Boolean {
		return poll() != null  ;
	}

	public function element() {
		return _queue[_front] ;
	}	

	public function enqueue(o):Boolean {
		var next:Number = _rear + 1 ;
		if ( (next == _front) || ( ( next == _qSize) && (_front == 0) )) {
			return false ;
		} else {
			_queue[_rear++] = o ;
			_count ++ ;
			if (_rear == _qSize) _rear = 0 ;
		}
		return true ;
	}

	public function get(id:Number) { 
		throw new UnsupportedOperation ;
		return false ;
	}

	public function insert(o):Boolean {
		throw new UnsupportedOperation ;
		return false ;
	}

	public function isEmpty():Boolean {
		return _count == 0 ;
	}

	public function isFull():Boolean {
		return _count == maxSize() ;
	}
	
	public function iterator():Iterator {
		return (new ProtectedIterator(new ArrayIterator(toArray()))) ;
	}

	public function maxSize():Number {
		return _qSize -1 ;
	}
	
	public function peek() {
		return isEmpty() ? null : _queue[_front] ;
	}
	
	public function poll() {
		if (_front == _qSize) _front = 0 ; // loop back
        if (_front == _rear) return null;  // queue is empty
        else  {
            _count-- ;
            var mem = _queue[_front] ;
            _queue[_front] = undefined ;
            _front++ ;
            return mem ; // return mem object
        }
	}	
	
	public function remove(o):Boolean {
		throw new UnsupportedOperation ;
		return false ;
	}
	
	public function size():Number {
		return _count ;
	}
	
	public function toArray():Array {
		if (_count == 0) {
			return new Array ;
		} else {
			var r:Array = new Array(_count) ;
			var i:Number = (_front == _qSize) ? 0 : _front ;
			var cpt:Number = 0 ;
			while (cpt < _count) {
				r[cpt++] = _queue[i++] ;
				if (i == _qSize) i = 0 ;
			}
			return r ;
		}
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = Serializer.toSource(_qSize - 1) ;
		var sourceB:String = Serializer.toSource(toArray()) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}
	
	public function toString():String {
		return (new QueueFormat()).formatToString(this) ;
	}

	// ----o Private Properties

	private var _queue:Array ;
    private var _rear:Number ; // The array index for the next object to be stored in the queue.
	private var _front:Number ; // The array index for the next object to be removed from the queue.
	private var _count:Number ; // The number of objects currently stored in the queue
    private var _qSize:Number ; // The number of objects in the array : queue size + 1


}