/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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