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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.ioc.factory 
{
    import system.Reflection;
    import system.data.Iterator;
    
    import vegas.ioc.ObjectAttribute;
    import vegas.ioc.TypeAliases;
    import vegas.ioc.TypeExpression;
    import vegas.ioc.TypePolicy;
    import vegas.ioc.evaluators.ConfigEvaluator;
    import vegas.ioc.evaluators.LocaleEvaluator;
    import vegas.ioc.evaluators.ReferenceEvaluator;
    import vegas.ioc.evaluators.TypeEvaluator;
    import vegas.net.FlashVars;
    
    import flash.display.Stage;
    
    /**
     * This object contains the configuration of the IOC object factory.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.ioc.factory.ObjectConfig ;
     * 
     * var config:ObjectConfig       = new ObjectConfig() ;
     * 
     * config.defaultInitMethod      = "init" ;
     * config.defaultDestroyMethod   = "destroy" ;
     * config.identify               = true ;
     * 
     * config.typeAliases            = [ { alias:"HashMap" , type:"system.data.maps.HashMap" } ] ;
     * config.typePolicy             = TypePolicy.ALIAS ;
     * 
     * trace( config ) ; // [ObjectConfig defaultDestroyMethod:destroy defaultInitMethod:init identify:true]
     * </pre>
     */
    public class ObjectConfig 
    {
        /**
         * Creates a new ObjectConfig instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function ObjectConfig( init:Object=null )
        {
            _config          = new Object() ;
            _configEvaluator = new ConfigEvaluator( this ) ;
            _locale          = new Object() ;
            _typeExpression  = new TypeExpression() ;
            _typeAliases     = new TypeAliases() ;
            _localeEvaluator = new LocaleEvaluator( this ) ;
            _typeEvaluator   = new TypeEvaluator( this ) ;
            throwError       = true ;
            initialize( init ) ;
        }
        
        /**
         * The config object reference used in the factory to register values and expressions.
         */
        public function get config():Object
        {
            return _config ;
        }
        
        /**
         * @private
         */
        public function set config( init:* ):void
        {
            for( var prop:String in init )
            {
                _config[prop] = init[prop] ;
            }
        }
        
        /**
         * Indicates the config evaluator reference. 
         */
        public function get configEvaluator():ConfigEvaluator
        {
            return _configEvaluator ;
        }
        
        /**
         * The default name of destroy callback method to invoke with object definition in the ObjectFactory. 
         */
        public var defaultDestroyMethod:String ;
        
        /**
         * The default name of destroy callback method to invoke with object definition in the ObjectFactory. 
         */
        public var defaultInitMethod:String ;
        
        
        /**
         * The FlashVars optional reference.
         * This property is optional and can be target in the IoC factory with the "ref" attribute with the value "#flashvars".
         */
        public var flashVars:FlashVars ;
        
        /**
         * Indicates if the singleton objects in the ObjectFactory are identifiy if the type of the object implements the Identifiable interface.
         */
        public var identify:Boolean ;
        
        /**
         * The locale object of the factory. To evaluate locale expression in the object definitions.
         */
        public function get locale():Object
        {
            return _locale ;
        }
        
        /**
         * @private
         */
        public function set locale( init:* ):void
        {
            for( var prop:String in init )
            {
                _locale[prop] = init[prop] ;
            }
        }
        
        /**
         * Indicates the locale evaluator reference.
         */
        public function get localeEvaluator():LocaleEvaluator
        {
            return _localeEvaluator ;
        }
        
        /**
         * Indicates if all the Lockable objects initialized in the object definitions in the factory must be locked during the invokation of this methods and the initialization of this properties.
         */
        public var lock:Boolean ;
        
        /**
         * Indicates the reference evaluator object.
         */
        public function get referenceEvaluator():ReferenceEvaluator
        {
            return _referenceEvaluator ;
        }
        
        /**
         * The root reference of the application. 
         * This property is optional and can be target in the IoC factory with the "ref" attribute with the value "#root".
         */
        public var root:* ;
        
        /**
         * The stage reference of the application. 
         * This property is optional and can be target in the IoC factory with the "ref" attribute with the value "#stage".
         */
        public var stage:Stage ;
        
        /**
         * Indicates if the class throws errors or return null when an error is throwing.
         */
        public function get throwError():Boolean
        {
            return _configEvaluator.throwError && _localeEvaluator.throwError && _typeEvaluator.throwError && _referenceEvaluator.throwError ;
        }
        
        /**
         * @private
         */
        public function set throwError( b:Boolean ):void
        {
            _configEvaluator.throwError    = b ;
            _localeEvaluator.throwError    = b ;
            _referenceEvaluator.throwError = b ;
            _typeEvaluator.throwError      = b ;
        }
        
        /**
         * Determinates the typeAliases reference of this config object.
         * <p>The setter of this virtual property can be populated with a TypeAliases instance or an Array of typeAliases items.</p>
         * <p>This setter attribute don't remove the old TypeAliases instance but fill it with new aliases. 
         * If you want cleanup the aliases of this configuration object you must use the <code class="prettyprint">typeAliases.clear()</code> method.</p>
         * <p>The typeAliases items are generic objects with 2 attributes <b>alias</b> (the alias String expression) and <b>type</b> (the type String expression).</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.ioc.factory.ObjectConfig ;
         * var config:ObjectConfig  = new ObjectConfig() ;
         * config.typeAliases       =
         * [ 
         *     { alias:"Sprite" , type:"flash.display.Sprite" } 
         * ] ;
         * </pre> 
         */
        public function get typeAliases():*
        {
              return _typeAliases ;
        }
        
        /**
         * @private
         */
        public function set typeAliases( aliases:* ):void
        {
            if ( aliases is TypeAliases )
            {
                var next:String ;
                var key:String ;
                var it:Iterator = (aliases as TypeAliases).iterator() ;
                while( it.hasNext() )
                {
                    next = it.next() as String ;
                    key  = it.key()  as String ;
                    _typeAliases.put(key, next) ;
                }
            }
            else if ( aliases is Array )
            {
            	var item:Object ;
                var arr:Array = aliases as Array ;
                var len:uint  = arr.length ;
                if ( len > 0 )
                {
                   while ( --len > -1 )
                   {
                        item = arr[len] as Object ;
                        if ( item != null && ( ObjectAttribute.TYPE_ALIAS in item ) && ( ObjectAttribute.TYPE in item ) )
                        {
                            _typeAliases.put( item[ObjectAttribute.TYPE_ALIAS] as String , item[ObjectAttribute.TYPE] as String ) ;
                        }
                   }
                }
            }
        }
        
        /**
         * Indicates the type evaluator reference. 
         */
        public function get typeEvaluator():TypeEvaluator
        {
            return _typeEvaluator ;
        }
        
        /**
         * Determinates the content of the typeExpression reference in this config object.
         * <p>The setter of this virtual property can be populated with a TypeAliases instance or an Array of typeAliases items.</p>
         * <p>This setter attribute don't remove the old TypeAliases instance but fill it with new aliases. 
         * If you want cleanup the aliases of this configuration object you must use the <code class="prettyprint">typeAliases.clear()</code> method.</p>
         * <p>The typeAliases items are generic objects with 2 attributes <b>alias</b> (the alias String expression) and <b>type</b> (the type String expression).</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.ioc.factory.ObjectConfig ;
         * var config:ObjectConfig  = new ObjectConfig() ;
         * config.typeAliases       = 
         * [ 
         *     { alias:"HashMap" , type:"system.data.maps.HashMap" } 
         * ] ;
         * </pre> 
         */
        public function get typeExpression():*
        {
            return _typeExpression ;
        }
        
        /**
         * @private
         */
        public function set typeExpression( expressions:* ):void
        {
            if ( expressions is TypeExpression )
            {
                _typeExpression = expressions || new TypeExpression() ;
            }
            else if ( expressions is Array )
            {
                var item:Object ;
                var ar:Array = expressions as Array ;
                var len:int  = ar.length ;
                if ( len > 0 )
                {
                   while ( --len > -1 )
                   {
                        item = ar[len] as Object ;
                        if ( item != null && ( ObjectAttribute.NAME in item ) && ( ObjectAttribute.VALUE in item ) )
                        {
                            _typeExpression.put( item[ObjectAttribute.NAME] as String , item[ObjectAttribute.VALUE] as String ) ;
                        }
                   }
                }
            }
        }
        
        /**
         * Indicates the type policy of the object factory who use this configuration object. 
         * The default value of this attribute is <code class="prettyprint">TypePolicy.NONE</code>.
         * <p>You can use the TypePolicy.NONE, TypePolicy.ALL, TypePolicy.ALIAS, TypePolicy.EXPRESSION values./p>
         * @see vegas.ioc.TypePolicy
         */
        public function get typePolicy():String
        {
            return _typePolicy ;
        }
        
        /**
         * @private
         */
        public function set typePolicy( policy:String ):void
        {
            switch( policy )
            {
                case TypePolicy.ALIAS      :
                case TypePolicy.EXPRESSION :
                case TypePolicy.ALL        :
                {
                    _typePolicy = policy ;
                    break ;
                }
                default :
                {
                    _typePolicy = TypePolicy.NONE ;
                }
            }
        }
        
        /**
         * Indicates if the logger model is used in the IoC factory to log the warning and errors.
         */
        public var useLogger:Boolean = true ;
        
        /**
         * Initialize the config object.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function initialize( init:Object ):void
        {
            if ( init == null )
            {
                return ;
            }
            for (var prop:String in init)
            {
                if ( prop in this )
                {
                    this[prop] = init[prop] ;
                }
            }
        }
        
        /**
         * Resets the target of the internal config dynamic object in this instance with a basic generic Object reference.
         */
        public function resetConfigTarget():void
        {
            _config = {} ;
        }
        
        /**
         * This method is used to change the target of the internal config dynamic object.
         */
        public function setConfigTarget( o:Object ):void
        {
            _config = Reflection.getClassInfo(o).isDynamic() ? o : {} ;
        }
        
        /**
         * This method is used to change the target of the internal local dynamic object.
         */
        public function setLocaleTarget( o:Object ):void
        {
            _locale = Reflection.getClassInfo(o).isDynamic() ? o : {} ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            var s:String = "[" + Reflection.getClassName(this) ;
            if ( defaultDestroyMethod != null )
            {
                s += " defaultDestroyMethod:" + defaultDestroyMethod ;
            }
            if ( defaultInitMethod != null )
            {
                s += " defaultInitMethod:" + defaultInitMethod ;
            }
            if ( identify )
            {
                s += " identify:" + identify ;
            }
            if ( lock )
            {
                s += " lock:" + lock ;
            }
            s += "]" ;
            return s ;
        }
        
        /**
         * @private
         */
        private var _config:Object ;
        
        /**
         * @private
         */
        private var _configEvaluator:ConfigEvaluator ;
        
        /**
         * @private
         */
        private var _locale:Object ;
        
        /**
         * @private
         */
        private var _localeEvaluator:LocaleEvaluator ; 
        
        /**
         * @private
         */
        private var _referenceEvaluator:ReferenceEvaluator = new ReferenceEvaluator() ;
        
        /**
         * @private
         */
        private var _typeAliases:TypeAliases ;
        
        /**
         * @private
         */
        private var _typeEvaluator:TypeEvaluator ;
        
        /**
         * @private
         */
        private var _typeExpression:TypeExpression ;
        
        /**
         * @private
         */
        private var _typePolicy:String = TypePolicy.NONE ;
    }
}