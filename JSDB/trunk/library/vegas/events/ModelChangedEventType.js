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
 * Enumeration of all basic event names in the ModelChangedEvent.
 * @author eKameleon
 */
if (vegas.events.ModelChangedEventType == undefined) 
{
	
	/**
	 * Creates the ModelChangedEventType singleton.
	 */
	vegas.events.ModelChangedEventType = {} ;

	/**
	 * The type of a ModelChangedEvent when an item is added in this model.
	 */
	vegas.events.ModelChangedEventType.ADD_ITEMS /*String*/ = "addItems" ;

	/**
	 * The type of a ModelChangedEvent when clear all items in the model.
	 */
	vegas.events.ModelChangedEventType.CLEAR_ITEMS /*String*/ = "clear" ;

	/**
	 * The type of a ModelChangedEvent when the model is changed.
	 */
	vegas.events.ModelChangedEventType.MODEL_CHANGED /*String*/ = "modelChanged" ;

	/**
	 * The type of a ModelChangedEvent when an item is removed in this model.
	 */
	vegas.events.ModelChangedEventType.REMOVE_ITEMS /*String*/ = "removeItems" ;

	/**
	 * The type of a ModelChangedEvent when the model is sorted.
	 */
	vegas.events.ModelChangedEventType.SORT_ITEMS /*String*/ = "sortItems" ;

	/**
	 * The type of a ModelChangedEvent when all is update in the model.
	 */
	vegas.events.ModelChangedEventType.UPDATE_ALL /*String*/ = "updateAll" ;

	/**
	 * The type of a ModelChangedEvent when a field in the model is updated.
	 */
	vegas.events.ModelChangedEventType.UPDATE_FIELD /*String*/ = "updateField" ;

	/**
	 * The type of a ModelChangedEvent when an item in the model changed.
	 */
	vegas.events.ModelChangedEventType.UPDATE_ITEMS /*String*/ = "updateItems" ;

}