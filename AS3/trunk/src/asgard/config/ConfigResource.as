/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.config 
{
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceType;
    import andromeda.process.ActionURLLoader;
    import andromeda.process.CoreActionLoader;    

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
    	 * The default IConfigLoader use in all ConfigResource to create a new resource process.
    	 */
    	public static var DEFAULT_LOADER:IConfigLoader = new EdenConfigLoader() ;    	
    	
        /**
         * The loader reference use to load the config resource.
         */
        public var loader:ActionURLLoader ;    	
    	
    	/**
    	 * The name of the full config file name.
    	 */
    	public var name:String ;
    	
        /**
         * The path of the full config file name.
         */
    	public var path:String ;
        
        /**
         * The suffix of the full config file name.
         */
        public var suffix:String ;           
    	
        /**
         * Indicates the flag of the verbose mode.
         */
        public var verbose:* ; 
        
        /**
         * Creates a new ActionURLLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
        	var action:AbstractConfigLoader = ( loader || DEFAULT_LOADER ) as AbstractConfigLoader ;
            if ( action != null )
			{
				if ( path != null )
                {
                    action.path   = path   ;
                }
                if ( suffix != null )
                {                            
                    action.suffix = suffix ;
                }
                if ( resource != null )
                {
                    action.fileName = resource ;
                }
                if ( verbose != null )
                {
                    action.verbose = (verbose is Boolean) ? (verbose as Boolean) : false;
                }                            
            }
			return action ;
        }

    }

}
