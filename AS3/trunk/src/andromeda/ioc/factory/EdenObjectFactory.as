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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.factory 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import andromeda.ioc.core.ObjectDefinition;
	import andromeda.ioc.factory.ObjectFactory;
	
	import vegas.core.IFactory;
	import vegas.data.map.HashMap;
	import vegas.data.queue.LinearQueue;
	import vegas.errors.NullPointerError;	

	// TODO implement scope property in the IObjectDefinition interface (singleton, prototype, ...)

	/**
	 * This factory builder use a deserialize eden object to creates all Objects with the IObjectDefinitionContainer.
	 * @author eKameleon
	 */
	public class EdenObjectFactory extends ObjectFactory implements IFactory 
	{
		
		/**
		 * Creates a new EdenObjectFactory instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function EdenObjectFactory( bGlobal:Boolean = false , sChannel:String = null )
		{
			super( bGlobal, sChannel ) ;
			_assemblies = new HashMap() ;
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
		 * Defines the label of the lazyInit name property of the object.
		 */		
		public static const LAZY_INIT:String = "lazyInit" ;
		
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
		 * This array contains objects to fill this factory with the run or create method.
		 */
		public var objects:Array ;
		
		/**
		 * Create the objects and fill the IObjectDefinitionContainer.
		 * <p><b>Parameters</b></p>
		 * {@code edenObject} An object who contains all the "objects" settings.
		 */
		public function create( ...arguments:Array ):void
		{
			run.apply( this, arguments ) ;
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
	     * Run the process.
	     */
		public override function run( ...arguments:Array ):void 
		{
			
			if ( running )
			{
				return ;
			}
			
			notifyStarted() ;
			
			setRunning( true ) ;
			
			if ( arguments[0] is Array )
			{
				objects = arguments[0] ;
			}
			
			if ( objects == null )
			{
				throw new NullPointerError(this + " run failed if the 'objects' Array property is null or undefined.") ;
			}	
			
			if ( objects.length > 0)
			{
				while ( objects.length > 0 )
				{
					_createNewObjectDefinition( objects.shift() ) ;
				}
			}
			
			_flushAssemblies( true ) ;
			
		}

		/**
		 * @private
		 */
		private var _assemblies:HashMap ;
		
		/**
		 * @private
		 */
		private var _buffer:LinearQueue ;
		
		/**
		 * @private
		 */
		private var _current:AssemblyEntry ;

		/**
		 * @private
		 */
		private static var _instance:EdenObjectFactory ;

		/**
		 * @private
		 */
		private var _loader:Loader ;

		/**
		 * @private
		 */	
		private function completeHandler(e:Event):void 
		{
			if ( _current != null )
			{
				_initDefinition( _current.definition  ) ;
				_current = null ;	
			}	
			_flushAssemblies();
		}

		/**
		 * Returns and creates a new IObjectDefinition instance.
		 * @return and creates a new IObjectDefinition instance.
		 */
		private function _createNewObjectDefinition( o:Object ):void
		{
			if ( o != null )
			{
			
				var assemblyName:String =  o[ ASSEMBLY_NAME ] ;
				var args:Array          =  o[ ARGUMENTS ] ;
				var destroy:String      =  o[ OBJECT_DESTROY_METHOD_NAME ] ;
				var id:String           =  o[ OBJECT_ID ] ;
				var init:String         =  o[ OBJECT_INIT_METHOD_NAME ] ;
				var lazyInit:Boolean    =  o[ LAZY_INIT ] ;
				var properties:Array    =  o[ OBJECT_PROPERTIES ] ;
				var singleton:Boolean   =  o[ OBJECT_SINGLETON ] ;
				var type:String         =  o[ TYPE ] ;

				var definition:ObjectDefinition = new ObjectDefinition( id, type , singleton , lazyInit ) ;
				definition.setConstructorArguments( args ) ;
				definition.setDestroyMethodName( destroy ) ;
				definition.setInitMethodName( init ) ;
				definition.setProperties( _createNewProperties( properties ) ) ;
				
				addObjectDefinition( id , definition ) ;

				if ( assemblyName && !_assemblies.containsKey( assemblyName ) )
				{
					_assemblies.put( assemblyName , new AssemblyEntry( assemblyName , definition ) ) ;	
				}
				else
				{
					_initDefinition( definition ) ;
				}
				
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
		
		/**
		 * @private
		 */
		private function _flushAssemblies( flag:Boolean=false ):void
		{
			if ( flag )
			{
				_buffer = new LinearQueue( _assemblies.getValues() ) ;
				_assemblies.clear() ;
			}

			if ( _buffer.size() > 0 )
			{
				
				if ( _loader == null )
				{
					_loader = new Loader() ;
					_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
					_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progress);
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
				}
				
				_current = _buffer.poll( ) as AssemblyEntry ;
				
				var assemblyName:String = _current.name ;
				
				if ( assemblyName.length > 0 )
				{
					_loader.load( new URLRequest( assemblyName ) , new LoaderContext( false , ApplicationDomain.currentDomain ) ) ;
				}
				else
				{
					ioErrorHandler() ;
				}
				
			}
			else
			{
				setRunning( false ) ;
				notifyFinished() ;	
			}
		}

		/**
		 * @private
		 */
		private function _initDefinition( definition:ObjectDefinition ):void
		{
			if ( definition.isSingleton() && ( definition.isLazyInit() == false ) )
			{
				if ( containsObject( definition.id ) )
				{
					getObject( definition.id ) ;
				}
			}
		}

		/**
		 * @private 
		 */		
		private function ioErrorHandler( e:IOErrorEvent=null ):void 
		{
			if ( e != null )
			{
				dispatchEvent( e ) ;
			}
			_flushAssemblies() ; 	
		}		

		/**
		 * @private 
		 */
		private function progress( e:ProgressEvent=null ):void 
		{
			if ( e != null )
			{
				dispatchEvent( e );
			}
		}

	}
}

import andromeda.ioc.core.ObjectDefinition;

import vegas.core.CoreObject;

/**
 * This entries contains an ObjectDefinition and this assemblyName value. 
 * @author eKameleon
 */
class AssemblyEntry extends CoreObject
{

	/**
	 * Creates a new AssemblyEntry instance.
	 * @param name The name of the assembly file to load.
	 * @param definition The object definition attached with the assembly file.
	 */
	public function AssemblyEntry( name:String , definition:ObjectDefinition )
	{
		this.name       = name ;
		this.definition = definition ;
	}
	
	/**
	 * The ObjectDefinition of this entry.
	 */
	public var definition:ObjectDefinition ;
	
	/**
	 * The name of this entry.
	 */
	public var name:String ;
	
}

