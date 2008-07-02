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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.io 
{
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.getDefinitionByName;
    
    import andromeda.ioc.io.ObjectResource;
    import andromeda.process.ActionLoader;
    import andromeda.process.CoreActionLoader;
    
    import asgard.net.ParserLoader;
    
    import vegas.util.ClassUtil;    

    /**
     * This value object contains all information about a dll to load in the application. 
     */
    public class AssemblyResource extends ObjectResource 
    {
		
		/**
		 * Creates a new AssemblyResource instance.
		 */
        public function AssemblyResource(init:Object = null)
        {
            super(init);
        }
        
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
                    if ( ClassUtil.extendsClass(clazz, Loader))
                    {
                        currentLoader = new clazz() as Loader ;
                    }
                } 
                else if ( loader is ParserLoader )
                {
                    currentLoader = loader as Loader ;
                }
                
            }        	
        	
            var action:ActionLoader = new ActionLoader( currentLoader || new DEFAULT_LOADER() ) ;
			
			action.request          = new URLRequest( path + resource ) ;
			action.context          = new LoaderContext( checkPolicyFile , ApplicationDomain.currentDomain ) ;
            
            return action ;
            
        }        
        
    }
}