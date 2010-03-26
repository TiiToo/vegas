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

package vegas.ioc.net
{
    import system.data.maps.HashMap;
    import system.events.ActionEvent;
    import system.hack;
    import system.process.ActionURLLoader;
    import system.process.CoreActionLoader;
    import system.process.Sequencer;
    import system.process.Task;
    
    import vegas.Factory;
    import vegas.ioc.ObjectAttribute;
    import vegas.ioc.factory.ObjectFactory;
    import vegas.ioc.io.ContextResource;
    import vegas.ioc.io.ObjectResource;
    import vegas.ioc.io.ObjectResourceBuilder;
    import vegas.ioc.io.ObjectResourceInfo;
    import vegas.net.FlashVars;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    
    /**
     * This loader object load an external IoC context and this dependencies and fill the IoC container.
     */
    public class ObjectFactoryLoader extends Task implements Factory
    {
        use namespace hack ;
        
        /**
         * Creates a new ObjectFactoryLoader instance.
         * @param context The uri of the context external eden file (default "application.eden").
         * @param path The optional path of the external context file (default "").
         * @param factory The ObjectFactory reference of this loader.
         */
        public function ObjectFactoryLoader( context:String = null , path:String = "" , factory:ObjectFactory = null )
        {
            this.context  = context ;
            this.factory  = factory ;
            this.path     = path    ;
            
            _info      = new ObjectResourceInfo() ;
            _resources = new HashMap() ; 
            
            sequencer = new Sequencer() ;
            
            sequencer.addEventListener( ActionEvent.FINISH   , _finishSequencer   , false, 0 , true ) ;
            sequencer.addEventListener( ActionEvent.PROGRESS , _progressSequencer , false, 0 , true ) ;
            sequencer.addEventListener( ActionEvent.START    , _startSequencer    , false, 0 , true ) ;
        }
        
        /**
         * The default context file uri value.
         */
        public var context:String ;
        
        /**
         * The IoC factory reference.
         */
        public function get factory():ObjectFactory
        {
            return _factory ;
        }
        
        /**
         * @private
         */
        public function set factory( value:ObjectFactory ):void
        {
            _factory = value ;
        }
        
        /**
         * The flashVars reference of the application. 
         * This property is optional and can be target in the IoC factory with the "ref" attribute with the value "#flashVars".
         */
        public function get flashVars():FlashVars
        {
            return factory.config.flashVars as FlashVars ;
        }
        
        /**
         * @private
         */
        public function set flashVars( flashVars:FlashVars ):void
        {
           factory.config.flashVars = flashVars ;
        }
        
        /**
         * The default path of the external context file.
         */
        public function get path():String
        {
            return ContextResource.DEFAULT_PATH ;
        }
        
        /**
         * @private
         */
        public function set path( value:String ):void
        {
            ContextResource.DEFAULT_PATH = value || "" ;
        }
        
        /**
         * Returns a ObjectResourceInfo object corresponding to the current resource being loaded.
         */
        public function get resourceInfo():ObjectResourceInfo
        {
            return _info ;
        }
        
        
        /**
         * The root reference of the application. 
         * This property is optional and can be target in the IoC factory with the "ref" attribute with the value "#root".
         */
        public function get root():DisplayObjectContainer
        {
            return factory.config.root as DisplayObjectContainer ;
        }
        
        /**
         * @private
         */
        public function set root( target:DisplayObjectContainer ):void
        {
           factory.config.root = target ;
        }
        
        /**
         * The Stage reference of the application. 
         * This property is optional and can be target in the IoC factory with the "ref" attribute with the value "#stage".
         */
        public function get stage():Stage
        {
            return factory.config.stage as Stage ;
        }
        
        /**
         * @private
         */
        public function set stage( target:Stage ):void
        {
           factory.config.stage = target ;
        }
        
        /**
         * Switch the verbose mode of this loader.
         */
        public var verbose:Boolean ;
        
        /**
         * Clear all the resources in the loader and reset it.
         */
        public function clear():void
        {
            objects  = [] ;
            _first   = true ;
            _resources.clear() ;
            sequencer.clear() ;
        }
        
        /**
         * Creates the objects.
         * @param ...arguments An Array who contains all the object definitions to fill the IoC container. 
         */
        public function create( ...arguments:Array ):void
        {
            if ( objects.length > 0 )
            {    
                factory.create( objects ) ;
            }
            else
            {
                if ( verbose && factory.sizeObjectDefinition() == 0 )
                {
                    logger.warn( this + " the factory is empty, no object definition are found." ) ;
                } 
                complete() ;
            }
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( running )
            {
                return ;
            }
            clear() ;
            if ( arguments.length > 0 && arguments[0] is String )
            {
                context = arguments[0] as String ;
            }
            addResource( new ContextResource( { resource:context } ) ) ;
            notifyStarted() ;
            _runSequencer() ;
        }
        
        /**
         * Register the current factory referenceof this loader. 
         */
        public function registerFactory():void
        {
            if ( _factory != null && _isRegister == false )
            {
                _isRegister = true ;
                _factory.addEventListener( ActionEvent.FINISH , complete ) ;
            }
        }
        
        /**
         * Unregister the current factory referenceof this loader. 
         */
        public function unregisterFactory():void
        {
            if ( _factory != null && _isRegister )
            {
                _isRegister = false  ;
                _factory.removeEventListener( ActionEvent.FINISH , complete ) ;
            }
        }
        
        ///////// protected
        
        /**
         * The array representation of the object definitions to insert in the IOC factory container.
         */
        protected var objects:Array ;
        
        /**
         * The internal sequencer of the factory loader. (Use it to load multiple context files).
         */
        protected var sequencer:Sequencer ;
        
        /**
         * This method is the strategy to insert a new ObjectResource in the sequencer. 
         * You must defines and overrides this method in your concrete ObjectFactoryLoader class.
         */
        protected function addResource( resource:ObjectResource ):Boolean
        {
            if ( resource != null && resource.type != null )
            {
                var loader:CoreActionLoader = resource.create() as CoreActionLoader ;
                if ( loader != null )
                {
                    _resources.put( loader , resource ) ;
                    return sequencer.addAction( loader ) ;
                }
                else
                {
                    return false ;
                }
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Invoked when the factory is complete.
         */
        protected function complete( e:ActionEvent = null ):void
        {
            if ( verbose )
            {
                logger.debug( this + " complete(" + e + ")" ) ;
            }
            unregisterFactory() ;
            notifyFinished() ;
        }
        
        ///////// private
           
        /**
         * @private
         */
        private var _factory:ObjectFactory ;
        
        /**
         * @private
         */
        private var _first:Boolean = true ;
        
        /**
         * @private
         */
        private var _imports:Array ;
        
        /**
         * @private
         */
        private var _info:ObjectResourceInfo ;
        
        /**
         * @private
         */
        private var _isRegister:Boolean ;
            
        /**
         * @private
         */
        private var _resources:HashMap ;
        
        /**
         * @private
         */
        private function _checkContext( o:* ):void
        {
            // trace( this + " progress data : " + eden.serialize( o )) ;
                
            // configuration 
                
            if ( _first )
            {
                _first = false ;    
                var config:Object = o[ ObjectAttribute.CONFIGURATION  ] ;
                if ( config != null )
                {
                    factory.config.initialize( config ) ;
                }
            }
            
            var a:Array ;
                
            // objects : the current object definitions
                
            a = o[ ObjectAttribute.OBJECTS ] as Array ;
            if ( a != null && a.length > 0 )
            {
                objects.unshift.apply( objects , a ) ;
            }
            
            // imports
            
            var size:int ;
            var resource:ObjectResource ;
            
            a = o[ ObjectAttribute.IMPORTS ] as Array ;
            
            if ( a != null && a.length > 0 )
            {
                size = a.length ;
                while ( --size > -1 )
                {
                    resource = ObjectResourceBuilder.get( a[size] ) ;
                    if ( resource != null )
                    {
                        resource.owner = factory ;
                        _imports.push( resource ) ;
                    }
                }
            }
        }
        
        /**
         * @private
         */
        private function _finishSequencer( e:ActionEvent ):void
        {
            
            if ( verbose )
            {
                logger.debug(this + " finish sequencer : " + e) ;
            }
            
            // imports
            
            if ( _imports != null && _imports.length > 0 )
            {
                var i:int ;
                var size:int = _imports.length ;
                for ( ; i<size ; i++ )
                {
                    addResource( _imports[i] as ObjectResource ) ;
                }
                _imports = [] ;
            }
            
            // next
            
            if ( sequencer.size() > 0 )
            {
                _runSequencer() ;
            }
            else
            {
                _info.unregisterLoader() ;
                _info.resource = null ;
                create() ;
            }
        }
        
        /**
         * @private
         */
        private function _initResource( resource:ObjectResource , action:CoreActionLoader ):void
        {
            // trace(this + " progress :: + " + action.request.url + " :: " + resource ) ;
            if ( resource != null  )
            {
                try
                {
                    if ( resource is ContextResource )
                    {
                        _checkContext( ( action as ActionURLLoader ).data ) ;
                    }
                    else
                    {
                        resource.initialize() ;
                    }
                }
                catch( e:Error )
                {
                    if ( verbose )
                    {
                        logger.error( this + " init resource failed : " + resource ) ;
                    }
                }
            }
        }
        
        /**
         * @private
         */
        private function _progressSequencer( e:ActionEvent ):void
        {
            if ( verbose )
            {
                logger.debug(this + " progress sequencer : " + e) ;
            }
            var action:CoreActionLoader = sequencer.current as CoreActionLoader ;
            var resource:ObjectResource = _resources.remove( action ) ;
            _initResource( resource , action ) ;
            var loader:CoreActionLoader = sequencer.element() as CoreActionLoader ; 
            _info.registerLoader( loader ) ;
            _info.resource = _resources.get( loader ) as ObjectResource ;
        }
        
        /**
         * @private
         */
        private function _runSequencer():void
        {
            var loader:CoreActionLoader = sequencer.element() as CoreActionLoader ; 
            _info.registerLoader( loader ) ;
            _info.resource = _resources.get( loader ) as ObjectResource ;
            sequencer.run() ;
        }
        
        /**
         * @private
         */
        private function _startSequencer( e:ActionEvent ):void
        {
            if ( verbose )
            {
                logger.debug(this + " start sequencer : " + e) ;
            }
            _imports = [] ;
            registerFactory() ;
        }
    }
}