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
    
    import system.Reflection;
    
    import vegas.core.Identifiable;
    import vegas.data.Map;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;
    import vegas.errors.NullPointerError;
    import vegas.util.ClassUtil;    

    /**
	 * The factory of all objects who implements the IObjectDefinition interface.
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
			typeEvaluator = new TypeEvaluator() ;
            singletons = new HashMap() ;
			if ( config == null )
			{
				config = new ObjectConfig() ; // the default empty ObjectConfig instance.
			}
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
			_config = o ;
			typeEvaluator.config = _config ;
        }		
		
		/**
		 * The maps of all objects in the container.
		 */
		public var singletons:HashMap ;
		
		/**
		 * Returns <code class="prettyprint">true</code> if the container contains the specified name.
		 * @param name the name of the object in the container.
		 * @return <code class="prettyprint">true</code> if the container contains the specified name.
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
		};
		
		/**
		 * This method returns an object with the specified name in argument.
		 * @param name The name of the object.
		 * @return the instance of the object with the name passed in argument.
		 */		
		public function getObject( name:String ):*
		{
			try
			{
				var instance:* = _findInCache( name ) ;	
				if ( instance == null )
				{
					var definition:IObjectDefinition = getObjectDefinition( name ) ;
					if ( definition == null )
					{
						throw new NullPointerError( this +  " get( " + name + " ) method failed, the object isn't register in the container.") ; 
					}
					if ( definition.isSingleton() )
					{
						instance = createAndCacheSingletonInstance( name , definition ) ;
					}
					else
					{
						instance = createObject( definition ) ;
					}
				}
			}
			catch(e:Error)
			{
				debug( this + " createObject failed with the name '" + name + "' : " + e.toString() ) ;
			}
			return instance || null ;
		}

		/**
		 * This method defined if the object is a lazy init singleton object (must be singleton).
		 * @param name The name of the object to find.
		 * @return <code class="prettyprint">true</code> if the object is a lazy init singleton object (must be singleton).
	 	 */	
		public function isLazyInit( name:String ):Boolean 
		{
			if ( containsObjectDefinition( name ) )
			{
				return getObjectDefinition(name).isLazyInit() ;
			}
			else
			{
				return false ;	
			}
		}

		/**
		 * This method indicates if the object is a singleton.
		 * @param name The name of the object to find.
		 * @return <code class="prettyprint">true</code> if the object is a singleton. 
	 	 */	
		public function isSingleton( name:String ):Boolean 
		{
			if ( containsObjectDefinition( name ) )
			{
				return getObjectDefinition(name).isSingleton() ;
			}
			else
			{
				return false ;	
			}
		}
		
		/**
		 * Removes and destroy a singleton in the container. 
		 * Invoke the 'destroy' method of this object is it's define in the IObjectDefinition of this singleton.
		 * @param name The name of the singleton to remove.
	 	 */
		public function removeSingleton( name:String ):void
		{
			if ( isSingleton(name) )
			{
				invokeDestroyMethod( singletons.get(name), getObjectDefinition(name) ) ;
				singletons.remove( name ) ;	
			}
		}
		
		/**
		 * @private
		 */
		private var _config:ObjectConfig ;
			
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
	 	 * Creates and cache the singleton instance define with the specified name and IDefinition.
	 	 * @param name the name of the class object.
	 	 * @param definition the IDefinition to apply over the new instance.
	 	 */
		protected function createAndCacheSingletonInstance( name:String, definition:IObjectDefinition ):*
		{
			var instance:* = singletons.get( name ) ;
			if( !instance ) 
			{
				instance = createObject( definition ) ;
				singletons.put( name, instance ) ;
			}
			return instance;
		}

		/**
		 * Creates a new Object with the specified name and the specified IObjectDefinition in argument.
		 * @return a new Object with the specified name and the specified IObjectDefinition in argument.
		 */
		protected function createObject( definition:IObjectDefinition ):*
		{
			var instance:* = null ;
			var clazz:Class ;
			var factoryMethod:ObjectMethod = definition.getFactoryMethod() ;
			if ( factoryMethod == null )
			{
				clazz           = typeEvaluator.eval( definition.getType() ) as Class ;
				instance        = ClassUtil.buildNewInstance( clazz, createArguments( definition.getConstructorArguments()) ) ;
			}
			else
			{	
				var factory:String ;
				var args:Array = createArguments( (factoryMethod as ObjectMethod).arguments ) ;
				var methodName:String   ;
				var ref:* ;
				if ( factoryMethod is ObjectStaticFactoryMethod )
				{
					clazz      = typeEvaluator.eval( (factoryMethod as ObjectStaticFactoryMethod).type as String ) as Class ;
					methodName = (factoryMethod as ObjectStaticFactoryMethod).name ;
					if ( clazz != null && methodName in clazz ) 
					{
						instance = clazz[methodName].apply( null, args ) ;
					}
				}
				else if ( factoryMethod is ObjectFactoryMethod )
				{
					factory    = (factoryMethod as ObjectFactoryMethod).factory ;
					methodName = (factoryMethod as ObjectFactoryMethod).name ;
					ref        = getObject( factory ) ;
					if ( ( ref != null ) && ( methodName != null ) && ( methodName in ref ) ) 
					{
						instance = ref[methodName].apply( null, args ) ;
					} 						
				}
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
		 * Invokes the destroy method of the specified object, if the init method is define in the IDefinition object.
		 */
		protected function invokeDestroyMethod( o:* , definition:IObjectDefinition ):void
		{
			var name:String     = definition.getDestroyMethodName();
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
		 * Populates all properties in the Map passed in argument.
		 */
		protected function populateProperties( o:* , properties:Map=null ):void 
		{
			if (properties != null && properties.size() > 0)
			{
				var it:Iterator = properties.iterator() ;
				while( it.hasNext() )
				{
					var value:* = it.next() ;
					var key:*   = it.key()  ;
					if( containsObject( value ) ) 
					{
						value = getObject( value ) ;
       					properties.put( key , value ) ;
   					}
					o[key] = value ;
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

        /**
         * @private
         */
        protected var typeEvaluator:TypeEvaluator ;        
        
		/**
		 * Returns the object register in cache in this container.
	 	 * @param the name of the object.
	 	 * @return the object register in cache in this container.
	 	 */
		private function _findInCache( name:String=null ):* 
		{
			return singletons.get(name) || null ;
		}
		
	}

}
