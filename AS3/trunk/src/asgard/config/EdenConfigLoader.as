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
	import asgard.net.EdenLoader;	

	/**
     * The EdenConfigLoader class based on the eden notation.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.events.ActionEvent ;
     * 
     * import asgard.config.Config ;
     * import asgard.config.EdenConfigLoader;
     * 
     * import flash.events.Event ;
     * 
     * var debug:Function = function ( e:Event ):void
     * {
     *     var data:* = Config.getInstance() ;
     *     for (var prop:String in data)
     *     {
     *         trace("# " + prop + " : " + data[prop]) ;
     *         if (data[prop] as Object)
     *         {
     *             for (var key:String in data[prop])
     *             {
     *                 trace("  - " + key + " : " + data[prop][key]) ;
     *             }
     *         }
     *     }
     * }
     * 
     * var loader:IConfigLoader = new EdenConfigLoader() ;
     * loader.addEventListener( ActionEvent.FINISH , debug) ;
     * loader.path = "config/" ;
     * loader.load() ;
     * </pre>
     * @author eKameleon
     */
    public class EdenConfigLoader extends AbstractConfigLoader
    {
        
        /**
         * Creates a new EdenConfigLoader instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code>bGlobal</code> argument is <code>true</code>.
         */
        public function EdenConfigLoader( bGlobal:Boolean = false, sChannel:String = null )
        {
        	super( new EdenLoader() , bGlobal, sChannel) ;
        	default_file_suffix = ".eden" ;
        }

    }
    
}