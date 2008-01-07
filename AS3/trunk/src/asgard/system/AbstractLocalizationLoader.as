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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.system
{
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	
	import asgard.net.ActionLoader;
	
	import system.Reflection;	

	/**
     * This skeletal class provides an easy implementation of the ILocalizationLoader interface. 
     * @author eKameleon
     */
    public class AbstractLocalizationLoader extends ActionLoader implements ILocalizationLoader
    {
        
        /**
         * Creates a new AbstractConfigLoader instance.
         * @param localization The Localization singleton reference of this loader.
         */
        public function AbstractLocalizationLoader( localization:Localization )
        {
            super() ;
            _localization = localization ;
            parsing       = true ;
        }
        
        /**
         * Returns the localization reference of this loader.
         * @return the localization reference of this loader.
         */
        public function get localization():Localization
    	{
    		return _localization ;	
    	}
    	
        /**
         * @private
         */
        public function set localization( localization:Localization ):void
    	{
    		_localization = localization ;	
    	}
    	
        /**
         * Defines the defaut path of the localization file.
         */
    	public var default_file_path:String = "" ;
    	
        /**
         * Defines the defaut prefix of the localization file.
         */
    	public var default_file_prefix:String = "localize_" ;
        
        /**
         * Defines the defaut file suffix of the localization file.
         */
    	public var default_file_suffix:String = ".txt" ;

        /**
         * The path of the localization file.
         */
    	public function get path():String 
    	{
		    return _path || default_file_path || "" ;
        }
        
        /**
         * @private
         */
        public function set path( value:String ):void
        {
		    _path = value ;
    	}

        /**
         * The prefix of the localization file.
         */
    	public function get prefix():String 
    	{
		    return _prefix || default_file_prefix || "" ;
        }
        
        /**
         * @private
         */
        public function set prefix( value:String ):void
        {
		    _prefix = value ;
    	}

        /**
         * The suffix of the config file with datas.
         */
    	public function get suffix():String 
    	{
	    	return _suffix || default_file_suffix || "" ;
    	}
 
        /**
         * The suffix of the config file with datas.
         */
	    public function set suffix( value:String ):void
	    {
		    _suffix = value ;
    	}
    
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            var cName:String = Reflection.getClassPath(this) ;
            var clazz:Class = ( getDefinitionByName( cName ) as Class ) ;
            var loader:ILocalizationLoader = (new clazz() as ILocalizationLoader) ;
            if (loader != null)
            {
                loader.data     = data ;
                loader.path     = path ;
                loader.prefix   = prefix ;
                loader.suffix   = suffix ;
            }
            return loader ;
            
        }
    
        /**
         * Sends and loads data from the specified URL.
         * @param request broke the internal request with your custom URLRequest.
         */
        public override function load( request:URLRequest ):void
        {
            notifyStarted() ;
            if (request == null)
            {
                _loader.load( request ) ;    
            }
            else
            {
                _loader.load(request) ;
            }
        }

        /**
         * Sends and loads data from the specified passed-in lang value (the passed-in argument must be a Lang reference or a valid string).
         * @param lang The localization Lang value.
         */
		public function loadLang( lang:* ):void
		{
			if ( Lang.validate( lang ) )
			{
				var request:URLRequest = new URLRequest( path + prefix + lang + suffix ) ;
				load(request) ;
			}	
		}

        /**
         * Parse your datas when loading is complete.
         */
        public override function parse():void
        {
            var o:*           = data ;
		    var current:Lang  = _localization.current ;
		    var locale:Locale = new Locale() ;
		    for ( var prop:String in o ) 
		    {
    			locale[ prop ] = o[prop] ;
	    	}
	    	_localization.put( current, locale ) ;
	    	_localization.notifyChange() ;
        }
        
        /**
         * @private
         */
		protected var _localization:Localization ;

        /**
         * @private
         */
        protected var _path:String ;

        /**
         * @private
         */
        protected var _prefix:String ;

        /**
         * @private
         */
        protected var _suffix:String ;
		
	}

}