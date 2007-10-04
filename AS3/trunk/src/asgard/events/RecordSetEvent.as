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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.events
{
	
	import asgard.data.remoting.RecordSet;
	
	import flash.events.Event;
	
	import vegas.events.ModelChangedEvent;
	
	/**
	 * The RecordSetEvent class.
	 * @author eKameleon
	 */
	public class RecordSetEvent extends ModelChangedEvent
	{
		
		/**
		 * Creates a new RecordSetEvent instance.
		 */
		public function RecordSetEvent
		( 
			eventName:String , rs:RecordSet = null, data:* = null, fieldName:String = null , firstItem:uint=0, index:uint=0, lastItem:uint=0
			, removedIDs:Array = null , removedItems:Array = null, bubbles:Boolean=false, cancelable:Boolean=false
		)
		{
			super(eventName, data, fieldName, firstItem, index, lastItem, removedIDs, removedItems, bubbles, cancelable);
			if ( rs != null )
			{
				setRecordSet(rs) ;
			}
		}
		
		static public const ADD_ITEMS:String = "addItems" ; 

		static public const CLEAR_ITEMS:String = "clear" ;

		static public const MODEL_CHANGED:String = "modelChanged" ;

		static public const REMOVE_ITEMS:String = "removeItems" ;

		static public const SORT_ITEMS:String = "sortItems" ;

		static public const UPDATE_ALL:String = "updateAll" ;

		static public const UPDATE_FIELD:String = "updateField" ;

		static public const UPDATE_ITEMS:String = "updateItems" ;

		static public const UPDATE_ROWS:String = "updateRows" ;

        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
		override public function clone():Event
		{
			return new RecordSetEvent(eventName, getRecordSet(), data, fieldName
				, firstItem, index, lastItem, removedIDs, removedItems
				, bubbles, cancelable) ;
		}
		
		/**
		 * Returns the RecordSet reference of this event.
		 * @return the RecordSet reference of this event.
		 */
		public function getRecordSet():RecordSet
		{
			return _rs ;
		}

		/**
		 * Sets the RecordSet reference of this event.
		 */
		public function setRecordSet(rs:RecordSet):void
		{
			_rs = rs ;
		}

		private var _rs:RecordSet ;

	}
}