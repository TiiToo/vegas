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
 * An object of type Char contains a single field whose type is String.
 * <p><b>Example :</b></p>
 * {@code
 * var c = new vegas.core.types.Char("Test") ;
 * trace("char : " + c) ;
 * trace("char code : " + c.getCode()) ;
 * trace("char size : " + c.length) ;
 * trace("char toSource : " + c.toSource()) ;
 * }
 * @author eKameleon
 */
if (vegas.core.types.Char == undefined) 
{

	/**
	 * Creates a new Char instance.
	 */
	vegas.core.types.Char = function ( s /*String*/ ) 
	{
		if (vegas.util.TypeUtil.typesMatch(s, String)) 
		{
			this._char = (s || "").substring(0, 1) ;
		}
		else 
		{
			throw new vegas.errors.IllegalArgumentError("Char constructor, 's' value must be a String.") ;
		}
	}

	vegas.core.types.Char.extend(String) ;
	
	/**
	 * Returns the integer character code for the character.
	 * @return the integer character code for the character.
	 */
	vegas.core.types.Char.prototype.getCode = function() /*Number*/ 
	{
		return this._char.charCodeAt(0) ;
	}

	/**
	 * Returns a eden reprensation of the object.
	 * @return a eden string representation of the source code of this object.
	 */
	vegas.core.types.Char.prototype.toSource = function() /*String*/ 
	{
		return "new " + this.getConstructorPath() + "(" + this._char.toSource() + ")" ;
	}	

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	vegas.core.types.Char.prototype.toString = function() /*String*/ 
	{
		return this._char.toString() ;
	}

	/**
	 * Returns the real value of the object.
	 * @return the real value of the object.
	 */
	vegas.core.types.Char.prototype.valueOf = function() 
	{
		return this._char.valueOf() ;
	}
	
	vegas.core.types.Char.prototype._char /*String*/ = null ;

}