/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process
{
    import system.events.BasicEvent;
    
    import flash.events.Event;    

    /**
     * A process who dispatch events in the global event flow with a singleton reference of the EventDispatcher class with a specified channel.
     */
    public class EventDispatcherProcess extends SimpleAction 
    {

        /**
         * Creates a new EventDispatcherProcess instance.
         * @param event The event to dispatch.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function EventDispatcherProcess( event:* = null , global:Boolean = false, channel:String = null)
        {
            super( global, channel ) ;
            if ( event is String )
            {
                this.event = new BasicEvent( event as String ) ;
            }
            else if ( event is Event )
            {
                this.event = event as Event ;
            }
        }
        
        /**
         * The event to dispatch in this process.
         */
        public var event:Event ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new EventDispatcherProcess( event , isGlobal() , channel ) ;
        }

        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
        	setRunning(true) ;
            notifyStarted() ;
            if ( event != null )
            {
                dispatchEvent( event ) ;
            }
            setRunning(false) ;
            notifyFinished() ;
        }
        
    }
}

