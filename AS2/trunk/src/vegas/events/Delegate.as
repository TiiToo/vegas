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

/** Delegate

	AUTHOR

		Name : Delegate
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new Delegate(scope, method:Function) ;

	METHOD SUMMARY
	
		- addArguments():Void
		
		- clone():Delegate
		
		- static create(scope, medthod):Function
		
		- getArguments():Array
		
		- getMethod():Function
		
		- getScope():Object
		
		- handleEvent(e:Event)
		
		- run():Void
		
		- setArguments():Void
		
		- toString():String

	INHERIT
	
		CoreObject → Delegate

	IMPLEMENTS
	
		EventListener, ICloneable, IFormattable, IHashable, IRunnable

	SEE ALSO
	
		Event

**/

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IRunnable;
import vegas.events.Event;
import vegas.events.EventListener;

class vegas.events.Delegate extends CoreObject implements ICloneable, EventListener, IRunnable {

	// ----o Constructor
	
	public function Delegate(scope, method:Function) {
		_s = scope ;
		_m = method ;
		_a = arguments.splice(2) ;
		_p = Function( Delegate.create.apply(this, [_s].concat([_m], _a) ) );
	}

	// ----o Public Methods

	public function addArguments():Void {
		if (arguments.length > 0) {
			_a = _a.concat(arguments) ;
			_p.a = _a ;
		}
	}
	
	public function clone() {
		return new Delegate(getScope(), getMethod()) ;
	}

	static public function create(scope, method:Function):Function {
		var f:Function = function() {	
			var o = arguments.callee ;
			var s = o.s ;
			var m = o.m ;
			var a = arguments.concat(o.a) ;
			return m.apply(s, a) ;
		} ;
		f.s = scope ;
		f.m = method ;
		f.a = arguments.splice(2);
		return f;
	}	
	
	public function getArguments():Array {
		return _a ;
	}

	public function getMethod():Function {
		return _m ;
	}
	
	public function getScope() {
		return _s ;
	}
	
	public function handleEvent(e:Event) {
		return _m.apply(_s, [e].concat(_a));
	}

	public function run():Void {
		addArguments.apply(this, arguments) ;
		_p() ;
	}

	public function setArguments():Void {
		if (arguments.length > 0) {
			_a = [].concat(arguments) ;
			_p.a = _a ;
		}
	}

	// ----o Private Properties
	
	private var _m:Function ; // method
	private var _s:Object ; // scope
	private var _a:Array ; // arguments
	private var _p:Function; // proxy

}