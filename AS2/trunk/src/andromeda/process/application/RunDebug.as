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

import andromeda.process.abstract.AbstractInitProcess;

import asgard.config.Config;
import asgard.system.Lang;
import asgard.system.Locale;
import asgard.system.Localization;

/**
 * This process is launch to debug an application who contains a Config and a Localization object.
 * @author eKameleon
 */
class andromeda.process.application.RunDebug extends AbstractInitProcess 
{
	
	/**
	 * Creates a new RunDebug instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	function RunDebug(bGlobal : Boolean, sChannel : String) 
	{
		super(bGlobal, sChannel);
	}
	
	/**
	 * Launch the debug process in this method.
	 */
	public function init():Void
	{
		
		getLogger().debug( this + " run") ;
		
		// View in the logs the default Configuration content
		
		var conf:Config = Config.getInstance() ;
		
		if ( conf.verbose != true )
		{
			return ;
		}
		
		getLogger().debug( this + " config") ;
		var space:String = "   " ;
		for (var each:String in conf) 
		{
			getLogger().info( space + "+ " + each + " : " + conf[each]) ;
			for (var prop:String in conf[each]) 
			{
				getLogger.info( space + space + "+ " + prop + " : " + conf[each][prop]) ;
			}
		}
		
		// View in the logs the default localization content 
		
		var target:Localization = Localization.getInstance();
		var current:Lang        = target.getCurrent() ;
		var locale:Locale       = target.getLocale() ;

		getLogger().debug( this + " localization : " + current ) ;
		
		for (var each:String in locale) 
		{
			getLogger().info( space + "+ " + each + " : " + locale[each]) ;
			for (var prop:String in locale[each]) 
			{
				getLogger().info( space + space + "+ " + prop + " : " + locale[each][prop]) ;
			}
		}
	}

}