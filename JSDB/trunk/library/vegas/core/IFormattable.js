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
 * Provides functionality to format the value of an object into a string representation.
 * @author eKameleon
 */
if (vegas.core.IFormattable == undefined) 
{

	vegas.core.IFormattable = function () {}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.core.IFormattable.extend(vegas.core.CoreObject) ;

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	vegas.core.IFormattable.prototype.toString = function() /*String*/ 
	{
		//
	}

}