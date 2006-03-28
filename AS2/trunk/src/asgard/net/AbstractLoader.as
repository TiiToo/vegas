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

/** ------ AbstractLoader

	AUTHOR

		Name : AbstractLoader
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-03-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	DESCRIPTION
	
		Abstract Class.

	INHERIT
	
		CoreObject
			|
			AbstractCoreEventDispatcher
			 |
			 AbstractLoader
			 	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, IEventDispatcher, ILoader
	
----------  */	

import asgard.events.LoaderEvent ;
import asgard.events.LoaderEventType ;
import asgard.net.ILoader ;

import vegas.events.AbstractCoreEventDispatcher ;
import vegas.events.Delegate ;
import vegas.events.Event ;
import vegas.events.TimerEventType ;
import vegas.util.factory.PropertyFactory ;
import vegas.util.Timer ;


/**
 * @author eKameleon
 * @version 1.0.0.0
 **/
 

class asgard.net.AbstractLoader extends AbstractCoreEventDispatcher implements ILoader {

	// ----o Constructor 
	
	private function AbstractLoader() {
		
		super() ;
		initEvent() ;
		_setInitTimer() ;
		_setProgressTimer() ;
		
	}

	// ----o Public Properties

	public var bytesLoaded:Number ; // [Read Only]
	public var bytesTotal:Number ; // [Read Only]
	public var data ; // [R/W]
	public var name:String ; // [R/W]
	public var running:Boolean ; // [Read Only]
	public var timeOut:Number ; // [R/W]
	public var percent:Number ; // [Read Only]

	// ----o Public Methods

	public function getBytesLoaded():Number {
		var bytesLoaded:Number = getContent().getBytesLoaded() ;
		return isNaN(bytesLoaded) ? 0 : bytesLoaded ;
	}

	public function getBytesTotal():Number {
		var bytesTotal:Number = getContent().getBytesTotal() ;
		return isNaN(bytesTotal) ? 0 : bytesTotal ;
	}

	public function getContent() {
		return _oContent ;
	}
	
	public function getData() {
		return _oData ;	
	}

	public function getName():String {
		return _sName ;
	}

	public function getPercent():Number {
		var n:Number = Math.min(100, Math.ceil( getBytesLoaded() / ( getBytesTotal() / 100 ) ) );
		return (isNaN(n)) ? 0 : n ;
	}
	
	public function getRunning():Boolean {
		return _isRunning ;	
	}

	public function getTimeOut():Number {
		return _nTimeOut ;
	}

	public function getUrl():String {
		return _sURL;
	}
	
	public function initEvent():Void {
		_e = new LoaderEvent(null, this) ;
	}

	public function load():Void {
		if (_tProgress.running) _tProgress.stop() ;
		if (this.getUrl()) {
			_nLastBytesLoaded = 0;
			_nTime = getTimer();
			_setRunning(true) ;
			_tProgress.start() ;
		} else {
			notifyError(this + ".load() can't retrieve file url : " + this.getUrl() , null ) ;
		}
	}

	public function notifyError(sError:String, nCode:Number) : Void {
		LoaderEvent(_e).setType(LoaderEventType.IO_ERROR) ;
		LoaderEvent(_e).error = sError ;
		LoaderEvent(_e).code = nCode ;
		release() ; // TODO test this instruction !!!!
		_oED.dispatchEvent(_e);
	}

	public function notifyEvent(eventType:String):Void {
		LoaderEvent(_e).setType(eventType) ;
		LoaderEvent(_e).error = null ;
		LoaderEvent(_e).code = null ;
		_oED.dispatchEvent(_e) ;
	}

	public function onLoadInit() : Void {
		_stopInitTimer() ;
		_setRunning(false) ;
		notifyEvent(LoaderEventType.INIT);
	}
	
	public function release():Void {
		_setRunning(false) ; // TODO test this instruction !!
		_tInit.stop() ;
		_tProgress.stop() ;
	}

	public function run() : Void {
		load() ;
	}

	public function setContent(o):Void {
		_oContent = o;
	}

	public function setData( o ):Void {
		_oData = o ;
	}

	public function setName(sName:String):Void {
		_sName = sName;
	}

	public function setTimeOut( n : Number ):Void {
		_nTimeOut = Math.max(1000, n) ;
	}

	public function setUrl(sURL:String):Void {
		_sURL = sURL;
	}

	// ----o Virtual Properties

	static private var __BYTES_LOADED__:Boolean = PropertyFactory.create(AbstractLoader, "bytesLoaded", true, true) ;	
	static private var __BYTES_TOTAL__:Boolean = PropertyFactory.create(AbstractLoader, "bytesTotal", true, true) ;	
	static private var __DATA__:Boolean = PropertyFactory.create(AbstractLoader, "data", true) ;
	static private var __NAME__:Boolean = PropertyFactory.create(AbstractLoader, "name", true) ;
	static private var __PERCENT__:Boolean = PropertyFactory.create(AbstractLoader, "percent", true, true) ;
	static private var __RUNNING__:Boolean = PropertyFactory.create(AbstractLoader, "running", true, true) ;		
	static private var __TIMEOUT__:Boolean = PropertyFactory.create(AbstractLoader, "timeOut", true) ;
	static private var __URL__:Boolean = PropertyFactory.create(AbstractLoader, "url", true) ;
			
	// ----o Private Properties
	
	private var _e:Event ;
	private var _isRunning:Boolean ;
	private var _nLastBytesLoaded : Number;
	private var _nTimeOut:Number = 9000 ; // default timeOut value : 9 seconds
	private var _nTime:Number ;
	private var _oContent ;
	private var _oData ;
	private var _sName:String ;
	private var _sURL:String ;
	private var _tInit : Timer;
	private var _tProgress:Timer ;

	// ----o Private Methods

	private function _checkTimeOut( nLastBytesLoaded:Number, nTime:Number ) : Void {
		if ( nLastBytesLoaded != _nLastBytesLoaded) {
			_nLastBytesLoaded = nLastBytesLoaded ;
			_nTime = nTime ;
		} else if ( (nTime - _nTime)  > _nTimeOut) {
			notifyEvent( LoaderEventType.TIMEOUT );
			release() ;
			notifyError(this + " load timeout with url : '" + this.getUrl() + "'." , null ) ;
		}
	}

	private function _onLoadProgress():Void {
		_checkTimeOut( getBytesLoaded(), getTimer() ) ;
		if ( getBytesLoaded() > 4 && getBytesLoaded() == getBytesTotal()) {
			_tProgress.stop() ;
			notifyEvent(LoaderEventType.PROGRESS);
			notifyEvent(LoaderEventType.COMPLETE) ;
			_startInitTimer() ;
		} else {
			notifyEvent(LoaderEventType.PROGRESS);
		}
	}

	/*protected*/ private function _setInitTimer( f:Function ) {
		_tInit = new Timer(150, 1) ;	
		_tInit.addEventListener(TimerEventType.TIMER, new Delegate(this, f || onLoadInit)) ;
	}

	/*protected*/ private function _setProgressTimer( f:Function ) {
		_tProgress = new Timer(50) ;
		_tProgress.addEventListener(TimerEventType.TIMER, new Delegate(this, f || _onLoadProgress)) ;
	}

	/*protected*/ private function _setRunning( b:Boolean ):Void {
		_isRunning = b ;
	}
	
	/*protected*/ private function _startInitTimer():Void {
		_tInit.start() ;	
	}

	/*protected*/ private function _stopInitTimer():Void {
		if (_tInit.running) _tInit.stop() ;	
	}

}