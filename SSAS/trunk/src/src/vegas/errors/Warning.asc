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
 * Thrown to indicate a warning message in an application or in the source code.
 * @author eKameleon
 */
if (vegas.errors.Warning == undefined) 
{

	/**
	 * Creates a new Warning instance.
	 */
	vegas.errors.Warning = function( message /*String*/ , e /*ErrorElement*/ ) 
	{
		vegas.errors.AbstractError.call(this, message, e) ; // super() ;
	}

	/**
	 * @extends vegas.errors.AbstractError
	 */
	vegas.errors.Warning.extend( vegas.errors.AbstractError ) ;

	/**
	 * Returns the String representation of this object.
	 * @return the String representation of this object.
	 */
	vegas.errors.Warning.prototype.toString = function () /*String*/ 
	{
		var msg /*String*/ = "## " + this.name + " : " + this.message + " ##" ;
		this.getLogger().warn(msg) ;
		return msg ;
	}
		
}
