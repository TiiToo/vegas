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

import asgard.events.LoaderEvent;
import asgard.net.StyleSheetLoader;
import asgard.net.URLRequest;
import asgard.text.StyleModel;

import mars.process.abstract.AbstractActionLoader;

import vegas.events.Delegate;
import vegas.events.EventListener;

/**
 * Launch the loading of the external stylesheet of this application.
 * @author eKameleon
 */
class mars.process.application.RunStyle extends AbstractActionLoader 
{
	
	/**
	 * Creates a new RunStyle instance.
	 * @param model the StyleModel to use in this process.
	 * @param url the url of the external css to load.
	 * @param loaderPolicy optional boolean flag to indicates if the loader use the loading view or not (defaut this value is true).
  	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	public function RunStyle( model:StyleModel , url:String , loaderPolicy:Boolean, bGlobal:Boolean, sChannel:String) 
	{
		super( bGlobal , sChannel , loaderPolicy ) ;
		this.model = model ;
		this.url   = url ;
	}
	
	/**
	 * The StyleModel reference of this process.
	 */
	public var model:StyleModel ;

	/**
	 * The default url of this process.
	 */
	public var url:String ;

	/**
	 * Invoqued when the style is loaded.
	 */ 
 	public function initialize(e:LoaderEvent):Void 
 	{
		
		if (e != null)
		{
			getLogger().debug( this + " initialize : " + e.getData() ) ;
		}
		else
		{
			getLogger().warn( this + " initialize but no CSS found." ) ;
		}
		
		notifyFinished() ;
		
	}

	/**
	 * Register the process loader object.
	 */
	public /*override*/ function registerLoader( loader:StyleSheetLoader )
	{
		super.registerLoader( loader ) ;
		loader.addEventListener( LoaderEvent.INIT, _listenerInit , null, null, true ) ;
 		return loader ;
	}

	/**
	 * Run the process.
	 */
	public function run() 
	{

		getLogger().debug( this + " run." ) ;

		notifyStarted() ;

		var uri:String = getConfig().style || url ;
		
		if (uri)
		{
			_listenerInit = new Delegate(this, initialize) ;
			var loader:StyleSheetLoader = model.loader ;
			registerLoader( loader ) ;
			loader.load( new URLRequest( uri ) ) ;
		}
		else
		{
			getLogger().warn(this + " run failed with an empty external css url.") ;
			notifyFinished() ;	
		}
		
	}

	/**
	 * Register the process loader object.
	 */
	public /*override*/ function unregisterLoader( loader:StyleSheetLoader )
	{
		super.registerLoader( loader ) ;
		loader.removeEventListener( LoaderEvent.INIT, _listenerInit ) ;
 		return loader ;
	}

	private var _listenerInit:EventListener ;
	
}