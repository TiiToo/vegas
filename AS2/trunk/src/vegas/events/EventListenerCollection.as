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

/**	EventListenerCollection

	AUTHOR
	
		Name : EventListenerCollection
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addListener( listener:EventListener, autoRemove:Boolean, priority:Number ):Number 
		
		- iterator():Iterator
		
		- propagate(e:Event):Event
		
		- removeListener( o ):EventListenerContainer
		
		- toString():String
	
	IMPLEMENTS
	
		CoreObject → EventListenerCollection
	
	IMPLEMENTS 
	
		IFormattable, IHashable, Iterable
	
	CHANGE    : 2005-11-12 change propagate method
	CHANGE    : 2006-01-19 use TypeUtil class.
	ADD       : 2006-01-22 use EventPhase.STOP_IMMEDIATE in propagate method
	
	TODO : optimiser les itérations
	
**/

import vegas.core.CoreObject;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.list.SortedArrayList;
import vegas.events.Event;
import vegas.events.EventListener;
import vegas.events.EventListenerComparator;
import vegas.events.EventListenerContainer;
import vegas.events.EventPhase;
import vegas.util.ConstructorUtil;
import vegas.util.TypeUtil;

class vegas.events.EventListenerCollection extends CoreObject implements Iterable {

	// ----o Constructor
	
	public function EventListenerCollection() {
		_listeners = new SortedArrayList() ;
		_listeners.setComparator(new EventListenerComparator()) ;
		_listeners.setOptions(Array.NUMERIC) ;
	}
	
	// ----o Public Methods
    
	public function addListener( listener:EventListener, autoRemove:Boolean, priority:Number ):Number {
		var container:EventListenerContainer = new EventListenerContainer(listener) ;
		container.enableAutoRemove(autoRemove) ;
		container.setPriority(priority) ;
		_listeners.insert(container) ;
		return _listeners.size() ;
	}

	public function iterator():Iterator {
		return _listeners.iterator() ;
	}
	
	public function propagate(e:Event):Event {
		var remove:Array = new Array() ;
		var l:Number = _listeners.size() ;
		for (var i:Number = 0 ; i<l ; i++) {
			if (e["stop"] == EventPhase.STOP_IMMEDIATE) break ;
			var container:EventListenerContainer = _listeners.get(i) ;
			container.getListener().handleEvent(e) ;
			if (container.isAutoRemoveEnabled()) {
				remove.push(container.getListener()) ;
			}
			if (e.isCancelled()) break ;
		}
		// remove all autoRemove listeners
		l = remove.length ;
		if (l > 0) while (--l > -1) removeListener(remove[l]) ;
		return e ;
	}

	public function removeListener( listener ):EventListenerContainer {
		if (listener instanceof EventListener) { // EventListener
			
			var it:Iterator = _listeners.iterator() ;
			while(it.hasNext()) {
				var container:EventListenerContainer = it.next() ;
				if (container.getListener() == listener) {
					_listeners.remove(container) ;
					return container ;
				}
			}
			
		} else if (TypeUtil.typesMatch(listener, Number)) {
			
			return _listeners.removeAt(listener) ;
			
		} else if (TypeUtil.typesMatch(listener, String)) { // constructorName
		 
			var it:Iterator = _listeners.iterator() ;
			while(it.hasNext()) {
				var container:EventListenerContainer = it.next() ;
				var constructorName:String = ConstructorUtil.getName(container) ;
				if (constructorName == listener) {
					_listeners.remove(container) ;
					return container ;
				}
			}
			
		}
		return null ;
	}
	
	// ----o Private Properties

	private var _autoRemove:Boolean = false ;
    private var _listeners:SortedArrayList  ;

}