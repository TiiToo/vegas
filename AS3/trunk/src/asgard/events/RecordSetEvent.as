package asgard.events
{
	
	import asgard.data.remoting.RecordSet ;	
	import asgard.events.ModelChangedEvent;

	import flash.events.Event ;

	public class RecordSetEvent extends ModelChangedEvent
	{
		
		// ----o Constructor
		
		public function RecordSetEvent
		(
			eventName:String , rs:RecordSet = null
			, data:* = null, fieldName:String = null
			, firstItem:uint=0, index:uint=0, lastItem:uint=0
			, removedIDs:Array = null , removedItems:Array = null
			, bubbles:Boolean=false, cancelable:Boolean=false
		)
		{
			super(eventName, data, fieldName
				, firstItem, index, lastItem, removedIDs, removedItems
				, bubbles, cancelable);
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
		static public const UPDATE_ROWS:String = "updateRows" ;

		// ----o Public Methods

		override public function clone():Event
		{
			return new RecordSetEvent(eventName, getRecordSet(), data, fieldName
				, firstItem, index, lastItem, removedIDs, removedItems
				, bubbles, cancelable) ;
		}
		
		public function getRecordSet():RecordSet
		{
			return _rs ;
		}

		public function setRecordSet(rs:RecordSet):void
		{
			_rs = rs ;
		}

		// ----o Private Properties
		
		private var _rs:RecordSet ;
		

	}
}