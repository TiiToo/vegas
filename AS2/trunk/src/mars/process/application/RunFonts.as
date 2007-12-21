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
import asgard.config.Config;
import asgard.display.DisplayLoader;
import asgard.display.DisplayObject;
import asgard.display.DisplayObjectCollector;
import asgard.events.LoaderEvent;
import asgard.net.MassiveLoader;

import mars.core.ApplicationCommand;
import mars.core.ApplicationDepthList;
import mars.core.ApplicationList;
import mars.process.abstract.AbstractActionLoader;

import vegas.data.set.HashSet;
import vegas.events.Delegate;

/**
 * This process load an external swf library of shared fonts use in this application.
 * @author eKameleon
 */
class mars.process.application.RunFonts extends AbstractActionLoader
{

	/**
	 * Creates a new RunFonts instance.
	 * @param applicationID the name of the application display.
	 * @param loaderPolicy optional boolean flag to indicates if the loader use the loading view or not (defaut this value is true).
  	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	public function RunFonts( applicationID:String , urls:Array, loaderPolicy:Boolean, bGlobal:Boolean, sChannel:String ) 
	{
		super( bGlobal , sChannel , loaderPolicy ) ;
		this.applicationID = applicationID ;
		if ( urls != null )
		{
			this.urls = urls ;	
		}
	}
	
	/**
	 * The default delay before launch the notifyFinished method if the process success.
	 */
	public static var DEFAULT_INIT_DELAY:Number = 200 ;

	/**
	 * The display application reference.
	 */
	public var applicationID:String ;

	/**
	 * The array of string urls to load the external swf who contains shared fonts.
	 */
	public var urls:Array ;
	
	/**
	 * initialize the sound library of the application.
	 */
	public function initialize():Void
	{
		_global.setTimeout( this, "notifyFinished", DEFAULT_INIT_DELAY ) ;
	}

	/**
	 * initialize the sound library of the application.
	 */
	public function progress( e:LoaderEvent ):Void
	{
		
        var name:String = e.getTarget().getName() ;
        var percent:Number = e.getPercent() ;
        
        if (Config.getInstance().verbose)
        {
            getLogger().info(  this + " load " + name + " progress : " + e.getPercent() + "%") ;
        }    
        
        if ( loaderPolicy == true )
        {
        	ApplicationCommand.changeLoader( "fonts in progress" , percent ) ; // TODO localize
        }

	}

	/**
	 * Run the process.
	 */
	public function run() 
	{
		
		notifyStarted() ;
		
		getLogger().debug( this + " run." ) ;
		
		var display:DisplayObject ;
		var view:MovieClip ;

		if ( DisplayObjectCollector.contains( applicationID ) )
		{
  			view = DisplayObjectCollector.get( applicationID ).view ;
  			try
  			{
				 display = new DisplayObject( ApplicationList.FONTS, view.createEmptyMovieClip( ApplicationList.FONTS  , ApplicationDepthList.FONTS_DEPTH ) ) ;
				 view    = display.view ;
  			}
  			catch(e:Error)
  			{
  				getLogger().warn( this + " the application can't creates and register the font display : " + e.toString() ) ;
  				notifyFinished() ;
  				return ;	
  			}
		}		
		else
		{
  			getLogger().warn( this + " the application can't creates and register the font display if the 'applicationID' is 'null' or 'undefined'.") ;
  			notifyFinished() ;
  			return ;	
		}
		
 		var config:Config = getConfig() ;
 		var urls:Array    = urls || config[ApplicationList.FONTS] ;
 		
 		getLogger().info(this + " fonts urls : " + urls ) ;
 		
 		if (urls instanceof Array && urls.length > 0)
 		{
 			
	 	 	if (urls.length > 0)
 	 		{
 	 			var massive:MassiveLoader = new MassiveLoader() ;
				registerLoader( massive ) ;
 	 			var loader:DisplayLoader ;
	 			var set:HashSet = new HashSet( urls ) ; // remove all double links in the array.
	 			urls = set.toArray() ;
	 			var size:Number = urls.length ;
	 			for( var i:Number = 0 ; i<size ; i++ )
	 			{
	 				var uri:String = urls[i] ;
	 				if ( uri.length > 0 )
	 				{
	 					var depth:Number = view.getNextHighestDepth() ;
 						loader = new DisplayLoader( view ,depth  , false ) ;
 						loader.addEventListener( LoaderEvent.PROGRESS, new Delegate( this, progress ) ) ;
 						massive.enqueue( loader , ApplicationList.FONTS + "_" + depth , uri );
					}
	 			}
	 			if ( massive.size() > 0 )
	 			{
	 				massive.addEventListener( LoaderEvent.FINISH, new Delegate(this, initialize), null, null, true) ;
	 				massive.run() ;
	 			}
	 			else
	 			{
 	 				getLogger().warn(this + " the massive loader of shared fonts swf is empty.") ;
 	 				notifyFinished() ;	
	 			}
	 			
 	 		}
 	 		else
 	 		{
 	 			getLogger().warn(this + " the array of font urls is empty.") ;
 	 			notifyFinished() ;		
 	 		}
 	 		
 		}
 		else
 		{
 			notifyFinished() ;
 		}
 	 	
	}
	
}