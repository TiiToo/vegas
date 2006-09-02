/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/*	AbstractConfigLoader

	AUTHOR

		Name : AbstractConfigLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2008-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/


package asgard.config
{

    import asgard.config.IConfigLoader ;
    import asgard.net.ActionLoader ;

    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    
    import vegas.util.ClassUtil ;

    public class AbstractConfigLoader extends ActionLoader implements IConfigLoader
    {
        
        // ----o Constructor
        
        public function AbstractConfigLoader( name:String="" )
        {

            super() ;
            
            _name = name ;
            
            _config = Config.getInstance( name ) ;
            
        }
        
    	// ----o Public Properties

        /**
         * Return the config object.
         */
        public function get config():Config 
    	{
    		return _config ;	
    	}
    	
        /**
         *
         */
    	public var default_file_name:String = "config" ;
        
        /**
         * 
         */
    	public var default_file_suffix:String = ".eden" ;
        
        
        /**
         * The name of the config file with datas.
         */
        public function get fileName():String 
        {
		    return (_fileName == null) ? default_file_name : _fileName ;	
    	}

    	public function set fileName( value:String ):void 
    	{
    		_fileName = value ;	
    	}

        /**
         * The name of the config.
         */
    	public function get name():String 
    	{
		    return _name ;
        }
   
        /**
         * The path of the config file with datas.
         */
    	public function get path():String 
    	{
		    return _path ;
        }
 
        public function set path( value:String ):void
        {
		    _path = value ;
    	}

        /**
         * The suffix of the config file with datas.
         */
    	public function get suffix():String 
    	{
	    	return (_suffix == null) ? default_file_suffix : _suffix ;
    	}
 
	    public function set suffix( value:String ):void
	    {
		    _suffix = value ;
    	}
 
        // ----o Public Methods
    
        /**
         * Returns a clone.
         */
        override public function clone():*
        {
            var cName:String = ClassUtil.getPath(this) ;
            var clazz:Class = ( getDefinitionByName( cName ) as Class ) ;
            var cloader:IConfigLoader = (new clazz(_name) as IConfigLoader) ;
            if (cloader != null)
            {
                cloader.data = data ;
                cloader.fileName = fileName ;
                cloader.path = path ;
                cloader.suffix = suffix ;
            }
            return cloader ;
            
        }
    
        /**
         * Sends and loads data from the specified URL.
         * @param request:URLRequest broke the internal request with your custom URLRequest
         */
        override public function load( request:URLRequest=null ):void
        {

            notifyStarted() ;

            if (request == null)
            {
                _request.url = path + fileName + suffix ;
                _loader.load(_request) ;    
            }
            else
            {
                _loader.load(request) ;
            }
            
        }



        // ----o Private Properties
        
        private var _config:Config = null ;
        private var _fileName:String = null ;
        private var _name:String ;
        private var _path:String = null ;
        private var _suffix:String = null ;

    }
}