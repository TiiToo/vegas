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
 * Internal class used in the EventDispatcher to collect {@code EventListener} for a specific event type.  
 * @author eKameleon
 */
if (vegas.events.EventListenerCollection == undefined) 
{

	/**
	 * Creates a new EventListenerCollection instance.
	 */
	vegas.events.EventListenerCollection = function () 
	{
		
		this._listeners = new vegas.data.list.SortedArrayList() ;
		this._listeners.setComparator(new vegas.events.EventListenerComparator()) ;
		this._listeners.setOptions(Array.NUMERIC) ;
		
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.EventListenerCollection.extend(vegas.core.CoreObject) ;
	
	/**
	 * Adds an {@code EventListener} in the collection 
	 * @param listener the EventListener in the collection
	 * @param autoRemove this EventListener is autoRemove when the event flow is finished.
	 * @param priority the priority value of the EventListener.
	 */
	vegas.events.EventListenerCollection.prototype.addListener = function ( listener /*EventListener*/, autoRemove/*Boolean*/, priority/*Number*/ ) /*Number*/ 
	{
		
		var container /*EventListenerContainer*/ = new vegas.events.EventListenerContainer(listener) ;
		
		container.enableAutoRemove(autoRemove) ;
		
		container.setPriority(priority) ;
		
		this._listeners.insert(container) ;
		
		return this._listeners.size() ;
		
	}

	/**
	 * Returns the iterator of this collection.
	 * @return the iterator of this collection.
	 */
	vegas.events.EventListenerCollection.prototype.iterator = function() /*Iterator*/ 
	{
		return this._listeners.iterator() ;
	}

	/**
	 * Propagate an event in the event flow of all {@code EventListener} in this collection.
	 */
	vegas.events.EventListenerCollection.prototype.propagate = function (e /*Event*/ ) /*Event*/ 
	{
		
		var EventPhase = vegas.events.EventPhase ;
		
		var remove /*Array*/ = new Array() ;
		
		var l /*Number*/ = this._listeners.size() ;
		
		for (var i /*Number*/ = 0 ; i<l ; i++) {
			
			if (e.stop == EventPhase.STOP_IMMEDIATE) break ;
			
			var container /*EventListenerContainer*/ = this._listeners.get(i) ;
			
			// WARN
			if(container.getListener().handleEvent != null) 
			{
				container.getListener().handleEvent(e) ;
			}
			
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
				this.removeListener(remove[l]) ;
			}
		}
		return e ;
	}

	/**
	 * Removes an {@code EventListener} in the collection.
	 * @return the EventListenerContainer of the listener removes in the collection.
	 */
	vegas.events.EventListenerCollection.prototype.removeListener = function ( listener ) /*EventListenerContainer*/ 
	{
		if ( (listener instanceof vegas.events.EventListener) || (listener.handleEvent instanceof Function) ) 
		{
			var it /*Iterator*/ = this._listeners.iterator() ;
			while(it.hasNext()) 
			{
				var container /*EventListenerContainer*/ = it.next() ;
				if (container.getListener() == listener) 
				{
					this._listeners.remove(container) ;
					return container ;
				}
			}
		} 
		else if (vegas.util.TypeUtil.typesMatch(listener, Number)) 
		{
			return this._listeners.removeAt(listener) ;
		}
		else if (vegas.util.TypeUtil.typesMatch(listener, String))
		{ 
			var it /*Iterator*/ = this._listeners.iterator() ;
			while(it.hasNext()) 
			{
				var container /*EventListenerContainer*/ = it.next() ;
				var constructorName /*String*/ = container.getConstructorName() ;
				if (constructorName == listener) 
				{
					this._listeners.remove(container) ;
					return container ;
				}
			}
		}
		return null ;
	}
	
	/**
	 * Returns the number of {@code EventListener} in this collection.
	 * @return the number of {@code EventListener} in this collection.
	 */
	vegas.events.EventListenerCollection.prototype.size = function () /*Number*/ 
	{
		return this._listeners.size() ;
	}
	
	/**
	 * @private
	 */
	vegas.events.EventListenerCollection.prototype._autoRemove /*Boolean*/ = false ;

	/**
	 * @private
	 */
    vegas.events.EventListenerCollection.prototype._listeners  /*SortedArrayList*/ = null ;

}