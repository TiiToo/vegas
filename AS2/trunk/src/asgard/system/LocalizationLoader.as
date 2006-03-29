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

/** ------ LocalizationLoader

	AUTHOR

		Name : LocalizationLoader
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-02-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Dynamic Class

	INHERIT
	
		CoreObject
			|
			AbstractCoreEventDispatcher
			 |
			 AbstractLoader
			 	|
			 	URLLoader
			 		|
			 		JSONLoader
			 	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, IEventDispatcher, ILoader
	
----------  */	

import asgard.events.LocalizationLoaderEvent;
import asgard.net.JSONLoader;
import asgard.net.URLRequest;
import asgard.system.Lang;
import asgard.system.Locale;
import asgard.system.Localization;

import vegas.errors.IllegalArgumentError;
import vegas.util.factory.PropertyFactory;



/**
 * @author eKameleon
 * @date 2006-03-24
 */
class asgard.system.LocalizationLoader extends JSONLoader {
	
	// ----o Constructor
	
	function LocalizationLoader() {
		super() ;
	}
	
	// ----o Public Properties
	
	public var path:String ; // [R/W]
	public var prefix:String ; // [R/W]
	public var suffix:String ; // [R/W]
	
	// ----o Public Methods

	public function getDefault():Lang {
		return Lang(_default) || null ;
	}

	public function getLocalization(lang:Lang):Locale {
		return Localization.getInstance().get(lang) ;
	}

	public function getPath():String {
		return _path || "" ;

	}
	
	public function getPrefix():String {
		return (_prefix == null) ? "localize_" : _prefix ;

	}

	public function getSuffix():String {
		return (_suffix == null) ? ".json" : _suffix ;
	}

	public function initEvent():Void {
		_e = new LocalizationLoaderEvent( null, this );
	}
	
	public function load( lang:Lang ):Void {
		if (Lang.validate(lang)) {
			var uri:String = getPath() + getPrefix() + lang + getSuffix() ;
			var request:URLRequest = new URLRequest(uri) ;
			super.load( request ) ;
		} else {
			throw new IllegalArgumentError(this + ".load(" + lang + ") argument must be a valid Lang") ;	
		}
	}

	public function setDefault( lang:String ):Void {
		_default = (Lang.validate(lang)) ? lang : null ;
	}

	public function setPath( sPath:String ):Void {
		_path = sPath || "" ;
	}

	public function setPrefix( sPrefix:String ):Void {
		_prefix = sPrefix || null ;
	}

	public function setSuffix( sSuffix:String ):Void {
		_suffix = sSuffix || null ;
	}

	// ----o Virtual Properties
	
	static private var __DEFAULT__:Boolean = PropertyFactory.create(LocalizationLoader, "default", true) ;
	static private var __PATH__:Boolean = PropertyFactory.create(LocalizationLoader, "path", true) ;
	static private var __PREFIX__:Boolean = PropertyFactory.create(LocalizationLoader, "prefix", true) ;
	static private var __SUFFIX_:Boolean = PropertyFactory.create(LocalizationLoader, "suffix", true) ;
	
	// ----o Private Properties
	
	private var _default:String = null ;
	private var _path:String = null ;
	private var _prefix:String = null ;
	private var _suffix:String = null ;

}