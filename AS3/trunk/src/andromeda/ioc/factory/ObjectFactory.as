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
	import flash.utils.getDefinitionByName;
	
	import andromeda.ioc.core.IObjectDefinition;
	import andromeda.ioc.core.ObjectAttribute;
	import andromeda.ioc.core.ObjectDefinitionContainer;
	import andromeda.ioc.core.ObjectFactoryMethod;
	import andromeda.ioc.core.ObjectMethod;
	import andromeda.ioc.core.ObjectStaticFactoryMethod;
	import andromeda.ioc.factory.IObjectFactory;
	
	import system.Reflection;
	
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
		}		
		
		/**
		 * The maps of all objects in the container.
		 */
		public var singletons:HashMap ;
		
		/**
		 * Returns <code class="prettyprint">true</code> if the LightContainer contains the specified name.
		 * @param name the name of the object in the container.
		 * @return <code class="prettyprint">true</code> if the LightContainer contains the specified name.
		 */		
		public function containsObject(name:String):Boolean 
		{
			return containsObjectDefinition(name);
		}
		
		/**
		 * The custom debug method of this factory.
		 */
		public function debug( o:* ):void
		{
			getLogger().warn ( o ) ;
			// use trace in this method if you want debug in Flash or the Flash debugger.
		}
		
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
						instance = _createAndCacheSingletonInstance( name , definition ) ;
					}
					else
					{
						instance = _createObject( definition.getType() , definition ) ;
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
		 * This method defined if the object is a singleton or a prototype.
		 * @param name The name of the object to find.
		 * @return <code class="prettyprint">true</code> if the object is a singleton or else if the object is a prototype. 
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
				_invokeDestroyMethod( singletons.get(name), getObjectDefinition(name) ) ;
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
		protected function _createArguments( argList:Array=null ):Array
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
		protected function _createAndCacheSingletonInstance( name:String, definition:IObjectDefinition ):*
		{
			var instance:* = singletons.get( name ) ;
			if( !instance ) 
			{
				instance = _createObject( definition.getType() , definition ) ;
				singletons.put( name, instance ) ;
			}
			return instance;
		}

		/**
		 * Creates a new Object with the specified name and the specified IObjectDefinition in argument.
		 * @return a new Object with the specified name and the specified IObjectDefinition in argument.
		 */
		protected function _createObject( name:String , definition:IObjectDefinition ):*
		{
			var instance:* = null ;
			var clazz:Class ;
			var factoryMethod:ObjectMethod = definition.getFactoryMethod() ;
			if ( factoryMethod == null )
			{
				clazz    = getDefinitionByName(name) as Class ;
				instance = ClassUtil.buildNewInstance(clazz, _createArguments( definition.getConstructorArguments()) ) ;
			}
			else
			{	
				var factory:String ;
				var sName:String   ;
				var ref:* ;
				if ( factoryMethod is ObjectStaticFactoryMethod )
				{
					clazz = getDefinitionByName( (factoryMethod as ObjectStaticFactoryMethod).type as String ) as Class ;
					sName = (factoryMethod as ObjectStaticFactoryMethod).name ;
					if ( sName in clazz ) 
					{
						instance = clazz[sName].apply( null, _createArguments( (factoryMethod as ObjectMethod).arguments ) ) ;
					}
				}
				else if ( factoryMethod is ObjectFactoryMethod )
				{
					factory = (factoryMethod as ObjectFactoryMethod).factory ;
					sName   = (factoryMethod as ObjectFactoryMethod).name ;
					ref = getObject(factory) ;
					if ( ref != null && sName in ref ) 
					{
						instance = ref[sName].apply( null, _createArguments( (factoryMethod as ObjectMethod).arguments ) ) ;
					} 						
				}
			}
			if ( instance != null )
			{
				_populateProperties( instance, definition.getProperties() );
				_invokeMethods( instance , definition.getMethods() ) ;
				_invokeInitMethod( instance, definition ) ;
			}
			return instance ;
		}

		/**
		 * Invoque the destroy method of the specified object, if the init method is define in the IDefinition object.
		 */
		protected function _invokeDestroyMethod( o:* , definition:IObjectDefinition ):void
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
		 * Invoque the init method of the specified object, if the init method is define in the IDefinition object.
		 */
		protected function _invokeInitMethod( o:* , definition:IObjectDefinition=null ):void
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
		 * Invoque the init method of the specified object, if the init method is define in the IDefinition object.
		 */
		protected function _invokeMethods( o:* , methods:Array ):void
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
						var args:Array  = _createArguments( item[ ObjectAttribute.ARGUMENTS ] ) ;
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
		protected function _populateProperties( o:* , properties:Map=null ):void 
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
		protected function _populateMethods( o:* , methods:Array=null ):void 
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
						var args:Array = _createArguments(item[ ObjectAttribute.ARGUMENTS ]) ;
						if ( name != null && name in o )
						{
							o[name].apply(o, args) ;
						}
					}
				}
			} 
		}


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
