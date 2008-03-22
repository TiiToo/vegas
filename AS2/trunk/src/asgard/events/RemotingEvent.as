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

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * The RemotingEvent class.
 * @author eKameleon
 */
class asgard.events.RemotingEvent extends DynamicEvent 
{

	/**
	 * Creates a new RemotingEvent instance.
	 */
	public function RemotingEvent(type:String, target, oResult, oFault, sMethodName:String, sCode:String, sLevel:String, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number )
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		code = sCode || null ;
		level = sLevel || null ;
		setResult(oResult) ;
		setFault(oFault) ;
		if (sMethodName) setMethodName(sMethodName) ; 
	}
	
	/**
	 * The RemotingEvent type when notify an error message.
	 */
	public static var ERROR:String = "onError" ;	

	/**
	 * The RemotingEvent type when notify an fault message.
	 */
	public static var FAULT:String = "onFault" ;

	/**
	 * The RemotingEvent type when notify the end of the process.
	 */
	public static var FINISH:String = "onFinished" ;

	/**
	 * The RemotingEvent type when notify the process is in progress.
	 */
	public static var PROGRESS:String = "onProgress" ;

	/**
	 * The RemotingEvent type when notify the result of the process.
	 */
	public static var RESULT:String = "onResult" ;
	
	/**
	 * The RemotingEvent type when notify the start of the process.
	 */
	public static var START:String = "onStarted" ;

	/**
	 * The RemotingEvent type when the process is out of time.
	 */
	public static var TIMEOUT:String = "onTimeOut" ;

	/**
	 * @private
	 */
	private static var __ASPF__ = _global.ASSetPropFlags(RemotingEvent, null , 7, 7) ;

	/**
	 * The optional error code of the process.
	 */
	public var code:String ;

	/**
	 * The optional fault object of the process.
	 */
	public function get fault() 
	{
		return getFault() ;	
	}
	
	/**
	 * @private
	 */
	public function set fault(oFault):Void 
	{
		setFault(oFault) ;	
	}

	/**
	 * The optional error level of the process.
	 */
	public var level:String ;

	/**
	 * The optional result object of the process.
	 */
	public function get result() 
	{
		return getResult() ;	
	}
	
	/**
	 * @private
	 */
	public function set result(oResult):Void 
	{
		setResult(oResult) ;	
	}
	
	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	public function clone() 
	{
		var e:RemotingEvent = new RemotingEvent(getType(), getTarget()) ;
		e.code = code ;
		e.setFault(getFault()) ;
		e.level = level ;
		e.setResult( getResult() ) ;
		e.setMethodName(getMethodName()) ;
		return e ;
	}

	/**
	 * Returns the optional error code of the process.
	 * @return the optional error code of the process.
	 */
	public function getCode():String 
	{
		return _sCode ;
	}

	/**
	 * Returns the optional description value of the process.
	 * @return the optional description value of the process.
	 */
	public function getDescription():String 
	{
		return _sDescription ;
	}

	/**
	 * Returns the optional detail value of the process.
	 * @return the optional detail value of the process.
	 */
	public function getDetail():String 
	{
		return _sDetail ;
	}

	/**
	 * Returns the optional exception stack value of the process.
	 * @return the optional exception stack value of the process.
	 */
	public function getExceptionStack():String 
	{
		return _sExceptionStack ;
	}

	/**
	 * Returns the optional fault value of the process.
	 * @return the optional fault value of the process.
	 */
	public function getFault() 
	{
		return _fault ;
	}

	/**
	 * Returns the optional level value of the process.
	 * @return the optional level value of the process.
	 */
	public function getLevel():String 
	{
		return _sLevel ;
	}

	/**
	 * Returns the optional line value of the process.
	 * @return the optional line value of the process.
	 */
	public function getLine():String 
	{
		return _sLine ;
	}

	/**
	 * Returns the optional method name value of the process.
	 * @return the optional method name value of the process.
	 */
	public function getMethodName():String 
	{
		return _sMethodName || target.getMethodName() || null ;
	}

	/**
	 * Returns the optional result value of the process.
	 * @return the optional result value of the process.
	 */
	public function getResult() 
	{
		return _result ;	
	}

	/**
	 * Returns the optional result value of the process.
	 * @return the optional result value of the process.
	 */
	public function getResults() 
	{
		return _result ;	
	}
	
	/**
	 * Sets the fault object of the remoting process.
	 */
	public function setFault( oFault , methodName:String):Void 
	{
		_fault = oFault || null ;	
		if (_fault != null) {
			_sCode = oFault.code || null ;
			_sDetail = oFault.details || null ;
			_sDescription = oFault.description || null ;
			_sExceptionStack = oFault.exceptionStack || null ;
			_sLevel = oFault.level || null ;
			_sLine = oFault.line || null ;
		}
		if (methodName) setMethodName( methodName ) ;
	}
	
	/**
	 * Sets the name of the remoting service's method.
	 */
	public function setMethodName( methodName:String ):Void 
	{
		_sMethodName = methodName || null  ;	
	}
	
	/**
	 * Sets the result of the remoting process.
	 */
	public function setResult( oResult , sMethodName:String ):Void 
	{
		_result = oResult ;
		if (sMethodName) 
		{
			setMethodName( sMethodName ) ;
		}
	}		
	
	/**
	 * @private
	 */
	private var _fault ;
	
	/**
	 * @private
	 */
	private var _result ;	
	
	/**
	 * @private
	 */	
	private var _sCode:String ;
	
	/**
	 * @private
	 */
	private var _sDescription:String ;
		
	/**
	 * @private
	 */
	private var _sDetail : String ;
	
	/**
	 * @private
	 */
	private var _sExceptionStack:String ;
	
	/**
	 * @private
	 */
	private var _sLevel:String ;

	/**
	 * @private
	 */
	 private var _sLine:String ;
	
	/**
	 * @private
	 */
	 private var _sMethodName:String ;
	
	/**
	 * @private
	 */
	/*protected*/ function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(_result)) ;
		ar.splice(3, null, Serializer.toSource(_fault)) ;
		ar.splice(4, null, Serializer.toSource(_sMethodName)) ;
		ar.splice(5, null, Serializer.toSource(code)) ;
		ar.splice(6, null, Serializer.toSource(level)) ;
		return ar ;
	}

}
