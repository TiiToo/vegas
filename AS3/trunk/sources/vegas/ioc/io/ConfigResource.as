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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
