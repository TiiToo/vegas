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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events.dom
{
    import flash.events.Event;
    
    import vegas.core.CoreObject;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;
    import vegas.data.list.SortedArrayList;
    import vegas.events.EventListener;
    import vegas.util.ClassUtil;
    
	/**
     * Internal class used in the EventDispatcher to collect {@code EventListener} for a specific event type.  
     * @author eKameleon
     */
	internal class EventListenerCollection extends CoreObject implements Iterable
	{
		
	    /**
	     * Creates a new EventListenerCollection instance.
	     */
		public function EventListenerCollection()
		{
    		_listeners = new SortedArrayList() ;
			_listeners.setComparator( EventListenerComparator.getInstance() ) ;
			_listeners.setOptions( Array.NUMERIC ) ;
		}
		
	    /**
	     * Adds an {@code EventListener} in the collection 
	     * @param listener the EventListener in the collection
	     * @param autoRemove this EventListener is autoRemove when the event flow is finished.
	     * @param priority the priority value of the EventListener.
	     * @return The new size of the collection.
	     */
        public function addListener( listener:EventListener, autoRemove:Boolean, priority:uint ):uint 
		{
			var container:EventListenerContainer = new EventListenerContainer(listener) ;
			container.enableAutoRemove(autoRemove) ;
			container.setPriority(priority) ;
			_listeners.insert(container) ;
			return _listeners.size() ;
		}

	    /**
	     * Returns the iterator of this collection.
	     * @return the iterator of this collection.
	     */
		public function iterator():Iterator
		{
			return _listeners.iterator() ;
		}
	
	    /**
	     * Propagates an event in the event flow of all {@code EventListener} in this collection.
	     */
		public function propagate( e:Event ):Event 
		{
			var remove:Array = new Array() ;
			var l:uint = _listeners.size() ;
			for (var i:Number = 0 ; i<l ; i++) 
			{
				
				if (e["stop"] == EventPhase.STOP_IMMEDIATE) 
				{
				    break ;
				}
				
				var container:EventListenerContainer = _listeners.get(i) ;
			
				// handle the event to Eventlistener !!
				container.getListener().handleEvent(e) ;
				
				if (container.isAutoRemoveEnabled()) 
				{
					remove.push(container.getListener()) ;
				}
			
				if (e.isCancelled()) break ;
			
			}
			// remove all autoRemove listeners
			l = remove.length ;
			if (l > 0)
			{
				 while (--l > -1) 
				 {
				 	removeListener(remove[l]) ;
				 }
			}
			return e ;
		}

	    /**
	     * Removes an {@code EventListener} in the collection.
	     * @return the EventListenerContainer of the listener removes in the collection.
	     */
		public function removeListener( listener:* ):EventListenerContainer 
		{
			
			if (listener is EventListener) 
			{
				var it:Iterator = _listeners.iterator() ;
				while(it.hasNext()) 
				{
					var container:EventListenerContainer = it.next() ;
					if (container.getListener() == listener) 
					{
						_listeners.remove(container) ;
						return container ;
					}
				}
			}
			else if ( listener is uint ) 
			{
			
				return _listeners.removeAt( listener ) ;
			
			} 
			else if ( listener is String))  // constructorName
			{
				var it:Iterator = _listeners.iterator() ;
				var container:EventListenerContainer ;
				var constructorName:String ;
				while(it.hasNext()) 
				{
					container = it.next() ;
					constructorName = ClassUtil.getName(container) ;
					if (constructorName == listener) 
					{
						_listeners.remove(container) ;
						return container ;
					}
				}
			
			}
			return null ;
		}

import vegas.data.list.SortedArrayList;
/**
	     * Returns the number of {@code EventListener} in this collection.
	     * @return the number of {@code EventListener} in this collection.
	     */
		public function size():uint 
		{
			return _listeners.size() ;
		}
	
		private var _autoRemove:Boolean = false ;

	    private var _listeners:SortedArrayList  ;

	}
	
}