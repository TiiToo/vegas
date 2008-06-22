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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net 
{
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import andromeda.ioc.factory.ECMAObjectFactory;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.io.ConfigResource;
    import andromeda.ioc.io.ContextResource;
    import andromeda.ioc.io.LocaleResource;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.net.ObjectFactoryLoader;
    import andromeda.process.ActionURLLoader;
    
    import asgard.config.AbstractConfigLoader;
    import asgard.config.Config;
    import asgard.config.EdenConfigLoader;
    import asgard.events.LocalizationEvent;
    import asgard.system.AbstractLocalizationLoader;
    import asgard.system.EdenLocalizationLoader;
    import asgard.system.Localization;
    
    import vegas.util.ClassUtil;    

    // TODO add events and progress UI to notify the IOC external process in progress.
    
    /**
     * This loader load an external IOC ECMAObject and this dependencies and create the ECMAObjectFactory container of the application.
     * See the ECMAObjectFactory class to use this loader. 
     * <p><b>Example :</b></p>
     * <p><b>1 -</b> The custom <code class="prettyprint">test.User</code> class.</b></p>
     * <pre class="prettyprint">
     * package test
     * {
     * 
     *     import system.Reflection;
     *     import vegas.core.CoreObject;
     *     
     *     public class User extends CoreObject
     *     {
     *     
     *         public function User( name:String = null )
     *         {
     *             this.name    = name ;
     *         }
     *         
     *         public var name:String ;
     *         
     *         public function initialize():void
     *         {
     *             trace( this + " initialize.") ;
     *         }
     *         
     *         public override function toString():String
     *         {
     *             return "[" + Reflection.getClassName(this) + ( name != null ? " " + name : "" ) + "]" ;
     *         }
     *     }
     * }
     * </pre>
     * <p><b>2 -</b> The main context eden application file : <b>"application.eden"</b></p>
     * <pre class="prettyprint">
     * {
     *     configuration :
     *     {
     *         defaultInitMethod    : "initialize" ,
     *         defaultDestroyMethod : "destroy"    ,
     *         identify             : true
     *     }
     *     ,
     *     imports :
     *     [
     *         { resource : "view.eden" }
     *     ]
     *     ,
     *     objects :
     *     [
     *         {
     *              id        : "user" ,
     *              type      : "test.User" ,
     *              singleton : true ,
     *              arguments :
     *              [
     *                  { value : "ekameleon" }
     *              ]
     *         }
     *     ]
     * }
     * </pre>
     * <p><b>3 -</b> The import eden context file : <b>"view.eden"</b></p>
     * <pre class="prettyprint">
     * {
     *     objects :
     *     [
     *         {
     *             id         : "my_field" ,
     *             type       : "flash.text.TextField"  , // this class is created and embed in the library of the swf.
     *             properties :
     *             [
     *                 { name : "autoSize"          , value : "left" } ,
     *                 { name : "defaultTextFormat" , value : new flash.text.TextFormat('arial', 12, 0xFFFFFF) } ,
     *                 { name : "filters"           , value : [ new flash.filters.DropShadowFilter(2,90,0x000000,0.6,8,8,1,3) ] } ,
     *                 { name : "text"              , value : "hello world" } ,
     *                 { name : "x"                 , value : 10 } ,
     *                 { name : "y"                 , value : 10 }
     *             ]
     *         }
     *         ,
     *         {
     *             id         : "my_sprite" ,
     *             type       : "asgard.display.CoreSprite" ,
     *             singleton  : true // must be a singleton to test the ObjectConfig.identify flag.
     *         }
     *         ,
     *         {
     *             id         : "square" ,
     *             type       : "Square" ,
     *             singleton  : true     ,
     *             properties :
     *             [
     *                 { name:"x" , value : 50  } ,
     *                 { name:"y" , value : 50  }
     *             ]
     *             ,
     *             methods :
     *             [
     *                 { name:"addChild" , arguments:[ { ref:"my_field" } ] }
     *             ]
     *         }
     *     ]
     * 
     * }
     * </pre>
     * <p><b>4 -</b> The main source code of the example :</p>
     * <pre class="prettyprint">
     * import buRRRn.eden.config;
     * 
     * import andromeda.events.ActionEvent;
     * import andromeda.ioc.factory.ECMAObjectFactory;
     * 
     * import asgard.display.CoreSprite ;
     * import asgard.net.ECMAObjectLoader ;
     *  
     * import test.User ;
     * 
     * //// eden white list : allow class and package to deserialize custom objects.
     * 
     * config.addAuthorized( "flash.filters.DropShadowFilter" ) ;
     * config.addAuthorized( "flash.text.TextField" ) ;
     * config.addAuthorized( "flash.text.TextFormat" ) ;
     * 
     * //// Enforces the class in the swf to use it in the eden context files.
     * 
     * var enforcer:Array = [ User ] ;
     * 
     * ////
     * 
     * var start:Function = function( e:Event ):void
     * {
     *     trace( e ) ;
     * }
     * 
     * var finish:Function = function( e:Event ):void
     * {
     *     trace( e ) ;
     *     
     *     // see the config.identify flag in the external context of the factory.
     *     
     *     var mySprite:CoreSprite = factory.getObject("my_sprite") as CoreSprite ;
     *     trace( mySprite + " id:" + mySprite.id ) ; // my_sprite
     *     
     *     addChild( mySprite ) ;
     *     
     *     mySprite.addChild( factory.getObject("square") ) ;
     * }
     * 
     * var factory = ECMAObjectFactory.getInstance() ;
     * 
     * var loader:ECMAObjectLoader = new ECMAObjectLoader( "application.eden" , "context/" ) ;
     * loader.addEventListener( ActionEvent.START  , start ) ;
     * loader.addEventListener( ActionEvent.FINISH , finish ) ;
     * 
     * loader.run() ;
     * </pre>
     * @author eKameleon
     * @see andromeda.ioc.factory.ECMAObjectFactory
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
        public function ECMAObjectLoader( context:String="application.eden" , path:String="" , factory:ECMAObjectFactory = null, internalLoader:Class=null )
        {
            super( context , path , factory , internalLoader ) ;
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
         * @private
         */
        public override function set internalLoader( clazz:Class ):void
        {
            _internalLoader = ClassUtil.extendsClass( clazz, ParserLoader ) ? clazz : EdenLoader ;
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
         * This method is the strategy to insert a new ObjectResource in the sequencer. 
         */
        protected override function addResource( resource:ObjectResource ):Boolean
        {
            
            if ( resource != null && resource.type != null )
            {
                
                var action:ActionURLLoader;
                
                switch( true )
                {
                    
                    case ( resource is ConfigResource ) :
                    {
                        var conf:ConfigResource = resource as ConfigResource ;
                        action = ( conf.loader || new EdenConfigLoader() ) as ActionURLLoader ;
                        if ( action != null )
                        {
                            if ( conf.path != null )
                            {
                                (action as AbstractConfigLoader).path   = conf.path   ;
                            }
                            if ( conf.suffix != null )
                            {                            
                                (action as AbstractConfigLoader).suffix = conf.suffix ;
                            }
                            if ( conf.resource != null )
                            {
                                (action as AbstractConfigLoader).fileName = conf.resource ;
                            }
                            if ( conf.verbose != null )
                            {
                                (action as AbstractConfigLoader).verbose = (conf.verbose is Boolean) ? (conf.verbose as Boolean) : false;
                            }                            
                        }
                        break ;
                    }
                    
                    case ( resource is ContextResource ) :
                    {
                        
                        var context:ContextResource = resource as ContextResource ;
                        var clazz:Class             = ClassUtil.extendsClass( context.loader as Class , ParserLoader ) ? context.loader as Class : internalLoader ;
                        var loader:URLLoader        = new clazz() ;
                        var url:String              = ( path || "" ) + context.resource ;
                        action                      = new ActionURLLoader( loader ) ;
                        action.request              = new URLRequest( url ) ;
                        break ;
                        
                    }
                    
                    case ( resource is LocaleResource ) :
                    {
                        var locale:LocaleResource = resource as LocaleResource ;
                        action = ( locale.loader || new EdenLocalizationLoader() ) as ActionURLLoader ;
                        if ( action != null )
                        {
                            if ( locale.path != null )
                            {
                                (action as AbstractLocalizationLoader).path   = locale.path   ;
                            }
                            if ( locale.prefix != null )
                            {                            
                                (action as AbstractLocalizationLoader).prefix = locale.prefix ;
                            }
                            if ( locale.suffix != null )
                            {                            
                                (action as AbstractLocalizationLoader).suffix = locale.suffix ;
                            }
                            if ( locale.verbose != null )
                            {
                                (action as AbstractLocalizationLoader).verbose = ( locale.verbose is Boolean ) ? ( locale.verbose as Boolean) : false;
                            }
                            if ( locale.resource != null )
                            {
                                (action as AbstractLocalizationLoader).lang = locale.resource ;
                            }
                        }
                        break ;
                    }
                
                }
                
                return sequencer.addAction( action ) ;
                
            }
            else
            {
                return false ;
            }
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

