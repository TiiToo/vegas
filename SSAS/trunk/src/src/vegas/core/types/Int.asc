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
 * Represents an integer value.
 * <p>A integer is a positive or negative natural number including 0.</p>
 * <p><b>Example :</b></p>
 * {@code
 * var i = new vegas.core.types.Int( 2.54 ) ;
 * 
 * trace("i toSource : " + i.toSource()) ;
 * trace("2.54 -> Int : " + i) ;
 * 
 * var i = new vegas.core.types.Int( -15.5 ) ;
 * trace("-15.5 -> Int : " + i) ;
 * 
 * var i = new vegas.core.types.Int( undefined ) ;
 * trace("undefined -> Int : " + i) ;
 * 
 * var i = new vegas.core.types.Int( null ) ;
 * trace("null -> Int : " + i) ;
 * 
 * var i = new vegas.core.types.Int( Infinity ) ;
 * trace("Infinity -> Int : " + i) ;
 * }
 */
if (vegas.core.types.Int == undefined) 
{

	/**
	 * Creates a new Int instance.
	 * @param n the number to convert to an Int.
	 * @throws NumberFormatError if the value passed in argument is Infinity or -Infinity
	 */
	vegas.core.types.Int = function ( n/*Number*/) 
	{ 
		
		if (n == Infinity || n == -Infinity) 
		{
			throw new vegas.errors.NumberFormatError("Int constructor, 'n' value not must be Infinity or -Infinity.") ;
		}
		else 
		{
			this._n = [n - n%1] ;
		}
		
	}
	
	/**
	 * @extends Number
	 */
	vegas.core.types.Int.extend ( Number ) ;
	
	/**
	 * Returns a eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	vegas.core.types.Int.prototype.toSource = function() /*String*/ 
	{
		return "new " + this.getConstructorPath() + "(" + this.valueOf() + ")" ;
	}	

	/**
	 * Returns a String representation of the object.
	 * @return a String representation of the object.
	 */
	vegas.core.types.Int.prototype.toString = function() /*String*/ 
	{
		return String(this._n) ;
	}	

	/**
	 * Returns the real value of the object.
	 */
	vegas.core.types.Int.prototype.valueOf = function() 
	{
		return this._n ;
	}

	vegas.core.types.Int.prototype._n /*Number*/ = 0 ;
	
}