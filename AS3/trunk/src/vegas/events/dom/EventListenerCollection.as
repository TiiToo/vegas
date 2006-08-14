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

/*	EventListenerCollection

	AUTHOR
	
		Name : EventListenerCollection
		Package : vegas.events.dom
		Version : 1.0.0.0
		Date :  2006-07-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addListener( listener:EventListener, autoRemove:Boolean, priority:Number ):Number 
		
		- hashCode():uint
		
		- iterator():Iterator
		
		- propagate(e:IEvent):IEvent
		
		- removeListener( listener:* ):EventListenerContainer
		
		- size():uint
		
		- toSource(...arguments:Array):String
		
		- toString():String
	
	IMPLEMENTS
	
		CoreObject → EventListenerCollection
	
	IMPLEMENTS 
	
		IFormattable, IHashable, ISerializable, Iterable
	
*/

package vegas.events.dom
{
	import vegas.core.CoreObject;
	import vegas.data.iterator.Iterable;
	import vegas.data.list.SortedArrayList ;
	import vegas.util.ClassUtil ;
	
	internal class EventListenerCollection extends CoreObject implements Iterable
	{
		
		// ----o Constructor
		
		public function EventListenerCollection()
		{
			super() ;
			_listeners = new SortedArrayList() ;
			_listeners.setComparator( new EventListenerComparator() ) ;
			_listeners.setOptions( Array.NUMERIC ) ;
		}
		
		// ----o Public Methods
	
		public function addListener( listener:EventListener, autoRemove:Boolean, priority:uint ):uint 
		{
			
			var container:EventListenerContainer = new EventListenerContainer(listener) ;
			container.enableAutoRemove(autoRemove) ;
			container.setPriority(priority) ;
			
			_listeners.insert(container) ;
			
			return _listeners.size() ;
			
		}
		
		public function iterator():Iterator
		{
			return _listeners.iterator() ;
		}
	
		public function propagate(e:IEvent):IEvent 
		{
			var remove:Array = new Array() ;
			var l:uint = _listeners.size() ;
			for (var i:Number = 0 ; i<l ; i++) 
			{
				
				if (e["stop"] == EventPhase.STOP_IMMEDIATE) break ;
				
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

		public function removeListener( listener:* ):EventListenerContainer {
			
			if (listener is EventListener) 
			{
			
				var it:Iterator = _listeners.iterator() ;
				while(it.hasNext()) {
					var container:EventListenerContainer = it.next() ;
					if (container.getListener() == listener) {
						_listeners.remove(container) ;
						return container ;
					}
				}
			}
			else if ( listener is uint ) 
			{
			
				return _listeners.removeAt(listener) ;
			
			} 
			else if ( listener is String))  // constructorName
			{
				var it:Iterator = _listeners.iterator() ;
				var container:EventListenerContainer ;
				var constructorName:String ;
				while(it.hasNext()) {
					container = it.next() ;
					constructorName = ClassUtil.getName(container) ;
					if (constructorName == listener) {
						_listeners.remove(container) ;
						return container ;
					}
				}
			
			}
			return null ;
		}
	
		public function size():uint 
		{
			return _listeners.size() ;
		}
	
		// ----o Private Properties
	
		private var _autoRemove:Boolean = false ;
	    private var _listeners:SortedArrayList  ;

	}
	
}