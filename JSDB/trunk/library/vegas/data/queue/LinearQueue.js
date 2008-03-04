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
 * LinearQueue stores values in a 'first-in, first-out' manner.
 * <p><b>Example :</b></p>
 * var q = new vegas.data.queue.LinearQueue(["item0", "item1"])  ;
 * trace ("queue size : " + q.size()) ;
 * trace ("enqueue item2 : " + q.enqueue ("item2")) ;
 * trace ("enqueue item3 : " + q.enqueue ("item3")) ;
 * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
 * 
 * trace ("------- element") ;
 * trace ("element : " + q.element()) ;
 * trace ("peek : " + q.peek()) ;
 * 
 * trace ("------- dequeue") ;
 * trace ("dequeue : " + q.dequeue()) ;
 * 
 * trace ("------- iterator") ;
 * var it = q.iterator() ;
 * while (it.hasNext()) 
 * {
 *     trace (it.next()) ;
 * }
 * 
 * trace ("queue size : " + q.size() ) ;
 * trace ("queue toSource : " + q.toSource()) ;
 * }
 * @author eKameleon
 */
if (vegas.data.queue.LinearQueue == undefined) 
{
	
	/**
	 * Creates a new LinearQueue instance.
	 */
	vegas.data.queue.LinearQueue = function ( ar/*Array*/ ) 
	{ 
		vegas.data.collections.AbstractCollection.apply(this, [ar]) ;
	}

	/**
	 * @extends vegas.data.collections.AbstractCollection
	 */
	proto = vegas.data.queue.LinearQueue.extend(vegas.data.collections.AbstractCollection) ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */	
	proto.clone = function () 
	{
		return new vegas.data.queue.LinearQueue(this._a) ;
	}

	/**
	 * Retrieves and removes the head of this queue.
	 * @return {@core true} if the head of this queue is removed.
	 */
	proto.dequeue = function () /*Boolean*/ 
	{
		return this.poll() != null  ;
	}

	/**
	 * Retrieves, but does not remove, the head of this queue.
	 * @return {@core true} if the head reference of this queue.
	 */
	proto.element = function () 
	{
		return this._a[0] ;
	}

	/**
	 * Inserts the specified element into this queue, if possible.
	 * @return {@code true} if the element is inserted in the queue.
	 */
	proto.enqueue = function (o) /*Boolean*/ 
	{
		if (o == undefined) return false ;
		this._a.push(o) ;
		return true ;
	}

	/**
	 * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
	 * @return {@core null} if the queue is empty else the head of the queue.
	 */
	proto.peek = function () 
	{
		if (this.isEmpty()) return null ;
		return this._a[0] ;
	}

	/**
	 * Retrieves and removes the head of this queue.
	 * @return the head of the queue and removes this reference in the queue.
	 */
	proto.poll = function () 
	{
		if (this.isEmpty()) return null ;
		return this._a.shift() ;
	}

	/**
	 * Returns the string representation of this object.
	 * @return the string representation of this object.
	 */
	proto.toString = function () /*String*/ 
	{
		return (new vegas.data.queue.QueueFormat()).formatToString(this) ;
	}
	
	delete proto ;
	
}