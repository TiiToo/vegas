/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.net 
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    
    import andromeda.events.ActionEvent;
    import andromeda.ioc.core.IObjectDefinition;
    import andromeda.ioc.core.ObjectAttribute;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.factory.strategy.ObjectFactoryValue;
    import andromeda.ioc.io.AssemblyResource;
    import andromeda.ioc.io.ContextResource;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceBuilder;
    import andromeda.process.ActionLoader;
    import andromeda.process.ActionURLLoader;
    import andromeda.process.CoreActionLoader;
    import andromeda.process.Sequencer;
    import andromeda.process.SimpleAction;
    
    import vegas.core.IFactory;
    import vegas.data.map.HashMap;    

    /**
     * This loader object load an external IoC context and this dependencies and fill the IoC container.
     */
    public class ObjectFactoryLoader extends SimpleAction implements IFactory
    {
        
        /**
         * Creates a new ObjectFactoryLoader instance.
         * @param context The uri of the context external eden file (default "application.eden").
         * @param path The optional path of the external context file (default "").
         * @param factory The optional ECMAObjectFactory reference of this loader. By default the loader use the ECMAObjectFactory.getInstance() reference. 
         */
        public function ObjectFactoryLoader( context:String=null , path:String="" , factory:ObjectFactory = null )
        {
            
            this.context  = context ;
            this.factory  = factory ;
            this.path     = path    ;
            
            _resources    = new HashMap() ; 
            
            sequencer     = new Sequencer() ;            
            
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
         * Switch the verbose mode of this loader.
         */
        public var verbose:Boolean = false ;
        
        /**
         * Clear the loader.
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
         */
        public function create( ...arguments:Array ):void         
        {
            if ( objects.length > 0 )
            {    
                factory.create( objects ) ;
            }
            else
            {
            	if ( verbose )
            	{
                    getLogger().warn( this + " the factory is empty." ) ;
            	}    
            }    
        }

        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            
            clear() ;
            
            if ( arguments.length > 0 && arguments[0] is String )
            {
                context = arguments[0] as String ;
            }
            
            addResource( new ContextResource( { resource:context } ) ) ;
            
            sequencer.run() ;
            
        }        
        
        /**
         * Invoked to debug the errors or warning during the factory process.
         */
        protected function fireEvent( e:* ):void
        {
            if ( verbose )
            {        	
                getLogger().info( this + " fireEvent(" + e + ")" ) ; // no event before the IOC factory initialization.
            }
            dispatchEvent( e ) ;
        }
        
        /**
         * Invoked when the factory is complete.
         */
        public function main( e:ActionEvent ):void
        {
            if ( verbose )
            {
                getLogger().debug( this + " main(" + e + ")" ) ;
            }
            fireEvent(e) ;
        }
        
        /**
         * Register the current factory referenceof this loader. 
         */
        public function registerFactory():void
        {
        	if ( _factory != null && _isRegister == false )
            {
                _isRegister = true ;
                _factory.addEventListener( IOErrorEvent.IO_ERROR   , fireEvent ) ;
                _factory.addEventListener( ProgressEvent.PROGRESS  , fireEvent ) ;
                _factory.addEventListener( Event.COMPLETE          , fireEvent ) ;
                _factory.addEventListener( ActionEvent.START       , fireEvent ) ;
                _factory.addEventListener( ActionEvent.FINISH      , main      ) ;

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
                _factory.removeEventListener( IOErrorEvent.IO_ERROR   , fireEvent ) ;
                _factory.removeEventListener( ProgressEvent.PROGRESS  , fireEvent ) ;
                _factory.removeEventListener( Event.COMPLETE          , fireEvent ) ;
                _factory.removeEventListener( ActionEvent.START       , fireEvent ) ;
                _factory.removeEventListener( ActionEvent.FINISH      , main      ) ;
            }
        }
        
        ///////// protected   
        
        /**
         * This Class reference is protected cause you must change this setter strategy in your concrete implementation.
         * @private
         */
        protected var _internalLoader:Class ;        
        
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
            	
            	_resources.put( loader , resource ) ;
            	
                return sequencer.addAction( loader ) ;
            }
            else
            {
                return false ;
            }
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

            // trace( this + " progress data : " + eden.serialize( data )) ;
                
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
                getLogger().debug(this + " finish sequencer : " + e) ;
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
            	sequencer.run() ;
            }
            else
            {
                registerFactory() ;
                create() ;
            }
        }
        
        private function _initResource( resource:ObjectResource , action:CoreActionLoader ):void
        {
            // trace(this + " progress :: + " + action.request.url ) ;
            if ( resource != null  )
            {
                switch( true )
                {
                	case resource is AssemblyResource :
                    {
                        var al:ActionLoader = action as ActionLoader ;
                        try
                        {
                            var id:* = resource.id ;
                            if ( id != null && factory.containsObjectDefinition(id) )
                            {
                            	var d:IObjectDefinition  = factory.getObjectDefinition(id) ;
                            	var s:ObjectFactoryValue = new ObjectFactoryValue( al.content ) ;
                            	d.setFactoryStrategy( s ) ;
                            }
                        }
                        catch( e1:Error )
                        {
                            if ( verbose )
                            {
                                getLogger().error( this + " init resource failed : " + e1 ) ;
                            }
                        }
                        break ;
                    }
                    case resource is ContextResource :
                    {
                        var au:ActionURLLoader = action as ActionURLLoader ;
                        try
                        {
                            _checkContext( au.data ) ;
                        }
                        catch( e2:Error )
                        {
                            if ( verbose )
                            {
                                getLogger().error( this + " init resource failed : " + e2 ) ;
                            }
                        }
                        break ;
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
                getLogger().debug(this + " progress sequencer : " + e) ;
            }
            
            var action:CoreActionLoader = sequencer.getCurrent() as CoreActionLoader ;
            var resource:ObjectResource = _resources.remove( action ) as ObjectResource ;
            
            // trace(this + " progress :: + " + resource + " :: " + _resources.size() ) ;
            
            _initResource( resource , action ) ;
            
        }
        
        /**
         * @private
         */
        private function _startSequencer( e:ActionEvent ):void
        {
            if ( verbose )
            {
                getLogger().debug(this + " start sequencer : " + e) ;
            }
            _imports = [] ;
            registerFactory() ;
        }

    }
}