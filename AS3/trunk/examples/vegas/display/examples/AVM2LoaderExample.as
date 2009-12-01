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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import vegas.display.AVM2Loader;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    
    public class AVM2LoaderExample extends Sprite 
    {
        public function AVM2LoaderExample()
        {
            loader = new AVM2Loader() ;
            
            loader.context = new LoaderContext( false , ApplicationDomain.currentDomain ) ;
            
            loader.contentLoaderInfo.addEventListener( Event.INIT , init ) ;
            
            loader.x = 25 ;
            loader.y = 25 ;
            
            addChild( loader ) ;
            
            var request:URLRequest = new URLRequest( "avm1.swf" ) ;
            
            loader.load( request ) ;
        }
        
        public var loader:AVM2Loader ;
        
        public var movie:MovieClip ;
        
        public function stopIt():void
        {
            trace("stop movie.") ;
            if ( movie != null )
            {
                movie.stop() ;
            }
        }
        
        public function init( e:Event ):void
        {
            trace(e) ;
            movie = (loader.content as MovieClip).mc ; // mc in the main timeline of the external SWF 
            movie.addFrameScript( movie.totalFrames - 1 , stopIt ) ; // stop the movie in the last frame
        }
    }
}
