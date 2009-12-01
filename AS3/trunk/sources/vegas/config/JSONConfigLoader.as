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

package vegas.config
{
    import vegas.net.JSONLoader; 
    
    /**
     * The JSONConfigLoader class based on the JSON notation.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.config.Config ;
     * import vegas.config.JSONConfigLoader;
     * import vegas.config.IConfigLoader;
     * 
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
     * </pre>
     * @see vegas.strings.JSON
     */
    public class JSONConfigLoader extends CoreConfigLoader
    {
        /**
         * Creates a new JSONConfigLoader instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function JSONConfigLoader( global:Boolean = false, channel:String = null )
        {
            super( new JSONLoader() , global, channel) ;
            default_file_suffix = ".json" ;
        }
    }
}