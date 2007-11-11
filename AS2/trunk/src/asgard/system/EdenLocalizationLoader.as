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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.events.LocalizationLoaderEvent;
import asgard.net.EdenLoader;
import asgard.net.URLRequest;
import asgard.system.ILocalizationLoader;
import asgard.system.Lang;
import asgard.system.Locale;
import asgard.system.Localization;

import vegas.errors.IllegalArgumentError;

/**
 * The ILocalizationLoader based on a external Eden string document.
 * @author eKameleon
 */
class asgard.system.EdenLocalizationLoader extends EdenLoader implements ILocalizationLoader
{
	
	/**
	 * Creates a new EdenLocalizationLoader instance.
	 */
	function EdenLocalizationLoader() 
	{
		super() ;
	}

	/**
	 * The default prefix name of the localized files ("localize_").
	 */
	public static var DEFAULT_PREFIX:String = "localize_" ;

	/**
	 * The default suffix name of the localized files(".eden").
	 */
	public static var DEFAULT_SUFFIX:String = ".eden" ;

	/**
	 * Determinates the path of the localization files.
	 */
	public function get path():String 
	{
		return getPath() ;	
	}
	
	/**
	 * @private
	 */
	public function set path(s:String):Void 
	{
		setPath(s) ;	
	}

	/**
	 * Determinates the prefix value of the localization files.
	 */
	public function get prefix():String 
	{
		return getPrefix() ;	
	}
	
	/**
	 * @private
	 */
	public function set prefix(s:String):Void 
	{
		setPrefix(s) ;	
	}

	/**
	 * Determinates the suffix value of the localization files.
	 */
	public function get suffix():String 
	{
		return getSuffix() ;	
	}
	
	/**
	 * @private
	 */
	public function set suffix(s:String):Void 
	{
		setSuffix(s) ;	
	}

	/**
	 * Returns the default Lang reference of the loader.
	 * @return the default Lang reference of the loader.
	 */
	public function getDefault():Lang 
	{
		return Lang(_default) || null ;
	}

	/**
	 * Returns the Locale object defines by the current passed-in Lang object.
	 * @return the Locale object defines by the current passed-in Lang object.
	 */
	public function getLocalization(lang:Lang):Locale 
	{
		return Localization.getInstance().get(lang) ;
	}

	/**
	 * Returns the path of the localization files.
	 * @return the path of the localization files.
	 */
	public function getPath():String 
	{
		return _path || "" ;
	}

	/**
	 * Returns the prefix value of the localization files.
	 * @return the prefix value of the localization files.
	 */
	public function getPrefix():String 
	{
		return (_prefix == null) ? DEFAULT_PREFIX : _prefix ;
	}

	/**
	 * Returns the suffix value of the localization files.
	 * @return the suffix value of the localization files.
	 */
	public function getSuffix():String 
	{
		return (_suffix == null) ? DEFAULT_SUFFIX : _suffix ;
	}
	
	/**
	 * Initialize the internal event of this loader.
	 */
	public function initEvent():Void 
	{
		_e = new LocalizationLoaderEvent( null, this );
	}
	
	/**
	 * Load the localize file data with the specified Lang argument.
	 */
	public function load( lang:Lang ):Void 
	{
		
		if (Lang.validate(lang)) 
		{
			var uri:String = getPath() + getPrefix() + lang + getSuffix() ;
			var request:URLRequest = new URLRequest(uri) ;
			super.load( request ) ;
		}
		else 
		{
			throw new IllegalArgumentError(this + ".load(" + lang + ") argument must be a valid Lang") ;	
		}
	}

	/**
	 * Sets the default lang reference of this loader.
	 */
	public function setDefault( lang:String ):Void 
	{
		_default = (Lang.validate(lang)) ? lang : null ;
	}

	/**
	 * Sets the path of the localization files.
	 */
	public function setPath( sPath:String ):Void 
	{
		_path = sPath || "" ;
	}

	/**
	 * Sets the prefix value of the localization files.
	 */
	public function setPrefix( sPrefix:String ):Void 
	{
		_prefix = sPrefix || null ;
	}

	/**
	 * Sets the suffix value of the localization files.
	 */
	public function setSuffix( sSuffix:String ):Void 
	{
		_suffix = sSuffix || null ;
	}

	/**
	 * @private
	 */
	private var _default:String = null ;

	/**
	 * @private
	 */
	private var _path:String = null ;

	/**
	 * @private
	 */
	private var _prefix:String = null ;

	/**
	 * @private
	 */
	private var _suffix:String = null ;


}