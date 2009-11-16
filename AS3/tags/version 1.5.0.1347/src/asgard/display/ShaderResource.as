
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
ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
Portions created by the Initial Developer are Copyright (C) 2004-2009
the Initial Developer. All Rights Reserved.
  
Contributor(s) :
  
 */
package asgard.display 
{
    import andromeda.ioc.core.ObjectDefinition;
    import andromeda.ioc.factory.ObjectFactory;
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceBuilder;
    
    import asgard.logging.logger;
    
    import system.process.ActionURLLoader;
    import system.process.CoreActionLoader;
    
    import flash.display.Shader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    
    /**
     * This resource object contains all information about a Shader file (*.pbj) to load in the application.
     */
    public class ShaderResource extends ObjectResource 
    {
        /**
         * Creates a new ShaderResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function ShaderResource( init:Object = null )
        {
            super(init);
            type = TYPE ;
        }
        
        /**
         * The root path of all Shader resources.
         */
        public static var DEFAULT_PATH:String = "" ;
        
        /**
         * The type of the resource.
         */
        public static const TYPE:String = "shader" ;
        
        /**
         * The optional path of the external Shader file to load.
         */
        public var path:String ;
        
        /**
         * The Shader reference use to load the resource.
         */
        public var shader:* ;
        
        /**
         * Indicates if the object definition of this resource must be a singleton.
         */
        public var singleton:Boolean = true ;
        
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
            try
            {
                if ( id == null || !(id is String) || id == "" )
                {
                    throw new Error(this + " create failed, the String id value of this resource not must be empty or 'null'") ;
                }
                
                var factory:ObjectFactory = owner as ObjectFactory ;
                
                if ( factory == null )
                {
                    throw new Error(this + " create failed, the factory reference of this resource not must be 'null'.") ;
                }
                
                if ( factory.containsObjectDefinition(id) )
                {
                    throw new Error(this + " create failed, the factory already contains the specified id : " + id) ;
                } 
                
                if ( shader != null )
                {
                    if ( shader is String )
                    {
                        shader = factory.getObject( shader as String ) as Shader ;
                    }
                    else if ( shader is Shader )
                    {
                        shader = shader as Shader ;
                    }
                }
                
                if ( shader == null )
                {
                    shader = new Shader() ;
                }
                
                var init:Object = 
                {
                    id           : id , 
                    type         : "flash.display.Shader",
                    factoryValue : shader , 
                    singleton    : singleton , 
                    lazyInit     : true 
                };
                    
                var definition:ObjectDefinition = ObjectDefinition.create(init) ;
                
                factory.addObjectDefinition( definition ) ;
                
                var uri:String             = (path || DEFAULT_PATH) + resource ;
                var action:ActionURLLoader = new ActionURLLoader( new ShaderLoader( shader )  ) ;
                
                action.dataFormat = URLLoaderDataFormat.BINARY ;
                
                action.request = new URLRequest( uri ) ;
                
                return action ;
            }
            catch( e:Error )
            {
                if ( verbose )
                {
                    logger.info(e.message) ;
                }
            }
            return null ; 
        }
        
        /**
         * Registers the resource in the ObjectResourceBuilder.
         */
        public static function register( type:String = "shader" ):void
        {
            ObjectResourceBuilder.addObjectResource( type , ShaderResource ) ;
        }
    }
}
