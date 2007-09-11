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
 * The JSON error class.
 */
if (vegas.string.errors.JSONError == undefined) 
{
	
	/**
	 * @requires vegas.errors.FatalError
	 */
	require("vegas.errors.FatalError") ;
	
	/**
	 * Creates a new JSONError instance.
	 */
	vegas.string.errors.JSONError = function (message/*String*/, at/*Number*/, source/*String*/) 
	{
		vegas.errors.FatalError.call(this, message) ; // super() ;		
		this.at = at ;
		this.source = source ;
	}
	
	/**
	 * @throws 
	 */
	vegas.string.errors.JSONError.extend( vegas.errors.FatalError ) ;

	/**
	 * The position of the error in the source.
	 */
	vegas.string.errors.JSONError.prototype.at /*Number*/ = null ;

	/**
	 * The bad source representation. 
	 */
	vegas.string.errors.JSONError.prototype.source /*String*/ = null ;

	vegas.string.errors.JSONError.prototype.toString = function () /*String*/ 
	{
		var ret /*String*/ = "## " + this.name + " : " + this.message ;
		if (!isNaN(this.at)) 
		{
			ret += ', at:' + this.at ;
		}
		if (this.source != null) 
		{
			ret += ' in "' + this.source + '"' ;
		}
		ret += " ##" ;
		this.getLogger().fatal(ret) ;
		return ret ;
	}

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
