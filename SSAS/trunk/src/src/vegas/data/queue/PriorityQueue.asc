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
 * This queue orders elements according to an order specified at construction time, which is specified either according to their natural order or according to a IComparator object.
 * @author eKameleon
 * @see IComparator
 */
if (vegas.data.queue.PriorityQueue == undefined) 
{
	
	/**
	 * Creates a new PriorityQueue instance.
	 * <p><b>Example :</b>
	 * {@code
	 * var q = new vegas.data.queue.PriorityQueue(null, ["item0", "item1"])  ;
	 * 
	 * trace ("queue size : " + q.size()) ;
	 * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
	 * trace ("enqueue item3 : " + q.enqueue ("item2")) ;
	 * trace ("enqueue item2 : " + q.enqueue ("item3")) ;
	 * trace ("enqueue item2 : " + q.enqueue ("item1")) ;
	 * 
	 * trace("> " + q) ;
	 * 
	 * q.setComparator( new vegas.util.comparators.StringComparator() ) ;
	 * 
	 * trace("> " + q) ;
	 * }
	 * </p>
	 * @param comp a IComparator object used in the PriorityQueue to defined the sort model when enqueue or modify the queue.
	 * @param ar an Array with values to fill the queue.
	 * @see IComparator
	 */
	vegas.data.queue.PriorityQueue = function ( comp/*Comparator*/ , ar /*Array*/  ) 
	{ 
		this.setComparator( comp ) ;
		if (ar instanceof Array && ar.length > 0) 
		{
			this._a = [].concat(ar) ;
			this._sort() ;
		} 
		else 
		{
			this._a = [] ;
		}
	}

	/**
	 * @extends vegas.data.queue.LinearQueue
	 */
	proto = vegas.data.queue.PriorityQueue.extend(vegas.data.queue.LinearQueue) ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () 
	{
		return new vegas.data.queue.PriorityQueue(this._comparator) ;
	}

	/**
	 * Returns the internal IComparator reference of this object.
	 * @return the internal IComparator reference of this object.
	 */
	proto.comparator = function() /*Comparator*/ 
	{
		return this._comparator ;
	}

	/**
	 * Inserts the specified element into this queue, if possible.
	 */
	proto.enqueue = function (o) /*Boolean*/ 
	{
		var isEnqueue /*Boolean*/ = this.__constructor__.prototype.enqueue.call(this, o) ;
		if ( isEnqueue && this._comparator != null ) 
		{
			this._sort() ;
		}
		return isEnqueue ;
	}

	/**
	 * Sets the IComparator reference of this object.
	 * @param comp the IComparator reference of this object.
	 */
	proto.setComparator = function( comp /*IComparator */) /*void*/
	{
		this._comparator = comp ;
		if (this._comparator != null)
		{
			this._sort() ;
		}
	}

	/**
	 * @private
	 */
	proto._sort = function () 
	{
		if (this._comparator != null ) 
		{
			this._a.sort(this._comparator.compare) ;
		}
	}

	/**
	 * @private
	 */
	proto._comparator = null ;
	
	delete proto ;
	
}