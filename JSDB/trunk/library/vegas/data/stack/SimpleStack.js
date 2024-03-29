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
 * The based implementation of the Stack interface.
 * The Stack interface represents a last-in-first-out (LIFO) stack of objects.
 * <p><b>Example :</b></p>
 * {@code
 * var s = new vegas.data.stack.SimpleStack() ;
 * 
 * s.push("item1") ;
 * s.push("item2") ;
 * s.push("item3") ;
 * 
 * trace ("stack peek : " + s.peek()) ;
 * trace ("stack pop : " + s.pop()) ;
 * 
 * trace ("stack.toSource : " + s.toSource()) ;
 * trace ("toString : " + s) ;
 * 
 * trace ("stack iterator") ;
 * var i = s.iterator() ;
 * while (i.hasNext())
 * {
 *     trace ( " - " + i.next()) ;
 * }
 * }
 * @author eKameleon
 */
if (vegas.data.stack.SimpleStack == undefined) 
{
	
	/**
	 * Creates a new SimpleStack instance.
	 * @param ar an array to fill the Stack
	 */
	vegas.data.stack.SimpleStack = function ( ar/*Array*/ ) 
	{ 
		vegas.data.collections.AbstractCollection.apply(this, [ar]) ;
	}

	/**
	 * @extends vegas.data.collections.AbstractCollection
	 */
	proto = vegas.data.stack.SimpleStack.extend(vegas.data.collections.AbstractCollection) ;

	/**
	 * Returns a shallow copy of this object.
	 * @return a shallow copy of this object.
	 */
	proto.clone = function () 
	{
		return new vegas.data.stack.SimpleStack(this._a) ;
	}

	/**
	 * Returns an element but if id = 0, it's the last element in the stack.
	 * @return an element but if id = 0, it's the last element in the stack.
	 */
	proto.get = function ( id/*Number*/ ) 
	{
		var a/*Array*/ = this.toArray() ;
		return a[id]  ;
	}

	/**
	 * Returns an iterator over the elements in this Stack.
	 * @return an iterator over the elements in this Stack.
	 */
	proto.iterator = function () 
	{
		return new vegas.data.iterator.ProtectedIterator(new vegas.data.iterator.ArrayIterator(this.toArray())) ;
	}

	/**
	 * Looks at the object at the top of this stack without removing it from the stack.
	 */
	proto.peek = function () 
	{
		return this._a[this._a.length - 1] ;
	}

	/**
	 * Removes the object at the top of this stack and returns that object as the value of this function.
	 * @return the removed object value.
	 */
	proto.pop = function () 
	{
		return this.isEmpty() ? null : this._a.pop() ;
	}

	/**
	 * Pushes an item into the top of this stack.
	 */
	proto.push = function (o)/*void*/ 
	{
		this._a.push(o) ;
	}

	/**
	 * Returns the index of an element in the Stack.
	 * @return the index of an element in the Stack.
	 */
	proto.search = function (o)/*Number*/ 
	{
		return this.indexOf(o) ;
	}

	/**
	 * Returns the array representation of all the elements of this Stack.
	 * @return the array representation of all the elements of this Stack.
	 */
	proto.toArray = function ()/*Array*/ 
	{
		var aReverse/*Array*/ = this._a.slice() ;
		aReverse.reverse() ;
		return aReverse ;
	}

	delete proto ;
	
}