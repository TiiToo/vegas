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
	import andromeda.ioc.core.ObjectDefinition;
	import andromeda.ioc.factory.ObjectFactory;
	
	import vegas.core.IFactory;
	import vegas.data.map.HashMap;	

	/**
	 * @author eKameleon
	 */
	public class EdenObjectFactory extends ObjectFactory implements IFactory 
	{
		
		/**
		 * Creates a new EdenObjectFactory instance.
		 */
		public function EdenObjectFactory()
		{
			super( );
		}
		
		/**
		 * Defines the label of the arguments in a method or a constructor object.
		 */
		public static const ARGUMENTS:String = "arguments" ;  
		
		/**
		 * Defines the label of the assembly name property of the object.
		 */
		public static const ASSEMBLY_NAME:String = "assemblyName" ;
		
		/**
		 * Defines the label of the name in a property object.
	 	 */
		public static const NAME:String = "name" ;  
		
		/**
		 * The name of the external object property to register the destroy method name.
		 */
		public static const OBJECT_DESTROY_METHOD_NAME:String = "destroy" ;  
		
		/**
		 * The name of the external object property to define the id of the object.
		 */
		public static const OBJECT_ID:String = "id" ;  
		
		/**
		 * The name of the external object property to register the init method name.
		 */
		public static const OBJECT_INIT_METHOD_NAME:String = "init" ;  
		
		/**
		 * The name of the external object property to register the properties.
		 */
		public static const OBJECT_PROPERTIES:String = "properties" ;  
	
		/**
		 * The name of the external object property to define the singleton flag of the object.
		 */
		public static const OBJECT_SINGLETON:String = "singleton" ;  
		
		/**
		 * Defines the label of the type of the object.
		 */
		public static const TYPE:String = "type" ;  
		
		/**
		 * Defines the label of the reference in a property object.
		 */
		public static const REFERENCE:String = "ref" ;  
		
		/**
		 * Defines the label of the value in a property object.
		 */
		public static const VALUE:String = "value" ;  
			
		/**
		 * Create the objects and fill the IObjectDefinitionContainer.
		 * <p><b>Parameters</b></p>
		 * {@code edenObject} An object who contains all the "objects" settings.
		 */
		public function create( ...arguments:Array ):void
		{
			var arg:Array = arguments[0] ;
			if ( arg is Array && arg.length > 0)
			{
				while ( arg.length > 0)
				{
					_createNewObjectDefinition( arg.shift() ) ;
				}
			}
		}
		
		/**
		 * Returns the singleton reference of this class.
		 * @return the singleton reference of this class.
		 */
		public static function getInstance():EdenObjectFactory
		{
			if ( _instance == null )
			{
				_instance = new EdenObjectFactory() ;
			}
			return _instance ;
		}

		/**
		 * @private
		 */
		// TODO private var _assemblies:HashMap ;
		
		/**
		 * @private
		 */
		private static var _instance:EdenObjectFactory ;
				
		/**
		 * Returns and creates a new IObjectDefinition instance.
		 * @return and creates a new IObjectDefinition instance.
		 */
		private function _createNewObjectDefinition( o:Object ):void
		{
			if ( o != null )
			{
			
				// TODO var assemblyName:String =  o[ ASSEMBLY_NAME ] ;
				
				var args:Array          =  o[ ARGUMENTS ] ;
				var destroy:String      =  o[ OBJECT_DESTROY_METHOD_NAME ] ;
				var id:String           =  o[ OBJECT_ID ] ;
				var init:String         =  o[ OBJECT_INIT_METHOD_NAME ] ;
				var properties:Array    =  o[ OBJECT_PROPERTIES ] ;
				var singleton:Boolean   =  o[ OBJECT_SINGLETON ] ;
				var type:String         =  o[ TYPE ] ;

				var definition:ObjectDefinition = new ObjectDefinition( type , singleton ) ;
				definition.setConstructorArguments( args ) ;
				definition.setDestroyMethodName( destroy ) ;
				definition.setInitMethodName( init ) ;
				definition.setProperties( _createNewProperties( properties ) ) ;

				addObjectDefinition( id , definition ) ;
			
			}
		}

		/**
		 * Returns and creates the Map of all properties.
		 * @return and creates the Map of all properties.
		 */
		private function _createNewProperties( a:Array = null ):HashMap
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
					args  = prop[ ARGUMENTS ] ;
					ref   = prop[ REFERENCE ]  ;
					name  = prop[ NAME ] ;
					value = prop[ VALUE ] ;
					
					if (args is Array && args.length > 0) 
					{
						properties.put( name , _createArguments( args ) ) ; // methods
					}
					else if (ref != null) 
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
