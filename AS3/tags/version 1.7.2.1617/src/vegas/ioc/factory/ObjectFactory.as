﻿/*

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

package vegas.ioc.factory 
{
    import system.Reflection;
    import system.data.Identifiable;
    import system.data.maps.HashMap;
    import system.evaluators.Evaluable;
    import system.evaluators.MultiEvaluator;
    import system.events.EventListener;
    import system.process.Lockable;
    
    import vegas.Factory;
    import vegas.ioc.IObjectDefinition;
    import vegas.ioc.IObjectFactory;
    import vegas.ioc.MagicReference;
    import vegas.ioc.ObjectArgument;
    import vegas.ioc.ObjectAttribute;
    import vegas.ioc.ObjectDefinitionContainer;
    import vegas.ioc.ObjectListener;
    import vegas.ioc.ObjectMethod;
    import vegas.ioc.ObjectProperty;
    import vegas.ioc.factory.strategy.IObjectFactoryStrategy;
    import vegas.ioc.factory.strategy.ObjectFactoryMethod;
    import vegas.ioc.factory.strategy.ObjectFactoryProperty;
    import vegas.ioc.factory.strategy.ObjectFactoryReference;
    import vegas.ioc.factory.strategy.ObjectFactoryValue;
    import vegas.ioc.factory.strategy.ObjectStaticFactoryMethod;
    import vegas.ioc.factory.strategy.ObjectStaticFactoryProperty;
    
    import flash.events.IEventDispatcher;
    
    /**
     * The basic Inversion of Control container/factory class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.text.TextField ;
     * import flash.text.TextFormat ;
     * 
     * import vegas.ioc.ObjectDefinition ;
     * import vegas.ioc.factory.ObjectFactory ;
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
     */
    public class ObjectFactory extends ObjectDefinitionContainer implements Factory, Identifiable, IObjectFactory
    {
        /**
         * Creates a new ObjectFactory instance.
         * @param id The id of this factory.
         * @param global The flag to use a global event flow or a local event flow.
         * @param channel The name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function ObjectFactory( id:* = null , global:Boolean = false , channel:String = null )
        {
            super( global, channel ) ;
            this.id    = id ;
            singletons = new HashMap() ;
            config     = new ObjectConfig() ; // the default empty ObjectConfig instance.
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
            _config.referenceEvaluator.factory = this ;
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
         * Indicates if a singleton reference is register in the factory with the specified id. 
         * @param The 'id' of the singleton.
         * @return <code class="prettyprint">true</code> if the singleton reference exist in the factory.
         */
        public function containsSingleton( id:String ):Boolean 
        {
            return singletons.containsKey(id) ;
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
                warn( this + " getObject failed with the id '" + id + "' : " + e.toString() ) ;
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
            if ( isSingleton(id) && singletons.containsKey(id) )
            {
                invokeDestroyMethod( singletons.get(id), getObjectDefinition(id) ) ;
                singletons.remove( id ) ;
            }
        }
        
        /**
         * The custom warn method of this factory to log a warning message in the application.
         * You can overrides this method, the prototype object is dynamic.
         */
        public function warn( ...args:Array ):void
        {
            if ( config.useLogger )
            {
                logger.warn.apply( null , args ) ;
            }
            else
            {
                trace.apply(null, args) ;
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
                    try
                    {
                        if ( item.policy == ObjectAttribute.REFERENCE )
                        {
                            value = _config.referenceEvaluator.eval( value as String ) ;
                        }
                        else if ( item.policy == ObjectAttribute.CONFIG )
                        {
                            value = _config.configEvaluator.eval( value as String ) ;
                        }
                        else if ( item.policy == ObjectAttribute.LOCALE )
                        {
                            value = _config.localeEvaluator.eval( value as String ) ;
                        }
                        else
                        {
                            // do nothing
                        }
                        if ( item.evaluators != null && item.evaluators.length > 0 )
                        {
                            value = eval( value , item.evaluators  ) ;
                        }
                        stack.push( value ) ;
                    }
                    catch( e:Error )
                    {
                        warn( this + " createArguments failed : " + e.toString() ) ;
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
                
                name = factoryMethod.name ;
                args = createArguments( factoryMethod.arguments ) ;
                
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
                instance = _config.referenceEvaluator.eval((strategy as ObjectFactoryReference).ref ) ;
            }
            return instance ;
        }
        
        /**
         * Invoked to creates all object in the factory register in the dependsOn collection.
         * <p>All objects in the dependsOn collection are initialized before the initialization of the current object build in the factory.</p>
         */
        protected function dependsOn( definition:IObjectDefinition ):void
        {
            if ( definition.getDependsOn() != null ) 
            {
                var id:String ;
                var ar:Array = definition.getDependsOn() ;
                var size:int = ar.length ;
                if ( size > 0 )
                {
                    for ( var i:int ; i<size ; i++ )
                    {
                        id = ar[i] as String ;
                        if ( containsObjectDefinition(id))
                        {
                            getObject(id) ; // not keep in memory
                        }
                    }
                }
            }
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
            var s:int   = evaluators.length ;
            var a:Array = [] ;
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
                
                if ( o is Evaluable )
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
         * Invoked to creates all object in the factory register in the generates collection.
         * <p>All objects in the generates collection are initialized after the initialization of the current object build in the factory.</p>
         */
        protected function generates( definition:IObjectDefinition ):void
        {
            if ( definition.getGenerates() != null ) 
            {
                var id:String ;
                var ar:Array = definition.getGenerates() ;
                var size:int = ar.length ;
                if ( size > 0 )
                {
                    for ( var i:int ; i<size ; i++ )
                    {
                       id = ar[i] as String ;
                       if ( containsObjectDefinition(id))
                       {
                           getObject(id) ; // not keep in memory
                       }
                    }
                }
            }
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
            var name:String = definition.getInitMethodName();
            if ( name == null && config != null )
            {
                name = config.defaultInitMethod ;
            }
            if( (name in o) && (o[name] is Function) ) 
            {
                (o[name] as Function).call(o) ;
            }
        }
        
        /**
         * Indicates if the specified object is Lockable and must be locked during the initialization of the properties and methods when is created.
         */
        protected function isLockable( o:* , definition:IObjectDefinition ):Boolean
        {
            return ( o is Lockable ) && ( ( definition.lock == true ) || ( config.lock === true && definition.lock != false ) ) ;
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
        protected function populateProperties( o:* , definition:IObjectDefinition ):void 
        {
            var properties:Array = definition.getProperties() ;
            if ( properties && properties.length > 0 )
            {
                var id:* = definition.id ;
                var size:int = properties.length ;
                for( var i:int ; i < size ; i++ )
                {
                    populateProperty( o , properties[i] as ObjectProperty , id ) ;
                }
            } 
        }
        
        /**
         * Populates a property in the specified object with the passed-in ObjectProperty object.
         * @param o The object to populate.
         * @param prop The ObjectProperty used to populate the object.
         * @param id The id of the current IObjectDefinition.
         */
        protected function populateProperty( o:* , prop:ObjectProperty , id:* ):void 
        {
            if ( o == null )
            {
                warn( this + " populate a new property failed, the object not must be 'null' or 'undefined', see the factory with the object definition '" + id + "'." ) ;
                return ;
            }
            
            var name:String = prop.name ;
            var value:*     = prop.value ;
            
            //////////// #init magic strategy to populate the property
            
            if( name == MagicReference.INIT )
            {
                if ( prop.policy == ObjectAttribute.REFERENCE && value is String )
                {
                    value = _config.referenceEvaluator.eval( value as String ) ;
                }
                else if ( prop.policy == ObjectAttribute.CONFIG )
                {
                    value = config.configEvaluator.eval( value as String ) ;
                }
                else if ( prop.policy == ObjectAttribute.LOCALE )
                {
                    value = config.localeEvaluator.eval( value as String ) ;
                }
                if ( prop.evaluators && prop.evaluators.length > 0 )
                {
                    value = eval( value , prop.evaluators ) ;
                }
                if ( value )
                {
                    for( var member:String in value )
                    {
                        o[member] = value[member] ;
                    }
                }
                else
                {
                    warn( this + " populate a new property failed with the magic name #init, the object to enumerate not must be null, see the factory with the object definition '" + id + "'." ) ;
                }
                return ;
            }
            
            //////////// default strategy to populate the property
            
            if ( !( name in o ) )
            {
                warn( this + " populate a new property failed with the name:" + name + ", this property don't exist in the object:" + o + ", see the factory with the object definition '" + id + "'." ) ;
                return ;
            }
            if ( o[name] is Function )
            {
                if( prop.policy == ObjectAttribute.ARGUMENTS )
                {
                    o[ name ].apply( o , createArguments( value as Array ) ) ;
                    return ;
                }
                else if ( prop.policy == ObjectAttribute.VALUE && prop.value === undefined )
                {
                    o[ name ]() ;
                    return ;
                }
            }
            try
            {
                if ( prop.policy == ObjectAttribute.REFERENCE && value is String )
                {
                    value = _config.referenceEvaluator.eval( value as String ) ;
                }
                else if ( prop.policy == ObjectAttribute.CONFIG )
                {
                    value = config.configEvaluator.eval( value as String ) ;
                }
                else if ( prop.policy == ObjectAttribute.LOCALE )
                {
                    value = config.localeEvaluator.eval( value as String ) ;
                }
                if ( prop.evaluators && prop.evaluators.length > 0 )
                {
                    value = eval( value , prop.evaluators ) ;
                }
                o[ name ] = value ;
            }
            catch( e:Error )
            {
                warn( this + " populateProperty failed with the name '" + name + "' in the object '" + o + ", see the factory with the object definition '" + id + "' error: " + e.toString() ) ;
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
            var size:int = listeners.length ;
            if ( size > 0 )
            {
                var dispatcher:IEventDispatcher ;
                var method:Function ;
                var listener:ObjectListener ;
                for (var i:int ; i<size ; i++ ) 
                {
                    try
                    {
                        listener   = listeners[i] as ObjectListener ;
                        dispatcher = _config.referenceEvaluator.eval( listener.dispatcher ) as IEventDispatcher ;
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
                        warn( this + " registerListeners failed with the target '" + o + "' , in the collection of this listeners at {" + i + "} : " + e.toString() ) ;
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
        private function _create( definition:IObjectDefinition ):*
        {
            var instance:* = null ;
            try
            {
                var clazz:Class  = config.typeEvaluator.eval( definition.getType() ) as Class ;
                var strategy:IObjectFactoryStrategy = definition.getFactoryStrategy() ;
                if ( strategy )
                {
                    instance = createObjectWithStrategy( strategy ) as clazz ;
                }
                else
                {
                    instance = Reflection.invokeClass( clazz , createArguments( definition.getConstructorArguments() ) ) as clazz ;
                }
            }
            catch( e:TypeError )
            {
                warn(this + " createObject failed, can't convert the instance with the specified type \"" + definition.getType() + "\" in the object definition \"" + definition.id + "\", this type don't exist in the application.") ;
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
                dependsOn( definition ) ; // dependencies
                
                populateIdentifiable ( instance , definition ) ; // identify
                
                var flag:Boolean = isLockable( instance, definition ) ;
                
                if ( flag )
                {
                    (instance as Lockable).lock() ; // lock
                }
                
                registerListeners( instance , definition.getBeforeListeners() ) ; // before
                
                populateProperties( instance , definition ) ; // init properties
                
                registerListeners( instance , definition.getAfterListeners() ) ; // after
                
                if ( flag )
                {
                    (instance as Lockable).unlock() ; // unlock
                }
                
                invokeInitMethod( instance , definition ) ; // init
                
                generates( definition ) ; // generates
            }
            return instance ;
        }
    }
}