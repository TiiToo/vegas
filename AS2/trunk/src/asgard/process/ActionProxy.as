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

/* ---------- ActionProxy

	AUTHOR

		Name : ActionProxy
		Package : asgard.process
		Version : 1.0.0.0
		Date :  2005-06-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTIES
	
		- args:Array
		
		- func:Function
		
		- obj:Object

	METHODS
	
		- addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void
		
		- clone():Pause
		
		- notifyFinished():Void 
		
		- notifyStarted():Void 
		
		- removeEventListener(eventName:String, listener):EventListener
		
		- run():Void
		
		- toString():String

	EVENTS
	
		- ActionEventType.FINISHED
		
		- ActionEventType.STARTED

	INHERIT
	
		CoreObject > AbstractCoreEventDispatcher > AbstractAction > ActionProxy

	IMPLEMENTS
	
		Action, ICloneable, IRunnable

----------  */

import vegas.events.Delegate ;

import asgard.process.AbstractAction ;

class asgard.process.ActionProxy extends AbstractAction {

	// ----o Constructor
	
	public function ActionProxy(o:Object, f:Function) {
		obj = o ;
		func = f ;
		args = arguments.splice(2) ;
	}

	// ----o Public Properties
	
	public var args:Array ;
	public var func:Function ;
	public var obj:Object ;
	
	// ----o Public Methods
	
	public function clone() {
		var p:ActionProxy = new ActionProxy(obj, func);
		p.args = args ;
		return p ;
	}
	
	public function run():Void {
		notifyStarted() ;
		Delegate.create.apply(this, [obj, func].concat(args)) ();
		notifyFinished() ;
	}

}

