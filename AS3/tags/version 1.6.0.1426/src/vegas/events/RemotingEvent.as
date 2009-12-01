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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events
{
    import system.events.BasicEvent;
    
    import flash.events.Event;
    
    /**
     * The RemotingEvent class.
     * @param type the string type of the instance. 
     * @param target the target of the event.
     * @param context the optional context object of the event.
     * @param bubbles indicates if the event is a bubbling event.
     * @param cancelable indicates if the event is a cancelable event.
     * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
     */
    public class RemotingEvent extends BasicEvent
    {
        /**
         * Creates a new RemotingEvent instance.
         * @param type the string type of the instance.
         * @param target the target of the event.
         * @param result The result value of the service.
         * @param fault The fault value object of the service.
         * @param methodName The name of the method of the service.
         * @param code The error code value.
         * @param level The error level value.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function RemotingEvent( type:String , target:Object = null , result:* = null , fault:* = null, methodName:String = null, code:String = null, level:String = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super( type, target, context, bubbles, cancelable, time );
            this.code       = code ;
            this.level      = level ;
            this.methodName = methodName ;
            setResult( result ) ;
            setFault( fault ) ;
        }
        
        /**
         * Defines the 'error' remoting event type. 
         */
        public static const ERROR:String = "error" ;
        
        /**
         * Defines the 'fault' remoting event type. 
         */
        public static const FAULT:String = "fault" ;
        
        /**
         * Defines the 'result' remoting event type. 
         */
        public static const RESULT:String = "result" ;
        
        /**
         * Indicates the code value of the server side error.
         */
        public var code:String ;
        
        /**
         * Indicates the description value of the server side error.
         */
        public var description:String ;
        
        /**
         * Indicates the details value of the server side error.
         */
        public var details:String ;
        
        /**
         * Indicates the exception stack value of the server side error.
         */
        public var exceptionStack:String ;
        
        /**
         * Indicates the fault value of the service.
         */
        public function get fault():* 
        {
            return _fault ;
        }
        
        /**
         * Indicates the level value of the server side error.
         */
        public var level:String ; 
        
        /**
         * Indicates the line value of the server side error.
         */
        public var line:String ; 
        
        /**
         * Indicates the name of the method of the service.
         */
        public var methodName:String ; 
        
        /**
         * Indicates the result value of the service.
         */
        public function get result():*
        {
            return _result ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new RemotingEvent( type , target, _result, _fault, methodName, code, level, context ) ;
        }
        
        /**
         * Sets the fault object of the remoting service result.
         */
        public function setFault( fault:* = null , methodName:String=null):void 
        {
            _fault = fault || null ;
            if (_fault != null) 
            {
                code           = ( "code"           in _fault ) ? _fault.code           : null ;
                details        = ( "details"        in _fault ) ? _fault.details        : null ;
                description    = ( "description"    in _fault ) ? _fault.description    : null ;
                exceptionStack = ( "exceptionStack" in _fault ) ? _fault.exceptionStack : null ;
                level          = ( "level" in _fault ) ? _fault.level : null ;
                line           = ( "line" in _fault ) ? _fault.exceptionStack : null ;
            }
            if (methodName != null ) 
            {
                this.methodName = methodName ;
            }
        }
        
        /**
         * Sets the result value of the service.
         */
        public function setResult( result:* = null , methodName:String = null ):void
        {
            _result = result ;
            if (methodName != null)
            {
                this.methodName = methodName ;
            } 
        }
        
        /**
         * @private
         */
        private var _fault:* ;
        
        /**
         * @private
         */
        private var _result:* ;
    }

}