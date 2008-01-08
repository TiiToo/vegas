/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is MarS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.config.ConfigEdenLoader;
import asgard.events.LoaderEvent;

import mars.process.abstract.AbstractActionLoader;

import vegas.events.Delegate;

/**
 * This control launch the loading of the configuration.
 * @author eKameleon
 */
class mars.process.application.RunConfig extends AbstractActionLoader
{
	
	/**
	 * Creates a new RunConfig instance.
	 * @param fileName The name of the config file (default "config").
	 * @param pathName The path of the config file (default "config/").
	 * @param suffixName The suffix of the config file (default ".eden").
	 * @param security The boolean flag to indicates if the eden deserialize is secure or not.
 	 * @param loaderPolicy optional boolean flag to indicates if the loader use the loading view or not (defaut this value is true).
 	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	public function RunConfig( fileName:String , pathName:String, suffixName:String , security:Boolean , loaderPolicy:Boolean , bGlobal:Boolean, sChannel:String ) 
	{
		
		super( bGlobal , sChannel , loaderPolicy ) ;
		
		if (fileName != null)
		{
			this.fileName   = fileName ;
		}
		if (pathName != null)
		{
			this.pathName   = pathName ;
		}
		if (suffixName != null)
		{
			this.suffixName = suffixName ;
		}
		if ( security != null )
		{
			this.security = security ;	
		}
	}

	/**
	 * The name of the config file.
	 */
	public var fileName:String = "config" ;
	
	/**
	 * The name of the path of the config file.
	 */
	public var pathName:String = "config/";
    
    /**
     * Indicates if use security to load the external config.
     */
    public var security:Boolean = true ;
    
	/**
	 * The name of the suffix of the config file.
	 */
	public var suffixName:String = ".eden" ;

	/**
	 * Run the process.
	 */
	public function run() 
	{
		
		notifyStarted() ;
			
		getLogger().debug( this + " run.") ;

        buRRRn.eden.Application._trace = Delegate.create(this , _trace ) ;
        buRRRn.eden.config.security = security ;
		
		var loader:ConfigEdenLoader = new ConfigEdenLoader() ;
		if (fileName)
		{
			loader.fileName = fileName ;
		}
		if ( pathName )
		{
			loader.path = pathName ;
		}
		if ( suffixName )
		{
			loader.suffix = suffixName ;
		}
		loader.addEventListener(LoaderEvent.START , new Delegate(this, notifyStarted), null, 1000, true) ;
		loader.addEventListener(LoaderEvent.INIT  , new Delegate(this, notifyFinished), null, 1000, true) ;
		registerLoader( loader ) ;

		loader.load() ;
		
	}

    /**
     * Invoked by the Eden tracer.
     */
    private function _trace( message:String ):Void
    {
        getLogger().warn( this + " : " + message ) ;
    }
    
}
	