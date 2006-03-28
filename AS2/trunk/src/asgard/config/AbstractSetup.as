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

/** AbstractSetup

	AUTHOR
	
		Name : AbstractSetup
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2006-03-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		Private constructor
	
	PROPERTY SUMMARY
	
		- name:String
		
		- namespace:String
		
		- running:Boolean [Read Only]
		
		- version:String
	
	METHOD SUMMARY
	
		- getConfig():Config
		
		- getConfigLoader():ConfigLoader
		
		- getRunning():Boolean
		
		- notifyChange():Void
		
		- onLoadComplete(ev:ConfigEvent):Void
		
		- onLoadError(ev:ConfigEvent):Void
		
		- onLoadFinished(ev:ConfigEvent):Void
		
		- onLoadProgress(ev:ConfigEvent):Void
		
		- onLoadStarted(ev:ConfigEvent)
		
		- release():Void
		
		- run():Void
		
		- setConfig(conf:Config):Void
	
		- setLoader(sFileName:String, sPath:String, sSuffix:String):Void
		
		- update():Void 
	
	INHERIT
	
		CoreObject > EventDispatcher > AbstractSetup
	
	IMPLEMENT
	
		IFormattable, IHashable, IEventDispatcher, IRunnable, ISetup, EventTarget, LoaderListener, ISetup

----------  */

import asgard.config.Config ;
import asgard.config.ConfigLoader ;
import asgard.config.ISetup ;
import asgard.events.LoaderEvent ;
import asgard.events.LoaderEventType ;
import asgard.events.UIEvent ;
import asgard.events.UIEventType;
import asgard.net.LoaderListener;

import vegas.events.EventDispatcher;
import vegas.events.Delegate;
import vegas.util.factory.PropertyFactory;

class asgard.config.AbstractSetup extends EventDispatcher implements ISetup, LoaderListener  {

	// ----o Constructor
	
	private function AbstractSetup( sFileName:String, sPath:String, sSuffix:String ) {

		_eChange = new UIEvent( UIEventType.CHANGE ) ;
		_loader = new ConfigLoader() ;
			
		_loader.addEventListener(LoaderEventType.COMPLETE, new Delegate(this, onLoadComplete)) ;
		_loader.addEventListener(LoaderEventType.INIT, new Delegate(this, onLoadInit)) ;
		_loader.addEventListener(LoaderEventType.PROGRESS, new Delegate(this, onLoadProgress)) ;
		_loader.addEventListener(LoaderEventType.START, new Delegate(this, onLoadStart)) ;
		_loader.addEventListener(LoaderEventType.IO_ERROR, new Delegate(this, onLoadError)) ;
		_loader.addEventListener(LoaderEventType.TIMEOUT, new Delegate(this, onLoadTimeOut)) ;

		setLoader(sFileName, sPath, sSuffix) ;

	}

	// ----o Public Properties
	
	public var name:String = null ;
	public var namespace:String = null  ;
	public var running:Boolean ; // [Read Only]
	public var version:String = null  ;
	
	// ----o Public Methods

	public function getConfig():Config {
		return Config.getInstance() ;
	}

	public function getConfigLoader():ConfigLoader {
		return _loader ;
	}
	
	public function getRunning():Boolean {
		return _loader.running ;
	}

	public function notifyChange():Void {
		dispatchEvent( _eChange ) ;
	}

	public function onLoadError(e:LoaderEvent):Void {
		// override
	}

	public function onLoadComplete(e:LoaderEvent):Void {

	}

	public function onLoadInit( e:LoaderEvent ) : Void {
		update() ;
		notifyChange() ;
	}

	public function onLoadProgress( e:LoaderEvent ):Void {
		// override
	}

	public function onLoadStart( e:LoaderEvent ):Void {
		// override
	}

	public function onLoadTimeOut( e:LoaderEvent ):Void {
		// override
	}
	
	public function release():Void {
		name = null ;
		namespace = null  ;
		version = null  ;
	}
	
	public function run():Void {
		if (!getRunning()) {
			release() ;
			_loader.load() ;
		}
	}
	
	public function setLoader(sFileName:String, sPath:String, sSuffix:String):Void {
		if (sFileName) _loader.setFileName(sFileName) ;
		if (sPath) _loader.setPath(sPath) ;
		if (sSuffix) _loader.setSuffix(sSuffix) ;	
	}

	public function update():Void {
		// override this method in you setup class.
	}

	// ----o Virtual Properties
	
	static private var __RUNNING__:Boolean = PropertyFactory.create(AbstractSetup, "running", true, true) ;

	// ----o Private Properties

	private var _eChange : UIEvent ;
	private var _loader:ConfigLoader ; 
	
}