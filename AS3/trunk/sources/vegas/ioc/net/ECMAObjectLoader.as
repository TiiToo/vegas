﻿/*

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
package vegas.ioc.net 
{
    import vegas.config.Config;
    import vegas.events.LocalizationEvent;
    import vegas.i18n.Localization;
    import vegas.ioc.factory.ECMAObjectFactory;
    import vegas.ioc.factory.ObjectFactory;
    
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
     * import vegas.ioc.factory.ECMAObjectFactory;
     * 
     * import vegas.ioc.io.ECMAObjectLoader ;
     * 
     * var debug:Function = function( e:Event ):void
     * {
     *     trace( e ) ;
     * }
     * 
     * var loader:ECMAObjectLoader = new ECMAObjectLoader( "hello_world.eden" , "context/" ) ;
     * 
     * loader.root = this ;
     * 
     * loader.addEventListener( ActionEvent.START  , debug ) ;
     * loader.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * loader.run() ;
     * </pre>
     * @see vegas.ioc.factory.ECMAObjectFactory
     */
    public class ECMAObjectLoader extends ObjectFactoryLoader
    {
        /**
         * Creates a new ECMAObjectLoader instance.
         * @param context The uri of the context external eden file (default "application.eden").
         * @param path The optional path of the external context file (default "").
         * @param factory The optional ECMAObjectFactory reference of this loader. By default the loader use the ECMAObjectFactory.getInstance() reference. 
         * @param internalLoader The internal parse loader class to use to load all external context files (optional EdenLoader).
         */
        public function ECMAObjectLoader( context:String = "application.eden" , path:String = "" , factory:ECMAObjectFactory = null )
        {
            super( context , path , factory ) ;
            localization = Localization.getInstance() ;
        }
        
        /**
         * @private
         */
        public override function set factory( value:ObjectFactory ):void
        {
            super.factory = value || ECMAObjectFactory.getInstance() ;
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
