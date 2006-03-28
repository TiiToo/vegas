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

/** TweenEntry

	AUTHOR

		Name : TweenEntry
		Package : asgard.transitions
		Version : 1.0.0.0
		Date :  2005-09-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY

		- begin:Number
		
		- change:Number
		
		- easing:Function
		
		- finish:Number [R/W]
		
		- prevPos:Number
		
		- prop:String

	METHOD SUMMARY
	
		- clone()
		
		- getFinish():Number
		
		- getPosition(t:Number, d:Number):Number
		
		- static noEasing(t:Number, b:Number, c:Number, d:Number):Number
		
		- setFinish(n:Number):Void
		
		- setPosition(obj, value:Number):Void
		
		- toString():String
	
	IMPLEMENTS
	
		ICloneable, IFormattable, IHashable

----------------*/

import vegas.core.CoreObject ;
import vegas.core.ICloneable ;
import vegas.util.factory.PropertyFactory;

class asgard.transitions.TweenEntry extends CoreObject implements ICloneable {
	
	// ----o Constructor
	
	public function TweenEntry(p:String, e:Function, b:Number, f:Number) {
		begin = b ;
		setEasing(e) ;
		finish = f ;
		prop = p ;
	}

	// ----o Public Properties
	
	public var begin:Number ;
	public var change:Number ;
	public var easing:Function ; // [R/W]
	public var isCached:Boolean ;
	public var prevPos:Number ;
	public var prop:String ;

	// ----o Public Methods
	
	public function clone() {
		var t:TweenEntry = new TweenEntry (prop, easing, begin, finish);
		return t ;
	}

	public function getEasing():Function {
		return _easing ;	
	}

	public function getFinish():Number {
		return _finish ;
	}
	
	public function getPosition(t:Number , d:Number):Number {
		var f:Function = _easing ;
		return f( t, begin, change , d ) ;
	}
	
	static public function noEasing(t:Number, b:Number, c:Number, d:Number):Number {
		return c*t/d + b;
	}
	
	public function setEasing( e:Function ):Void {
		_easing	= e || TweenEntry.noEasing ;
	}
	
	public function setFinish(n:Number):Void {
		_finish = n ;
		var c:Number = n - begin ;
		change = isNaN(c) ? 0 : c ;
	}
	
	public function setPosition(value:Number):Number {
		prevPos = _pos ;
		_pos = value ;
		return value ;
	}
	
	public function toString():String {
		return "[TweenEntry" + (prop ? (":" + prop) : "") + "]" ;
	}

	// ----o Virtual Properties

	public function get finish():Number {
		return getFinish() ;
	}
	
	public function set finish(n:Number):Void {
		setFinish(n) ;
	}
	// ----o Virtual Properties

	static private var __EASING__:Boolean = PropertyFactory.create(TweenEntry, "easing", true) ;
	
	// ----o Private Properties

	private var _easing:Function = TweenEntry.noEasing ;
	private var _finish:Number ;
	private var _pos ;

}