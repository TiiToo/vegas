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
package asgard.system 
{
    import flash.utils.getDefinitionByName;
    
    import andromeda.ioc.io.ObjectResource;
    import andromeda.ioc.io.ObjectResourceType;
    import andromeda.process.ActionURLLoader;
    import andromeda.process.CoreActionLoader;
    
    import vegas.util.ClassUtil;    

    /**
     * This resource object contains all information about a localization file to load in the application.
     */
    public class LocaleResource extends ObjectResource 
    {
    	
        /**
         * Creates a new LocaleResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function LocaleResource( init:Object=null )
        {
            super(init) ;
            type = ObjectResourceType.I18N ;
        }
    	
    	/**
    	 * The default ILocalizationLoader class use in all LocaleResource to create a new resource process.
    	 */
    	public static var DEFAULT_LOADER:Class = EdenLocalizationLoader ;
    	
    	/**
    	 * The loader reference use to load the locale resource.
    	 */
    	public var loader:* ;
    	
        /**
         * The custom loader reference use to load the locale resource (The class must inherit from the AbstractLocalizationLoader class).
         */
    	public var path:String ;
    	
        /**
         * The prefix of the full localization file name.
         */
        public var prefix:String ;
        
        /**
         * The suffix of the full localization file name.
         */
        public var suffix:String ;           

        /**
         * Indicates the flag of the verbose mode.
         */
        public var verbose:* ;  	
    	
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
       	
            var action:AbstractLocalizationLoader ;
            
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
                    if ( ClassUtil.extendsClass(clazz, AbstractLocalizationLoader))
                    {
                        action = new clazz() as AbstractLocalizationLoader ;
                    }
                } 
                else if ( loader is AbstractLocalizationLoader )
                {
                    action = loader as AbstractLocalizationLoader ;
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
                if ( prefix != null )
                {                            
                    action.prefix = prefix ;
                }
                if ( suffix != null )
                {                            
                    action.suffix = suffix ;
                }
                if ( verbose != null )
                {
                    action.verbose = ( verbose is Boolean ) ? ( verbose as Boolean) : false;
                }
                if ( resource != null )
                {
                    action.lang = resource ;
                }                           
            }
			return action ;
        }    	
    	
    }
}