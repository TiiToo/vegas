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
	
		- clone():Event

 	CONSTANT SUMMARY

		- ADD_ITEMS:String 
		
			"addItems"
		
		- MODEL_CHANGED:String 
			
			"modelChanged"
		
		- REMOVE_ITEMS:String
			
			"removeItems"
		
		- SORT_ITEMS:String
		
			"sortItems"
		
		- UPDATE_ALL:String
		
			"updateAll"
		
		- UPDATE_FIELD:String
		
			"updateField"
		
		- UPDATE_ITEMS:String
		
			"updateItems"
		
		- MODEL_CHANGED::String
		
			"modelChanged"
  	 
	INHERIT
	
		Event → ModelChangedEvent
		
**/

package vegas.events
{
	
	import flash.events.Event;

	public class ModelChangedEvent extends Event
	{
		
		// ----o Constructor
		
		public function ModelChangedEvent(
			type:String = ModelChangedEvent.MODEL_CHANGED, bubbles:Boolean = false, cancelable:Boolean = false
			, data:* = null, fieldName:String = null
			, firstItem:Number = null, index:Number = null, lastItem:Number = null
			, removedIDs:Array = null , removedItems:Array = null
		) {
			super(type, bubbles, cancelable);
			this.data = data ;
			this.fieldName = fieldName ;
			this.firstItem = firstItem ;
			this.index = index ;
			this.lastItem = lastItem ;
			this.removedIDs = removedIDs ;
			this.removedItems = removedItems ;
		}
		
		// ----o Constants
		
		static public const ADD_ITEMS:String = "addItems" ; 
		static public const CLEAR_ITEMS:String = "clear" ;
		static public const MODEL_CHANGED:String = "modelChanged" ;
		static public const REMOVE_ITEMS:String = "removeItems" ;
		static public const SORT_ITEMS:String = "sortItems" ;
		static public const UPDATE_ALL:String = "updateAll" ;
		static public const UPDATE_FIELD:String = "updateField" ;
		static public const UPDATE_ITEMS:String = "updateItems" ;
				
		// ----o Public Properties
	
		public var data:* = null ;
		public var fieldName:String = null ;
		public var firstItem:Number = null ;
		public var index:Number = null ;
		public var lastItem:Number = null ;
		public var removedIDs:Array = null ;
		public var removedItems:Array = null ;
			
		// ----o Public Methods
		
		/**
		 * Return a clone of the instance. 
		 */
		override public function clone():Event
		{
			return new ModelChangedEvent(
				type, bubbles, cancelable, data, fieldName
				, firstItem, index, lastItem, removedIDs, removedItems
			);
		}
		
	}
}