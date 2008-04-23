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
package andromeda.ioc.core 
{
    import vegas.core.CoreObject;
    import vegas.data.Map;
    import vegas.data.map.HashMap;
    import vegas.errors.IllegalArgumentError;    

    /**
     * The concrete implementation of the IObjectDefinition interface.
     * @author eKameleon
     */
    public class ObjectDefinition extends CoreObject implements IObjectDefinition
    {

        /**
         * Creates a new ObjectDefinition instance.
         * @param id the id of the <code class="prettyprint">ObjectDefinition</code> object.
         * @param type the type of the <code class="prettyprint">ObjectDefinition</code> object.
         * @param singleton the boolean flag to indicate if the object is a sigleton or not.
         * @param lazyInit the boolean flag to indicate if the singleton object is lazy init or not.
         */    
        public function ObjectDefinition( id:* , type:String , singleton:Boolean=false , lazyInit:Boolean=false )
        {
            if ( id == null )
            {
                throw new IllegalArgumentError( this + " constructor failed, the 'id' value passed in argument not must be empty or 'null' or 'undefined'.") ;
            }
            if ( type == null || type.length == 0 )
            {
                throw new IllegalArgumentError( this + " constructor failed, the string 'type' passed in argument not must be empty or 'null' or 'undefined'.") ;    
            }
            _id        = id ;
            _type      = type ;
            _singleton = singleton  ;
            _scope     = singleton ? ObjectScope.SINGLETON : ObjectScope.PROTOTYPE ;
            _lazyInit  = lazyInit && _singleton ;
        }

        /**
         * (read-write) Indicates the id of this object.
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
         * Indicates if the object definition is a singleton and the type of the object is Identifiable if the object must be
         * populated with the id of the definition when is instanciated.
         */
        public function get identify():* 
        {
            return _identify ;    
        }
    
        /**
         * @private
         */
        public function set identify( value:* ):void
        {
            _identify = ( value is Boolean ) ? value : null ;
        }
        
        /**
         * Creates a new ObjectDefinition instance and populated it with the specified init object in argument.
         * @param o A generic object to populate the new ObjectDefinition instance.
         * @return A ObjectDefinition instance.
         */
        public static function create( o:* ):ObjectDefinition
        {

                var args:Array                 =  o[ ObjectAttribute.ARGUMENTS ] ;
                var destroy:String             =  o[ ObjectAttribute.OBJECT_DESTROY_METHOD_NAME ] ;
                var factoryMethod:Object       =  o[ ObjectAttribute.OBJECT_FACTORY_METHOD ] ;
                var id:String                  =  o[ ObjectAttribute.OBJECT_ID ] ;
                var identify:*                 =  o[ ObjectAttribute.IDENTIFY ] ;
                var init:String                =  o[ ObjectAttribute.OBJECT_INIT_METHOD_NAME ] ;
                var lazyInit:Boolean           =  o[ ObjectAttribute.LAZY_INIT ] ;
                var methods:Array              =  o[ ObjectAttribute.OBJECT_METHODS ] ;
                var properties:Array           =  o[ ObjectAttribute.OBJECT_PROPERTIES ] ;
                var scope:String               =  o[ ObjectAttribute.OBJECT_SCOPE ] ;
                var singleton:Boolean          =  o[ ObjectAttribute.OBJECT_SINGLETON ] ;
                var staticfactoryMethod:Object =  o[ ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD ] ;                
                var type:String                =  o[ ObjectAttribute.TYPE ] ;
                
                var definition:ObjectDefinition = new ObjectDefinition( id, type , singleton , lazyInit ) ;
                
                definition.identify = identify ;
                
                definition.setConstructorArguments( args ) ;
                definition.setDestroyMethodName( destroy ) ;
                definition.setFactoryMethod( ObjectFactoryMethod.create( factoryMethod ) ) ;
                definition.setInitMethodName( init ) ;
                definition.setMethods( methods ) ;
                definition.setProperties( _createNewProperties( properties ) ) ;
                definition.setScope( scope ) ;
                definition.setFactoryMethod( ObjectStaticFactoryMethod.create( staticfactoryMethod ) ) ;
                
                return definition ;            
            
        }
        
        /**
         * Returns the constructor arguments values of this object in a Array list.
         * @return the constructor arguments values of this object in a Array list.
         */    
        public function getConstructorArguments():Array 
        {
            return _constructorArguments ;
        }
        
        /**
         * Returns the name of the method invoked when the object is destroyed.
         * @return the name of the method invoked when the object is destroyed.
         */    
        public function getDestroyMethodName():String 
        {
            return _destroyMethodName;
        }
        
        /**
         * Returns the factory ObjectMethod of this definition.
         * @return the factory ObjectMethod object of this definition.
         */
        public function getFactoryMethod():ObjectMethod    
        {
            return _factoryMethod ;
        }        
        
        /**
         * Returns the name of the method call when the object is instanciate.
         * @return the name of the method call when the object is instanciate.
         */    
        public function getInitMethodName():String 
        {
            return _initMethodName;
        }

        /**
         * Returns the Array of all method definitions of this Definition.
         * @return the Array of all method definitions of this Definition.
         */    
        public function getMethods():Array 
        {
            return _methods ;
        }

        /**
         * Returns the Map of all properties of this Definition.
         * @return the Map of all properties of this Definition.
         */    
        public function getProperties():Map 
        {
            return _properties ;
        }

        /**
         * Returns the scope of the object.
         * @return the scope of the object.
         */    
        public function getScope():String 
        {
            return _scope ;
        }    

        /**
         * Returns the type of the object (the class name).
         * @return the type of the object (the class name).
         */    
        public function getType():String 
        {
            return _type ;
        }
        
        /**
         * Indicates if the object lazily initialized. Only applicable to a singleton object. 
         * If false, it will get instantiated on startup by object factories that perform eager initialization of singletons.
         * @return A boolean who indicates if the object lazily initialized. 
         */    
        public function isLazyInit():Boolean 
        {
            return _lazyInit;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object in a Sigleton else the object is a prototype.
         * @return <code class="prettyprint">true</code> if the object in a Sigleton else the object is a prototype.
         */        
        public function isSingleton():Boolean 
        {
            return _singleton ;
        }
        
        /**
         * Sets the constructor arguments values of this object.
         * @param value the array representation of all arguments in the constructor of the object instance.
         */    
        public function setConstructorArguments( value:Array = null ):void 
        {
            _constructorArguments = value ;
        }
        
        /**
         * Sets the name of the method invoked when the object is destroyed.
         * @param value the name of the destroy method of the object.
         */    
        public function setDestroyMethodName( value:String = null ):void 
        {
            _destroyMethodName = value;
        }
        
        /**
         * Sets the factory ObjectMethod of this definition.
         */
        public function setFactoryMethod( value:ObjectMethod ):void    
        {
            if ( value != null && ( value is ObjectFactoryMethod || value is ObjectStaticFactoryMethod ) )
            {
                _factoryMethod = value ;
            }
        }            
        
        /**
         * Init the name of the method.
          * @param value the string 'init method' name.
         */        
        public function setInitMethodName( value:String = null ):void 
        {
            _initMethodName = value;
        }

        /**
         * Sets the Array of all method definition of this Definition.
         * @param ar the Array of all method definitions of the object.
         */    
        public function setMethods( ar:Array = null ):void 
        {
            _methods = ar ;
        }

        /**
         * Sets the map of all properties of this Definition.
         * @param value the Map of all properties of the object.
         */    
        public function setProperties( value:Map = null ):void 
        {
            _properties = value ;
        }

        /**
         * Sets the scope of the object.
         */    
        public function setScope( scope:String = null ):void 
        {
            if ( scope != null && ObjectScope.validate( scope ) )
            {
                _scope     = scope  || ObjectScope.SINGLETON ;
                _singleton = _scope == ObjectScope.SINGLETON ;
            }
        }

        /**
         * Sets the type of the object (the class name).
         * @param value the string representation of the type object.
         */    
        public function setType( value:String = null ):void 
        {
            _type = value ;
        }
            
        /**
          * The internal Map of all arguments use in the constructor of the object.
          */
        private var _constructorArguments:Array ;
        
        /**
         * The name of the destroy method of the object.
         */
        private var _destroyMethodName:String;
        
        /**
         * The factory method of this definition.
         */
        private var _factoryMethod:ObjectMethod ;
        
        /**
         * The internal id of this object.
         */
        private var _id:* ;        
        
        /**
         * @private
         */
        private var _identify:* = null ;
        
        /**
         * The name of the init method of the object.
         */
        private var _initMethodName:String;

        /**
         * The lazy init flag of the object.
         */
        private var _lazyInit:Boolean ;
        
        /**
         * The internal Array of all method definitions of the object.
         */
        private var _methods:Array ;
        
        /**
         * The internal Map of all properties of the object.
         */
        private var _properties:Map ;
        
        /**
         * The scope of the object.
         */
        private var _scope:String ;
        
        /**
         * The internal Map of all singletons.
         */
        private var _singleton:Boolean ;
        
        /**
         * The type of the IDefinition object.
         */
        private var _type : String;
        
        /**
         * Returns and creates the Map of all properties.
         * @return and creates the Map of all properties.
         */
        private static function _createNewProperties( a:Array = null ):HashMap
        {
            if ( a == null )
            {
                return null ;
            }
            var len:uint = a.length ;
            if ( len > 0 )
            {
                
                var args:Array  ;
                var prop:Object ;
                var name:String ;
                var properties:HashMap = new HashMap() ;
                var ref:String  ;
                var value:* ;
                
                for (var i:Number = 0 ; i<len ; i++)
                {
                    
                    prop  = a[i] ;
                    args  = prop[ ObjectAttribute.ARGUMENTS ] ;
                    ref   = prop[ ObjectAttribute.REFERENCE ]  ;
                    name  = prop[ ObjectAttribute.NAME ] ;
                    value = prop[ ObjectAttribute.VALUE ] ;
                    
                    if (ref != null) 
                    {
                        properties.put( name , ref ) ; // ref property    
                    }
                    else 
                    {
                        properties.put( name, value ) ; // property    
                    }
                }
                return (properties.size() > 0) ? properties : null ;
            }
            else
            {
                return null ;    
            }    
        }
        
        
    }

}
