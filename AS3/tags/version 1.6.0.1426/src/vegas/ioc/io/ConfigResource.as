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

package vegas.ioc.io 
{
    import system.Reflection;
    import system.process.CoreActionLoader;
    
    import vegas.config.EdenConfigLoader;
    import vegas.ioc.io.ObjectResourceBuilder;
    import vegas.config.CoreConfigLoader;
    
    import flash.utils.getDefinitionByName;
    
    /**
     * This resource object contains all information about a config file to load in the application.
     */
    public class ConfigResource extends ObjectResource
    {
        /**
         * Creates a new ConfigResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function ConfigResource( init:Object=null )
        {
            super(init) ;
            type = ObjectResourceType.CONFIG ;
        }
        
        /**
         * The default IConfigLoader class use in all ConfigResource to create a new resource process.
         */
        public static var DEFAULT_LOADER:Class = EdenConfigLoader ;
        
        /**
         * The custom loader reference use to load the config resource (The class must inherit from the CoreConfigLoader class).
         */
        public var loader:* ;
        
        /**
         * The path of the full config file name.
         */
        public var path:String ;
        
        /**
         * The suffix of the full config file name.
         */
        public var suffix:String ;
        
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
            var action:CoreConfigLoader ;
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
                    if ( Reflection.getClassInfo(clazz).inheritFrom(CoreConfigLoader) )
                    {
                        action = new clazz() as CoreConfigLoader ;
                    }
                } 
                else if ( loader is CoreConfigLoader )
                {
                    action = loader as CoreConfigLoader ;
                }
            }
            if ( action == null )
            {
                action = new DEFAULT_LOADER() ;
            }
            if ( action != null )
            {
                if ( path != null )
                {
                    action.path = path   ;
                }
                if ( suffix != null )
                {
                    action.suffix = suffix ;
                }
                if ( resource != null )
                {
                    action.fileName = resource ;
                }
                action.verbose = verbose ;
            }
            return action ;
        }
        
        /**
         * Registers the resource in the ObjectResourceBuilder.
         */
        public static function register( type:String = "config" ):void
        {
            ObjectResourceBuilder.addObjectResource( type , ConfigResource ) ;
        }
    }
}