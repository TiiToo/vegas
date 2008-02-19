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
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import andromeda.ioc.core.ObjectAttribute;
	import andromeda.ioc.core.ObjectDefinition;
	import andromeda.ioc.core.ObjectFactoryMethod;
	import andromeda.ioc.core.ObjectStaticFactoryMethod;
	import andromeda.ioc.factory.ObjectFactory;
	
	import vegas.core.IFactory;
	import vegas.data.map.HashMap;
	import vegas.data.queue.LinearQueue;
	import vegas.data.sets.HashSet;
	import vegas.errors.NullPointerError;	

	/**
	 * This factory builder use a deserialize eden object to creates all Objects with the IObjectDefinitionContainer.
	 * <p><b>Example :</b></p>
 	 * <p><b>1 -</b> The eden application file : <b>"application.eden"</b></p>
 	 * <code>
	 *   {
	 *        objects : 
	 *        [
	 *            {   
	 *                id            : "address"  ,
	 *                type          : "test.Address" ,
	 *                properties    : 
	 *                [ 
	 *                    { name : "city"   , value : "Marseille" } ,
	 *                    { name : "street" , value : "xx xxx xxxxxxxxxxx" } ,
	 *                    { name : "zip"    , value : 13004 } 
	 *                ]
	 *            }
	 *            ,
	 *            {   
	 *                id         : "job_dev"  ,
	 *                type       : "test.Job" ,
	 *                properties : [ { name:"name" , value:"AS Developper" } ]
	 *            }
	 *            ,
	 *            {   
	 *                id            : "user" , 
	 *                type          : "test.User" , 
	 *                arguments     : 
	 *                [ 
	 *                    { value :"eKameleon" } , 
	 *                    { value :"ALCARAZ"   } , 
	 *                    { ref   :"address"   } 
	 *                ] ,
	 *                lazyInit      : true , // only if this object is a singleton, the singleton isn't initialized during the factory initialize process.
	 *                singleton     : true ,
	 *                destroy       : "destroy" ,  // only if this object is a singleton and the user destroy the reference in the factory.
	 *                init          : "initialize" ,
	 *                properties : 
	 *                [
	 *                    { name:"age"       , value : 30          } ,
	 *                    { name:"firstName" , value : "Marc"      } , 
	 *                    { name:"job"       , ref   : "job_dev"   } , 
	 *                    { name:"url"       , value : "http://www.ekameleon.net/blog" }
	 *                ]
	 *                ,
	 *                methods :
	 *                [
	 *                    { name:"setMail" , arguments  :  [ { value :"vegas@ekameleon.net" } ] }
	 *                ]
	 *             }
	 *             ,
	 *             {
	 *                 id            : "square" ,
	 *                 type          : "Square" ,
	 *                 assemblyName  : "dll/dll.swf" , // external swf with a linked Sprite in the library
	 *                 properties    :
	 *                 [
	 *                     { name:"x" , value : 100  } ,
	 *                     { name:"y" , value : 25   }
	 *                 ]
	 *             }
	 *         ]
	 *    }
	 * </code>
	 * <p>2 - The ActionScript test code :</p>
	 * <code>
	 * import andromeda.ioc.core.ObjectDefinition ;
	 * import andromeda.ioc.factory.ECMAObjectFactory ;
	 * import andromeda.events.ActionEvent ;
	 * 
	 * import flash.display.StageAlign ;
	 * import flash.display.StageScaleMode ;
	 * import flash.events.Event;
	 * import flash.events.IOErrorEvent;
	 * import flash.events.ProgressEvent;
	 * 
	 * import buRRRn.eden ;
	 * 
	 * import test.User ;
	 * 
	 * stage.align     = StageAlign.TOP_LEFT ;
	 * stage.scaleMode = StageScaleMode.NO_SCALE ;
	 * 
	 * var complete:Function = function ( event:Event ):void
	 * {
	 *     var loader:URLLoader = event.target as URLLoader ;
	 *     var source:String    = loader.data ;
	 *     var app:Object       = eden.deserialize(source) ;
	 *     
	 *     factory.create( app.objects ) ;
	 * }
	 * 
	 * var debug:Function = function( e:Event ):void
	 * {
	 *     trace( e ) ;
	 * }
	 * 
	 * var main:Function = function( e:ActionEvent ):void
	 * {
	 * 
	 *     trace( e ) ;
	 *     
	 *     var user:User = factory.getObject( "user" ) ;
	 *     
	 *     trace( "User pseudo         : " + user.pseudo ) ; // ekameleon
	 *     trace( "User firstName      : " + user.firstName ) ; // Marc
	 *     trace( "User name           : " + user.name ) ; // ALCARAZ
	 *     trace( "User age            : " + user.age ) ; // 30
	 *     trace( "User mail           : " + user.mail ) ; // vegas@ekameleon.net
	 *     trace( "User url            : " + user.url  ) ; // http://www.ekameleon.net/blog
	 *     trace( "User job            : " + user.job ) ; // [Job AS Developper]
	 *     trace( "User address        : " + user.address ) ; // [Address]
	 *     trace( "User address city   : " + user.address.city ) ; // Marseille
	 *     trace( "User address street : " + user.address.street ) ; // xx xxx xxxxxxxxxxx
	 *     trace( "User address zip    : " + user.address.zip ) ; // 13004
	 *     trace( "User isSingleton    : " + factory.isSingleton( "user" ) ) ;
	 *     trace( "User isLazyInit     : " + factory.isLazyInit( "user" ) ) ;
	 *     
	 *     var sprite:Sprite = factory.getObject("square") as Sprite ; // use external dll in the "dll/dll.swf" file
	 *     addChild(sprite) ;
	 *     
	 *     trace( "---" ) ;
	 *     
	 *     var def:ObjectDefinition ;
	 *     
	 *     def = factory.getObjectDefinition("user") ;
	 *     trace( "# 'user' IObjectDefinition scope : " + def.getScope() ) ;
	 *     
	 *     def = factory.getObjectDefinition("address") ;
	 *     trace( "# 'address' IObjectDefinition scope : " + def.getScope() ) ;
	 * }
	 *  
	 * var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
	 *  
	 * factory.addEventListener( IOErrorEvent.IO_ERROR   , debug ) ;
	 * factory.addEventListener( ProgressEvent.PROGRESS  , debug ) ;
	 * factory.addEventListener( Event.COMPLETE          , debug ) ;
	 * factory.addEventListener( ActionEvent.START       , debug ) ;
	 * factory.addEventListener( ActionEvent.FINISH      , main  ) ;
	 *  
	 * var request:URLRequest = new URLRequest( "context/application.eden" ) ;
	 *  
	 * var loader:URLLoader   = new URLLoader() ;
	 * loader.addEventListener( Event.COMPLETE , complete ) ;
	 *  
	 * loader.load( request ) ;
	 * </code>
	 * <p><b>3 -</b> The <b>test.User</b> class.</p>
	 * <code>
	 * package test
	 * {
	 *     import system.Reflection;
	 *     import vegas.core.CoreObject;
	 *     
	 *     public class User extends CoreObject
	 *     {
	 *         public function User( pseudo:String = null, name:String =null , address:Address = null )
	 *         {
	 *             this.pseudo  = pseudo ;
	 *             this.name    = name ;
	 *             this.address = address ;
	 *         }
	 *         
	 *         public var address:Address ;
	 *         public var age:Number ;
	 *         public var firstName:String ;
	 *         public var job:Job ;
	 *         public var mail:String ;
	 *         public var name:String ;
	 *         public var pseudo:String ;
	 *         public var url:String ;
	 *         
	 *         public function destroy():void
	 *         {
	 *             trace( this + " destroy.") ;
	 *         }
	 *         
	 *         public function initialize():void
	 * 		   {
	 * 		        trace( this + " initialize.") ;
	 * 		   }
	 * 		   
	 * 		   public function setMail( sMail:String ):void
	 * 		   {
	 * 		       mail = sMail ;
	 * 		   }
	 * 		   
	 * 		   public override function toString():String
	 * 		   {
	 * 		        return "[" + Reflection.getClassName(this) + ( pseudo != null ? " " + pseudo : "" ) + "]" ;
	 * 		   }
	 * 	   }
	 * }
 	 * </code>
	 * <p><b>4 -</b> The <b>test.Address</b> class.</p>
	 * <code>
	 * package test
	 * {
	 *     import vegas.core.CoreObject ;
	 *     
	 *     public class Address extends CoreObject
	 *     {
	 *     
	 *         public function Address() {}
	 *         
	 *         public var city:String ;
	 *         public var street:String
	 *         public var zip:Number ;
	 *         
	 *     }
 	 * }
	 * </code>
	 * <p><b>5 -</b> The <b>test.Job</b> class.</p>
	 * <code>
	 * package test
	 * {
	 *     import system.Reflection;
	 *     import vegas.core.CoreObject ;
	 *     
	 *     public class test.Job extends CoreObject
	 *     {
	 *     
	 *         public function Job() {}
	 *         
	 *         public var name:String ;
	 *         
	 *         public function toString():String
	 *         {
	 *             return "[" + Reflection.getClassName(this) + " " + name + "]" ;
	 *         }
	 *         
	 *     }
	 * }
	 * </code>
	 * @author eKameleon
	 */
	public class ECMAObjectFactory extends ObjectFactory implements IFactory 
	{
		
		/**
		 * Creates a new EdenObjectFactory instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code>bGlobal</code> argument is <code>true</code>.
		 */
		public function ECMAObjectFactory( bGlobal:Boolean = false , sChannel:String = null )
		{
			super( bGlobal, sChannel ) ;
			_setDefinitions = new HashSet() ;
			_assemblies     = new HashMap() ;
		}
		
		/**
		 * This array contains objects to fill this factory with the run or create method.
		 */
		public var objects:Array ;
		
		/**
		 * Create the objects and fill the IObjectDefinitionContainer.
		 * <p><b>Parameters</b></p>
		 * <code>edenObject</code> An object who contains all the "objects" settings.
		 */
		public function create( ...arguments:Array ):void
		{
			run.apply( this, arguments ) ;
		}
		
		/**
		 * Returns the singleton reference of this class.
		 * @return the singleton reference of this class.
		 */
		public static function getInstance():ECMAObjectFactory
		{
			if ( _instance == null )
			{
				_instance = new ECMAObjectFactory() ;
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
			
			_setDefinitions.clear() ;
			
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
		private static var _instance:ECMAObjectFactory ;

		/**
		 * @private
		 */
		private var _loader:Loader ;
		
		/**
		 * @private
		 */
		private var _setDefinitions:HashSet ;
		
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
			
				var assemblyName:String        =  o[ ObjectAttribute.ASSEMBLY_NAME ] ;
				var args:Array                 =  o[ ObjectAttribute.ARGUMENTS ] ;
				var destroy:String             =  o[ ObjectAttribute.OBJECT_DESTROY_METHOD_NAME ] ;
				var factoryMethod:Object       =  o[ ObjectAttribute.OBJECT_FACTORY_METHOD ] ;
				var id:String                  =  o[ ObjectAttribute.OBJECT_ID ] ;
				var init:String                =  o[ ObjectAttribute.OBJECT_INIT_METHOD_NAME ] ;
				var lazyInit:Boolean           =  o[ ObjectAttribute.LAZY_INIT ] ;
				var methods:Array              =  o[ ObjectAttribute.OBJECT_METHODS ] ;
				var properties:Array           =  o[ ObjectAttribute.OBJECT_PROPERTIES ] ;
				var scope:String               =  o[ ObjectAttribute.OBJECT_SCOPE ] ;
				var singleton:Boolean          =  o[ ObjectAttribute.OBJECT_SINGLETON ] ;
				var staticfactoryMethod:Object =  o[ ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD ] ;				
				var type:String                =  o[ ObjectAttribute.TYPE ] ;
				
				var definition:ObjectDefinition = new ObjectDefinition( id, type , singleton , lazyInit ) ;
				definition.setConstructorArguments( args ) ;
				definition.setDestroyMethodName( destroy ) ;
				definition.setFactoryMethod( ObjectFactoryMethod.create( factoryMethod ) ) ;
				definition.setInitMethodName( init ) ;
				definition.setMethods( methods ) ;
				definition.setProperties( _createNewProperties( properties ) ) ;
				definition.setScope( scope ) ;
				definition.setFactoryMethod( ObjectStaticFactoryMethod.create( staticfactoryMethod ) ) ;
				
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

		/**
		 * @private
		 */
		private function _flushInitSingletonDefinitions():void
		{
			if ( _setDefinitions.isEmpty() == false )
			{
				var ar:Array  = _setDefinitions.toArray() ;
				var size:uint = ar.length ;
				for ( var i:uint = 0 ; i<size ; i++ )
				{
					getObject( ar[i] as String ) ;
				} 
				_setDefinitions.clear() ;
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
					_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR  , ioErrorHandler ) ;
					_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS , progress ) ;
					_loader.contentLoaderInfo.addEventListener( Event.COMPLETE         , completeHandler ) ;
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
				_flushInitSingletonDefinitions() ;
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
					_setDefinitions.insert( definition.id ) ;
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

