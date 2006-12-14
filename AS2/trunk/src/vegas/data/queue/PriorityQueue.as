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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.IComparator;
import vegas.data.queue.LinearQueue;
import vegas.errors.IllegalArgumentError;

/**
 * This queue orders elements according to an order specified at construction time, which is specified either according to their natural order or according to a IComparator object.
 * @author eKameleon
 * @see IComparator
 */
class vegas.data.queue.PriorityQueue extends LinearQueue 
{

	/**
	 * Creates a new PriorityQueue instance.
	 * <p><b>Example :</b>
	 * {@code
	 *    var q:PriorityQueue = new PriorityQueue( ar ) ;
	 *    var q:PriorityQueue = new PriorityQueue( comparator, ar)  ;
	 * }
	 * </p>
	 */
	public function PriorityQueue() 
	{
		var l:Number = arguments.length ;
		if (l > 0) 
		{
			var arg = arguments[0] ;
			if (arg instanceof IComparator) 
			{
				_comparator = arg ;
				arg = arguments[1] ;
			}
			else if (arg instanceof Array) 
			{
				constructor.apply(this, arg) ;				
			}
		} 
		else 
		{
			throw new IllegalArgumentError("PriorityQueue in constructor arguments must not be 'null' or 'undefined'") ;
		}
	}

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	public function clone() 
	{
		return new PriorityQueue(_comparator);
	}
	
	/**
	 * Returns the internal IComparator reference.
	 */
	public function comparator():IComparator 
	{
		return _comparator ;
	}
	
	/**
	 * Inserts the specified element into this queue, if possible.
	 */
	public function enqueue(o):Boolean 
	{
		var isEnqueue:Boolean = super.enqueue(o) ;
		if ( isEnqueue && _comparator ) 
		{
			_a.sort(_comparator.compare) ;
		}
		return isEnqueue ;
	}
	
	/**
	 * The internal IComparator reference.
	 */
	private var _comparator:IComparator = null ;
	
}