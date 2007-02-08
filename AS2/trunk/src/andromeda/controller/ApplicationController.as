/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.FrontController;

/**
 * The singleton FrontController of the application.
 * @author eKameleon
 */
class andromeda.controller.ApplicationController extends FrontController 
{
	
	/**
	 * Singleton of the global FrontController in the application.
	 */
	private function ApplicationController() 
	{
		//
	}
	
	/**
	 * Returns the singleton instance of the ApplicationController.
	 */
	static public function getInstance():ApplicationController 
	{
		if ( ! _instance ) 
		{
			_instance = new ApplicationController() ;
		}
		return _instance ;
	}

	/**
	 * The internal singleton reference of the Controller.
	 */
	static private var _instance:ApplicationController ;

}