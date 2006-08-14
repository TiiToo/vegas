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

package asgard.net.remoting
{
	
	import asgard.data.remoting.RecordSet ;
	import asgard.events.RemotingEvent ;
	import asgard.net.remoting.RemotingService ;
	
	import flash.net.Responder ;
	
	import vegas.core.CoreObject ;
	import vegas.events.Delegate ;

	public class RemotingServiceResponder extends CoreObject
	{
		
		// ----o Constructor
		
		public function RemotingServiceResponder( service:RemotingService, resultMethod:Function=null, faultMethod:Function=null)
		{

			
			_responder = new Responder(onResult, onStatus) ;

			if ( faultMethod == null ) 
			{
				faultMethod = service["onFault"] ;
			}
	
			if ( resultMethod == null ) 
			{
				resultMethod = service["onResult"] ;
			}
			
			_eFault = new RemotingEvent( RemotingEvent.FAULT, null) ;
			_eResult = new RemotingEvent( RemotingEvent.RESULT, null) ;
			
			_fault = new Delegate(service, faultMethod) ;
			_result = new Delegate(service, resultMethod) ;
			
		}
	
		// ----o Public Methods

		public function getMethodName():String 
		{
			return _methodName ;
		}
	
		public function getService():RemotingService
		{
			return _service ;	
		}
	
		public function onResult( data:* ):void
		{
			if (data is RecordSet) 
			{
				data.setParentService( getService() ) ;
			}
			_eResult.setResult( data.serverInfo ? new RecordSet(data) : data, _methodName ) ;
			_result.setArguments( _eResult ) ;
			_result.run() ;
		}

		public function onStatus( fault:Object ):void 
		{
			_eFault.setFault(fault, _methodName) ;
			_fault.setArguments( _eFault );
			_fault.run();
		}

		public function setMethodName(sName:String):void 
		{
			_methodName = sName ;
		}

		public function setService( service:RemotingService ):void 
		{
			_service = service ;
		}

		// ----o Private Properties
	
		private var _eFault:RemotingEvent ;
		private var _eResult:RemotingEvent ;
	
		private var _fault:Delegate ;
		private var _methodName:String ;
		private var _result:Delegate ;
	
		private var _responder:Responder ;
	
		private var _service:RemotingService ;
		
	}
}