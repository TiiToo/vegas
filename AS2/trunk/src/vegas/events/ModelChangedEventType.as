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

/**
 * Enumeration of all basic event names in the ModelChangedEvent.
 * @author eKameleon
 */
class vegas.events.ModelChangedEventType 
{

	/**
	 * The type of a ModelChangedEvent when an item is added in this model.
	 */
	public static var ADD_ITEMS:String = "addItems" ; 

	/**
	 * The type of a ModelChangedEvent when clear all items in the model.
	 */
	public static var CLEAR_ITEMS:String = "clear" ;

	/**
	 * The type of a ModelChangedEvent when the model is changed.
	 */
	public static var MODEL_CHANGED:String = "modelChanged" ;

	/**
	 * The type of a ModelChangedEvent when an item is removed in this model.
	 */
	public static var REMOVE_ITEMS:String = "removeItems" ;

	/**
	 * The type of a ModelChangedEvent when the model is sorted.
	 */
	public static var SORT_ITEMS:String = "sortItems" ;

	/**
	 * The type of a ModelChangedEvent when all is update in the model.
	 */
	public static var UPDATE_ALL:String = "updateAll" ;

	/**
	 * The type of a ModelChangedEvent when a field in the model is updated.
	 */
	public static var UPDATE_FIELD:String = "updateField" ;

	/**
	 * The type of a ModelChangedEvent when an item in the model changed.
	 */
	public static var UPDATE_ITEMS:String = "updateItems" ;
	
	
	private static var __ASPF__ = _global["ASSetPropFlags"](ModelChangedEventType, null , 7, 7) ;
	
}
