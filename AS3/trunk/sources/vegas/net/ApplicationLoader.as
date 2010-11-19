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

package vegas.net 
{
	import vegas.ioc.ObjectFactoryLoader;
    import system.ioc.ObjectFactory;

    import vegas.config.Config;
    import vegas.events.LocalizationEvent;
    import vegas.i18n.Localization;
    
    /**
     * This loader load an external file who contains a context with all object definitions, resources and configuration objects to create and manage the ECMAObjectFactory IoC container.
     * <p><b>Example : "hello world"</b></p>
     * <p><b>1 -</b> The top-level context eden application file : <b>"hello_world.eden"</b></p>
     * <pre class="prettyprint">
     * objects =
     * [
     *     {
     *         id        : "my_format" ,
     *         type      : "flash.text.TextFormat" ,
     *         arguments : [ { value:"arial" } , { value:24 } , { value:0xFEF292 } , { value:true } ]
     *     }
     *     ,
     *     {
     *         id         : "my_field" ,
     *         type       : "flash.text.TextField"  ,
     *         properties :
     *         [
     *             { name : "autoSize"          , value  : "left"            } ,
     *             { name : "defaultTextFormat" , ref    : "my_format"       } ,
     *             { name : "text"              , value  : "HELLO WORLD"     } ,
     *             { name : "x"                 , value  : 10                } ,
     *             { name : "y"                 , value  : 10                }
     *         ]
     *     }
     *     ,
     *     {
     *         id               : "stage" ,
     *         type             : "flash.display.Stage"  ,
     *         factoryReference : "#stage" ,
     *         singleton        : true ,
     *         properties       :
     *         [
     *             { name : "align"     , value:""        } ,
     *             { name : "scaleMode" , value:"noScale" }
     *         ]
     *     }
     *     ,
     *     {
     *         id               : "root" ,
     *         type             : "flash.display.MovieClip"  ,
     *         factoryReference : "#root" ,
     *         singleton        : true ,
     *         properties       :
     *         [
     *             { name : "addChild" , arguments  : [ { ref:"my_field" } ]}
     *         ]
     *     }
     * ] ;
     * </pre>
     * <p><b>2 -</b> The main source code :</p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent;
     * 
     * import vegas.net.ApplicationLoader;
     * 
     * var debug:Function = function( e:Event ):void
     * {
     *     trace( e ) ;
     * }
     * 
     * var loader:ApplicationLoader = new ApplicationLoader( "hello_world.eden" , "context/" ) ;
     * 
     * loader.root = this ;
     * 
     * loader.addEventListener( ActionEvent.START  , debug ) ;
     * loader.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * loader.run() ;
     * </pre>
     */
    public class ApplicationLoader extends ObjectFactoryLoader
    {
        /**
         * Creates a new ApplicationLoader instance.
         * @param context The uri of the context external eden file (default "application.eden").
         * @param path The optional path of the external context file (default "").
         * @param factory The optional ObjectFactory reference of this loader. By default the loader use the ECMAObjectFactory.getInstance() reference. 
         * @param internalLoader The internal parse loader class to use to load all external context files (optional EdenLoader).
         */
        public function ApplicationLoader( context:String = "application.eden" , path:String = "" , factory:ObjectFactory = null , config:Config = null , localization:Localization = null )
        {
            super( context , path , factory ) ;
            localization = Localization.getInstance()  ; 
        }
        
        /**
         * @private
         */
        public override function set factory( value:ObjectFactory ):void
        {
            super.factory = value ;
            factory.config.setConfigTarget( Config.getInstance() ) ;
        }
        
        /**
         * Indicates the Localization reference of this loader.
         */
        public function get localization():Localization
        {
            return _localization ;
        }
        
        /**
         * @private
         */
        public function set localization( localization:Localization ):void
        {
            if ( _localization != null )
            {
                _localization.removeEventListener( LocalizationEvent.CHANGE , updateLocalization , false ) ;
            }
            _localization = localization ;
            if ( _localization != null )
            {
                _localization.addEventListener( LocalizationEvent.CHANGE , updateLocalization , false, 0, true ) ;
            }
            updateLocalization() ;
        }
        
        /**
         * Invoked when the localization of the application is changed or to update the locale object of 
         * the IoC factory configuration with the current locale object of the application.
         */
        protected function updateLocalization( e:LocalizationEvent = null ):void
        {
            factory.config.setLocaleTarget( _localization != null ? _localization.getLocale() : null ) ;
        }
        
        /**
         * @private
         */
        private var _localization:Localization ;
    }
}
