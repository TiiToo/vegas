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

/**	RecordSet

	AUTHOR
	
		Name : RecordSet
		Package : vegas.data.iterator
		Version : 0.0.0.1 alpha
		Date :  2005-05-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var rs:RecordSet = new RecordSet( oRaw ) ;

	METHOD SUMMARY
		
		- addView(listener:EventListener):Void
		
		- clone()
		
		- iterator():Iterator
		
		- notifyChanged(ev:ModelChangedEvent):Void
		
		- removeView(listener:EventListener):Void
				
		- toString():String

	EVENT TYPE SUMMARY

		- RecordSetEvent.ADD_ITEMS:String
		
		- RecordSetEvent.CLEAR_ITEMS:String
		
		- RecordSetEvent.REMOVE_ITEMS:String
		
		- RecordSetEvent.SORT_ITEMS:String
					
		- RecordSetEvent.UPDATE_ITEMS:String

	INHERIT
	
		CoreObject → AbstractCoreEventDispatcher → AbstractModel → RecordSet

	IMPLEMENTS 
	
		IEventDispatcher, IFormattable, IHashable, IModel, EventTarget

**/

import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.iterator.RecordSetIterator;
import vegas.errors.Warning;
import vegas.events.RecordSetEvent;
import vegas.util.ArrayUtil;
import vegas.util.mvc.AbstractModel;

// TODO setDeliveryMode : see RecordSet class (macromedia in mc.remoting package).
// TODO finir la documentation
// TODO voir toute la gestion remote et local du RecordSet (finir).

/**
 * @author eKameleon
 */
class vegas.data.remoting.RecordSet extends AbstractModel implements Iterable {

	// ----o Constructor
	
	public function RecordSet( o ) {
		
		_aItems = [] ;
		_aColumnNames = [] ;
		
		if (o instanceof Array) {
			_aColumnNames = o ;
		} else {
			parse(o) ;
		}
		
		_eAdd    = new RecordSetEvent(RecordSetEvent.ADD_ITEMS, this) ;
		_eClear  = new RecordSetEvent(RecordSetEvent.CLEAR_ITEMS, this);
		_eRemove = new RecordSetEvent(RecordSetEvent.REMOVE_ITEMS, this) ;
		_eSort   = new RecordSetEvent(RecordSetEvent.SORT_ITEMS, this) ;
		_eUpdate = new RecordSetEvent(RecordSetEvent.UPDATE_ITEMS, this) ;
		
	}

	// ----o Public Properties
	
	public var serverInfo:Object ; // attached by the player
	public var serverinfo:Object ; // attached by the player
	public var serviceName:String ; 
	
	// ----o Public Methods

	public function addItem(oItem) {
		return addItemAt(size(), oItem) ; 
	}

	public function addItemAt(index:Number, oItem) {
		var l:Number = size() ;
		var b:Boolean = true ;
		
		if (index >= 0 && index < l ) {
			
			_aItems.splice(index, 0, oItem) ;
			
		} else {
			
			 if (index == l) {
			 	_aItems[index] = oItem ;	
			 } else {
			 	return null ;	
			 }
		}
		oItem.__ID__ = _id ++ ;
		_eAdd.index = index ;
		notifyChanged( _eAdd ) ;
		return oItem ;
	}

	public function checkLocal():Boolean {
		try {
			if ( isLocal()) {
				return false ;
			} else {
				throw new Warning(this + " Operation not allowed on partial recordset") ;
			}
		} catch (e:Warning) {
			trace(e.toString()) ;
			return true ;
		}
	}
	
	/**
	 * Removes all the items from a RecordSet
	 */
	public function clear():Void {
		_id = 0 ;
		_aColumnNames = new Array();
		_eClear.removedItems = _aItems.splice(0) ;
		notifyChanged(_eClear) ;
	}

	public  function contains( oItem ):Boolean {
		return ArrayUtil.contains(_aItems, oItem) ;
	}

	public function editField(index:Number, fieldName:String , value):Void {
		
		if ( checkLocal() ) return ;
		if (index<0 || index > size()) return ;
		_aItems[index][fieldName] = value ;
		
	}	

	public function filter(filter:Function, context):RecordSet {
		
		if ( checkLocal() ) {
		  return null ;
		}

		var rs:RecordSet = new RecordSet() ;
		rs.setColumnNames(_aColumnNames) ;
	
		var len:Number = size() ;
		for(var i:Number = 0; i < len ; i++) {
			var item:Object = getItemAt(i) ;
			if ((item != null) && (item != 1) && filter(item, context))	{
				rs.addItem(item);
			}
		}
		return rs ;
		
	}


	public function getColumnNames():Array {
		return _aColumnNames;
	}

