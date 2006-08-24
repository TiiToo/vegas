/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ListModel

	AUTHOR

		Name : ListModel
		Package : lunas.display.components.list
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addItem( oItem )
		
		- addItemAt( oItem, index:Number )
		
		- addModelListener(oL):Void
		
		- clear():Void
		
		- contains(oItem):Boolean
		
		- getItemAt(index:Number)
		
		- getItemByKey(key:Number)
		
		- indexOf(oItem):Number
		
		- indexOfField(fieldName:String, value):Number
		
		- isEmpty():Boolean
		
		- notifyChanged(e:IEvent):Void
		
		- removeItem(oItem)
		
		- removeItemAt(index:Number)
		
		- removeItemsAt(index:Number, len:Number):Array
		
		- removeModelListener(oL):Void
		
		- removeRange(from:Number, to:Number):Array
		
		- setItemIndex( oItem, index:Number):Void
		
		- size():Number
		
		- sortItems(compareFunc:Function, options:Number):Void
		
		- sortItemsBy( fieldNames , options ):Void
		
		- toArray():Array
		
		- toString():String
	
	EVENT SUMMARY
	
		- ModelChangedEvent
	
	EVENT TYPE SUMMARY

		- ModelChangedEventType.ADD_ITEMS:String
		
		- ModelChangedEventType.CLEAR_ITEMS:String
		
		- ModelChangedEventType.REMOVE_ITEMS:String
		
		- ModelChangedEventType.SORT_ITEMS:String
					
		- ModelChangedEventType.UPDATE_ITEMS:String

	INHERIT 
	
		CoreObject → AbstractCoreEventDispatcher → AbstractModel → ListModel

	IMPLEMENTS 
	
		IEventDispatcher, IFormattable, IHashable, IModel, EventTarget

	TODO Create a PageableModel Abstract class.

**/

import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.events.ModelChangedEvent;
import vegas.events.ModelChangedEventType;
import vegas.util.ArrayUtil;
import vegas.util.mvc.AbstractModel;

class lunas.display.components.list.ListModel extends AbstractModel implements Iterable {

	// ----o Constructor

	public function ListModel () { 
		super() ;
		_model = [] ;
	}

	// ----o Constant
	
	static public var ADD_ITEMS:String = ModelChangedEventType.ADD_ITEMS ; 
	static public var CLEAR_ITEMS:String = ModelChangedEventType.CLEAR_ITEMS ; 
	static public var REMOVE_ITEMS:String = ModelChangedEventType.REMOVE_ITEMS ; 
	static public var UPDATE_ITEMS:String = ModelChangedEventType.UPDATE_ITEMS ;

	static private var __ASPF__ = _global.ASSetPropFlags(ListModel, null , 7, 7) ;

	// ----o Public Methods
	
	public function addItem( oItem ) {
		return addItemAt(oItem, size()) ; 
	}
	
	public function addItemAt(oItem, index:Number) {
		var l:Number = size() ;
		if (index < 0) return null ;
		else if (index > l) return null ;
		else {
			_model.splice(index, 0, oItem) ;
			var ev:ModelChangedEvent = new ModelChangedEvent(ModelChangedEventType.ADD_ITEMS, this) ;
			ev.index = index ;
			notifyChanged( ev ) ;
			return oItem ;
		}
	}
	
	public function clear():Void {
		var e:ModelChangedEvent = new ModelChangedEvent(ModelChangedEventType.CLEAR_ITEMS, this);
		e.removedItems = _model.splice(0) ;
		notifyChanged(e) ;
	}
	
	public  function contains( oItem ):Boolean {
		return ArrayUtil.contains(_model, oItem) ;
	}

	public function editField(index:Number, fieldName:String, newData):Void {
		_model.getItemAt(index)[fieldName] = newData ;
		var ev:ModelChangedEvent = new ModelChangedEvent(ModelChangedEventType.UPDATE_FIELD, this) ;
		ev.index = index ;
		ev.fieldName = fieldName ;
		ev.data = newData ;
		notifyChanged ( ev ) ;
	}

	public function getItemAt(index:Number) {
		return _model[index] ;
	}
	
	public function getItemByKey(key:Number) {
		var l:Number = size() ;
		while (--l > -1) {
			if (_model[l].__KEY == key) return _model[l] ;
		}
		return null ;
	}
	
	public function indexOf( oItem ):Number {
		return ArrayUtil.indexOf(_model, oItem) ;
	}
	
	public function indexOfField(fieldName:String, value):Number {
		var l:Number = _model.length ;
		while (--l > -1) {
			if (_model[l][fieldName] == value) return l ;
		}
		return -1 ;
	}
	
	public function isEmpty():Boolean {
		return (!_model.length > 0) ;
	}
	
	public function iterator():Iterator {
		return new ArrayIterator(_model) ;
	}
	
	public function removeItem( oItem ) {
		var index:Number = indexOf(oItem) ;
		if (index > -1) {
			return removeItemAt(index) ;
		} else {
			return null ;
		}
	}
	
	public function removeItemAt(index:Number) {
		var ret = getItemAt(index) ; 
		removeItemsAt(index, 1);
		return ret;
	}
	
	public function removeItemsAt(index:Number, len:Number):Array {
		var oldItems = _model.splice(index, len) ;
		var ev:ModelChangedEvent = new ModelChangedEvent(ModelChangedEventType.REMOVE_ITEMS, this) ;
		ev.firstItem = index ;
		ev.lastItem = index + len - 1 ;
		ev.removedItems = [].concat(oldItems) ;
		notifyChanged ( ev ) ;
		return oldItems ;
	}
	
	public function removeRange(from:Number, to:Number):Array {
		if (from == undefined) return null ;
		return removeItemsAt(from, to - from) ;
	}
	
	public function setItemIndex( oItem, index:Number):Void {
		var id:Number = indexOf(oItem) ;
		if (id == -1 || id == index) return ;
		else {
			var tmp = oItem ;
			_model.splice(id, 1) ;
			_model.splice(index, 0, tmp) ;
			notifyChanged(new ModelChangedEvent(ModelChangedEventType.UPDATE_ITEMS, this)) ;
		}
	}
	
	public function size():Number {
		return _model.length ;
	}

	public function sortItems(compareFunc:Function, options:Number):Void {
		_model.sort(compareFunc, options) ;
		notifyChanged(new ModelChangedEvent(ModelChangedEventType.SORT_ITEMS, this)) ;
	}

	public function sortItemsBy( fieldNames , options ):Void {
		_model.sortOn( fieldNames, options ) ;
		notifyChanged(new ModelChangedEvent(ModelChangedEventType.SORT_ITEMS, this)) ;
	}
		
	public function toArray():Array {
		return [].concat(_model) ;
	}
	
	// ----o Private Properties

	private var _model:Array ;

}