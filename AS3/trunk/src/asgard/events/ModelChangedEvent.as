/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.events
{
	
	import flash.events.Event;

    /**
     * @author eKameleon
     */
	public class ModelChangedEvent extends Event
	{
		
		/**
		 * Creates a new ModelChangedEvent instance.
		 */
		public function ModelChangedEvent
		(
			eventName:String=null
			, data:* = null, fieldName:String = null
			, firstItem:uint=0, index:uint=0, lastItem:uint=0
			, removedIDs:Array = null , removedItems:Array = null
			, bubbles:Boolean = false, cancelable:Boolean = false
		) {
			super(ModelChangedEvent.MODEL_CHANGED, bubbles, cancelable);
			this.eventName = eventName ;
			this.data = data ;
			this.fieldName = fieldName ;
			this.firstItem = firstItem ;
			this.index = index ;
			this.lastItem = lastItem ;
			this.removedIDs = removedIDs ;
			this.removedItems = removedItems ;
		}
		
		static public const ADD_ITEMS:String = "addItems" ; 

		static public const CLEAR_ITEMS:String = "clear" ;

		static public const MODEL_CHANGED:String = "modelChanged" ;

		static public const REMOVE_ITEMS:String = "removeItems" ;

		static public const SORT_ITEMS:String = "sortItems" ;

		static public const UPDATE_ALL:String = "updateAll" ;

		static public const UPDATE_FIELD:String = "updateField" ;

		static public const UPDATE_ITEMS:String = "updateItems" ;

		public var data:* = null ;

		public var eventName:String = null ;
		
		/**
		 * The name of the field that was updated, or null. 
		 */
		public var fieldName:String = null ;

        /**
         * The index of the first item that was added, changed, or removed. 
         */
		public var firstItem:uint = 0 ;

		public var index:uint = 0  ;

		public var lastItem:uint = 0 ;

        /**
         * An array containing the IDs of the items that were removed, or null. 
         */
		public var removedIDs:Array = null ;

        /**
         * An array containing the items that were removed from the data provider, or null. 
         */
		public var removedItems:Array = null ;
			
		/**
		 * Returns a shallow copy of this object.
		 * @return a shallow copy of this object.
		 */
		override public function clone():Event
		{
			return new ModelChangedEvent(
				eventName, data, fieldName
				, firstItem, index, lastItem, removedIDs, removedItems
				, bubbles, cancelable
			);
		}
		
	}
}