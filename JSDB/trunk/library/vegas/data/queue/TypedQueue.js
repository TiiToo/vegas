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
 * TypedQueue is a wrapper for Queue instances that ensures that only values of a specific type can be added to the wrapped queue.
 * <p><b>Example :</b></p>
 * {@code
 * var tq = new vegas.data.queue.TypedQueue(String, new vegas.data.queue.LinearQueue()) ;
 * 
 * trace("----o enqueue") ;
 * trace ("enqueue item1 : " + tq.enqueue("item1")) ;
 * trace ("enqueue item2 : " + tq.enqueue("item2")) ;
 * trace ("queue size : " + tq.size()) ;
 * trace ("tq toSource : " + tq.toSource()) ;
 * trace("----o supports") ;
 * trace ("supports a string : " + tq.supports("bobo")) ;
 * trace ("supports a number : " + tq.supports(150)) ;
 * trace ("---o setType") ;
 * tq.setType(Number) ;
 * trace ("tq : " + tq) ;
 * trace ("---o Validate") ;
 * trace ("enqueue true : " + tq.enqueue(true)) ;
 * }
 * @author eKameleon
 */
if (vegas.data.queue.TypedQueue == undefined) 
{

	/**
	 * @requires vegas.util.AbstractTypeable
	 */
	require("vegas.util.AbstractTypeable") ;

	/**
	 * Creates a new TypedQueue instance.
	 * @param type The type of all elements insert in the Queue.
	 * @param queue The Queue to be wrapped. 
	 */
	vegas.data.queue.TypedQueue = function ( type /*Function*/ , queue /*Queue*/ ) 
	{ 
		vegas.util.AbstractTypeable.call(this, type) ;
		if (queue == null) 
		{
			throw new vegas.errors.IllegalArgumentError("TypedQueue constructor, Argument 'queue' must not be 'null' or 'undefined'") ;
		}
		if (queue.size() > 0) 
		{
			var it = co.iterator() ;
			while ( it.hasNext() ) 
			{
				this.validate(it.next()) ;
			}
		}
		this._queue = queue ;
	}

	/**
	 * @extends vegas.util.AbstractTypeable
	 */
	proto = vegas.data.queue.TypedQueue.extend(vegas.util.AbstractTypeable) ;
	
	/**
	 * Removes all elements in this typed queue.
	 */
	proto.clear = function () 
	{
		this._queue.clear() ;
	}

	/**
	 * Returns the shallow copy of this object.
	 * @return the shallow copy of this object.
	 */
	proto.clone = function () 
	{
		return new vegas.data.queue.TypedQueue(this.getType(), this._queue.clone()) ;
	}

	/**
	 * Removes the head of this queue and return true if removes.
	 * @return {@code true} if the Queue is dequeue.
	 */
	proto.dequeue = function ()/*Boolean*/ 
	{
		return this._queue.dequeue() ;
	}

	/**
	 * Retrieves, but does not remove, the head of this queue.
	 */
	proto.element = function () 
	{
		return this._queue.element() ;
	}
	
	/**
	 * Inserts the specified element into this queue, if possible and return true.
	 */
	proto.enqueue = function (o)/*Boolean*/ 
	{
		this.validate(o) ;
		return this._queue.enqueue(o) ;  
	} 

	/**
	 * Returns {@code true} if this queue is empty.
	 * @return {@code true} if this queue is empty.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._queue.isEmpty() ;
	}

	/**
	 * Returns the iterator representation of the object.
	 * @return the iterator representation of the object.
	 */
	proto.iterator = function ()/*Iterator*/ 
	{
		return this._queue.iterator() ;
	}

	/**
	 * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
	 */
	proto.peek = function () 
	{
		return this._queue.peek() ;
	}
	
	/**
	 * Retrieves and removes the head of this queue.
	 */
	proto.poll = function () 
	{
		return this._queue.poll() ;
	}

	/**
	 * Sets the type of this ITypeable object.
	 */
	proto.setType = function (type /*Function*/) /*void*/ 
	{
		vegas.util.AbstractTypeable.prototype.setType.call(this, type) ;
		this._queue.clear() ;
	}

	/**
	 * Returns the size of this queue.
	 * @return the size of this queue.
	 */
	proto.size = function ()/*Number*/ 
	{
		return this._queue.size() ;
	}

	/**
	 * Returns an array representation of this queue.
	 * @return an array representation of this queue.
	 */
	proto.toArray = function ()/*Array*/ 
	{
		return this._queue.toArray() ;
	}

	/**
	 * Returns the eden representation of the object.
	 * @return the string representing the source code of the object.
	 */
	proto.toSource = function (indent/*Number*/, indentor/*String*/)/*String*/ 
	{
		var sourceA/*String*/ = vegas.util.TypeUtil.toString(this._type) ;
		var sourceB/*String*/ = this._queue.toSource() ;
		return "new vegas.data.queue.TypedQueue(" + sourceA + "," + sourceB + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function ()/*String*/ 
	{
		return this._queue.toString() ;
	}

	delete proto ;
	
}