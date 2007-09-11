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
 * Thrown to indicate that the code has attempted to cast an object to a subclass of which it is not an instance.
 * @author eKameleon
 */
if (vegas.errors.ClassCastError == undefined) 
{
	
	/**
	 * @requires vegas.errors.FatalError
	 */
	require("vegas.errors.FatalError") ;
	
	/**
	 * Creates a new ClassCastError instance.
	 */
	vegas.errors.ClassCastError = function( message /*String*/ , e /*ErrorElement*/ ) 
	{
		vegas.errors.FatalError.call(this, message, e) ; // super() ;
	}
	
	/**
	 * @extends vegas.errors.FatalError
	 */
	vegas.errors.ClassCastError.extend( vegas.errors.FatalError ) ;

}
