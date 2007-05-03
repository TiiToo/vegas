
import andromeda.core.ApplicationDepthList;
import andromeda.core.ApplicationList;
import andromeda.process.abstract.AbstractActionLoader;

import asgard.config.Config;
import asgard.display.DisplayLoader;
import asgard.display.DisplayLoaderCollector;
import asgard.display.DisplayObjectCollector;
import asgard.events.LoaderEvent;
import asgard.media.ApplicationSoundLibrary;
import asgard.net.URLRequest;

import vegas.events.Delegate;
/**
 * This process load an external swf library of sounds use in this application.
 * Use ApplicationSoundLibrary.getInstance().getSound( SoundList.ID_SOUND ).start() to launch a sound in the library when the library is loading.
 * @author eKameleon
 * @see ApplicationSoundLibrary
 */
class andromeda.process.application.RunSound extends AbstractActionLoader
{

	/**
	 * Creates a new RunSound instance.
	 * @param applicationID the name of the application display.
	 */	
	public function RunSound( applicationID:String ) 
	{
		this.applicationID = applicationID ;
	}

	/**
	 * The display application reference.
	 */
	public var applicationID:String ;

	/**
	 * initialize the sound library of the application.
	 */
	public function initialize():Void
	{
		
		var config:Config = getConfig() ;
		var sounds:Array = config.sound.sounds ;
		
		getLogger().debug(this + " initialize : " + sounds ) ;
		
		if (sounds instanceof Array && sounds.length > 0)
		{
			var soundLibrary:ApplicationSoundLibrary = ApplicationSoundLibrary.getInstance() ;
			soundLibrary.initialize( DisplayLoaderCollector.get( ApplicationList.SOUND ).getContent() ) ;
			soundLibrary.addSounds(Config.getInstance().sound.sounds) ;
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

 		var config:Config = Config.getInstance() ;
 		var path:String = config.libraryPath || "" ;
 		var sounds:Array = config.sound.sounds ;
 		var url:String = config.sound.url || "" ;
 		
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