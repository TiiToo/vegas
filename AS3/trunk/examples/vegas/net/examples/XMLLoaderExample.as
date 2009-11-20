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
    import vegas.net.XMLLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the XMLLoader class.
     */
    public class XMLLoaderExample extends Sprite 
    {
        public function XMLLoaderExample()
        {
            var loader:XMLLoader   = new XMLLoader() ;
            var request:URLRequest = new URLRequest("data/config.xml");
            
            loader.addEventListener(ProgressEvent.PROGRESS , onProgress );
            loader.addEventListener(Event.COMPLETE         , onComplete );
            
            loader.load(request) ;
        }
        
        protected function onComplete( e:Event ):void
        {
            var xml:XML = e.target.data as XML  ;
            trace( "result : " + xml ) ;
        }
        
        protected function onProgress( e:ProgressEvent ):void
        {
            var percent:Number = Math.round( e.bytesLoaded * 100 / e.bytesTotal ) ;
            trace( e + "  progress : " + percent + " %" ) ;
        }
        
    }
}
