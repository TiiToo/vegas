﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events.dom
{
    import vegas.core.CoreObject;
    import vegas.data.Queue;
    import vegas.data.iterator.Iterator;
    import vegas.data.queue.LinearQueue;
    
    [ExcludeClass]
    
    /**
     * Internal class used in <code class="prettyprint">vegas.events.dom.EventDispatcher</code> class to bufferize the events if no EventListener are registered with the event type of the event.
     */
	internal class EventQueue extends CoreObject
	{
		
	    /**
	     * Creates a new EventQueue instance.
	     */
		public function EventQueue()
		{
			_events = new LinearQueue() ;
		}

	    /**
	     * Enqueue an event in the buffer if no EventListener are registered in the EventListener.
	     */
    	public function enqueue( e:DomEvent ):void 
	    {
	        e.queueEvent() ;
	        _events.enqueue(e);
	    }

	    /**
	     * Returns a queue with all events bufferized.
	     * @return a queue with all events bufferized.
	     */
    	public function getQueuedEvents( ...arguments:Array ):Queue 
    	{
			if ( arguments[0] is String ) 
			{
				
				var q:LinearQueue = new LinearQueue() ;
				var eventType:String = arguments[0] ;
				var it:Iterator = _events.iterator() ;
				while (it.hasNext()) 
				{
					var e:DomEvent = it.next() ;
					if (e.getType() == eventType) 
					{
						q.enqueue(e) ;
					}
				}
				return q ;
			
			}
			else 
			{
				return _events ;
			}
	    }
	    
	    /**
         * The size of this buffer.
         */
		public function size():uint
		{
			return _events.size() ;
		}

    	/**
	     * Internal LinearQueue used by this this instance.
    	 */
    	private var _events:LinearQueue = null ;
    	
	}
}