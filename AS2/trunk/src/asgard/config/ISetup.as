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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ISetup

	AUTHOR
	
		Name : ISetup
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2006-03-27
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- getConfig():Config
		
		- getConfigLoader():ConfigLoader
		
		- getRunning():Boolean
		
		- notifyChange():Void
		
		- release():Void
		
		- run():Void
		
		- setConfig(conf:Config):Void
	
		- setLoader(sFileName:String, sPath:String, sSuffix:String):Void
		
		- update():Void 
	
	
	IMPLEMENT
	
		IRunnable

----------  */

import asgard.config.Config;
import asgard.config.ConfigLoader;

import vegas.core.IRunnable;

/**
 * @author eKameleon
 */
interface asgard.config.ISetup extends IRunnable {
	
	function getConfig():Config ;

	function getConfigLoader():ConfigLoader ;
	
	function getRunning():Boolean ;

	function notifyChange():Void ;

	function release():Void ;
	
	function setLoader(sFileName:String, sPath:String, sSuffix:String):Void ;

	function update():Void ;

	
	
}