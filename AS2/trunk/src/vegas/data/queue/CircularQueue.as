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

/**
 * @author eKameleon
 */
class vegas.data.queue.CircularQueue extends CoreObject implements BoundedQueue, ICloneable, Collection, ISerializable {

	/**
	 * Creates a new CircularQueue instance.
	 * @param qSize the max number of element in the queue
	 * @param elaments an array with elements to enqueue in the current stack.
	 */
	public function CircularQueue( qSize:Number , elements:Array) {
		_qSize = (qSize || CircularQueue.DEFAULT_SIZE) + 1 ;
		clear() ;
		var l:Number = elements.length ;
		if (l > 0) for (var i:Number = 0 ; i<l ; i++) 
		{
			enqueue(elements[i]) ;
		}
	}
	
	/**
	 * The default numbers of elements in the queue.
	 */
	static public var DEFAULT_SIZE:Number = Number.MAX_VALUE ;

	/**
	 * Clear all elements in the queue.
	 */
	public function clear():Void {
		_queue = new Array(_qSize) ;
		_count = 0 ;
		_rear = 0 ;
		_front = 0 ;
	}

	/**
	 * Returns a shallow copy of the queue.
	 */
	public function clone() 
	{
		var s:Number = _qSize - 1 ;
		var a:Array = toArray() ;
		return new CircularQueue(s , a) ;
	}

	/**
	 * Returns {@code true} if the queue contains the object passed in argument.
	 */
	public function contains(o):Boolean {
		var l:Number = _queue.length ;
		for (var i:Number = 0 ; i<l ; i++) if (_queue[i] == o) return true ;
		return false ; 
	}
	
	/**
	 * Retreives the first element in the queue object, return a boolean.
	 */
	public function dequeue():Boolean 
	{
		return poll() != null  ;
	}

	/**
	 * Returns the value of the first element in the queue.
	 */
	public function element() 
	{
		return _queue[_front] ;
	}	

	/**
	 * Enqueue a new element in the queue if the que is not full, return a boolean.
	 */
	public function enqueue(o):Boolean 
	{
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

	/**
	 * Returns an element in the queue with the id passed in argument. This method is unsupported in a CircularQueue.
	 * @throws UnsupportedOperation
	 */
	public function get(id:Number) 
	{ 
		throw new UnsupportedOperation(this + " 'get' method us unsupported in a CircularQueue") ;
	}

	/**
	 * Insert an element in the queue. This method is unsupported in a CircularQueue.
	 * @throws UnsupportedOperation
	 */
	public function insert(o):Boolean 
	{
		throw new UnsupportedOperation(this + " 'insert' method us unsupported in a CircularQueue") ;
		return false ;
	}

	/**
	 * Returns {@code true} if the queue is empty.
	 */
	public function isEmpty():Boolean 
	{
		return _count == 0 ;
	}

	/**
	 * Returns {@code true} if the queue is full.
	 */
	public function isFull():Boolean 
	{
		return _count == maxSize() ;
	}
	
	/**
	 * Returns the iterator of the queue.
	 * @see {@code vegas.data.iterator.ProtectedIterator}
	 */
	public function iterator():Iterator 
	{
		return (new ProtectedIterator(new ArrayIterator(toArray()))) ;
	}

	/**
	 * Returns the max number of occurrences in the given queue.
	 */
	public function maxSize():Number 
	{
		return _qSize -1 ;
	}
	
	/**
	 * Returns the value of the first element in the queue or {@code null} if the queue is empty.
	 */
	public function peek() 
	{
		return isEmpty() ? null : _queue[_front] ;
	}
	
	/**
	 * Returns the value of the first element in the queue and remove this value in the queue.
	 */
	public function poll() {
		if (_front == _qSize) 
		{
			_front = 0 ; // loop back
		}
        if (_front == _rear) 
        {
        	return null;  // queue is empty
        }
        else  
        {
            _count-- ;
            var mem = _queue[_front] ;
            _queue[_front] = undefined ;
            _front++ ;
            return mem ; // return mem object
        }
	}	
	
	/**
	 * Remove the passed argument value. This method is unsupported in a CircularQueue.
	 * @throws UnsupportedOperation
	 */
	public function remove(o):Boolean 
	{
		throw new UnsupportedOperation(this + " 'remove' method us unsupported in a CircularQueue") ;
		return false ;
	}
	
	/**
	 * Returns the number of elements in the CircularQueue.
	 */
	public function size():Number 
	{
		return _count ;
	}
	
	/**
	 * Returns the array representation of the CircularQueue.
	 */
	public function toArray():Array 
	{
		if (_count == 0) {
			return new Array() ;
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

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		var sourceA:String = Serializer.toSource(_qSize - 1) ;
		var sourceB:String = Serializer.toSource(toArray()) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString():String 
	{
		return (new QueueFormat()).formatToString(this) ;
	}

	/**
	 * The internal array.
	 */
	private var _queue:Array ;
	
	/**
	 * The array index for the next object to be stored in the queue.
	 */
    private var _rear:Number ;
    
    /**
     * The array index for the next object to be removed from the queue.
     */ 
	private var _front:Number ;
	
	/**
	 * The number of objects currently stored in the queue.
	 */
	private var _count:Number ;

	/**
	 * The number of objects in the array : queue size + 1
	 */
    private var _qSize:Number ;

}