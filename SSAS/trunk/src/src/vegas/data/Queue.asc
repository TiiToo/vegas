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
 * A collection designed for holding elements prior to processing. Besides basic Collection operations, queues provide additional insertion, extraction, and inspection operations.
 * <p>
 * Queues typically, but do not necessarily, order elements in a FIFO (first-in-first-out) manner.
 * </p>
 * <p>Whatever the ordering used, the head of the queue is that element which would be removed by a call to remove() or poll().</p>
 * @author eKameleon
 */
if (vegas.data.Queue == undefined) 
{
	
	/**
	 * Creates a new Queue instance.
	 */
	vegas.data.Queue = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.Queue.extend(vegas.core.CoreObject) ;

	/**
	 * Removes all of the elements from this queue (optional operation).
	 */
	proto.clear = function ()/*void*/ 
	{
		//
	}

	/**
	 * Returns the shallow copy of this queue.
	 */
	proto.clone = function () 
	{
		//
	}

	/**
	 * Retrieves and removes the head of this queue.
	 */
	proto.dequeue = function (o)/*Boolean*/ 
	{
		//
	}

	/**
	 * Retrieves, but does not remove, the head of this queue.
	 */	
	proto.element = function () 
	{
		//
	}
	
	/**
	 * Inserts the specified element into this queue, if possible.
	 */
	proto.enqueue = function (o)/*Boolean*/ 
	{
		//
	}

	/**
	 * Returns {@code true} if this queue contains no elements.
	 * @return {@code true} if this queue is empty else {@code false}.
	 */
	proto.isEmpty = function ()/*Boolean*/ 
	{
		//
	}

	/**
	 * Returns the iterator of this queue.
	 * @return the iterator of this queue.
	 */
	proto.iterator = function ()/*Iterator*/ 
	{
		//
	}

	/**
	 * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
	 */
	proto.peek = function (o)/*Boolean*/ 
	{
		//
	}

	/**
	 * Retrieves and removes the head of this queue.
	 */	
	proto.poll = function ()/*Number*/ 
	{
		//
	}

	/**
	 * Returns the number of elements in this queue.
	 */
	proto.size = function ()/*Array*/ 
	{
		//
	}

	/**
	 * Returns an array containing all of the elements in this collection.
	 */
	proto.toArray = function ()/*String*/ 
	{
		//
	}
	
	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function() /*String*/ 
	{
		//
	}
	
	delete proto ;
	
}