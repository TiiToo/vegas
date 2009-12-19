﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
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
