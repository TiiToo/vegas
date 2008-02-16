/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.config
{
	import asgard.config.AbstractConfigLoader;
	import asgard.net.JSONLoader;	    

	/**
     * <p><b>Example :</b></p>
     * <code>
     * import asgard.config.Config ;
     * import asgard.config.JSONConfigLoader;
     * import asgard.config.IConfigLoader;
     * import flash.events.Event ;
     *        
     * var complete:Function = function ( e:Event ):void
     * {
     *     var data:* = Config.getInstance() ;
     *     for (var prop:String in data)
     *     {
     *         trace("> " + prop + " : " + data[prop]) ;
     *         if (data[prop] as Object)
     *         {
     *             for (var key:String in data[prop]) 
     *             {
     *                 trace("    > " + key + " : " + data[prop][key]) ;
     *             }
     *         }
     *    }
     * }
     *        
     * var loader:IConfigLoader = new JSONConfigLoader() ;
     * loader.addEventListener(Event.COMPLETE, complete) ;
     * loader.path = "config/" ;
     * loader.load() ;
     * </code>	
     * @author eKameleon
     */
    public class JSONConfigLoader extends AbstractConfigLoader
    {
        
        /**
         * Creates a new JSONConfigLoader instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code>bGlobal</code> argument is <code>true</code>.
         */
        public function JSONConfigLoader( bGlobal:Boolean = false, sChannel:String = null )
        {
            super( new JSONLoader() , bGlobal, sChannel) ;
            default_file_suffix = ".json" ;
        }

    }
    
}