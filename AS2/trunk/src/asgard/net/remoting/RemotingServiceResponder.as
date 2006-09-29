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

/** RemotingServiceResponder

	AUTHOR

		Name : RemotingServiceResponder
		Package : asgard.net.remoting
		Version : 1.0.0.0
		Date :  2006-05-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- getMethodName():String
		
		- getService()

		- onResult( oResult ):Void
		
		- onStatus( oFault:Object ):Void
		
		- setMethodName(sName:String):Void

		- setService( service )

**/

import asgard.data.remoting.RecordSet;
import asgard.events.RemotingEvent;

import vegas.core.CoreObject;
import vegas.events.Delegate;

/**
 * @author eKameleon
 */
class asgard.net.remoting.RemotingServiceResponder extends CoreObject 
{
	
	// ----o Constructor
	
	public function RemotingServiceResponder( scope, resultMethod:Function, faultMethod:Function) 
	{
		
		super();
		
		if (!faultMethod) faultMethod = scope["onFault"] ;
		if (!resultMethod) resultMethod = scope["onResult"] ;
		
		_eFault = new RemotingEvent( RemotingEvent.FAULT, null) ;
		_eResult = new RemotingEvent( RemotingEvent.RESULT, null) ;
		
		_fault = new Delegate(scope, faultMethod) ;
		_result = new Delegate(scope, resultMethod) ;
		
	}
	
	// ----o Public Methods

	public function getMethodName():String 
	{
		return _methodName ;
	}
	
	public function getService() 
	{
		return _service ;	
	}
	
	public function onResult( oResult ):Void 
	{
		if (oResult instanceof RecordSet) 
		{
			oResult.setParentService( getService() ) ;
		}
		_eResult.setResult( oResult, _methodName ) ;
		_result.setArguments( _eResult ) ;
		_result.run() ;
	}

	public function onStatus( oFault:Object ):Void 
	{
		_eFault.setFault(oFault, _methodName) ;
		_fault.setArguments( _eFault );
		_fault.run();
	}

	public function setMethodName(sName:String):Void 
	{
		_methodName = sName ;
	}

	public function setService( service ) 
	{
		_service = service ;
	}

	// ----o Private Properties
	
	private var _eFault:RemotingEvent ;
	private var _eResult:RemotingEvent ;
	
	private var _fault:Delegate ;
	private var _methodName:String ;
	private var _result:Delegate ;
	
	private var _service ;
	
}