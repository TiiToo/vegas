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

package asgard.data.remoting
{
	import asgard.data.iterator.RecordSetIterator;
	import asgard.events.RecordSetEvent;
	import asgard.net.NetServerConnection;
	import asgard.net.remoting.RemotingService;
	
	import vegas.data.iterator.Iterable;
	import vegas.data.iterator.Iterator;
	import vegas.errors.Warning;
	import vegas.util.mvc.AbstractModel;
	
	public class RecordSet extends AbstractModel implements Iterable
	{
		
		// ----o Constructor
		
		public function RecordSet( o:* = null )
		{
	
			_eAdd    = new RecordSetEvent(RecordSetEvent.ADD_ITEMS) ;
			_eClear  = new RecordSetEvent(RecordSetEvent.CLEAR_ITEMS);
			_eRemove = new RecordSetEvent(RecordSetEvent.REMOVE_ITEMS) ;
			_eSort   = new RecordSetEvent(RecordSetEvent.SORT_ITEMS) ;
			_eUpdate = new RecordSetEvent(RecordSetEvent.UPDATE_ITEMS) ;
		
			_items = [] ;
			mTiles = [] ;
	
			if (o != null) 
			{
		
				if (o is Array) 
				{
					mTiles = o ;
				}
				else 
				{
					parse(o) ;
				}		
			}
			
			// Use with AMF serialization - see serverInfo read-write property !

		}

		// ----o Public Properties
	
		public var numRows:uint ;
		public var serviceName:String ; 
		
		// ----o Public Methods

		public function addItem(oItem:*):*
		{
			return addItemAt(size(), oItem) ; 
		}

		public function addItemAt(index:uint, oItem:*):*
		{

			var l:uint = size() ;
			var b:Boolean = true ;
			
			if (index >= 0 && index < l ) 
			{
				
				_items.splice(index, 0, oItem) ;
				
			}
			else 
			{
				
				 if (index == l) 
				 {
				 	_items[index] = oItem ;	
				 }
				 else 
				 {
				 	return null ;	
				 }
			}
			
			oItem.__ID__ = _id ++ ;
			_eAdd.index = index ;
	
			notifyChanged( _eAdd ) ;
	
			return oItem ;
	
		}
	
		public function checkLocal():Boolean 
		{
			try 
			{
				if ( isLocal()) 
				{
					return false ;
				}
				else 
				{
					throw new Warning(this + " Operation not allowed on partial recordset") ;
				}
			}
			catch (e:Warning) 
			{
				trace(e.toString()) ;
				return true ;
			}
			return false ;
		}

		/**
		 * Removes all the items from a RecordSet
		 */
		public function clear():void {
			_id = 0 ;
			mTiles = new Array();
			_eClear.removedItems = _items.splice(0) ;
			notifyChanged(_eClear) ;
		}
	
		public  function contains( oItem:* ):Boolean 
		{
			return _items.indexOf(oItem) > -1 ;
		}

		public function editField(index:uint, fieldName:String , value:*):void 
		{
		
			if ( checkLocal() ) return ;
			if (index<0 || index > size()) return ;
			_items[index][fieldName] = value ;
		
		}	

		public function filter(filter:Function, context:*):RecordSet 
		{
		
			if ( checkLocal() ) {
			  return null ;
			}

			var rs:RecordSet = new RecordSet() ;
			rs.setColumnNames(mTiles) ;
	
			var len:uint = size() ;
			for(var i:uint = 0; i < len ; i++) 
			{
				var item:* = getItemAt(i) ;
				if ((item != null) && (item != 1) && filter( item, context ))	
				{
					rs.addItem(item);
				}
			}
			return rs ;
		
		}


		public function getColumnNames():Array 
		{
			return mTiles ;
		}

		public function getItemAt(id:uint):* 
		{
			if (isEmpty() || (id < 0) || (id >= size()) ) 
			{
				return null ;
			}
			if (isLocal()) 
			{
				return _items[id] ;
			}
		}


		/**
		 * Returns a unique ID corresponding to the record, at the specified index.
		 * The RecordSet object assigns each record a unique ID. The ID is not part 
		 * of the record; it is a separate item that is associated with the record
		 * internally within the RecordSet object. Unlike a record index, its ID will
		 * not change when the RecordSet object is sorted or when records are added or
		 * deleted. When a record is deleted, its ID is retired and will never be used
		 * again in this RecordSet object.
		 */
		public function getItemID( index:uint ):*
		{
			return _items[index].hashCode() ;
		}

		/**
		 * Returns the number of records in the local RecordSet.
		 */
		public function getLocalLength():uint 
		{
			return size() ;	
		}

		public function getLength():uint 
		{
			return size() ;	
		}

		/**
		 * Returns the number of records that have been downloaded from the server.
		 * The count does not include records that have been requested but not yet arrived.
		 * For local RecordSet objects, this will always return the same value as the getLocalLength method.
		 */
		public function getNumberAvailable():uint 
		{
			return isLocal() ? size() : mRecordsAvailable ; 
		}

		/**
		 * Returns the number of records available on the server. 
		 */
		public function getRemoteLength():uint 
		{
			if( isLocal())
			{
				return mRecordsAvailable ;
			}
			else
			{
				return mTotalCount ;
			}
		}

		public function indexOf( oItem:* ):int 
		{
			return _items.indexOf(oItem) ;
		}

		public function indexOfField(fieldName:String, value:*):int 
		{
			var l:Number = _items.length ;
			while (--l > -1) 
			{
				if (_items[l][fieldName] == value) return l ;
			}
			return -1 ;
		}

		public function isEmpty():Boolean {
		return _items.length == 0 ;
	}

		public function isFullyPopulated():Boolean {
			return isLocal() ;
		}

		public function isLocal():Boolean {
			return mRecordSetID == null ;
		}

		/**
		 * Returns a new instance of RecordSetIterator for the RecordSet in use.
		 */
		public function iterator():Iterator
		{
			return new RecordSetIterator(this) ;
		}

		public function parse( oRaw:* ):void 
		{
		
			clear();
		
			mTiles = oRaw.serverInfo.columnNames ;
		
			mRecordsAvailable = 0 ;
			
			// implémenter setData ici !
			// setData((serverInfo.cursor == null) ? 0 : (serverInfo.cursor - 1), serverInfo.initialData);
			
			var aItems:Array = oRaw.serverInfo.initialData ;
			
			
			var l:Number = aItems.length ;
			for (var i:Number = 0 ; i<l ; i++) 
			{
				var item:Object = {} ;
				var aProperties:Array = aItems[i] ;
				var count:Number = aProperties.length ;
				for (var j:Number = 0 ; j<count ; j++) 
				{
					item[ mTiles[ j ] ] = aProperties[j] ;
				}
				_items.push( item );
			}
			
			serverInfo = null ;
		
		}

		static public function register():void
		{
		
			RemotingService.registerClassAlias(RecordSet, "RecordSet") ;	
		
		}

		public function removeItem(oItem:*):*
		{
			var index:Number = indexOf(oItem) ;
			if (index > -1) 
			{
				return removeItemAt(index) ;
			}
			else 
			{
				return null ;
			}
		}
	
		public function removeItemAt(index:Number):* 
		{
			var ret:* = getItemAt(index) ; 
			removeItemsAt(index, 1);
			return ret;
		}

		public function removeItemsAt(index:uint, len:uint):Array 
		{
			var oldItems:* = _items.splice(index, len) ;
			_eRemove.firstItem = index ;
			_eRemove.lastItem = index + len - 1 ;
			_eRemove.removedItems = [].concat(oldItems) ;
			notifyChanged ( _eRemove ) ;
			return oldItems ;
		}
	
		public function removeRange(from:uint=0, to:uint=0):Array 
		{
			if (isNaN(from)) return null ;
			return removeItemsAt(from, to - from) ;
		}
	
		/**
		 * Replaces a record in the RecordSet object at the specified index.
		 */
		public function replaceItemAt( index:uint, item:* ):void
		{
			if (index>=0 && index<=size()) 
			{
				var tmpID:* = getItemID(index) ;
				_items[index] = item ;
				_items[index].__ID__ = tmpID ;
				_eUpdate.index = index ;
				notifyChanged( _eUpdate ) ;
			}
		}
	
		public function setItemIndex( oItem:*, index:Number):void 
		{
			var id:int = indexOf(oItem) ;
			if (id == -1 || id == index) {
				return ;
			}
			else 
			{
				var tmp:* = oItem ;
				_items.splice(id, 1) ;
				_items.splice(index, 0, tmp) ;
				_eUpdate.index = index ;
				notifyChanged( _eUpdate ) ;
			}
		}

		public function setColumnNames(ar:Array):void 
		{
			mTiles = ar ;	
		}

		public function setParentService( service:RemotingService ):void 
		{
			_nc = service.getConnection() ;
		}

		/**
		 * Returns the number of records in the RecordSet.
		 */
		public function size():uint
		{
			if (isLocal()) {
				return _items.length ;
			} else {
				return mTotalCount ;
			}
		}

		public function sortItems(compareFunc:Function, options:Number):void 
		{
			if (checkLocal()) return ;
			_items.sort(compareFunc, options) ;
			notifyChanged(_eSort) ;
		}

		public function sortItemsBy( fieldNames:* , options:* ):void
		{
			if (checkLocal()) return ;
			_items.sortOn( fieldNames, options ) ;
			notifyChanged(_eSort) ;
		}
	
		public function toArray():Array 
		{
			return _items ;
		}

		// ----o Virtual Properties

		public function get columnNames():Array 
		{
			return getColumnNames() ;
		}

		public function set columnNames(ar:Array):void
		{
			setColumnNames(ar) ;
		}


		public function get items():Array 
		{
			return _items ;
		}

		public function get length():Number 
		{
			return getLength() ;
		}
		
		public function get serverInfo():Object
		{
		
			return _serverInfo  ;	
		
		}

		public function set serverInfo( oInfo:Object ):void
		{
		
			_serverInfo = oInfo ;	
			if (_serverInfo != null) 
			{
				parse(this) ;
			}
		
		}

		public function get serverinfo():Object
		{
		
			return _serverInfo  ;	
		
		}

		public function set serverinfo( oInfo:Object ):void
		{
		
			serverInfo( oInfo ) ;
		
		}

		// ----o Private Properties
	
		private var mTiles : Array;
		private var _items : Array ;
	
		private var _eAdd:RecordSetEvent = null ;
		private var _eClear:RecordSetEvent = null ;
		private var _eRemove:RecordSetEvent = null ;
		private var _eSort:RecordSetEvent = null ;
		private var _eUpdate:RecordSetEvent = null ;
	
		private var _id:Number = 0 ;
	
		// -- server-associated RecordSet only
		
		private var mDeliveryMode:String;	
		private var mRecordsAvailable:uint ;
		private var mRecordSetID:* = null ;
		private var mRecordSetService:RemotingService ;
		private var mTotalCount:Number ;
	
		// -- only if deliverymode = "page"
		
		private var mPageSize:Number;
		private var mNumPrefetchPages:Number;
		private var mAllNotified:Boolean;
		private var mOutstandingRecordCount:Number;
	
		private var _nc:NetServerConnection ;
		
		private var _serverInfo:Object ;
		
	}
		
}


