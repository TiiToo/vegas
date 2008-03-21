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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The CircularQueue class allows for storing objects in a circular queue of a predefined size.
 * <p><b>Example :</b></p>
 * {@code
 * var q = new vegas.data.queue.CircularQueue(5) ;
 * 
 * trace ("maxSize : " + q.maxSize()) ;
 * trace ("enqueue item1 : " + q.enqueue ("item1")) ;
 * trace ("enqueue item2 : " + q.enqueue ("item2")) ;
 * trace ("enqueue item3 : " + q.enqueue ("item3")) ;
 * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
 * trace ("enqueue item5 : " + q.enqueue ("item5")) ;
 * trace ("enqueue item6 : " + q.enqueue ("item6")) ;
 * 
 * trace ("element : " + q.element()) ;
 * trace ("dequeue : " + q.dequeue()) ;
 * trace ("element : " + q.element()) ;
 * trace ("size    : " + q.size()) ;
 * trace ("isFull  : " + q.isFull()) ;
 * trace ("array   : " + q.toArray()) ;
 * 
 * trace("") ;
 * 
 * trace ("queue : " + q) ;
 * 
 * trace("") ;
 * 
 * trace ("dequeue       : " + q.dequeue()) ;
 * trace ("enqueue item6 : " + q.enqueue("item6")) ;
 * trace ("enqueue item7 : " + q.enqueue("item7")) ;
 * trace ("peek          : " + q.peek()) ;
 * trace ("size          : " + q.size()) ;
 * trace ("isFull        : " + q.isFull()) ;
 * 
 * trace("") ;
 * 
 * trace ("q : " + q) ;
 * 
 * trace ("------- clone") ;
 * 
 * var clone = q.clone() ;
 * trace ("dequeue clone       : " + clone.dequeue()) ;
 * trace ("enqueue clone item8 : " + clone.enqueue("item8")) ;
 * trace ("original queue      : " + q) ;
 * trace ("clone queue         : " + clone) ;
 * trace ("clone iterator      :") ;
 * var i = clone.iterator() ;
 * while (i.hasNext()) 
 * {
 *     trace ("\t+ " + i.next()) ;
 * }
 * trace("clone.toSource : " + clone.toSource()) ;
 * 
 * }
 * @author eKameleon
 */
