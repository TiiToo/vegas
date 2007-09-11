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
 * TypedQueue is a wrapper for Stack instances that ensures that only values of a specific type can be added to the wrapped stack.
 * <p><b>Example :</b></p>
 * {@code
 * var s = new vegas.data.stack.SimpleStack() ;
 * s.push("item1") ;
 * s.push("item2") ;
 * s.push("item3") ;
 * 
 * var ts = new vegas.data.stack.TypedStack(String, s) ;
 * ts.push("item4") ;
 * 
 * trace("stack >> " + ts.size() + " : " + ts) ;
 * trace("stack.toSource : " + ts.toSource()) ;
 * 
 * ts.push(2) ;
 * }
 * @author eKameleon
 */
if (vegas.data.stack.TypedStack == undefined) 
{

	/**
	 * @requires vegas.util.AbstractTypeable
	 */
	require("vegas.util.AbstractTypeable") ;

	/**
	 * Creates a new TypedStack instance.
	 * @param type the type class of this ITypeable object.
	 * @param stack the Stack reference protected with this ITypeable object.
	 * @throws IllegalArgumentError if the {@code type} argument is {@code null} or {@code undefined}.
	 * @throws IllegalArgumentError if the {@code stack} argument is {@code null} or {@code undefined}.
	 */
	vegas.data.stack.TypedStack = function ( type /*Function*/ , stack /*Stack*/ ) 
	{ 
		this.__constructor__.call(this, type) ;
		if (stack == null) 
		{
			throw new vegas.errors.IllegalArgumentError("TypedStack constructor, argument 'stack' must not be 'null' or 'undefined'") ;
		}
		if (stack.size() > 0) 
		{
			var it = stack.iterator() ;
			while ( it.hasNext() ) 
			{
				this.validate(it.next()) ;
			}
		}
		this._stack = stack ;
	}
	
	/**
	 * @extends vegas.util.AbstractTypeable
	 */
	proto = vegas.data.stack.TypedStack.extend(vegas.util.AbstractTypeable) ;

	/**
	 * Removes all of the elements from this Stack (optional operation).
	 */
	proto.clear = function () 
	{
		this._stack.clear() ;
	}

	/**
	 * Returns a shallow copy of this Stack (optional operation).
	 * @return a shallow copy of this Stack (optional operation).
	 */
	proto.clone = function () 
	{
		return new vegas.data.stack.TypedStack(this.getType(), this._queue.clone()) ;
	}

	/**
	 * Returns {@code true} if this Stack contains no elements.
	 * @return {@code true} if this Stack contains no elements.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._stack.isEmpty() ;
	}

	/**
	 * Returns an iterator over the elements in this Stack.
	 * @return an iterator over the elements in this Stack.
	 */
	proto.iterator = function ()/*Iterator*/ 
	{
		return this._stack.iterator() ;
	}

	/**
	 * Looks at the object at the top of this stack without removing it from the stack.
	 */
	proto.peek = function () 
	{
		return this._stack.peek() ;
	}

	/**
	 * Removes the object at the top of this stack and returns that object as the value of this function.
	 */
	proto.pop = function () 
	{
		return this._stack.poll() ;
	}

	/**
	 * Pushes an item onto the top of this stack.
	 */
	proto.push = function (o) 
	{
		this.validate(o) ;
		this._stack.push(o) ;
	}

	/**
	 * Returns the 1-based position where an object is on this stack.
	 */
	proto.search = function (o) /*Number*/ 
	{
		return this._search(o) ;
	}

	/**
	 * Sets the type of this ITypeable object.
	 */
	proto.setType = function (type /*Function*/) /*void*/ 
	{
		this.__constructor__.prototype.setType.call(this, type) ;
		this._stack.clear() ;
	}

	/**
	 * Returns the number of elements in this Stack.
	 * @return the number of elements in this Stack.
	 */
	proto.size = function ()/*Number*/ 
	{
		return this._stack.size() ;
	}

	/**
	 * Returns the array representation of all the elements of this Stack.
	 * @return the array representation of all the elements of this Stack.
	 */
	proto.toArray = function ()/*Array*/ 
	{
		return this._stack.toArray() ;
	}

	/**
	 * Returns a eden representation of the object.
	 * @return a string representation the source code of the object.
	 */
	proto.toSource = function (indent/*Number*/, indentor/*String*/)/*String*/ 
	{
		var sourceA/*String*/ = vegas.util.TypeUtil.toString(this._type) ;
		var sourceB/*String*/ = this._stack.toSource() ;
		return "new vegas.data.stack.TypedStack(" + sourceA + "," + sourceB + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	proto.toString = function ()/*String*/ 
	{
		return this._stack.toString() ;
	}
	
	delete proto ;
	
}