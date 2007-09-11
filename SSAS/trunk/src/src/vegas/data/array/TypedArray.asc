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
 * {@code TypedArray} acts like a normal array but assures that only objects of a specific type are added to the array.
 * <p><b>Example :</b></p>
 * {@code
 * import vegas.data.array.TypedArray ;
 * 
 * var ta:TypedArray = new TypedArray(String, ["item1", "item2", "item3"]) ;
 * trace ("ta : " + ta) ; // output : ta : item1,item2,item3
 * ta.push(2) ; // [TypeMismatchError] TypedArray.validate('value':2) is mismatch
 * }
 * @author eKameleon 
 */
if (vegas.data.array.TypedArray == undefined) 
{
	
	/**
	 * Creates a new TypedArray instance.
	 */
	vegas.data.array.TypedArray = function ( type/*Function*/, ar /*Array*/ ) 
	{ 
		if (type == null) 
		{
			throw new vegas.events.IllegalArgumentError("TypedArray constructor, Argument 'type' must not be 'null' nor 'undefined'.") ;
		}
		this._type = type ;
		if (ar instanceof Array && ar.length > 0) 
		{
			var len = ar.length ;
			for (var i = 0 ; i<len ; i++) 
			{
				var value = ar[i] ;
				if (this.supports(value)) 
				{
					this.push(value) ;
				}
			}
		}
	}

	/**
	 * @extends Array
	 */
	vegas.data.array.TypedArray.extend( Array ) ;

	/**
	 * Creates and returns a shallow copy of the object.
	 */	
	vegas.data.array.TypedArray.prototype.clone = function () 
	{
		return new vegas.data.array.TypedArray(this.getType(), this.slice()) ;
	}

	/**
	 * Concatenates the elements specified in the parameter list with the elements of this array and returns a new array containing these element.
	 * @return a new array that contains the elements of this array as well as the passed-in elements.
	 */
	vegas.data.array.TypedArray.prototype.concat = function () 
	{
		var r = new vegas.data.array.TypedArray(this.getType()) ;
		var i, j, k, l1, l2 ;
		var o  ;
		i = this.length ;
		while(--i>-1) 
		{
			r.push(this[i]);
		}
		l1 = arguments.length ;
		j = -1 ;
		while(++j < l1) 
		{
			var cur = arguments[j] ;
			if (cur instanceof Array) 
			{
				l2 = cur.length ;
				k = -1 ;
				while (++k < l2) 
				{
					o = cur[k] ;
					if (this.supports(o)) {
						r.push(o);
					}
				}
			} else 
			{
				if (this.supports(cur)) 
				{
					r.push(cur);
				}
			}
		}
		return r ;
	}
	
	/**
	 * Returns the type of the ITypeable object.
	 * @return the type of the ITypeable object.
	 */
	vegas.data.array.TypedArray.prototype.getType = function() 
	{
		return this._type;
	}

	/**
	 * Returns the iterator of the object.
	 * @return the iterator of the object.
	 */	
	vegas.data.array.TypedArray.prototype.iterator = function () /*Iterator*/ 
	{
		return new vegas.data.iterator.ArrayIterator(this) ;
	}

	/**
	 * Adds one or more elements to the end of this array and returns the new length of this array.
	 * @return the new length of this array
	 * @throws TypeMismatchError 
	 */	
	vegas.data.array.TypedArray.prototype.push = function (value) 
	{
		if (arguments.length > 1) {
			var len = arguments.length;
			var i = 0 ;
			while (++i < len) {
				this.validate(arguments[i]) ;
			}
		}
		else 
		{
			this.validate(value) ;
		}
		return this.__constructor__.prototype.push.apply(this, arguments) ;
	}

	/**
	 * Sets the type of the ITypeable object.
	 */	
	vegas.data.array.TypedArray.prototype.setType = function(type/*Function*/) 
	{
		this._type = type ;
		this.length = 0 ;
	}
	
	/**
	 * Returns true if the IValidator object validate the value.
	 */
	vegas.data.array.TypedArray.prototype.supports = function(value) 
	{
		return ( vegas.util.TypeUtil.typesMatch(value, this._type) == true ) ;
	}

	/**
	 * Returns a eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	vegas.data.array.TypedArray.prototype.toSource = function(indent/*Number*/, indentor/*String*/) /*String*/ 
	{
		var sourceA = vegas.util.TypeUtil.toString(this._type) ;
		var sourceB = Array.prototype.toSource.apply(this) ;
		return "new vegas.data.array.TypedArray(" + sourceA + "," + sourceB + ")" ;
	}

	/**
	 * Adds one or more elements to the beginning of this array and returns the new length of this array.
	 * @return the new length of this array
	 */
	vegas.data.array.TypedArray.prototype.unshift = function(value) 
	{
		if (arguments.length > 1) 
		{
			var len = arguments.length ;
			var i = -1 ;
			while (++i < l ) 
			{
				this.validate(arguments[i]);
			}
		} 
		else 
		{
			this.validate(value) ;
		}
		return Number(Array.prototype.unshift.apply(this, arguments)) ;
	}

	/**
	 * Evaluates the condition it checks and updates the IsValid property.
	 * @throws vegas.errors.TypeMismatchError 
	 */
	vegas.data.array.TypedArray.prototype.validate = function(value) 
	{
		if (!this.supports(value)) 
		{
			throw new vegas.errors.TypeMismatchError("TypedArray.validate('" + value + "') is mismatch.")
		}
	}
	
}