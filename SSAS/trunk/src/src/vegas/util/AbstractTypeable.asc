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
 * This abstract class is used to create concrete {@code ITypeable} implementations.
 * @author eKameleon
 * @see ITypeable
 * @see IValidator
 */
if (vegas.util.AbstractTypeable == undefined) 
{

	/**
	 * Creates a new ITypeable instance if you extend this class.
	 * @param type the Type of this ITypeable object.
	 */
	vegas.util.AbstractTypeable = function ( type /*Function*/ ) 
	{ 
		if (type == null) 
		{
			throw new vegas.events.IllegalArgumentError(this + " constructor, Argument 'type' must not be 'null' nor 'undefined'.") ;
		}
		this._type = type ;
	}

	/**
	 * @extends vegas.core.ITypeable
	 */
	proto = vegas.util.AbstractTypeable.extend(vegas.core.ITypeable) ;

	/**
	 * Returns the type of the ITypeable object.
	 * @return the type of the ITypeable object.
	 */
	proto.getType = function() /*Void*/ 
	{
		return this._type ;
	}

	/**
	 * Sets the type of the ITypeable object.
	 */
	proto.setType = function (type/*Function*/) /*void*/ 
	{
		this._type = type ;
	}

	/**
	 * Returns {@code true} if the IValidator object validate the value.
	 * @return {@code true} is this specific value is valid.
	 */
	proto.supports = function (value) /*Boolean*/ 
	{
		return vegas.util.TypeUtil.typesMatch(value, this._type) ;
	}
	
	/**
	 * Evaluates the condition it checks and updates is valide.
	 */
	proto.validate = function (value) /*void*/ 
	{
		if (!this.supports(value)) 
		{
			throw new vegas.errors.TypeMismatchError(this + ".validate('" + value + "') is mismatch.")
		}
	}
	
	delete proto ;
	
}