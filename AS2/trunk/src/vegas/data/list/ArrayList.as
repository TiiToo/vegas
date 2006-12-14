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

import vegas.data.Collection;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.data.list.AbstractList;

/**
 * Resizable-array implementation of the List interface.
 * Implements all optional list operations, and permits all elements, including null. 
 * @author eKameleon
 */
class vegas.data.list.ArrayList extends AbstractList 
{
	
	/**
	 * Creates a new ArrayList instance.
	 */
	function ArrayList() 
	{
		
		var arg = arguments[0] ;
		
		if (arg instanceof Array) {
			
			var it:Iterator = new ArrayIterator(arg) ;
			while (it.hasNext()) {
				insert(it.next()) ;
			}
			
		} else if (arg instanceof Collection) {
			
			var it:Iterator = arg.iterator() ;
			while (it.hasNext()) {
				insert(it.next()) ;
			}
			
		} else if (typeof (arg) == "number") {
			
			_a.length = arg ;
			
		}
	}

	/**
	 * Creates and returns a shallow copy of the object.
	 * @return A new object that is a shallow copy of this instance.
	 */	
	public function clone() 
	{
		return new ArrayList(toArray()) ;
	}
	
	/**
	 * ncreases the capacity of this ArrayList instance, if necessary, to ensure that it can hold at least the number of elements specified by the minimum capacity argument.
	 */
	public function ensureCapacity(n:Number):Void 
	{
		_a.length = n ;
	}
	
}