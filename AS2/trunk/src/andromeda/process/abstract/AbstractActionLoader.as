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

import andromeda.core.ApplicationCommand;

import asgard.config.Config;
import asgard.events.LoaderEvent;
import asgard.net.ILoader;

import pegas.process.SimpleAction;

import vegas.events.Delegate;
import vegas.events.EventTarget;

/**
 * This skeletal class simplify the implementation of the process with an internal ILoader process in the application.
 * @author eKameleon
 */
class andromeda.process.abstract.AbstractActionLoader extends SimpleAction 
{

	/**
	 * Creates a new AbstractActionLoader instance.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param loaderPolicy optional boolean flag to indicates if the loader use the loading view or not (defaut this value is true).
	 */	
	function AbstractActionLoader( bGlobal:Boolean, sChannel:String , loaderPolicy:Boolean ) 
	{
		super(bGlobal, sChannel);
		if ( loaderPolicy != null )
		{
			this.loaderPolicy = loaderPolicy ; 	
		}
	}
	
	/**
	 * The loader policy (visible or not)
	 */
	public var loaderPolicy:Boolean = true ;
	
	/**
	 * Returns the config object of the application. 
	 * You can overrides this method.
	 * @return the config object of the application.
	 */
	public function getConfig()
	{
		return Config.getInstance() ;
	}	

	/**
	 * Notify an ActionEvent when the process is finished.
	 */
	public function notifyFinished():Void
	{
		_setRunning(false) ;
		if( loaderPolicy == true )
		{
			ApplicationCommand.hideLoader() ;
		}
		super.notifyFinished() ;	
	}
	
	/**
	 * Notify an ActionEvent when the process is started.
	 */
	public function notifyStarted():Void
	{
		_setRunning(true) ;
		super.notifyStarted() ;	
	}

	/**
	 * Register the process loader object.
	 */
	public function registerLoader( loader:ILoader )
	{
		EventTarget(loader).addEventListener( LoaderEvent.COMPLETE , new Delegate(this, _onLoadComplete ) ) ;
 		EventTarget(loader).addEventListener( LoaderEvent.IO_ERROR , new Delegate(this, _onLoadError    ) ) ;
 		EventTarget(loader).addEventListener( LoaderEvent.PROGRESS , new Delegate(this, _onLoadProgress ) ) ;
 		EventTarget(loader).addEventListener( LoaderEvent.TIMEOUT  , new Delegate(this, _onLoadTimeout  ) ) ;
 		return loader ;
	}

	private function _onLoadError(ev:LoaderEvent):Void
	{
	    getLogger().error(  this + " " + ev.getType() + " : " + ev.error ) ;
	   	notifyFinished() ;
	}
	
	private function _onLoadComplete(ev:LoaderEvent):Void
	{
	    getLogger().debug( this + " load complete." ) ;
        if( loaderPolicy == true )
        {
	       ApplicationCommand.changeLoader( this + " " + "100%", 100 ) ;
        }
	}	
	
	private function _onLoadProgress (ev:LoaderEvent):Void
	{
	    getLogger().info(  this + " load progress : " + ev.getPercent() + "%") ;
	    if( loaderPolicy == true )
		{
	   		ApplicationCommand.changeLoader( this + " " + ev.getPercent() + "%", ev.getPercent() ) ;
		}
	}
	
	private function _onLoadTimeout (ev:LoaderEvent):Void
	{
		getLogger().debug(  this + " load timeout." ) ;
	   	notifyFinished() ;
	}

}