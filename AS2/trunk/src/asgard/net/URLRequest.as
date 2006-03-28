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

/* -------- URLRequest

	AUTHOR

		Name : URLRequest
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-03-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net


------------*/

import asgard.net.URLRequestMethod;

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.errors.ArgumentsError;
import vegas.util.factory.PropertyFactory ;

/**
 * @author eKameleon
 * @version 1.0.0.0
 */
 
class asgard.net.URLRequest extends CoreObject implements ICloneable {
	
	/**
	 * Constructor
	 */
		
	public function URLRequest(url:String) {
		super() ;
		_sURL = url ;
	}

	/**
	 * Constants
	 */
		
	static public var DEFAULT_CONTENT_TYPE:String = "application/x-www-form-urlencoded" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(URLRequest, null , 7, 7) ;

	/**
	 * Public Properties
	 */
	
	/**
	 * The MIME content type of any POST data.
	 */
	public var contentType:String ; // [R/W]
	
	/**
	 * An object containing data to be transmitted with the URL request.
	 */
	public var data ; // [R/W]
	
	/**
	 * Controls whether the HTTP form submission method is a GET or POST operation.
	 */
	public var method:String ; // [R/W]
	
	/**
	 * The array of HTTP request headers to be appended to the HTTP request.
	 */
	public var requestHeaders:Array ; // [R/W]
	
	/**
	 * The URL to be requested.
	 */
	public var url:String ; // [R/W]
	
	/**
	 * If true, the request is encoded using the system code page, rather than Unicode.
	 */
	public var useCodePage:Boolean ; // [R/W]
	
	/**
	 * Public Methods
	 */
	
	public function clone() {
		var request:URLRequest = new URLRequest(this.getUrl()) ;
		request.setData( getData() ) ;
		request.setContentType( getContentType() ) ;
		request.setMethod( getMethod() ) ;
		request.setRequestHeaders( getRequestHeaders() ) ;
		request.setUseCodePage( getUseCodePage() ) ;
		return request ;
	}
	
	public function getContentType():String {
		return _sContentType || DEFAULT_CONTENT_TYPE ;	
	}

	public function getData() {
		return _oData ;	
	}

	public function getMethod():String {
		return _sMethod || URLRequestMethod.POST ;
	}

	/**
	 * Retreive the array of HTTP request headers to be appended to the HTTP request.
	 * @return an array of HTTP request headers.
	 */
	public function getRequestHeaders():Array {
		return _aRequestHeaders ;
	}

	public function getUrl():String {
		return _sURL ;	
	}

	public function getUseCodePage():Boolean {
		return _bUseCodePage ;
	}

	public function setContentType(sType:String):Void {
		_sContentType = sType ;
	}

	public function setData( oData ) {
		_oData = oData ;	
	}

	public function setMethod(sMethod:String):Void {
		if (URLRequestMethod.validate(sMethod)) {
			_sMethod = sMethod ;
		} else {
			throw new ArgumentsError(this + ".setMethod("+ sMethod + ") argument is not a URLRequestHeader value" ) ;	
		}
	}

	public function setRequestHeaders(ar:Array):Void {
		_aRequestHeaders = ar ;
	}

	public function setUrl(sURL:String):Void {
		_sURL = sURL ;	
	}
		
	public function setUseCodePage(b:Boolean):Void {
		_bUseCodePage = b ;
	}

	/**
	 * Virtual Properties
	 */

	static private var __CONTENT_TYPE__:Boolean = PropertyFactory.create(URLRequest, "contentType", true) ;
	static private var __DATA__:Boolean = PropertyFactory.create(URLRequest, "data", true) ;
	static private var __METHOD__:Boolean = PropertyFactory.create(URLRequest, "method", true) ;
	static private var __REQUEST_HEADERS__:Boolean = PropertyFactory.create(URLRequest, "requestHeaders", true) ;		
	static private var __URL__:Boolean = PropertyFactory.create(URLRequest, "url", true) ;	
	static private var __USE_CODE_PAGE__:Boolean = PropertyFactory.create(URLRequest, "useCodePage", true) ;
	
	/**
	 * Private Properties
	 */
	
	private var _aRequestHeaders:Array ;
	private var _bUseCodePage:Boolean ;	
	private var _oData ;
	private var _sContentType:String ;
	private var _sMethod:String ;
	private var _sURL:String ;
	
}