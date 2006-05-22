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

/** EventListenerProxy

	AUTHOR
	
		Name : EventListenerProxy
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-10-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		- new EventListenerProxy( myObject , myFunction:Function ) ;
		- new EventListenerProxy( myObject , myFunction:String ) ;

	METHOD SUMMARY
	
		- addArguments():Void
		
		- clone():Delegate
		
		- static create(scope, medthod):Function
		
			PARAMS
			
				- scope 
				
					an object
				
				- method
				
					a function or a string
		
		- getArguments():Array
		
		- getMethod():Function
		
		- getScope():Object
		
		- handleEvent(e:Event)
		
		- run():Void
		
		- setArguments():Void
		
		- toString():String
	
	INHERIT
	
		CoreObject → Delegate → EventListenerProxy
	
	IMPLEMENTS
	
		ICloneable, EventListener, IRunnable, IFormattable, IHashable

	SEE ALSO
	
		Event

**/

import vegas.events.Delegate;
import vegas.events.Event;
import vegas.util.TypeUtil;

class vegas.events.EventListenerProxy extends Delegate {

	// ----o Constructor
	
	public function EventListenerProxy(scope , method) {
		this.__proto__.__constructor__.apply(this, [].concat(arguments)) ;
	}

	// ----o Public Methods
  
	/*override*/ public function clone() {
		return new EventListenerProxy(getScope(), getMethod()) ;
	}
  
	/*override*/ public function handleEvent(e:Event) { 
		if (_m instanceof Function) {
			super.handleEvent(e) ;
		} else if (TypeUtil.typesMatch(_m, String)) {
			var f:Function = _s[_m] ;
			if (f) return f.apply(_s || null, [e].concat(_a)) ;
		}
    }
  
	// ----o Private Properties
	
	private var _m ;
  
}