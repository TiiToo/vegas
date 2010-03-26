/*

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

package vegas.ioc.io 
{
    import vegas.ioc.ObjectDefinition;
    import vegas.ioc.factory.ObjectFactory;
    import vegas.ioc.factory.strategy.ObjectFactoryValue;
    import vegas.ioc.io.ObjectResource;
    
    import system.Reflection;
    import system.process.ActionLoader;
    import system.process.CoreActionLoader;
    
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.getDefinitionByName;
    
    /**
     * This value object contains all information about a dll to load in the application. 
     */
    public class AssemblyResource extends ObjectResource 
    {
        /**
         * Creates a new AssemblyResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function AssemblyResource(init:Object = null)
        {
            super(init);
        }
        
        /**
         * The default class name of the object definition if the id of the assembly is not 'null' or 'undefined'.
         */
        public static var DEFAULT_CLASS_NAME:String = "flash.display.DisplayObject" ;
        
        /**
         * The default Loader class use in all AssemblyResource to create a new resource process.
         */
        public static var DEFAULT_LOADER:Class = Loader ;
        
        /**
         * The root path of all assembly resources.
         */
        public static var DEFAULT_PATH:String = "" ;
        
        /**
         * Indicates if the assembly must check a policy file in the server of the external library to load.
         */
        public var checkPolicyFile:Boolean ;
        
        /**
         * Indicates the definition object to initialize the ObjectDefinition of the current assembly.
         * Use this attribute only if the 'id' of the assembly resource is not 'null' or 'undefined'.
         */
        public var definition:Object ;
        
        /**
         * Indicates if the assembly is loading in the current domain or a specific ApplicationDomain (default "current").
         */
        public function get domain():String
        {
            return _domain ;
        }
        
        /**
         * Indicates if the assembly is loading in the current domain or a specific ApplicationDomain.
         */
        public function set domain( value:String ):void
        {
            _domain = AssemblyDomain.isValid( value ) ? value : AssemblyDomain.CURRENT ;
        }
        
        /**
         * The loader to use to load the assembly.
         */
        public var loader:* ;
        
        /**
         * The optional root path of the assembly.
         */
        public var path:String ;
        
        /**
         * Creates a new ActionURLLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
            _action     = null ;
            _definition = null ;
            
            var path:String  = path || DEFAULT_PATH ;
            
            var currentLoader:Loader ;
            
            if ( loader != null )
            {
                var clazz:Class ;
                if (loader is String)
                {
                    clazz = getDefinitionByName( loader as String )  as Class ;
                }
                else if ( loader is Class )
                {
                    clazz = loader as Class ;
                }
                if ( clazz != null  )
                {
                    if ( Reflection.getClassInfo(clazz).inheritFrom(Loader) ) 
                    {
                        currentLoader = new clazz() as Loader ;
                    }
                } 
                else if ( loader is Loader )
                {
                    currentLoader = loader as Loader ;
                }
            }
            
            var factory:ObjectFactory = owner as ObjectFactory ;
            
            if ( id != null && id is String && factory != null && factory.containsObjectDefinition( id ) == false )
            {
                var init:Object = 
                {
                    id        : id  ,
                    type      : DEFAULT_CLASS_NAME 
                };
                if ( definition != null )
                {
                    for (var prop:String in definition )
                    {
                       init[prop] = definition[prop] ;
                    }
                }
                _definition = ObjectDefinition.create( init ) ;
                
                factory.addObjectDefinition( _definition  ) ;
            }
            
            var appDomain:ApplicationDomain = ( domain == AssemblyDomain.CURRENT ) ? ApplicationDomain.currentDomain : null ;
            
            _action = new ActionLoader( currentLoader || new DEFAULT_LOADER() ) ;
            
            _action.request = new URLRequest( path + resource ) ;
            _action.context = new LoaderContext( checkPolicyFile , appDomain ) ;
            
            return _action ;
        } 
        
        /**
         * The optional method invoked when the resource is loading.
         */
        public override function initialize( ...args:Array ):void
        {
            if ( _definition != null && _action != null )
            {
                _definition.setFactoryStrategy( new ObjectFactoryValue( _action.content ) ) ;
            }
            else
            {
                throw new Error( this + " initialize resource failed." ) ;
            }
        }
        
        /**
         * Registers the resource in the ObjectResourceBuilder.
         */
        public static function register( type:String = "assembly" ):void
        {
            ObjectResourceBuilder.addObjectResource( type , AssemblyResource ) ;
        }
        
        /**
         * @private
         */
        private var _action:ActionLoader ;
        
        /**
         * @private
         */
        private var _domain:String = AssemblyDomain.CURRENT ;
        
        /**
         * @private
         */
        private var _definition:ObjectDefinition ;
    }
}
