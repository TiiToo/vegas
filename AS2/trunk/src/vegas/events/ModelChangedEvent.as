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

/**	ModelChangedEvent

	AUTHOR

		Name : ModelChangedEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR

		var ev:Event = new ModelChangedEvent(name:String, target) ;

	PROPERTY SUMMARY
	
		- data
		
		- fieldName:String
			The name of the field that was updated, or null. 
		
		- firstItem:Number
			The index of the first item that was added, changed, or removed. 
		
		- index:Number
		
		- lastItem:Number
		
		- removedIDs:Array
			An array containing the IDs of the items that were removed, or null. 
		
		- removedItems:Array
			An array containing the items that were removed from the data provider, or null. 

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
	
		BasicEvent → DynamicEvent → ModelChangedEvent
		
	IMPLEMENTS
	
		Event, ICloneable, IFormattable, IHashable

**/

import vegas.events.BasicEvent;
import vegas.events.ModelChangedEventType;
import vegas.util.serialize.Serializer;

class vegas.events.ModelChangedEvent extends BasicEvent {

	// ----o Constructor
	
	public function ModelChangedEvent( 
		name:String , target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number 
		, data, fieldName:String, firstItem:Number, index:Number, lastItem:Number, removedIDs:Array, removedItems:Array
	) {
		
		super(name || ModelChangedEventType.MODEL_CHANGED, target, context, bubbles, eventPhase, time, stop) ;
		
		data = data || null ;
		fieldName = fieldName || null ;
		firstItem = isNaN(firstItem) ? null : firstItem ;
		index = isNaN(index) ? null : index ;
		lastItem = isNaN(lastItem) ? null : lastItem ;
		removedIDs = removedIDs || null ;
		removedItems = removedItems || null ;
		
	}

	// ----o Public Properties
	
	public var data = null ;
	public var fieldName:String = null ;
	public var firstItem:Number = null ;
	public var index:Number = null ;
	public var lastItem:Number = null ;
	public var removedIDs:Array = null ;
	public var removedItems:Array = null ;

	// ----o Public Methods

	public function clone() {
		return new ModelChangedEvent(
			getType(), getTarget(), getContext(), getBubbles(), getEventPhase(), getTimeStamp(), stop,
			data, fieldName, firstItem, index, lastItem, removedIDs, removedItems
		) ;
	}

	// ----o Protected Methods
	
	/*protected*/ private function _getParams():Array {
		var ar:Array = super._getParams() ;
		ar = ar.concat( [
			Serializer.toSource(data) ,
			Serializer.toSource(fieldName) ,
			Serializer.toSource(firstItem) ,
			Serializer.toSource(index) ,
			Serializer.toSource(lastItem) ,
			Serializer.toSource(removedIDs) ,
			Serializer.toSource(removedItems) 
		] ) ;
		return ar ;
	}

}

