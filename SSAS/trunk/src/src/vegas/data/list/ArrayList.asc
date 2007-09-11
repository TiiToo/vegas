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
 * Resizable-array implementation of the List interface.
 * Implements all optional list operations, and permits all elements, including null.
 * <p><b>Example : </b></p>
 * {@code 
 * var co = new vegas.data.collections.SimpleCollection(["item0", "item1"]) ;
 * var list = new vegas.data.list.ArrayList( co ) ;
 * 
 * list.insert("item2") ;
 * list.insert("item3") ;
 * list.insert("item4") ;
 * 
 * trace("> " + list) ;
 * trace("> size : " + list.size()) ;
 * trace("> contains co : " + list.containsAll(co)) ;
 * 
 * var it = list.listIterator() ;	
 * while(it.hasNext()) 
 * {
 *     trace("next : " + it.next()) ;
 * }
 *
 * while(it.hasPrevious()) 
 * {
 *     trace("previous : " + it.previous()) ;
 * }
 * 
 * list.ensureCapacity(2) ;
 * trace("> " + list) ;
 * }
 * @author eKameleon
 * @version 1.0.0.0
 */
if (vegas.data.list.ArrayList == undefined) 
{

	/**
	 * Creates a new ArrayList instance.
	 */
	vegas.data.list.ArrayList = function ( o ) 
	{ 
		
		vegas.data.list.AbstractList.call(this) ;
		
		this._a = [] ;
		
		var arg = arguments[0] ;
		
		if (arg instanceof Array) 
		{
			var it = new vegas.data.iterator.ArrayIterator(arg) ;
			while (it.hasNext()) 
			{
				this.insert(it.next()) ;
			}
		}
		else if (arg instanceof vegas.data.Collection) 
		{
			var it = arg.iterator() ;
			while (it.hasNext()) 
			{
				this.insert( it.next() ) ;
			}
		}
		else if (typeof (arg) == "number") 
		{
			this._a.length = arg ;
		}
		
	}
	
	// Inherit
	vegas.data.list.ArrayList.extend(vegas.data.list.AbstractList) ;

	/**
	 * Creates and returns a shallow copy of the object.
	 * @return A new object that is a shallow copy of this instance.
	 */	
	vegas.data.list.ArrayList.prototype.clone = function() 
	{
		return new vegas.data.list.ArrayList( this.toArray() ) ;
	}

	/**
	 * Increases the capacity of this ArrayList instance, if necessary, to ensure that it can hold at least the number of elements specified by the minimum capacity argument.
	 */
	vegas.data.list.ArrayList.prototype.ensureCapacity = function(n) 
	{
		this._a.length = n ;
	}
	
}