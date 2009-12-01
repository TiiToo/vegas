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
    import system.events.ActionEvent;
    
    import vegas.config.Config;
    import vegas.config.JSONConfigLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the JSONConfigLoader class.
     */
    public class JSONConfigLoaderExample extends Sprite 
    {
        public function JSONConfigLoaderExample()
        {
            var loader:JSONConfigLoader = new JSONConfigLoader() ;
            loader.addEventListener( ActionEvent.FINISH , debug) ;
            loader.path = "config/" ;
            loader.run() ;
        }
        
        public function debug( e:Event ):void
        {
            trace( e ) ;
            var data:* = Config.getInstance() ;
            for (var prop:String in data)
            {
                trace("# " + prop + " : " + data[prop]) ;
                if (data[prop] as Object)
                {
                    for (var key:String in data[prop]) 
                    {
                        trace("  - " + key + " : " + data[prop][key]) ;
                    }
                }
           }
        }
    }
}
