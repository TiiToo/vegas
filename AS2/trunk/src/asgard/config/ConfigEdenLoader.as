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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.config.Config;
import asgard.events.ConfigLoaderEvent;
import asgard.events.LoaderEvent;
import asgard.net.EdenLoader;
import asgard.net.URLRequest;

import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.util.ConstructorUtil;

/**
 * The ConfigEdenLoader class.
 * @author eKameleon
 */
class asgard.config.ConfigEdenLoader extends EdenLoader 
{
	
	/**
	 * Creates a new ConfigEdentLoader instance.
	 */
	function ConfigEdenLoader( config ) 
	{
		
		super();
		_oConfig = config || Config.getInstance() ;
		
	}

	public var default_file_name:String = "config" ;
	
	public var default_file_suffix:String = ".eden" ;
	
	public function get fileName():String 
	{
		return getFileName() ;	
	}
	
	public function set fileName(s:String):Void 
	{
		setFileName(s) ;	
	}
	
	static public var LOGGER:ILogger = Log.getLogger( ConstructorUtil.getPath( new ConfigEdenLoader() ) ) ;

	public function get path():String 
	{
		return getPath() ;	
	}
	
	public function set path(s:String):Void 
	{
		setPath(s) ;	
	}

	public function get suffix():String 
	{
		return getSuffix() ;	
	}
	
	public function set suffix(s:String):Void 
	{
		setSuffix(s) ;	
	}

	public function deserializeData():Void 
	{
		super.deserializeData() ;
		for (var each:String in _oData) 
		{
			_oConfig[each] = _oData[each] ;
		}
	}
	
	public function getConfig():Config 
	{
		return _oConfig ;	
	}

	public function getFileName():String 
	{
		return (_fileName == null) ? default_file_name : _fileName ;	
	}

	public function getPath():String 
	{
		return _path || "" ;

	}
	
	public function getSuffix():String 
	{
		return (_suffix == null) ? default_file_suffix : _suffix ;
	}

	public function initEvent():Void 
	{
		
		_e = new ConfigLoaderEvent( null, this ) ;
		
	}
	
	public function load( fileName:String ):Void 
	{
		if (fileName) 
		{
			setFileName(fileName) ;
		}
		var uri:String = getPath() + getFileName() + getSuffix() ;
		super.load(new URLRequest(uri) ) ;
	}
	
  	/*override*/ public function onLoadInit(e:LoaderEvent):Void 
  	{
		LOGGER.info(this + ".onLoadInit() : Config has been loaded") ; 
	}

	static public function protectConfig( oConfig ):Void 
	{
		oConfig.__resolve = function( p:String ) : String 
		{
			ConfigEdenLoader.LOGGER.warn("Config object : '" + p + "' property is undefined" ) ;
			return "" ;
		} ;
		_global.ASSetPropFlags(oConfig, "__resolve", 7, 1) ;
	}

	public function setFileName(sFileName:String):Void 
	{
		_fileName = sFileName ;	
	}

	public function setPath( sPath:String ):Void 
	{
		_path = sPath || "" ;
	}

	public function setSuffix( sSuffix:String ):Void 
	{
		_suffix = sSuffix || null ;
	}

	private var _fileName:String = null ;

	private var _oConfig:Config ;

	private var _path:String = null ;

	private var _suffix:String = null ;

}