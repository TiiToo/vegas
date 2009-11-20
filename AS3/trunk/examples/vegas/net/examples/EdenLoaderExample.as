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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import system.eden;
    import system.logging.LoggerLevel;
    
    import vegas.net.EdenLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the EdenLoader class.
     */
    public class EdenLoaderExample extends Sprite 
    {
        public function EdenLoaderExample()
        {
            // test eden config and authorized white list.
            
            LoggerLevel ;
            
            eden.addAuthorized( "system.logging.LoggerLevel.*" ) ;
            
            //////////////
            
            var loader:EdenLoader = new EdenLoader() ;
            var request:URLRequest = new URLRequest("data/config.eden");
            
            loader.addEventListener( Event.COMPLETE         , complete ) ;
            loader.addEventListener( ProgressEvent.PROGRESS , progress ) ;
            
            loader.load(request) ;
        }
        
        protected function complete( e:Event ):void
        {
            var data:* = e.target.data ;
            trace( eden.serialize(data) ) ;
        }
        
        protected function progress( e:ProgressEvent ):void
        {
            var percent:Number = Math.round( e.bytesLoaded * 100 / e.bytesTotal ) ;
            trace( e + "  progress : " + percent + " %" ) ;
        }
    }
}