	public function getItemAt(id:Number) {
		if (isEmpty() || (id < 0) || (id >= size()) ) {
			return null ;
		}
		if (isLocal()) {
			return _aItems[id] ;
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
	public function getItemID( index:Number ) {
		return _aItems[index].hashCode() ;
	}

	/**
	 * Returns the number of records in the local RecordSet.
	 */
	public function getLocalLength():Number {
		return size() ;	
	}

	/**
	 * Returns the number of records that have been downloaded from the server.
	 * The count does not include records that have been requested but not yet arrived.
	 * For local RecordSet objects, this will always return the same value as the getLocalLength method.
	 */
	public function getNumberAvailable():Number {
		return isLocal() ? size() : _recordsAvailable ; 
	}

	/**
	 * Returns the number of records available on the server. 
	 */
	public function getRemoteLength():Number {
		if( isLocal())
			return _recordsAvailable ;
		else
			return _totalCount ;
	}

	public function indexOf( oItem ):Number {
		return ArrayUtil.indexOf(_aItems, oItem) ;
	}

	public function indexOfField(fieldName:String, value):Number {
		var l:Number = _aItems.length ;
		while (--l > -1) {
			if (_aItems[l][fieldName] == value) return l ;
		}
		return -1 ;
	}

	public function isEmpty():Boolean {
		return _aItems.length == 0 ;
	}

	function isFullyPopulated():Boolean {
		return isLocal() ;
	}

	function isLocal():Boolean {
		return _recordSetID == null ;
	}

	/**
	 * Returns a new instance of RecordSetIterator for the RecordSet in use.
	 */
	public function iterator():Iterator {
		return new RecordSetIterator(this) ;
	}

	public function parse( oRaw ):Void {
		
		clear();
		
		_aColumnNames = oRaw.serverInfo.columnNames ;
		
		var aItems:Array = oRaw.serverInfo.initialData ;
		var i:Iterator = new ArrayIterator( aItems );
		while( i.hasNext()) 
		{
			var item:Object = {} ;
			var aProperties = i.next();
			var len:Number = aProperties.length ;
			for (var i:Number = 0 ; i<len ; i++) {
				var name:String = _aColumnNames[ i ];
				var value = aProperties[i] ;
				item[ name ] = value ;
			}
			_aItems.push( item );
		}
	}

	public function removeItem(oItem) {
		var index:Number = indexOf(oItem) ;
		if (index > -1) {
			return removeItemAt(index) ;
		} else {
			return null ;
		}
	}
	
	public function removeItemAt(index:Number) {
		var ret = getItemAt[index] ; 
		removeItemsAt(index, 1);
		return ret;
	}

	public function removeItemsAt(index:Number, len:Number):Array {
		var oldItems = _aItems.splice(index, len) ;
		_eRemove.firstItem = index ;
		_eRemove.lastItem = index + len - 1 ;
		_eRemove.removedItems = [].concat(oldItems) ;
		notifyChanged ( _eRemove ) ;
		return oldItems ;
	}
	
	public function removeRange(from:Number, to:Number):Array {
		if (isNaN(from)) return null ;
		return removeItemsAt(from, to - from) ;
	}
	
	/**
	 * Replaces a record in the RecordSet object at the specified index.
	 */
	public function replaceItemAt( index:Number, item:Object ):Void {
		if (index>=0 && index<=size()) {
			var tmpID = getItemID(index) ;
			_aItems[index] = item ;
			_aItems[index].__ID__ = tmpID ;
			_eUpdate.index = index ;
			notifyChanged( _eUpdate ) ;
		}
	}
	
	public function setItemIndex( oItem, index:Number):Void {
		var id:Number = indexOf(oItem) ;
		if (id == -1 || id == index) return ;
		else {
			var tmp = oItem ;
			_aItems.splice(id, 1) ;
			_aItems.splice(index, 0, tmp) ;
			_eUpdate.index = index ;
			notifyChanged( _eUpdate ) ;
		}
	}

	public function setColumnNames(ar:Array):Void {
		_aColumnNames = ar ;	
	}

	/**
	 * Returns the number of records in the RecordSet.
	 */
	public function size():Number {
		if (isLocal()) {
			return _aItems.length ;
		} else {
			return _totalCount ;
		}
	}
	
	public function sortItems(compareFunc:Function, options:Number):Void {
		if (checkLocal()) return ;
		_aItems.sort(compareFunc, options) ;
		notifyChanged(_eSort) ;
	}

	public function sortItemsBy( fieldNames , options ):Void {
		if (checkLocal()) return ;
		_aItems.sortOn( fieldNames, options ) ;
		notifyChanged(_eSort) ;
	}
	
	public function toArray():Array {
		return _aItems ;
	}

	// ----o Private Properties
	
	private var _aColumnNames : Array;
	private var _aItems : Array ;

	private var _eAdd:RecordSetEvent ;
	private var _eClear:RecordSetEvent ;
	private var _eRemove:RecordSetEvent ;
	private var _eSort:RecordSetEvent ;
	private var _eUpdate:RecordSetEvent ;

	private var _id:Number = 0 ;

	private var _recordsAvailable:Number ;
	private var _recordSetID:Number = null ;
	private var _totalCount:Number ;
	

}