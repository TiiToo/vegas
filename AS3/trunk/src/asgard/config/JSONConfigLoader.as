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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* JSONConfigLoader

	AUTHOR

		Name : JSONConfigLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2008-09-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	EXAMPLE
	
    	import asgard.config.Config ;
        import asgard.config.JSONConfigLoader;
        import asgard.config.IConfigLoader;
        
        import flash.events.Event ;
        
        var complete:Function = function ( e:Event ):void
        {
            var data:* = Config.getInstance() ;
            for (var prop:String in data)
            {
                trace("> " + prop + " : " + data[prop]) ;
                if (data[prop] as Object)
                {
                    for (var key:String in data[prop]) 
                    {
                    
                        trace("    > " + key + " : " + data[prop][key]) ;
                    }
                }
            }
        }
        
        var loader:IConfigLoader = new EdenConfigLoader() ;
        loader.addEventListener(Event.COMPLETE, complete) ;
        loader.path = "config/" ;
        loader.load() ;
		
*/

package asgard.config
{
    
    import asgard.config.AbstractConfigLoader;
    import asgard.net.JSONLoader;
   
    import flash.events.Event ;
    import flash.net.URLLoader;

    public class JSONConfigLoader extends AbstractConfigLoader
    {
        
        // ----o Constructor
        
        public function JSONConfigLoader( name:String="" )
        {

            super(name ) ;
            default_file_name = "config" ;
            default_file_suffix = ".json" ;
            
        }
        
        // ----o Public Methods
    
        /**
         * Return the original loader in the constructor. Override this method.
         */ 
        override public function getLoader():URLLoader
        {
            return (new JSONLoader() as URLLoader) ;
        }

        // ----o Protected Methods

        /**
         * Dispatch Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        override protected function complete(e:Event):void
		{
		    var o:* = data ;
		    var c:* = config ;
		    for (var prop:String in o) 
		    {
    			c[ prop ] = o[prop] ;
	    	}
            super.complete(e) ;
        }    
        
    }
    
}