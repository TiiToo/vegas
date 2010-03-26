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

package vegas.config
{
    import system.Reflection;
    import system.process.ActionURLLoader;
    
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    
    /**
     * This skeletal class provides an easy implementation of the IConfigLoader interface. 
     */
    public class CoreConfigLoader extends ActionURLLoader implements IConfigLoader
    {
        /**
         * Creates a new CoreConfigLoader instance.
         * @param loader The URLLoader object to load.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function CoreConfigLoader( loader:URLLoader, global:Boolean = false, channel:String = null )
        {
            super( loader , global, channel ) ;
            parsing = true ;
            _config = Config.getInstance() ;
        }
        
        /**
         * Returns the config object.
         * @return the config object.
         */
        public function get config():Config 
        {
            return _config ;
        }
        
        /**
         * Defines the defaut file name ('config').
         */
        public var default_file_name:String = "config" ;
        
        /**
         * Defines the defaut file suffix ('.eden').
         */
        public var default_file_suffix:String = ".txt" ;
        
        /**
         * The name of the config file with datas.
         */
        public function get fileName():String 
        {
            return (_fileName == null) ? default_file_name : _fileName ;
        }
        
        /**
         * The name of the config file with datas.
         */
        public function set fileName( value:String ):void 
        {
            _fileName = value ;
        }
        
        /**
         * The path of the config file with datas.
         */
        public function get path():String 
        {
            return _path ;
        }
        
        /**
         * The path of the config file with datas.
         */
        public function set path( value:String ):void
        {
            _path = value ;
        }
        
        /**
         * Indicates the URLRequest object who captures all of the information in a single HTTP request.
         */
        public override function get request():URLRequest
        {
            return _request || new URLRequest( ( path || "" ) + ( fileName || "" ) + ( suffix || "" ) ) ;
        }
        
        /**
         * The suffix of the config file with datas.
         */
        public function get suffix():String 
        {
            return (_suffix == null) ? default_file_suffix : _suffix ;
        }
        
        /**
         * The suffix of the config file with datas.
         */
        public function set suffix( value:String ):void
        {
            _suffix = value ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            var cName:String = Reflection.getClassPath(this) ;
            var clazz:Class = ( getDefinitionByName( cName ) as Class ) ;
            var cloader:* = new clazz(_name) ;
            if (cloader != null)
            {
                cloader.data     = data ;
                cloader.fileName = fileName ;
                cloader.path     = path ;
                cloader.suffix   = suffix ;
            }
            return cloader ;
        }
        
        /**
         * Parse your datas when loading is complete.
         */
        public override function parse():void
        {
            var o:* = data ;
            var c:* = config ;
            for ( var prop:String in o ) 
            {
                c[ prop ] = o[prop] ;
            }
        }
        
        /**
         * @private
         */
        protected var _config:Config ;
        
        /**
         * @private
         */
        protected var _fileName:String ;
        
        /**
         * @private
         */
        protected var _name:String ;
        
        /**
         * @private
         */
        protected var _path:String ;
        
        /**
         * @private
         */
        protected var _suffix:String ;
    }
}