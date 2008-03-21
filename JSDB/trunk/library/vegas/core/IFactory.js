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
 * Defines an interface implemented by classes that create objects.
 * @author eKameleon
 */
if (vegas.core.IFactory == undefined) 
{

	vegas.core.IFactory = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.core.IFactory.extend(vegas.core.CoreObject) ;

	/**
	 * Returns and creates a new Object.
	 */
	vegas.core.IFactory.prototype.create = function() 
	{
		//
	}

}