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
 * CoreObject offers a default implementation of the IFormattable, IHashable and ISerializable interfaces.
 * <p>
 * {@code
 * 
 * CoreObject = vegas.core.CoreObject ;
 *  
 * var core = new CoreObject() ;
 * 
 * trace("> core : " + core) ;
 * trace("> hashcode : " + core.hashCode()) ;
 * trace("> toSource : " + core.toSource()) ;
 * }
 * </p>
 * @author eKameleon
 */
if (vegas.core.CoreObject == undefined) 
{

	/**
	 * Creates a new CoreObject instance.
	 */
	vegas.core.CoreObject = function () 
	{
		//
	}
	
	/**
	 * @extends Object
	 */
	proto = vegas.core.CoreObject.extend(Object) ;

	/**
	 * Returns the internal {@code ILogger} reference of this {@code ILogable} object.
	 * @return the internal {@code ILogger} reference of this {@code ILogable} object.
	 */
	proto.getLogger = function() /*ILogger*/
	{
		return this._logger ; 	
	}

	/**
	 * Sets the internal {@code ILogger} reference of this {@code ILogable} object.
	 */
	proto.setLogger = function( log /*ILogger*/ ) /*void*/ 
	{
		this._logger = log ;
	}

	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function () /*String*/ 
	{
		return "new " + this.getConstructorPath() + "()" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	proto.toString = function () /*String*/ 
	{
		return "[" + this.getConstructorName() + "]" ;
	}
	
	/**
	 * The internal ILogger reference of this object.
	 */
	/*private*/ proto._logger /*ILogger*/ = null ;
	
	encapsulate(proto) ;
	
}