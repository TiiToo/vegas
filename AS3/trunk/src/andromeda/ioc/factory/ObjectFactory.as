﻿/*

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
package andromeda.ioc.factory 
{
    import flash.events.IEventDispatcher;
    
    import andromeda.ioc.core.*;
    import andromeda.ioc.evaluators.ReferenceEvaluator;
    import andromeda.ioc.factory.IObjectFactory;
    import andromeda.ioc.factory.strategy.*;
    
    import system.Reflection;
    import system.evaluators.IEvaluator;
    import system.evaluators.MultiEvaluator;
    
    import vegas.core.IFactory;
    import vegas.core.ILockable;
    import vegas.core.Identifiable;
    import vegas.data.Map;
    import vegas.data.map.HashMap;
    import vegas.events.EventListener;
    import vegas.util.ClassUtil;    

    /**
     * The basic Inversion of Control container/factory class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.text.TextField ;
     * import flash.text.TextFormat ;
     * 
     * import andromeda.ioc.core.ObjectDefinition ;
     * import andromeda.ioc.factory.ObjectFactory ;
     * 
     * var factory:ObjectFactory = new ObjectFactory();
     * 
     * var context:Object =
     * {
     *     id         : "my_field" ,
     *     type       : "flash.text.TextField" ,
     *     properties :
     *     [
     *         { name:"defaultTextFormat" , value:new TextFormat("verdana", 11) } ,
     *         { name:"selectable"        , value:false                         } ,
     *         { name:"text"              , value:"hello world"                 } ,
     *         { name:"textColor"         , value:0xF7F744                      } ,
     *         { name:"x"                 , value:100                           } ,
     *         { name:"y"                 , value:100                           }
     *     ]
     * }
     * 
     * var definition:ObjectDefinition = ObjectDefinition.create( context ) ;
     * 
     * container.addObjectDefinition( definition );
     * 
     * var field:TextField = factory.getObject("my_field") as TextField ;
     * 
     * addChild(field) ;
     * </pre>
     * @author eKameleon
     */
    public class ObjectFactory extends ObjectDefinitionContainer implements Identifiable, IObjectFactory, IFactory
    {

        /**
         * Creates a new ObjectFactory instance.
         * @param id The id of this factory.
         * @param bGlobal The flag to use a global event flow or a local event flow.
         * @param sChannel The name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function ObjectFactory( id:*=null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal, sChannel ) ;
            _re.factory      = this ;
            this.id          = id ;            
            singletons       = new HashMap() ;
            config           = new ObjectConfig() ; // the default empty ObjectConfig instance.
        }
        
        /**
         * Determinates the configuration object of the object factory.
         */
        public function get config():ObjectConfig
        {
            return _config ;    
        }
        
        /**
         * @private
         */
        public function set config( o:ObjectConfig ):void
        {
            _config = o || new ObjectConfig() ;
        }        
        
        /**
         * Indicates the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
    
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _id = id ;
        }          
        
        /**
         * The maps of all objects in the container.
         */
        public var singletons:HashMap ;
		
        /**
         * Returns <code class="prettyprint">true</code> if the referencial contains the specified object.
         * @param id The 'id' of the object to search.
         * @return <code class="prettyprint">true</code> if the referencial contains the specified object.
         */     
        public function containsObject(name:String):Boolean 
        {
            return containsObjectDefinition(name);
        }
        
        /**
         * Create the objects and fill the IObjectDefinitionContainer.
         * @param ...arguments An object who contains all the "objects" settings.
         */
        public function create( ...arguments:Array ):void
        {
            run.apply( this, arguments ) ;
        }        
        
        /**
         * The custom debug method of this factory.
         * You can overrides this method, the prototype object is dynamic.
         */
        public function debug( o:* ):void
        {
            getLogger().warn( o ) ; // use trace in this method if you want debug in Flash or the Flash debugger.
        }
        
        /**
         * This method returns an object with the specified id in argument.
         * @param id The 'id' of the object to return.
         * @return the instance of the object with the id passed in argument.
         */        
        public function getObject( id:String ):*
        {
            if ( id == null )
            {
               return null ;    
            }
            try
            {
                var instance:* = singletons.get(id) || null ;    
                if ( instance == null )
                {
                    var definition:IObjectDefinition = getObjectDefinition( id ) ;
                    if ( definition == null )
                    {
                        throw new Error( this +  " get( " + id + " ) method failed, the object isn't register in the container.") ; 
                    }
                    if ( definition.isSingleton() )
                    {
                        instance = createAndCacheSingletonInstance( id , definition ) ;
                    }
                    else
                    {
                        instance = createObject( definition ) ;
                    }
                }
            }
            catch(e:Error)
            {
                debug( this + " getObject failed with the id '" + id + "' : " + e.toString() ) ;
            }
            return instance || null ;
        }

        /**
         * This method indicates if the specified object definition is lazy init.
         * @param id The 'id' of the object definition to check..
         * @return <code class="prettyprint">true</code> if the specified object definition is lazy init.
         */     
        public function isLazyInit( id:String ):Boolean 
        {
            if ( containsObjectDefinition( id ) )
            {
                return getObjectDefinition(id).isLazyInit() ;
            }
            else
            {
                return false ;    
            }
        }

        /**
         * This method defined if the scope of the specified object definition is "singleton".
         * @param The 'id' of the object.
         * @return <code class="prettyprint">true</code> if the object is a singleton. 
         */     
        public function isSingleton( id:String ):Boolean 
        {
            if ( containsObjectDefinition( id ) )
            {
                return getObjectDefinition(id).isSingleton() ;
            }
            else
            {
                return false ;    
            }
        }
        
        /**
         * Removes and destroy a singleton in the container. 
         * Invoke the <b>'destroy'</b> method of this object is it's define in the <code class="prettyprint">IObjectDefinition</code> of this singleton.
         * @param id The id of the singleton to remove.
          */
        public function removeSingleton( id:String ):void
        {
            if ( isSingleton(id) )
            {
                invokeDestroyMethod( singletons.get(id), getObjectDefinition(id) ) ;
                singletons.remove( id ) ;    
            }
        }

	    /**
         * Creates the arguments Array representation of the specified definition.
         * @return the arguments Array representation of the specified definition.
         */
        protected function createArguments( args:Array=null ):Array
        {
            if ( args == null )
            {
                return null ;    
            }
            var len:int = args.length ;
            if ( len > 0 )
            {
            	
            	var i:int ;
                var stack:Array = [] ;
                var item:ObjectArgument ;
                var value:* ;
                
                for ( ; i<len ; i++)
                {

                    item  = args[i] as ObjectArgument ;
                    
                    value = item.value ;
                    
                    if ( item.evaluators != null && item.evaluators.length > 0 )
                    {
                        value = eval( value , item.evaluators  ) ;
                    }
                    
                    if ( item.policy == ObjectAttribute.REFERENCE )
                    {
                        stack.push( _re.eval( value as String ) ) ;    
                    }
                    else if ( item.policy == ObjectAttribute.CONFIG )
                    {
                    	stack.push( config.configEvaluator.eval( value as String ) ) ;
                    }
                    else if ( item.policy == ObjectAttribute.LOCALE )
                    {
                    	stack.push( config.localeEvaluator.eval( value as String ) ) ;
                    }                                  
                    else
                    {
                        stack.push( value ) ;    
                    }
                    
                }
                return stack ;        
            }
            else
            {
                return null ;
            }
        } 
        
        /**
         * Creates and cache the singleton instance define with the specified id and IObjectDefinition.
         * @param id the id of the class object.
         * @param definition the IDefinition to apply over the new instance.
         */
        protected function createAndCacheSingletonInstance( id:String, definition:IObjectDefinition ):*
        {
            var instance:* = singletons.get( id ) ;
            if( !instance ) 
            {
                instance = _create( definition ) ;
                singletons.put( id, instance ) ;
                _initialize( instance , definition ) ;
            }
            return instance;
        }

        /**
         * Creates a new Object with the specified id and the specified IObjectDefinition in argument.
         * @return a new Object with the specified id and the specified IObjectDefinition in argument.
         */
        protected function createObject( definition:IObjectDefinition ):*
        {
            var instance:* = _create( definition ) ;
            _initialize( instance , definition ) ;
            return instance ;
        }
        
        /**
         * Creates a new Object with a specified IObjectFactoryStrategy instance.
         * @return A new Object with a specified IObjectFactoryStrategy instance.
         */
        protected function createObjectWithStrategy( strategy:IObjectFactoryStrategy ):*
        {

            if ( strategy == null )
            {
                return null ;
            }
            
            var args:Array ;
            var instance:* = null ;
            var clazz:Class ;
            var factory:String ;
            var ref:* ;
            var name:String ;
            
            var factoryMethod:ObjectMethod ;
            
            if ( strategy is ObjectMethod )
            {
                
                factoryMethod = strategy as ObjectMethod ;
                
                name          = factoryMethod.name ;
                args          = createArguments( factoryMethod.arguments ) ;
                                
                if ( factoryMethod is ObjectStaticFactoryMethod )
                {
                    clazz  = config.typeEvaluator.eval( (factoryMethod as ObjectStaticFactoryMethod).type as String ) as Class ;
                    if ( clazz != null && name in clazz ) 
                    {
                        instance = clazz[name].apply( null, args ) ;
                    }
                }
                else if ( factoryMethod is ObjectFactoryMethod )
                {
                    factory  = (factoryMethod as ObjectFactoryMethod).factory ;
                    ref      = getObject( factory ) ;
                    if ( ( ref != null ) && ( name != null ) && ( name in ref ) ) 
                    {
                        instance = ref[name].apply( null, args ) ;
                    }
                }
            }
            else if ( strategy is ObjectProperty )
            {
                var factoryProperty:ObjectProperty = strategy as ObjectProperty ;

                name = factoryProperty.name ;

                if ( factoryProperty is ObjectStaticFactoryProperty )
                {
                    clazz = config.typeEvaluator.eval( (factoryProperty as ObjectStaticFactoryProperty).type as String ) as Class ;
                    if ( clazz != null && name in clazz ) 
                    {
                        instance = clazz[name] ;
                    }
                }
                else if ( factoryProperty is ObjectFactoryProperty )
                {

                    factory = (factoryProperty as ObjectFactoryProperty).factory ;
                    if ( factory != null && containsObjectDefinition(factory) )
                    {
                        ref = getObject(factory) ;
                        if ( ( ref != null ) && ( name != null ) && ( name in ref ) ) 
                        {
                            instance = ref[name] ;
                        }
                    }
                }
            }
            else if ( strategy is ObjectFactoryValue )
            {
            	instance = (strategy as ObjectFactoryValue).value ;
            }
            else if ( strategy is ObjectFactoryReference )
            {
            	instance = _re.eval((strategy as ObjectFactoryReference).ref ) ;
            }            
            return instance ;
        }
        
        /**
         * Evaluates a value with an Array of evaluators or IEvaluator reference in the factory.
         * @param value The value to evaluate.
         * @param evaluators The Array who contains IEvaluator objects or String ids who representing a IEvaluator in the factory.
         * @return The new value after evaluation.
         */
        protected function eval( value:* , evaluators:Array ):*
        {
            if ( evaluators == null || evaluators.length == 0 )
            {
                return value ;
            }
            _e.clear() ;
            var o:* ;
            var a:Array = [] ;
            var s:int   = evaluators.length ;
            for ( var i:int = 0 ; i < s ; i++ )
            {
                o = evaluators[i] ;
                if ( o == null )
                {
                	continue ;
                }
                
                if ( o is String )
                {
                	o = getObject( o as String ) ;
                }
                
                if ( o is IEvaluator )
                {
                    a.push( o ) ;                   
                }  
            }
            if ( a.length > 0 )
            {
            	_e.add( a ) ;
                value = _e.eval( value ) ;
                _e.clear() ;    
            }
            return value ;
        }
        
    
              
        
        /**
         * Invokes the destroy method of the specified object, if the init method is define in the IDefinition object.
         */
        protected function invokeDestroyMethod( o:* , definition:IObjectDefinition ):void
        {
            var name:String = definition.getDestroyMethodName();
            if ( name == null && config != null )
            {
                name = config.defaultDestroyMethod ;
            }            
            var method:Function = Reflection.getMethodByName( o , name ) ;
            if( method != null ) 
            {
                method.call(o) ;
            }
        }
         
        /**
         * Invokes the init method of the specified object, if the init method is define in the IDefinition object.
         */
        protected function invokeInitMethod( o:* , definition:IObjectDefinition=null ):void
        {
            var name:String     = definition.getInitMethodName();
            if ( name == null && config != null )
            {
                name = config.defaultInitMethod ;
            }
            var method:Function = Reflection.getMethodByName( o , name ) ;
            if( method != null ) 
            {
                method.call(o) ;
            }
        }
        
        /**
         * Invokes the init method of the specified object, if the init method is define in the IDefinition object.
         */
        protected function invokeMethods( o:* , methods:Array ):void
        {
            if ( o == null || methods == null )
            {
                return ;
            }
            var name:String ;
            var size:uint = methods.length ;
            if ( size > 0 )
            {
                var m:ObjectMethod ;       	
                for (var i:uint = 0 ; i<size ; i++) 
                {
                    try
                    {
                        m = methods[i] as ObjectMethod ;     
                        name = m.name ;
                        if ( name in o )
                        {
                            o[ name ].apply( o , createArguments( m.arguments ) ) ;    
                        }
                    }
                    catch( e:Error ) 
                    {
                        // do nothing
                        debug( this + " invokeMethods failed with the scope '" + o + "' , in the collection of this methods at {" + i + "} : " + e.toString() ) ;
                        //
                    }    
                }
            }
        }

        /**
         * Indicates if the specified object is ILockable and must be locked during the initialization of the properties and methods when is created.
         */
        protected function isLockable( o:* , definition:IObjectDefinition ):Boolean
        {
            return ( o is ILockable ) && ( ( definition.lock == true ) || ( config.lock === true && definition.lock != false ) ) ;
        }
        
        /**
         * Populates the <code class="prettyprint">Identifiable</code> singleton object, if the 'identify' flag is true the config of this factory and if specified the <code class="prettyprint">IObjectDefinition</code> object scope is singleton.
         */
        protected function populateIdentifiable( o:* , definition:IObjectDefinition ):void
        {
            if ( definition.isSingleton() && o is Identifiable )
            {
                if ( ( definition.identify == true ) || ( config.identify === true && definition.identify != false ) )
                {
                    ( o as Identifiable ).id = definition.id ;
                }
            }
        }

        /**
         * Populates all properties in the Map passed in argument.
         */
        protected function populateProperties( o:* , properties:Map=null ):void 
        {
            if (properties != null && properties.size() > 0)
            {
                var prop:ObjectProperty ;
                var value:* ;
                var name:String ;
                var values:Array = properties.getValues() ;
                var size:int     = values.length ;
                for( var i:int = 0 ; i<size ; i++ )
                {
                    prop = values[i] as ObjectProperty ;
                    
                    name  = prop.name ;
                    value = prop.value ;
                    
                    if ( prop.evaluators != null && prop.evaluators.length > 0 )
                    {
                        value = eval( value , prop.evaluators  ) ;
                    }                    
                                        
                    if ( prop.policy == ObjectAttribute.REFERENCE && value is String )
                    {
                        o[ name ] = _re.eval( value as String ) ;
                    }
                    else if ( prop.policy == ObjectAttribute.CONFIG )
                    {
                    	o[ name ] = config.configEvaluator.eval( value as String ) ;
                    }
                    else if ( prop.policy == ObjectAttribute.LOCALE )
                    {
                    	o[ name ] = config.localeEvaluator.eval( value as String ) ;
                    }
                    else
                    {
                        o[ name ] = value ;
                    }
                }
            } 
        }
        
        /**
         * Initialize the listener callback of the specified object.
         */
        protected function registerListeners( o:* , listeners:Array ):void
        {
            if ( o == null || listeners == null )
            {
                return ;
            }
            var size:uint = listeners.length ;
            if ( size > 0 )
            {
                var dispatcher:IEventDispatcher ;
                var method:Function ;
                var listener:ObjectListener ;        
                for (var i:uint = 0 ; i<size ; i++) 
                {
                    try
                    {
                        listener   = listeners[i] as ObjectListener ;     
                        dispatcher = _re.eval( listener.dispatcher ) as IEventDispatcher ;
                        if ( dispatcher != null && listener.type != null )
                        {
                            if ( listener.method != null && listener.method in o ) 
                            {
                                method =  o[listener.method] as Function  ;
                            }
                            else if ( o is EventListener  )
                            {
                                method = ( o as EventListener).handleEvent ; 
                            }                             
                            if ( method != null)
                            {
                                dispatcher.addEventListener( listener.type , method , listener.useCapture, listener.priority, listener.useWeakReference ) ;  
                            }
                        }
                    }
                    catch( e:Error ) 
                    {
                        // do nothing
                        debug( this + " registerListeners failed with the target '" + o + "' , in the collection of this listeners at {" + i + "} : " + e.toString() ) ;
                        //
                    }    
                }
            }
        }        
        
        /**
         * @private
         */
        private var _config:ObjectConfig ;
        
        /**
         * @private
         */
        private var _id:* ;
                    
        /**
         * @private
         */
        private var _e:MultiEvaluator = new MultiEvaluator() ;
        
        /**
         * @private
         */
        private var _re:ReferenceEvaluator = new ReferenceEvaluator() ;
        
        /**
         * @private
         */
        private function _create( definition:IObjectDefinition ):*
        {
                  
            var instance:*   = null ;
            
            var clazz:Class  = config.typeEvaluator.eval( definition.getType() ) as Class ;
            
            var strategy:IObjectFactoryStrategy = definition.getFactoryStrategy() ;
            
            try
            {
                if ( strategy == null )
                {
                    instance = ClassUtil.buildNewInstance( clazz, createArguments( definition.getConstructorArguments()) ) as clazz ;
                }
                else
                {   
                    instance = createObjectWithStrategy( strategy ) as clazz ;
                }
            }
            catch( e:TypeError )
            {
                getLogger().fatal(this + " createObject failed, can't convert the instance with the specified type \"" + definition.getType() + "\" in the object definition \"" + definition.id + "\", this type don't exist in the application.") ;   
            }
            
            return instance ;
        } 
        

        /**
         * @private
         */
        private function _initialize( instance:* , definition:IObjectDefinition ):*
        {
            if ( instance != null && definition != null )
            {
                
                populateIdentifiable ( instance , definition ) ;
                
                var flag:Boolean = isLockable( instance, definition ) ;
                
                if ( flag )
                {
                    (instance as ILockable).lock() ;
                }
                                
                registerListeners( instance , definition.getListeners() ) ;
                
                populateProperties( instance , definition.getProperties() );
                
                invokeMethods( instance , definition.getMethods() ) ;
                
                if ( flag )
                {
                    (instance as ILockable).unlock() ;
                }                
                
                invokeInitMethod( instance , definition ) ;
                
            }
            return instance ;
        }        
        
    }
}

