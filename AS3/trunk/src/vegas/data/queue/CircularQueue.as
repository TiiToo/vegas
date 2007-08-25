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
	import vegas.core.CoreObject;
	import vegas.data.BoundedQueue;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.data.iterator.ProtectedIterator;
	import vegas.data.queue.QueueFormat;
	import vegas.util.Copier;
	import vegas.util.Serializer;

    /**
     * The CircularQueue class allows for storing objects in a circular queue of a predefined size.
     * <p><b>Example :</b></p>
     * {@code
     * import vegas.data.iterator.Iterator ;
     * import vegas.data.queue.CircularQueue ;
     * 
     * var q:CircularQueue = new CircularQueue(5) ;
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
     * trace ("size : " + q.size()) ;
     * trace ("isFull : " + q.isFull()) ;
     * trace ("array : " + q.toArray()) ;
     * 
     * trace("") ;
     * 
     * trace ("queue : " + q) ;
     * 
     * trace("") ;
     * 
     * trace ("dequeue : " + q.dequeue()) ;
     * trace ("enqueue item6 : " + q.enqueue("item6")) ;
     * trace ("enqueue item7 : " + q.enqueue("item7")) ;
     * trace ("peek : " + q.peek()) ;
     * trace ("size : " + q.size()) ;
     * trace ("isFull : " + q.isFull()) ;
     * 
     * trace("") ;
     * 
     * trace ("q : " + q) ;
     * 
     * trace ("------- clone") ;
     * 
     * var clone:CircularQueue = q.clone() ;
     * trace ("dequeue clone : " + clone.dequeue()) ;
     * trace ("enqueue clone item8 : " + clone.enqueue("item8")) ;
     * trace ("original queue : " + q) ;
     * trace ("clone queue : " + clone) ;
     * trace ("clone iterator :") ;
     * var i:Iterator = clone.iterator() ;
     * while (i.hasNext()) 
     * {
     *     trace ("\t+ " + i.next()) ;
     * }
     * trace("clone.toSource : " + clone.toSource()) ;
     * 
     * }
     * @author eKameleon
     */
	public class CircularQueue extends CoreObject implements BoundedQueue
	{

    	/**
    	 * Creates a new CircularQueue instance.
    	 * @param qSize the max number of element in the queue
    	 * @param elements an array with elements to enqueue in the current stack.
    	 */
		public function CircularQueue( qSize:uint=uint.MAX_VALUE , elements:Array=null )
		{
			
			_qSize = ( isNaN(qSize) ? CircularQueue.MAX_CAPACITY : qSize ) + 1 ;
			
			clear() ;
			
			if (elements == null) 
			{
			    return ;
			}
			else
			{
			    var l:Number = elements.length ;
			    if (l > 0)
			    {
    				for (var i:Number = 0 ; i<l ; i++)
				    {
    					enqueue( elements[i] ) ;
	    			}
		    	}
		    }
        }

	    /**
	     * The default numbers of elements in the queue.
	     */
		static public var MAX_CAPACITY:uint = uint.MAX_VALUE ;

		public function clear():void
		{
			_queue = new Array(_qSize) ;
			_count = 0 ;
			_rear = 0 ;
			_front = 0 ;
		}
		
		public function clone():*
		{
			var s:Number = _qSize - 1 ;
			var a:Array = toArray() ;
			return new CircularQueue(s , a) ;
		}
		
		public function contains(o:*):Boolean
		{
			return _queue.indexOf(o) != -1 ;
		}
		
		public function copy():*
		{
			return new CircularQueue(maxSize(), Copier.copy(toArray())) ;
		}
		
		public function dequeue():Boolean
		{
			return poll() != null  ;
		}
		
		public function element():*
		{
			return _queue[_front] ;
		}

		public function enqueue(o:*):Boolean
		{
			var next:uint = _rear + 1 ;
			if ( (next == _front) || ( ( next == _qSize) && (_front == 0) )) 
			{
				return false ;
			} else {
				_queue[_rear++] = o ;
				_count ++ ;
				if (_rear == _qSize) _rear = 0 ;
			}
			return true ;
		}
		
		public function isEmpty():Boolean
		{
			return _count == 0 ;
		}
		
		public function isFull():Boolean
		{
			return _count == maxSize() ;
		}
		
		public function iterator():Iterator
		{
			return (new ProtectedIterator(new ArrayIterator(toArray()))) ;
		}
		
		public function maxSize():uint
		{
			return _qSize -1 ;
		}
		
		public function peek():*
		{
			return isEmpty() ? null : _queue[_front] ;
		}
		
		public function poll():*
		{
			if (_front == _qSize) _front = 0 ; // loop back
        	if (_front == _rear) return null;  // queue is empty
        	else  {
            	_count-- ;
            	var mem:* = _queue[_front] ;
            	_queue[_front] = undefined ;
            	_front++ ;
            	return mem ; // return mem object
        	}
		}
		
		public function size():uint
		{
			return _count ;
		}

		public function toArray():Array
		{
		if (_count == 0) {
			return new Array() ;
		} else {
			var r:Array = new Array(_count) ;
			var i:Number = (_front == _qSize) ? 0 : _front ;
			var cpt:uint = 0 ;
			while (cpt < _count) {
				r[cpt++] = _queue[i++] ;
				if (i == _qSize) i = 0 ;
			}
			return r ;
		}
		}
		
		override public function toSource(...arguments:Array):String
		{
			return Serializer.getSourceOf(this, [_qSize - 1, toArray()]) ;
		}
		
		override public function toString():String
		{
			return (new QueueFormat()).formatToString(this) ;
		}

		private var _queue:Array ;
	    private var _rear:uint ; // The array index for the next object to be stored in the queue.
		private var _front:uint ; // The array index for the next object to be removed from the queue.
		private var _count:uint ; // The number of objects currently stored in the queue
	    private var _qSize:uint ; // The number of objects in the array : queue size + 1

	}
	
}