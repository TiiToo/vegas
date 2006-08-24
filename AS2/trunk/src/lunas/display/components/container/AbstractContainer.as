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

/** AbstractComponent

	AUTHOR

		Name : AbstractContainer
		Package : lunas.display.components.container
		Version : 1.0.0.0
		Date :  2006-02-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- addChild( oChild )
		
		- addChildAt( oChild, index:Number )
		
		- clear():Void
		
		- contains(oChild):Boolean
		
		- getChildAt(index:Number)
		
		- getChildByKey(key:Number)
		
		- getChildByName(name:String)
		
		- iterator():Iterator
		
		- indexOf(oChild):Number
		
		- removeChild(oChild):Void
		
		- removeChildAt(index:Number):Void
		
		- removeChildsAt(index:Number, len:Number):Void
		
		- removeRange(from:Number, to:Number):Void
		
		- setChildIndex( oChild, index:Number):Void
		
		- size():Number
		
		- toString():String
	
	EVENT SUMMARY

		UIEvent
		
	EVENT TYPE SUMMARY
	
		- ADDED:UIEventType
		
		- REMOVED:UIEventType

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractContainer

	IMPLEMENTS
	
		IContainer, IHashable, Iterable

**/

import lunas.display.components.AbstractComponent;
import lunas.display.components.container.ContainerModel;
import lunas.display.components.IContainer;

import vegas.core.HashCode;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.util.factory.DisplayFactory;
import vegas.util.mvc.IController;
import vegas.util.mvc.IView;

class lunas.display.components.container.AbstractContainer extends AbstractComponent implements IContainer, Iterable {

	// ----o Constructor

	private function AbstractContainer () { 
		_createContainer() ;
		_oModel = new ContainerModel() ;
	}

	// ----o Public Methods
	
	public function addChild( o , oInit) {
		return addChildAt( o, size(), oInit) ;
	}
	
	public function addChildAt(o, index:Number, oInit) {
		var c:MovieClip = DisplayFactory.createChild( o , "child" + HashCode.nextName(), index, _mcContainer, oInit) ;
		HashCode.identify(c) ;
		notifyAdded(c, index) ;
		_oModel.addChildAt(c, index) ;     
		return c ;
	}
	
	public function clear():Void {
		_oModel.clear() ;
	}
	
	public  function contains( oChild ):Boolean {
		return _oModel.contains(oChild) ;
	}
	
	public function getChildAt(index:Number) {
		return _oModel.getChildAt(index) ;
	}
	
	public function getChildByKey(key:Number) {
		return _oModel.getChildByKey(key) ;
	}
	
	public function getChildByName(name:String) {
		return _oModel.getChildByName(name) ;
	}
		
	public function iterator():Iterator {
		return _oModel.iterator() ;
	}

	public function indexOf( oChild ):Number {
		return _oModel.indexOf(oChild) ;
	}

	public function removeChild( oChild ):Void {
		removeChild(oChild) ;
	}
	
	public function removeChildAt(index:Number):Void {
		if (getChildAt(index)) {
			removeChildsAt(index, 1) ;
		}
	}

	public function removeChildsAt(index:Number, len:Number):Void {
		_oModel.removeChildsAt(index, len) ;
		notifyRemoved() ;
	}
	
	public function removeRange(from:Number, to:Number):Void {
		_oModel.removeRange(from, to) ;
		notifyRemoved() ;
	}

	public function setChildIndex( oChild, index:Number):Void {
		_oModel.setChildIndex(oChild, index) ;
	}
	
	public function size():Number {
		return _oModel.size() ;
	}
	
	// ----o Private Properties

	private var _mcContainer:MovieClip ;
	private var _oController:IController ;
	private var _oModel:ContainerModel ;
	private var _oView:IView ;
	
	// ----o Private Methods

	public function _createContainer():Void {
		if (_mcContainer == undefined) {
			createEmptyMovieClip("_mcContainer", 50) ;
		}
	}	
	
}