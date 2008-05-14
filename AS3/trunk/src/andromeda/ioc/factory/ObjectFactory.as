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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.factory 
{
    import andromeda.ioc.core.*;
    import andromeda.ioc.evaluators.TypeEvaluator;
    import andromeda.ioc.factory.IObjectFactory;
    import andromeda.ioc.factory.strategy.IObjectFactoryStrategy;
    import andromeda.ioc.factory.strategy.ObjectFactoryMethod;
    import andromeda.ioc.factory.strategy.ObjectFactoryProperty;
    import andromeda.ioc.factory.strategy.ObjectStaticFactoryMethod;
    import andromeda.ioc.factory.strategy.ObjectStaticFactoryProperty;
    
    import system.Reflection;
    
    import vegas.core.Identifiable;
    import vegas.data.Map;
    import vegas.data.map.HashMap;
    import vegas.errors.NullPointerError;
    import vegas.util.ClassUtil;    

    /**
     * The basic Inversion of Control container/factory class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import test.User ;
     * 
     * import andromeda.ioc.core.ObjectDefinition ;
     * import andromeda.ioc.factory.ObjectFactory ;
     * 
     * import vegas.data.map.HashMap ;
     * 
     * var factory:ObjectFactory = new ObjectFactory();
     * 
     * var properties:HashMap = new HashMap() ;
     * properties.put("pseudo" , "ekameleon" ) ;
     * properties.put("url"  , "http://www.ekameleon.net/blog" );
     * 
     * var definition:ObjectDefinition = new ObjectDefinition( "test.User" ) ;
     * definition.setProperties( properties ) ;
     * definition.setInitMethodName( "initialize" ) ;
     * 
     * factory.addObjectDefinition("user", definition );
     * 
     * var user:User = factory.getObject("user") ;
     * 
     * trace( "# User pseudo : " + user.pseudo ) ; // ekameleon
     * trace( "# User url    : " + user.url    ) ; // http://www.ekameleon.net/blog
     * </pre>
     * With the <b>test.User</b> class :
     * <pre class="prettyprint">
     * package test
     * {
     *     import vegas.core.CoreObject ;
     * 
     *     public class User extends CoreObject
     *     {
     *         
     *         public function User() {}
     *         
     *         public var pseudo:String ;
     *         public var url:String ;
     *         
     *         public function initialize():void
     *         {
     *             trace( "# " + this + " initialize.") ;
     *         }
     *         
     *     }
     * }
     * </pre>
     * @author eKameleon
     */
    public class ObjectFactory extends ObjectDefinitionContainer implements IObjectFactory 
    {

        /**
         * Creates a new ObjectFactory instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function ObjectFactory( bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal, sChannel ) ;
            _typeEvaluator = new TypeEvaluator() ;
            singletons    = new HashMap() ;
            config        = new ObjectConfig() ; // the default empty ObjectConfig instance.
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
            _typeEvaluator.config = _config ;
        }        
        
        /**
         * The maps of all objects in the container.
         */
        public var singletons:HashMap ;
        
        /**
         * Indicates the type evaluator reference in this factory. 
         */
        public function get typeEvaluator():TypeEvaluator
        {
            return _typeEvaluator ;
        }          
        
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
                        throw new NullPointerError( this +  " get( " + id + " ) method failed, the object isn't register in the container.") ; 
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
                debug( this + " createObject failed with the id '" + id + "' : " + e.toString() ) ;
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
         * @private
         */
        private var _config:ObjectConfig ;
       
        /**
         * @private
         */
        private var _typeEvaluator:TypeEvaluator ;          
       
        /**
          * Creates the arguments Array representation of the specified definition.
          * @return the arguments Array representation of the specified definition.
          */
        protected function createArguments( argList:Array=null ):Array
        {
            if ( argList == null )
            {
                return null ;    
            }
            var len:Number = argList.length ;
            if ( len > 0 )
            {
                var stack:Array = [] ;
                var item:Object ;
                for (var i:Number = 0 ; i<len ; i++)
                {
                    item = argList[i] ;
                    if ( item.ref != null )
                    {
                        stack.push( getObject( item.ref ) ) ;    
                    }
                    else if ( item.value != null )
                    {
                        stack.push( item.value ) ;    
                    }
                    else
                    {
                        stack.push(null) ;
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
                instance = createObject( definition ) ;
                singletons.put( id, instance ) ;
            }
            return instance;
        }

        /**
         * Creates a new Object with the specified id and the specified IObjectDefinition in argument.
         * @return a new Object with the specified id and the specified IObjectDefinition in argument.
         */
        protected function createObject( definition:IObjectDefinition ):*
        {
            var instance:* = null ;
            var clazz:Class ;
            var strategy:IObjectFactoryStrategy = definition.getFactoryStrategy() ;
            if ( strategy == null )
            {
                clazz           = _typeEvaluator.eval( definition.getType() ) as Class ;
                instance        = ClassUtil.buildNewInstance( clazz, createArguments( definition.getConstructorArguments()) ) ;
            }
            else
            {   
                instance = createObjectWithStrategy( strategy ) ;
            }
            if ( instance != null )
            {
                populateIdentifiable ( instance , definition ) ;
                populateProperties   ( instance , definition.getProperties() );
                invokeMethods        ( instance , definition.getMethods() ) ;
                invokeInitMethod     ( instance , definition ) ;
            }
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
            var instance:* = null ;
            var clazz:Class ;
            var factory:String ;
            var ref:* ;
            var name:String ;
            if ( strategy is ObjectMethod )
            {
                var factoryMethod:ObjectMethod = strategy as ObjectMethod ;
                name = factoryMethod.name ;
                var args:Array = createArguments( factoryMethod.arguments ) ;
                if ( factoryMethod is ObjectStaticFactoryMethod )
                {
                    clazz  = _typeEvaluator.eval( (factoryMethod as ObjectStaticFactoryMethod).type as String ) as Class ;
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
                    clazz = _typeEvaluator.eval( (factoryProperty as ObjectStaticFactoryProperty).type as String ) as Class ;
                    if ( clazz != null && name in clazz ) 
                    {
                        instance = clazz[name] ;
                    }
                }
                else if ( factoryProperty is ObjectFactoryProperty )
                {
                    factory = (factoryProperty as ObjectFactoryProperty).factory ;
                    ref     = getObject( factory ) ;
                    if ( ( ref != null ) && ( name != null ) && ( name in ref ) ) 
                    {
                        instance = ref[name] ;
                    }
                }
            }
            return instance ;
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
            var size:uint = methods.length ;
            if ( size > 0 )
            {
                for (var i:uint = 0 ; i<size ; i++) 
                {
                    try
                    {
                        var item:Object = methods[i] ;
                        var name:String = item[ ObjectAttribute.NAME ] ;
                        var args:Array  = createArguments( item[ ObjectAttribute.ARGUMENTS ] ) ;
                        if ( name in o )
                        {
                            o[ name ].apply( o , args ) ;    
                        }
                    }
                    catch( e:Error ) 
                    {
                        // do nothing
                        debug( this + " invokeMethods failed with the scope '" + o + "' : " + e.toString() ) ;
                        //
                    }    
                }
            }
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
                    (o as Identifiable ).id = definition.id ;
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
                var values:Array = properties.getValues() ;
                var size:uint    = values.length ;
                for( var i:uint = 0 ; i<size ; i++ )
                {
                    prop = values[i] as ObjectProperty ;
                    if 
                    ( 
                        prop.policy == ObjectAttribute.REFERENCE 
                            && prop.value is String 
                                && containsObject( prop.value as String ) 
                    )
                    {
                        o[prop.name] = getObject( prop.value ) ;
                    }
                    else
                    {
                        o[prop.name] = prop.value ;
                    }
                }
            } 
        }

        /**
         * Populates all properties in the Map passed in argument.
         */
        protected function populateMethods( o:* , methods:Array=null ):void 
        {
            if ( o == null || methods == null )
            {
                return ;
            }
            var size:uint = methods.length ;
            if ( size > 0 )
            {
                for( var i:uint = 0 ; i<size ; i++ )
                {
                    var item:Object = methods[i] ;
                    if ( item != null )
                    {
                        var name:String = item[ ObjectAttribute.NAME ] ;
                        var args:Array = createArguments(item[ ObjectAttribute.ARGUMENTS ]) ;
                        if ( name != null && name in o )
                        {
                            o[name].apply(o, args) ;
                        }
                    }
                }
            } 
        }
     
            
    }

}
