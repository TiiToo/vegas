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
 * This event is used with some models.
 * @author eKameleon
 */
if (vegas.events.ModelChangedEvent == undefined) 
{

	/**
	 * Creates a new ModelChangedEvent instance.
	 * @param type the string type of the instance. 
	 * @param target the target of the event.
	 */	
	vegas.events.ModelChangedEvent = function(type/*String*/, target/*Object*/) 
	{
		vegas.events.DynamicEvent.call( this, type || vegas.events.ModelChangedEventType.MODEL_CHANGED, target) ;
	}
	
	/**
	 * @extends vegas.events.DynamicEvent
	 */
	proto = vegas.events.ModelChangedEvent.extend( vegas.events.DynamicEvent ) ;
 
 	/**
	 * The type of a ModelChangedEvent when an item is added in this model.
	 */
	vegas.events.ModelChangedEvent.ADD_ITEMS /*String*/ = "addItems" ; 

	/**
	 * The type of a ModelChangedEvent when clear all items in the model.
	 */
	vegas.events.ModelChangedEvent.CLEAR_ITEMS /*String*/ = "clear" ;

	/**
	 * The type of a ModelChangedEvent when the model is changed.
	 */
	vegas.events.ModelChangedEvent.MODEL_CHANGED /*String*/ = "modelChanged" ;

	/**
	 * The type of a ModelChangedEvent when an item is removed in this model.
	 */
	vegas.events.ModelChangedEvent.REMOVE_ITEMS /*String*/ = "removeItems" ;

	/**
	 * The type of a ModelChangedEvent when the model is sorted.
	 */
	vegas.events.ModelChangedEvent.SORT_ITEMS /*String*/ = "sortItems" ;

	/**
	 * The type of a ModelChangedEvent when all is update in the model.
	 */
	vegas.events.ModelChangedEvent.UPDATE_ALL /*String*/ = "updateAll" ;

	/**
	 * The type of a ModelChangedEvent when a field in the model is updated.
	 */
	vegas.events.ModelChangedEvent.UPDATE_FIELD /*String*/ = "updateField" ;

	/**
	 * The type of a ModelChangedEvent when an item in the model changed.
	 */
	vegas.events.ModelChangedEvent.UPDATE_ITEMS /*String*/ = "updateItems" ;
 
 	/**
	 * The data of this event.
	 */
	proto.data = null ;
	
	/**
	 * The name of the field that was updated, or null. 
	 */
	proto.fieldName /*String*/ = null ;
	
	/**
	 * The index of the first item that was added, changed, or removed. 
	 */
	proto.firstItem /*Number*/ = null ;
	
	/**
	 * The index of the item of this event.
	 */
	proto.index /*Number*/ = null ;
	
	/**
	 * The lastItem value of this event.
	 */	
	proto.lastItem /*Number*/ = null ;
	
	/**
	 * An array containing the IDs of the items that were removed, or null. 
	 */
	proto.removedIDs /*Array*/ = null ;
	
	/**
	 * An array containing the items that were removed from the data provider, or null. 
	 */
	proto.removedItems /*Array*/ = null ;
 
	/**
	 * Returns a shallow copy of this instance.
	 * @return a shallow copy of this instance.
	 */
	proto.clone = function () {
		var e /*ModelChangedEvent*/ = new vegas.events.ModelChangedEvent(this.getType() , this.getTarget()) ;
		e.data = this.data || null ;
		e.fieldName = this.fieldName || null ;
		e.firstItem = isNaN(this.firstItem) ? null : this.firstItem ;
		e.index = isNaN(this.index) ? null : this.index ;
		e.lastItem = isNaN(this.lastItem) ? null : this.lastItem ;
		e.removedIDs = this.removedIDs || null ;
		e.removedItems = this.removedItems || null ;
		return e ;
	}
	
	delete proto ;

}
