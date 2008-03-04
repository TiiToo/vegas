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
 * This class provides a Abstract implementation to creates Error classes with an internal logging model. 
 * @author eKameleon
 */
if ( vegas.errors.AbstractError == undefined ) 
{

	/**
	 * @requires vegas.logging.Log
	 */
	require("vegas.logging.Log") ;
    
	/**
	 * Creates a new AbstractError only if you inherit this class.
	 */
	vegas.errors.AbstractError = function( message /*String*/ , e /*ErrorElement*/ ) 
	{
		
		this.errorElement = e || null ;
		
		this.name = vegas.util.ConstructorUtil.getName(this, vegas) ;
		
		this.message = message ;
		
		var category = this.getConstructorPath() ;
		
		this._logger = vegas.logging.Log.getLogger( category ) ;
		
	}

	/**
	 * @extends Error
	 */
	vegas.errors.AbstractError.extend( Error ) ;

	/**
	 * The internal ErrorElement reference.
	 */
	vegas.errors.AbstractError.prototype.errorElement /*ErrorElement*/ = null ;
	
	/**
	 * The category of the internal ILogger of this object.
	 */
	vegas.errors.AbstractError.prototype.getCategory = function () /*String*/ 
	{
		return (this._logger.category != null) ? this._logger.category : null ;
	}

	/**
	 * Returns the internal ILogger of the current Error.
	 * @return the internal ILogger of the current Error.
	 */
	vegas.errors.AbstractError.prototype.getLogger = function () /*ILogger*/ 
	{
		return this._logger ;
	}
	
	/**
	 * Sets the internal {@code ILogger} reference of this {@code ILogable} object.
	 */
	vegas.errors.AbstractError.prototype.setLogger = function( log /*ILogger*/ ) /*void*/
	{
		this._logger = log ;
	}
	
	vegas.errors.AbstractError.prototype._logger /*ILogger*/ = null ;
	
}
