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


import asgard.config.Config;
import asgard.config.ConfigLoader;

import vegas.core.IRunnable;

/**
 * This interface defines a tool to invoqued the configuration of your application.
 * @author eKameleon
 */
interface asgard.config.ISetup extends IRunnable 
{

	/**
	 * Returns the reference of the Config singleton.
	 * @return the reference of the Config singleton.
	 */
	function getConfig():Config ;
	
	/**
	 * Returns the reference of the ConfigLoader use by this object to load the configuration of the application.
	 * @return the reference of the ConfigLoader use by this object to load the configuration of the application
	 */
	function getConfigLoader():ConfigLoader ;
	
	/**
	 * Returns {@code true} if the object is running.
	 * @return {@code true} if the object is running.
	 */
	function getRunning():Boolean ;


	/**
	 * Notify an UIEvent with the event type {@code UIEventType.CHANGE}.
	 */
	function notifyChange():Void ;

	/**
	 * Calls this method to release the object.
	 */
	function release():Void ;

	/**
	 * Sets the loader of this object.
	 */
	function setLoader(sFileName:String, sPath:String, sSuffix:String):Void ;

	/**
	 * Update the object.
	 */
	function update():Void ;

}