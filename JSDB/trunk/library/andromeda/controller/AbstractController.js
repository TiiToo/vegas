/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This class provides a skeletal implementation of the {@code IController} interface, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
if (andromeda.controller.AbstractController == undefined) 
{
	
	/**
	 * @requires andromeda.controller.IController
	 */
	require("andromeda.controller.IController") ;
	
	/**
	 * Creates a new AbstractController instance.
	 */
	andromeda.controller.AbstractController = function () 
	{ 
		
	}

	/**
	 * @extends andromeda.controller.IController
	 */
	andromeda.controller.AbstractController.extend(andromeda.controller.IController) ;

}