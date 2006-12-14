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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** AbstractTextArea

	AUTHOR

		Name : AbstractTextArea
		Package : lunas.display.components.text
		Version : 1.0.0.0
		Date :  2006-02-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	PROPERTY SUMMARY

		- autoSize:Boolean

		- editable:Boolean [R/W]

		- field:TextField

		- hPosition:Number

		- label:String [R/W]

		- length:Number [Read Only]

		- maxHPosition:Number [Read Only]

		- maxVPosition:Number [Read Only]

		- multiline:Boolean [R/W]

		- vPosition:Number

	METHOD SUMMARY
		
		- getAutoSize():Boolean

		- getEditable():Boolean

		- getHTML():Boolean

		- getHPosition():Number

		- getHScrollPolicy():Number

		- getLabel():String

		- getLength():Number

		- getMaxHPosition():Number

		- getMaxVPosition():Number 

		- getMultiline():Boolean

		- getText():String

		- getVPosition():Number

		- getVScrollPolicy():Number

		- setHTML(b:Boolean):Void

		- setAutoSize(b:Boolean):Void

		- setEditable(b:Boolean):Void

		- setHPosition(n:Number)

		- setHScrollPolicy(n:Number)

		- setLabel(str:String):Void

		- setMultiline(b:Boolean):Void

		- setText(str:String):Void

		- setVPosition(n:Number)

		- setVScrollPolicy(n:Number)

		- viewLabelChanged():Void (override this method)

	IMPLEMENTS 
	
		ILabel, IEventTarget

	EVENT SUMMARY

		UIEvent

	EVENT TYPE SUMMARY

		- UIEventType.CHANGE

		- UIEventType.LABEL_CHANGE

		- UIEventType.SCROLL

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractLabel

	IMPLEMENTS
	
		ILabel

	SEE ALSO
	
		IBuilder, IStyle

**/

import asgard.display.ScrollPolicy;
import asgard.events.UIEvent;
import asgard.events.UIEventType;

import lunas.display.components.text.AbstractLabel;

import vegas.events.Delegate;

class lunas.display.components.text.AbstractTextArea extends AbstractLabel {

	// ----o Constructor

	private function AbstractTextArea() { 
		field.onChanged = Delegate.create(this, notifyChanged) ;
		field.onScroller = Delegate.create(this, notifyScroll) ;
	}

	// ----o Constants

	static public var AUTO:Number = ScrollPolicy.AUTO ;
	static public var OFF:Number = ScrollPolicy.OFF ;
	static public var ON:Number = ScrollPolicy.ON ;

	static private var __ASPF__ = _global.ASSetPropFlags(AbstractTextArea, null, 7, 7) ;

	// ----o Public Properties
	
	// public var editable:Boolean ; // [R/W]
	public var field:TextField ;
	// 	public var hPosition:Number ; // [R/W]
	// 	public var hScrollPolicy:Number ; // [R/W]
	// 	public var length:Number ; // [Read Only]
	// 	public var maxHPosition:Number ; // [Read Only]
	// 	public var maxVPosition:Number ; // [Read Only]
	// 	public var vPosition:Number ; // [R/W]
	// 	public var vScrollPolicy:Number ; // [R/W]

	// ----o Public Methods
	
	public function getEditable():Boolean {
		return _editable ;
	}

	public function getHPosition():Number {
		return field.hscroll ;
	}

	public function getHScrollPolicy():Number {
		return _hscrollPolicy ;
	}
	
	public function getLength():Number {
		return field.text.length ;
	}

	public function getMaxHPosition():Number {
		return field.maxhscroll ;
	}

	public function getMaxVPosition():Number {
		return field.maxscroll ;
	}

	public function getVPosition():Number {
		return field.scroll ;
	}

	public function getVScrollPolicy():Number {
		return _vscrollPolicy ;
	}

	public function notifyScroll():Void {
		dispatchEvent( new UIEvent (UIEventType.SCROLL) ) ;
	}

	public function setEditable(b:Boolean):Void {
		_editable = b ;
		update() ;
	}

	public function setHPosition(n:Number) {
		field.hscroll = n ;
	}

	public function setHScrollPolicy(n:Number) {
		_hscrollPolicy = ScrollPolicy.validate(n) ? n : ScrollPolicy.OFF ;
		update() ;
	}	

	public function setVPosition(n:Number) {
		field.scroll = n ;
	}	

	public function setVScrollPolicy(n:Number) {
		_vscrollPolicy = ScrollPolicy.validate(n) ? n : ScrollPolicy.OFF ;
		update() ;
	}	
		
	/* override this method !! 	
	public function viewLabelChanged():Void 
	{
		// override this method when label property change
	}
	*/
	
	// ----o Virtual Properties

	public function get editable():Boolean {
		return getEditable() ;	
	}
	
	public function set editable(b:Boolean):Void {
		setEditable(b) ;	
	}

	public function get hPosition():Number {
		return getHPosition() ;	
	}
	
	public function set hPosition(n:Number):Void {
		setHPosition(n) ;	
	}

	public function get hScrollPolicy():Number {
		return getHScrollPolicy() ;	
	}
	
	public function set hScrollPolicy(n:Number):Void {
		setHScrollPolicy(n) ;	
	}

	public function get length():Number {
		return getLength() ;	
	}

	public function get maxHPosition():Number {
		return getMaxHPosition() ;	
	}
	
	public function get maxVPosition():Number {
		return getMaxVPosition() ;	
	}

	public function get vPosition():Number {
		return getVPosition() ;	
	}
	
	public function set vPosition(n:Number):Void {
		setVPosition(n) ;	
	}

	public function get vScrollPolicy():Number {
		return getVScrollPolicy() ;	
	}
	
	public function set vScrollPolicy(n:Number):Void {
		setVScrollPolicy(n) ;	
	}

	// ----o Private Properties
	
	private var _editable:Boolean ;
	private var _hscrollPolicy:Number ;
	private var _vscrollPolicy:Number ;
	
}