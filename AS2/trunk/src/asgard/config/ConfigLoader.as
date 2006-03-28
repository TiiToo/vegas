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

/** ConfigLoader

	AUTHOR

		Name : ConfigLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2006-03-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

**/

import asgard.config.Config ;
import asgard.events.ConfigLoaderEvent ;
import asgard.events.LoaderEvent ;
import asgard.net.JSONLoader ;
import asgard.net.URLRequest ;

import vegas.logging.ILogger ;
import vegas.logging.Log ;
import vegas.util.factory.PropertyFactory ;

/**
 * @author eKameleon
 */
class asgard.config.ConfigLoader extends JSONLoader {
	
	// ----o Constructor
	
	function ConfigLoader( config ) {
		super();
		_oConfig = config || Config.getInstance() ;
		ConfigLoader.protectConfig( _oConfig ) ;
		_logger = Log.getLogger("asgard.config") ;
	}

	// ----o Constants
	
	static public var DEFAULT_FILE_NAME:String = "config" ;
	
	static public var DEFAULT_SUFFIX:String = ".json" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(ConfigLoader, null , 7, 7) ;
	
	// ----o Public Properties
	
	public var fileName:String ; // [R/W]
	public var path:String ; // [R/W]
	public var suffix:String ; // [R/W]

	// ----o Public Methods
	
	public function deserializeData():Void {
		super.deserializeData() ;
		for (var each:String in _oData) {
			_oConfig[each] = _oData[each] ;
		}
	}
	
	public function getConfig():Config {
		return _oConfig ;	
	}

	public function getFileName():String {
		return (_fileName == null) ? ConfigLoader.DEFAULT_FILE_NAME : _fileName ;	
	}

	public function getPath():String {
		return _path || "" ;

	}
	public function getSuffix():String {
		return (_suffix == null) ? ConfigLoader.DEFAULT_SUFFIX : _suffix ;
	}

	public function initEvent():Void {
		_e = new ConfigLoaderEvent( null, this );
	}
	
	public function load( fileName:String ):Void {
		if (fileName) setFileName(fileName) ;
		var uri:String = getPath() + getFileName() + getSuffix() ;
		var request:URLRequest = new URLRequest(uri) ;
		super.load( request ) ;
	}

  	/*override*/ public function onLoadInit(e:LoaderEvent):Void {
		
		_logger.info(this + ".onLoadInit() : Config has been loaded") ; 
		
	}

	static public function protectConfig( oConfig ):Void {
		var logger:ILogger = Log.getLogger("asgard.config") ;
		oConfig.__resolve = function( p:String ) : String {
			logger.warn("Config object : '" + p + "' property is undefined" ) ;
			return "" ;
		} ;
		_global.ASSetPropFlags(oConfig, "__resolve", 7, 1) ;
	}

	public function setFileName(sFileName:String):Void {
		_fileName = sFileName ;	
	}

	public function setPath( sPath:String ):Void {
		_path = sPath || "" ;
	}

	public function setSuffix( sSuffix:String ):Void {
		_suffix = sSuffix || null ;
	}

	// ----o Virtual Properties

	static private var __FILE_NAME__:Boolean = PropertyFactory.create(ConfigLoader, "fileName", true) ;	
	static private var __PATH__:Boolean = PropertyFactory.create(ConfigLoader, "path", true) ;
	static private var __SUFFIX_:Boolean = PropertyFactory.create(ConfigLoader, "suffix", true) ;
	
	// ----o Private Properties
	
	private var _fileName:String = null ;
	private var _logger:ILogger ;
	private var _oConfig:Config ;
	private var _path:String = null ;
	private var _suffix:String = null ;

}