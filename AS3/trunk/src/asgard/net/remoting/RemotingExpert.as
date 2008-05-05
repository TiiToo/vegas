/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net.remoting 
{
    import flash.errors.IllegalOperationError;
    
    import asgard.net.remoting.RemotingService;
    
    import vegas.core.CoreObject;
    import vegas.core.IRunnable;    

    /**
     * The RemotingExpert is a command who initialize a RemotingService before run it.
     * @author eKameleon
     */
    public class RemotingExpert extends CoreObject implements IRunnable
    {
		
		/**
		 * Creates a new <code class="prettyprint">RemotingExpert</code> instance.
		 * @param service The <code class="prettyprint">RemotingService</code> reference of this expert.
		 * @param serviceName The name of the service to run.
		 * @param methodName The name of the method of the service to run.
		 * @param params The <code class="prettyprint">Array</code> representation of all arguments passed-in the server-side service method.
		 */
		public function RemotingExpert( service:RemotingService=null , serviceName:String=null , methodName:String=null , params:Array=null , resultEventType:String=null , faultEventType:String=null )
		{
			this.service         = service ;
			this.serviceName     = serviceName ;
			this.methodName      = methodName ;
			this.params          = params ;
			this.resultEventType = resultEventType ;
			this.faultEventType  = resultEventType ;
		}
		
		/**
		 * The gateway url value of the service.
		 */
		public var gatewayUrl:String ;
		
		/**
		 * The event type of the event invoked in the RemotingService instance when a result event is dispatched.
		 */
		public var faultEventType:String ;
				
		/**
		 * The method name of the service to run.
		 */
		public var methodName:String ;

		/**
		 * The Array representation of all arguments passed-in the server-side service method.
		 */
		public var params:Array ;
		
		/**
		 * The event type of the event invoked in the RemotingService instance when a result event is dispatched.
		 */
		public var resultEventType:String ;
		
		/**
		 * The RemotingService reference of this expert.
		 */
		public var service:RemotingService ;

		/**
		 * The service name to run.
		 */
		public var serviceName:String ;
		
		/**
		 * Initialize the expert.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */
		public function initialize( init:Object = null ):void
		{
		    if ( init != null && init is Object )
        	{
        		for (var prop:String in arguments[0] )
        		{
        			this[prop] = arguments[0] ;
        		}
        	}	
		}
		
		/**
		 * Runs the service.
		 * @throws flash.errors.IllegalOperationError if the <code class="prettyprint">RemotingService</code> reference not must be 'null' or 'undefined.
		 */
        public function run(...arguments:Array):void
        {	
        	initialize( arguments[0] ) ;
        	if ( service != null )
        	{	
        		
        		service.setEventTypeFAULT  ( faultEventType  ) ;
        		service.setEventTypeRESULT ( resultEventType ) ;
        		
        		if ( gatewayUrl != null )
        		{
        			service.gatewayUrl = gatewayUrl ;	
        		}
        		if ( serviceName != null )
        		{
        			service.serviceName = serviceName ;
        		}
        		if ( methodName != null )
        		{
        			service.methodName = methodName ;
        		}
        		service.trigger() ;	
        	}
        	else
        	{
        		throw new IllegalOperationError( this + " run failed, the RemotingService reference not must be 'null' or 'undefined." ) ;	
            }
        }
    }
}
