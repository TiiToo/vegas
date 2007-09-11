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
 * The error throws when a fatal method or action is detected in the code.
 * This error notify a fatal level message in the vegas.errors.* logging category.
 * <p><b>Example :</b></p>
 * {@code
 * var e = new vegas.errors.FatalError("A little fatal error.") ;
 * try
 * {
 *     if (e) throw (e) ;
 * }
 * catch(e)
 * {
 *     trace( e.toString() ) ; // use toString with trace !!
 * }
 * }
 * @author eKameleon
 */
if (vegas.errors.FatalError == undefined) 
{
	
	/**
	 * @requires vegas.errors.AbstractError
	 */
	require("vegas.errors.AbstractError") ;
	
	/**
	 * Creates a new FatalError instance.
	 */
	vegas.errors.FatalError = function( message /*String*/ , e /*ErrorElement*/ ) 
	{
		vegas.errors.AbstractError.call(this, message, e) ; // super() ;
	}
	
	/**
	 * @extends vegas.errors.AbstractError
	 */
	vegas.errors.FatalError.extend( vegas.errors.AbstractError ) ;

	/**
	 * Returns the String representation of this object.
	 * @return the String representation of this object.
	 */
	vegas.errors.FatalError.prototype.toString = function () /*String*/ 
	{
		var msg /*String*/ = "## " + this.name + " : " + this.message + " ##" ;
		this.getLogger().fatal(msg) ;
		return msg ;
	}
		
}