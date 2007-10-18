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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import andromeda.core.ApplicationDepthList;
import andromeda.core.ApplicationList;
import andromeda.media.SoundLibrary;
import andromeda.process.abstract.AbstractActionLoader;

import asgard.config.Config;
import asgard.display.DisplayLoader;
import asgard.display.DisplayLoaderCollector;
import asgard.display.DisplayObjectCollector;
import asgard.events.LoaderEvent;
import asgard.net.URLRequest;

import vegas.events.Delegate;
/**
 * This process load an external swf library of sounds use in this application.
 * Use SoundLibrary model with model.getSound( SoundList.ID_SOUND ).start() to launch a sound in the library when the library is loading.
 * @author eKameleon
 * @see andromeda.media.SoundLibrary
 */
class andromeda.process.application.RunSound extends AbstractActionLoader
{

	/**
	 * Creates a new RunSound instance.
	 * @param model the SoundLibrary model of this process.
	 * @param applicationID the name of the application display.
	 */	
	public function RunSound( model:SoundLibrary, applicationID:String ) 
	{
		this.applicationID = applicationID ;
		this.model = model ;
	}

	/**
	 * The display application reference.
	 */
	public var applicationID:String ;

	/**
	 * The SoundLibrary reference of this process.
	 */
	public var model:SoundLibrary ;

	/**
	 * initialize the sound library of the application.
	 */
	public function initialize():Void
	{
		
		var config:Config = getConfig() ;
		var sounds:Array = config.sound.sounds ;
		
		getLogger().debug(this + " initialize : " + sounds ) ;
		
		if (model == null)
		{
			getLogger().warn(this + " the initialize of this process failed with an empty SoundLibrary model.") ;	
		}
		else if (sounds instanceof Array && sounds.length > 0)
		{
			model.initialize( DisplayLoaderCollector.get( ApplicationList.SOUND ).getContent() ) ;
			model.addSounds(Config.getInstance().sound.sounds) ;
		}
		
		notifyFinished() ;

	}

	/**
	 * Run the process.
	 */
	public function run() 
	{
		
		notifyStarted() ;
		
		getLogger().debug( this + " run." ) ;

		if ( !DisplayLoaderCollector.contains( ApplicationList.SOUND ) )
		{
  			var view:MovieClip = DisplayObjectCollector.get( applicationID ).view ;
  			try
  			{
				DisplayLoaderCollector.insert( ApplicationList.SOUND, new DisplayLoader(view, ApplicationDepthList.SOUND_DEPTH , false) ) ;
  			}
  			catch(e:Error)
  			{
  				getLogger().warn( this + ", the application can't creates and register the sound display : " + e.toString ) ;
  				notifyFinished() ;
  				return ;	
  			}
		}		

 		var config:Config = getConfig() ;
 		var path:String = config.libraryPath || "" ;
 		var sounds:Array = config.sound.sounds ;
 		var url:String = config.sound.url || "" ;
 		
 		getLogger().info(this + " sound url : " + url ) ;
 		getLogger().info(this + " sounds : " + sounds ) ;
 		
 		if (sounds instanceof Array && sounds.length > 0)
 		{
 			
	 	 	if (url.length > 0)
 	 		{
	 			
	 			var request:URLRequest = new URLRequest(path + url);
 				var loader:DisplayLoader = DisplayLoaderCollector.get( ApplicationList.SOUND ) ;
 				
 				loader.addEventListener( LoaderEvent.INIT , new Delegate( this, initialize ) , false, 1000, true ) ;
				registerLoader( loader ) ;
 				loader.load(request) ;
 	 		}
 		}
 		else
 		{
 			notifyFinished() ;
 		}
 	 	
	}
	
}