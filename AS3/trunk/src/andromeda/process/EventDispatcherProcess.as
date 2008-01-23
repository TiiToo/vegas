/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process
{
	import flash.events.Event;
	
	import vegas.events.BasicEvent;
	import vegas.events.EventDispatcher;	

	/**
     * A process who dispatch events in the global event flow with a singleton reference of the EventDispatcher class with a specified channel.
     * @author eKameleon
     */
	public class EventDispatcherProcess extends SimpleAction 
	{

		/**
		 * Creates a new EventDispatcherProcess instance.
		 * @param event The event to dispatch.
		 * @param channel The event channel flow to dispatch the event.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function EventDispatcherProcess( event:*, channel:String=null , bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal, sChannel ) ;
			if ( event is String )
			{
				this.event = new BasicEvent( event as String ) ;	
			}
			else if ( event is Event )
			{
				this.event = event as Event ;
			}
			if ( channel != null )
			{
				this.channel = channel ;
			}
		}

		/**
		 * The channel of the global event dispatcher used in this process.
		 */
		public var channel:String = null ;
		
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
			return new EventDispatcherProcess( event , channel ) ;
		}

    	/**
	      * Run the process.
	      */
		public override function run( ...arguments:Array ):void 
		{
			notifyStarted() ;
			setRunning(true) ;
			EventDispatcher.getInstance( channel ).dispatchEvent( event ) ;
			setRunning(false) ;
			notifyFinished() ;
		}
		
	}
}

