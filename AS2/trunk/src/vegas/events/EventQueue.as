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

/* ------- 	EventQueue

	AUTHOR
	
		Name : EventQueue
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Classe utilisée par la classe !EventDispatcher (en AS3 cette classe est une classe privée)

	METHOD SUMMARY
	
		- enqueue(e:Event):Void
		
		- getQueuedEvents([eventType:String]):Queue

			return a queue with all events
			
			return queued events of a specific event name
		
		- size():Number
		
		- toString():String
	
	IMPLEMENTS

		IFormattable, IHashable

----------  */

import vegas.core.CoreObject ;
import vegas.data.iterator.Iterator;
import vegas.data.Queue;
import vegas.data.queue.LinearQueue;
import vegas.events.Event;

class vegas.events.EventQueue extends CoreObject  {

	// ----o Constructor
	
	public function EventQueue() {
		_events = new LinearQueue ;
	}

	// ----o Public Methods

    public function enqueue( e:Event ):Void {
        e.queueEvent() ;
        _events.enqueue(e);
    }

    public function getQueuedEvents():Queue {
		if (typeof(arguments[0]) == "string") {
			var q:LinearQueue = new LinearQueue ;
			var eventType:String = arguments[0] ;
			var it:Iterator = _events.iterator() ;
			while (it.hasNext()) {
				var e:Event = it.next() ;
				if (e.getType() == eventType) q.enqueue(e) ;
			}
			return q ;
		} else {
			return _events ;
		}
    }
    
	public function size():Number {
		return _events.size() ;
	}
	
	// ----o Private Properties

    private var _events:LinearQueue ;
    
}