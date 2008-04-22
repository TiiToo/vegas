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
package asgard.net 
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    
    import andromeda.events.ActionEvent;
    import andromeda.ioc.core.ObjectAttribute;
    import andromeda.ioc.factory.ECMAObjectFactory;
    import andromeda.ioc.factory.ObjectConfig;
    import andromeda.process.Sequencer;
    import andromeda.process.SimpleAction;
    
    import asgard.process.ActionURLLoader;
    
    import vegas.core.IFactory;
    import vegas.data.sets.HashSet;
    import vegas.events.AbstractCoreEventDispatcher;
    import vegas.util.ClassUtil;    

    // TODO add the "root" id definition in the ECMAObjectFactory .. see the scope of the internal definition ?
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
     *         { ressource : "view.eden" }
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
    public class ECMAObjectLoader extends SimpleAction implements IFactory
    {
        
        /**
         * Creates a new ECMAObjectLoader instance.
         * @param context The uri of the context external eden file (default "application.eden").
         * @param path The optional path of the external context file (default "").
         * @param internalLoader The internal parse loader class to use to load all external context files (optional EdenLoader).
         */
        public function ECMAObjectLoader( context:String="application.eden" , path:String="" , internalLoader:Class=null )
        {
            
            this.context        = context ;
            this.path           = path    ;
            this.internalLoader = internalLoader ;
            
            factory = ECMAObjectFactory.getInstance() ; 
            
            factory.addEventListener( IOErrorEvent.IO_ERROR   , fireEvent ) ;
            factory.addEventListener( ProgressEvent.PROGRESS  , fireEvent ) ;
            factory.addEventListener( Event.COMPLETE          , fireEvent ) ;
            factory.addEventListener( ActionEvent.START       , fireEvent ) ;
            factory.addEventListener( ActionEvent.FINISH      , main  ) ;            
            
            _imports = new HashSet() ;
            
            _sequencer = new Sequencer() ;
            _sequencer.addEventListener( ActionEvent.FINISH   , _finishSequencer   , false, 0 , true ) ;
            _sequencer.addEventListener( ActionEvent.PROGRESS , _progressSequencer , false, 0 , true ) ;
            _sequencer.addEventListener( ActionEvent.START    , _startSequencer    , false, 0 , true ) ;
            
        }

        /**
         * The default context file uri value.
         */
        public var context:String ;
        
        /**
         * The ECMAScript object IOC factory reference.
         */
        public var factory:ECMAObjectFactory ;

        /**
         * Indicates the ParseLoader used in this loader.
         */
        public function get internalLoader():Class
        {
            return _internalLoader ;
        }    

        /**
         * @private
         */
        public function set internalLoader( loader:Class ):void
        {
            _internalLoader = ClassUtil.extendsClass( loader, ParserLoader ) ? loader : EdenLoader ;
        }    

        /**
         * The default path of the external context file.
         */
        public var path:String ;
        
        /**
         * Clear the loader.
         */
        public function clear():void
        {
            _first  = true ;
            objects = [] ;
            _imports.clear() ;
            _sequencer.clear() ;
        }
        
        /**
         * Create the objects.
         */
        public function create( ...arguments:Array ):void         
        {
            if ( objects.length > 0 )
            {    
                factory.create( objects ) ;
            }
            else
            {
                getLogger().warn( this + " the factory is empty." ) ;    
            }    
        }

        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            clear() ;
            _importContext( context ) ;
            _sequencer.run() ;
        }        
        
        /**
         * Invoked to debug the errors or warning during the factory process.
         */
        protected function fireEvent( e:* ):void
        {
            getLogger().info( e ) ; // no event before the IOC factory initialization.
            dispatchEvent( e ) ;
        }
        
        /**
         * Invoked when the factory is complete.
         */
        public function main( e:ActionEvent ):void
        {
            getLogger().debug( e ) ;
            fireEvent(e) ;
        }
        
        /**
         * The array representation of the object definitions to insert in the IOC factory container.
         */
        protected var objects:Array ;        
        
        /**
         * @private
         */
        private var _first:Boolean = true ;
        
        /**
         * @private
         */
        private var _imports:HashSet ;        
        
        /**
         * @private
         */
        private var _internalLoader:Class ;
        
        /**
         * @private
         */
        private var _sequencer:Sequencer ;

        /**
         * @private
         */
        private function _finishSequencer( e:ActionEvent ):void
        {
            getLogger().debug(e) ;    
    
            var a:Array   ;
            var size:uint = _imports.size() ;
            if ( size > 0 )
            {
                a = _imports.toArray() ;
                a.reverse() ;
                while( --size > -1 )
                {
                    _importContext( a[size] ) ;
                }
            } 
            
            // next
            
            if ( _sequencer.size() > 0 )
            {
                _sequencer.run() ;            
            }
            else
            {
                create() ;    
            }
        }

        /**
         * @private
         */
        private function _importContext( uri:String ):Boolean
        {
            var url:String = ( path || "" ) + uri ;
            var loader:ActionURLLoader = new ActionURLLoader( new internalLoader() as ParserLoader ) ;
            loader.request = new URLRequest( url ) ;
            return _sequencer.addAction( loader ) ;
        }
        
        /**
         * @private
         */
        private function _progressSequencer( e:ActionEvent ):void
        {
            
            getLogger().debug(e) ;
            
            var loader:ActionURLLoader = _sequencer.getCurrent() as ActionURLLoader ;
            
            try
            {
            
                var data:Object = loader.data  ;
                
                // configuration 
                
                if ( _first )
                {
                    _first = false ;    
                    var config:Object = data[ ObjectAttribute.CONFIGURATION     ] ;
                    if ( config != null )
                    {
                        factory.config = new ObjectConfig( config ) ;    
                    }
                }
                
                // objects : the current object definitions
            
                var o:Array = data[ ObjectAttribute.OBJECTS ] as Array ;
                if ( o != null && o.length > 0 )
                {
                    objects.unshift.apply(objects, o ) ;
                }
                            
                // imports
                
                var size:uint ;
                var i:Array = data[ ObjectAttribute.IMPORTS ] as Array ;
                if ( i != null && i.length > 0 )
                {
                    size = i.length ;
                    while ( --size > -1 )
                    {
                        var ressource:String = i[size][ ObjectAttribute.RESSOURCE ] as String ;
                        if ( ressource != null && ressource.length > 0 )
                        {
                            _imports.insert( ressource ) ;
                        }
                    }
                }
            }
            catch( error:Error )
            {
                // do nothing    
            }
        }
        
        /**
         * @private
         */
        private function _startSequencer( e:ActionEvent ):void
        {
            getLogger().debug(e) ;
            _imports.clear() ;
        }

    }
    
}
