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

/* ---------- AbstractCoreEventDispatcher

	AUTHOR
	
		Name : AbstractCoreEventDispatcher
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-03-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addEventListener(eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void
		
		- addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void
		
		- dispatchEvent( event , [isQueue, [target, [context]]]):Event
		
		- getEventDispatcher() : EventDispatcher 

 		- getEventListeners(eventName:String) : EventListenerCollection
		
		- getGlobalEventListeners():EventListenerCollection
		
		- getRegisteredEventNames():Set
			
		- hasEventListener(eventName:String):Boolean
		
		- removeEventListener(eventName:String, listener, useCapture:Boolean ):EventListener
		
		- removeGlobalEventListener(o):EventListener

	INHERIT
	
		EventTarget

----------  */

import vegas.core.CoreObject;
import vegas.data.Set;
import vegas.events.Event;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;
import vegas.events.IEventDispatcher;

/**
 *
 * @author eKameleon
 * @version 1.0.0.0
 **/
 
class vegas.events.AbstractCoreEventDispatcher extends CoreObject implements IEventDispatcher {

	// ----o Constructor 
	
	private function AbstractCoreEventDispatcher() {
		super() ;
		_oED = getEventDispatcher() ;
	}		

	// ----o Püblic Methods
	
	public function addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void {
		_oED.addEventListener.apply(_oED, arguments) ;
	}

	public function addGlobalEventListener(listener:EventListener, priority:Number, autoRemove:Boolean):Void {
		_oED.addGlobalEventListener.apply(_oED, arguments) ;
	}		
	
	public function dispatchEvent(event, isQueue:Boolean, target, context):Event {
		return _oED.dispatchEvent.apply(_oED, arguments) ;	
	}

	public function getEventDispatcher() : EventDispatcher {
		return new EventDispatcher( this ) ;
	}

	public function getEventListeners(eventName:String):EventListenerCollection {
		return _oED.getEventListeners.apply(_oED, arguments) ;
	}

	public function getGlobalEventListeners():EventListenerCollection {
		return _oED.getGlobalEventListeners.apply(_oED, arguments) ;
	}
	
	public function getRegisteredEventNames():Set {
		return _oED.getRegisteredEventNames.apply(_oED, arguments) ;
	}
	
	public function hasEventListener(eventName:String):Boolean {
		return _oED.hasEventListener.apply(_oED, arguments) ;
	}
	
	public function removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener {
		return _oED.removeEventListener.apply(_oED, arguments) ;
	}
	
	public function removeGlobalEventListener( listener ):EventListener {
		return _oED.removeGlobalEventListener.apply(_oED, arguments) ;
	}
	
	// ----o Private Properties
	
	private var _oED:EventDispatcher ;

}