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

/* ------- 	ModelChangedEvent

	AUTHOR

		Name : ModelChangedEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR

		ModelChangedEvent(name:String, target:Object)

	PROPERTY SUMMARY

		- bubbles:Boolean [R/W]
		
		- context [R/W]
		
		- eventName:String 
			The name (sub-type) of the event; one of MODEL_CHANGED, ADD_IDTEMS, REMOVE_ITEMS, SORT, UPDATE_ALL, UPDATE_FIELD, or UPDATE_ITEMS. 
		
		- eventPhase:Number [R/W]
		
		- fieldName:String 
			The name of the field that was updated, or null. 
		
		- firstItem:Number 
			The index of the first item that was added, changed, or removed. 
		
		- lastItem:Number 
			The index of the last item that was added changed or removed. 
		
		- removedIDs:Array 
			An array containing the IDs of the items that were removed, or null. 
		
		- removedItems:Array 
			An array containing the items that were removed from the data provider, or null. 
		
		- target [R/W]
		
		- time:Number [Read Only]
		
		- type:String [R/W]

	METHOD SUMMARY
	
		- cancel():Void
		
		- clone():BasicEvent
		
		- getBubbles():Boolean
		
		- getContext():Object
		
		- getCurrentTarget():Object
		
		- getEventPhase():Number
		
		- getTarget():Object
		
		- getTime():Number
		
		- getType():String
		
		- isCancelled():Boolean
		
		- isQueued():Boolean
		
		- queueEvent():Void
		
		- setBubbles(b:Boolean):Void
		
		- setContext(context:Object):Void
		
		- setCurrentTarget(target):Void
		
		- setEventPhase(n:Number):Void
		
		- setTarget(target:Object):Void
		
		- setType(type:String):Void
		
		- stopImmediatePropagation()
		
		- toString():String

	EVENTS SUMMARY

		- ADD_ITEMS:String = "addItems" ; 
		
		- MODEL_CHANGED:String = "modelChanged" ;
		
		- REMOVE_ITEMS:String = "removeItems" ;
		
		- SORT:String = "sort" ;
		
		- UPDATE_ALL:String = "updateAll" ;
		
		- UPDATE_FIELD:String = "updateField" ;
		
		- UPDATE_ITEMS:String = "updateItems" ;

	INHERIT
	
		Object > BasicEvent > DynamicEvent > ModelChangedEvent

	IMPLEMENTS
	
		Event
		
	SEE ALSO
	
		ModelChangedEventType

----------  */

import vegas.events.BasicEvent;
import vegas.events.ModelChangedEventType;

class vegas.events.ModelChangedEvent extends BasicEvent {

	// ----o Constructor
	
	public function ModelChangedEvent(name:String, target:Object) {
		super(name || ModelChangedEventType.MODEL_CHANGED , target) ;
		trace("ok : " + name);
	}

	// ----o Public Properties
	
	public var data ;
	public var fieldName:String = null ;
	public var firstItem:Number = null ;
	public var index:Number = null ;
	public var lastItem:Number = null ;
	public var removedIDs:Array = null ;
	public var removedItems:Array = null ;

	// ----o Public Methods

	public function clone() {
		return new ModelChangedEvent(getType(), getTarget()) ;
	}

}
