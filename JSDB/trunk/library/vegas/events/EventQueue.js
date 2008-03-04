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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Internal class used in {@code EventDispatcher} class to bufferize the events if no EventListener are registered with the event type of the event.
 */
if (vegas.events.EventQueue == undefined) 
{

	/**
	 * Creates a new EventQueue instance.
	 */
	vegas.events.EventQueue = function ( container /*EventListenerContainer*/ ) 
	{
		this._events = new vegas.data.queue.LinearQueue() ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.EventQueue.extend(vegas.core.CoreObject) ;
	
	/**
	 * Enqueue an event in the buffer if no EventListener are registered in the EventListener.
	 */
	vegas.events.EventQueue.prototype.enqueue = function ( e/*Event*/ ) /*Void*/ 
	{
        e.queueEvent() ;
        this._events.enqueue(e) ;
    }

	/**
	 * Returns a queue with all events bufferized.
	 * @return a queue with all events bufferized.
	 */
    vegas.events.EventQueue.prototype.getQueuedEvents = function () /*Queue*/ 
    {
		if (vegas.util.TypeUtil.typesMatch(arguments[0], String)) 
		{
			var q /*LinearQueue*/ = new vegas.data.queue.LinearQueue() ;
			var eventType /*String*/ = arguments[0] ;
			var it /*Iterator*/ = this._events.iterator() ;
			while (it.hasNext()) 
			{
				var e /*Event*/ = it.next() ;
				if (e.getType() == eventType) q.enqueue(e) ;
			}
			return q ;
		} 
		else 
		{
			return this._events ;
		}
    }
    
    /**
     * The size of this buffer.
     */
	vegas.events.EventQueue.prototype.size = function () /*Number*/ 
	{
		return this._events.size() ;
	}

	vegas.events.EventQueue.prototype._events /*LinearQueue*/ = null ;

}