if (vegas.data.queue.CircularQueue == undefined) 
{

	/**
	 * Creates a new CircularQueue instance.
	 * @param qSize the max number of element in the queue
	 * @param elements an array with elements to enqueue in the current stack.
	 */
	vegas.data.queue.CircularQueue = function ( qSize /*Number*/ , ar/*Array*/ ) 
	{ 
		this._queue = [] ;
		this._qSize = (qSize || vegas.data.queue.CircularQueue.MAX_CAPACITY) + 1 ;
		this.clear() ;
		if (ar != null && ar.length > 0) 
		{
			var l = ar.length ;
			if (l > 0) for (var i = 0 ; i<l ; i++) this.enqueue(ar[i]) ;
		}
	}

	/**
	 * @extends vegas.data.Queue
	 */	
	proto = vegas.data.queue.CircularQueue.extend(vegas.data.Queue) ;

	/**
	 * The default numbers of elements in the queue.
	 */
	vegas.data.queue.CircularQueue.MAX_CAPACITY = Number.MAX_VALUE ;

	/**
	 * Clear all elements in the queue.
	 */
	proto.clear = function () 
	{
		this._queue = new Array(this._qSize) ;
		this._count = 0 ;
		this._rear = 0 ;
		this._front = 0 ;
	}

	/**
	 * Returns a shallow copy of the queue.
	 * @return a shallow copy of the queue.
	 */
	proto.clone = function () 
	{
		var s /*Number*/ = this._qSize - 1 ;
		var a /*Array*/ = this.toArray() ;
		return new vegas.data.queue.CircularQueue(s , a) ;
	}

	/**
	 * Returns {@code true} if the queue contains the object passed in argument.
	 * @return {@code true} if the queue contains the object passed in argument.
	 */
	proto.contains = function (o) /*Boolean*/ 
	{
		return this._queue.contains(o) ;
	}
	
	/**
	 * Retreives the first element in the queue object, return a boolean.
	 * @return {@code true} if the first element in the queue is dequeue.
	 */
	proto.dequeue = function () /*Boolean*/ 
	{
		return this.poll() != null  ;
	}

	/**
	 * Returns the value of the first element in the queue.
	 * @return the value of the first element in the queue.
	 */
	proto.element = function () 
	{
		return this._queue[this._front] ;
	}

	/**
	 * Enqueue a new element in the queue if the que is not full, return a boolean.
	 */
	proto.enqueue = function (o) /*Boolean*/ 
	{
		var next /*Number*/ = this._rear + 1 ;
		if ( (next == this._front) || ( ( next == this._qSize) && (this._front == 0) )) 
		{
			return false ;
		} 
		else 
		{
			this._queue[this._rear++] = o ;
			this._count ++ ;
			if (this._rear == this._qSize) this._rear = 0 ;
		}
		return true ;
	}

	/**
	 * Returns an element in the queue with the id passed in argument. This method is unsupported in a CircularQueue.
	 * @throws UnsupportedOperation The 'get' method is unsupported.
	 */
	proto.get = function (id/*Number*/) // Collection implementation
	{ 
		throw new vegas.errors.UnsupportedOperationError("CircularQueue 'get' method is unsupported.") ;
	}

	/**
	 * Insert an element in the queue. This method is unsupported in a CircularQueue.
	 * @throws UnsupportedOperation CircularQueue 'insert' method is unsupported.
	 */
	proto.insert = function (o) /*Boolean*/  // Collection implementation 
	{
		throw new vegas.errors.UnsupportedOperationError("CircularQueue 'insert' method is unsupported.") ;
	}

	/**
	 * Returns {@code true} if the queue is empty.
	 * @return {@code true} if the queue is empty.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._count == 0 ;
	}

	/**
	 * Returns {@code true} if the queue is full.
	 * @return {@code true} if the queue is full.
	 */
	proto.isFull = function () /*Boolean*/ 
	{
		return this._count == this.maxSize() ;
	}
	
	/**
	 * Returns the iterator of the queue.
	 * @return the iterator of the queue.
	 * @see {@code vegas.data.iterator.ProtectedIterator}
	 */
	proto.iterator = function ()  /*Iterator*/ 
	{
		var it = new vegas.data.iterator.ArrayIterator(this.toArray()) ;
		return new vegas.data.iterator.ProtectedIterator(it) ;
	}

	/**
	 * Returns the max number of occurrences in the given queue.
	 * @return the max number of occurrences in the given queue.
	 */
	proto.maxSize = function () /*Number*/ 
	{
		return this._qSize -1 ;
	}

	/**
	 * Returns the value of the first element in the queue or {@code null} if the queue is empty.
	 * @return the value of the first element in the queue or {@code null} if the queue is empty.
	 */
	proto.peek = function () 
	{
		return this.isEmpty() ? null : this._queue[this._front] ;
	}

	/**
	 * Returns the value of the first element in the queue and remove this value in the queue.
	 * @return the value of the first element in the queue and remove this value in the queue.
	 */
	proto.poll = function () 
	{
		if (this._front == this._qSize) 
		{
			this._front = 0 ; // loop back
		}
        if (this._front == this._rear) 
        {
        	return null ;  // queue is empty
        }
        else  
        {
            this._count-- ;
            var mem = this._queue[this._front] ;
            this._queue[this._front] = undefined ;
            this._front++ ;
            return mem ; // return mem object
        }
	}	

	/**
	 * Remove the passed argument value. This method is unsupported in a CircularQueue.
	 * @throws UnsupportedOperation
	 */
	proto.remove = function (o) /*Boolean*/ 
	{
		throw new vegas.errors.UnsupportedOperationError("CircularQueue 'remove' method is unsupported.") ;
	}

	/**
	 * Returns the number of elements in the CircularQueue.
	 * @return the number of elements in the CircularQueue.
	 */
	proto.size = function () /*Number*/ 
	{
		return this._count ;
	}
	
	/**
	 * Returns the array representation of the CircularQueue.
	 * @return the array representation of the CircularQueue.
	 */
	proto.toArray = function () /*Array*/ 
	{
		if (this._count == 0) 
		{
			return new Array() ;
		} 
		else 
		{
			var r /*Array*/ = new Array(this._count) ;
			var i /*Number*/ = (this._front == this._qSize) ? 0 : this._front ;
			var cpt /*Number*/ = 0 ;
			while (cpt < this._count) 
			{
				r[cpt++] = this._queue[i++] ;
				if (i == this._qSize) i = 0 ;
			}
			return r ;
		}
	}

	/**
	 * Returns a eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function (indent /*Number*/, indentor/*String*/ ) /*String*/ 
	{
		var sourceA /*String*/ = this.maxSize().toSource() ;
		var sourceB /*String*/ = (this.toArray()).toSource() ;
		return "new " + this.getConstructorPath + "(" + sourceA + "," + sourceB + ")" ;
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function () /*String*/ 
	{
		return (new vegas.data.queue.QueueFormat()).formatToString(this) ;
	}
	
	delete proto ;
	
}