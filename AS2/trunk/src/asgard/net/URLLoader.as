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

/** ------ URLLoader

	AUTHOR

		Name : URLLoader
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-03-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

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
			 	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, IEventDispatcher, ILoader
	
----------  */	

import asgard.events.LoaderEvent ;
import asgard.events.LoaderEventType ;
import asgard.net.URLLoaderEvent ;

import asgard.net.AbstractLoader;
import asgard.net.DataFormat;
import asgard.net.URLRequest;
import asgard.net.URLRequestHeader;
import asgard.net.URLVariables;

import vegas.events.Delegate;
import vegas.util.factory.PropertyFactory;

/**
 * @author eKameleon
 */
 
class asgard.net.URLLoader extends AbstractLoader {
	
	// ----o Constructor
	
	function URLLoader() {
		super() ;
		setDataFormat(DataFormat.TEXT) ;
		_setInitTimer(super.onLoadInit) ;
	}

	// ----o Constants

	static public var DEFAULT_CONTENT_TYPE:String = "application/x-www-form-urlencoded" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(URLLoader, null , 7, 7) ;

	// ----o Public Properties
	
	public var dataFormat ; // [R/W]
	
	// ----o Public Methods

	public function addRequestHeader( header, headerValue:String ):Void {
		getContent().addRequestHeader(header, headerValue) ;
	}

	public function checkData():Void {
		deserializeData() ;
		_startInitTimer() ;
	}
	
	public function deserializeData():Void {
		// override thid method
	}

	/*override*/ public function getContent():LoadVars {
		return LoadVars( super.getContent() );
	}
	
	public function getContentType():String {
		return getContent().contentType ;	
	}
	
	public function getDataFormat():String {
		return _sDataFormat ;
	}

	public function initEventSource():Void {
		_e = new URLLoaderEvent(null, this);
	}
	
	public function isLoaded():Boolean {
		return getContent().loaded ;	
	}	

	/*override*/ public function load(request:URLRequest):Void {
		
		_oData = null ;
		
		if (request) {
		
			System.useCodepage = (request.getUseCodePage() || false) ;
			
			if (request.getUrl() != undefined) {
				//trace("request url not undefined : " + request.getUrl()) ;
				setUrl( request.getUrl() ) ;
			}
			
			_sContentType = request.getContentType() || URLRequest.DEFAULT_CONTENT_TYPE ;
			_sMethod = request.getMethod() ;
			_aHeaders = request.getRequestHeaders() ;
			
		}
		
		var sender ;
			
		switch (getDataFormat()) {
			case DataFormat.BINARY :
				sender = new Object() ;
				break ;
			default :
				sender = new LoadVars() ;
				break ;
		}
		
		sender.contentType = _sContentType ;
		
		var len:Number = _aHeaders.length ;
		if (len > 0) {
			while(--len > -1) {
				var header:URLRequestHeader = _aHeaders[len] ;
				LoadVars.prototype.addRequestHeader.call( sender, header.name , header.value ) ;
			} 
		}
		
		var receive = new LoadVars() ;
		receive.onData = Delegate.create(this, _onData) ;

		setContent( receive ) ;
				
		notifyEvent(LoaderEventType.START) ;

		sender.sendAndLoad = LoadVars.prototype.sendAndLoad ;
		
		LoadVars.prototype.sendAndLoad.call(sender, this.getUrl(), receive, _sMethod ) ;
		
  		super.load() ;
  		
  	}
    
    public var sendAndLoad:Function = LoadVars.prototype.sendAndLoad ;
    
  	/*override*/ public function onLoadInit(e:LoaderEvent):Void {
		// overwriting for delaying 'onLoadInit' broadcast
	}
  
  	public function release():Void {
  		getContent().onData = null ;
  		getContent().onLoad = null ;
  		super.release() ;
  			
  	}
  
	public function setContent(oLoadVars:LoadVars):Void {
		super.setContent( oLoadVars );
	}
	
	public function setContentType(sType:String):Void {
		getContent().contentType = sType || DEFAULT_CONTENT_TYPE ;
	}
	
	public function setDataFormat(s:String):Void {
		s = DataFormat.validate(s) ? s : DataFormat.TEXT ;
		_sDataFormat = s ;
	}

	// ----o Virtual Properties

	static private var __DATA_FORMAT__:Boolean = PropertyFactory.create(URLLoader, "dataFormat", true) ;
		
	// ----o Private Properties
	
	private var _aHeaders:Array ;
	private var _sContentType:String = URLRequest.DEFAULT_CONTENT_TYPE ;
	private var _sDataFormat:String ;
	private var _sMethod:String = "POST" ;
	private var _oData = null ;
	
	// ----o Private Methods
	
	private function _onData( source:String ) {

		if (source == undefined) {
			
			_onLoad(false) ;
			
		} else {
		
			switch (getDataFormat()) {
			
				case DataFormat.TEXT :
					_oData = new String(source) ;
					break ;
				
				case DataFormat.VARIABLES :
					_oData = new URLVariables(source) ;
					break ;

				case DataFormat.BINARY :
				default :
					_oData = source ;
					break ;

			}

			_onLoad(true) ;
					
		}
	}
	
	private function _onLoad(success:Boolean):Void {
		if (success) {
			checkData() ;
		} else {
			notifyError(this + " : Unload to load/parse URL file : " + this.getUrl() , null ) ;
		}
	}
}