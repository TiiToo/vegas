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

/* AbstractAction

	AUTHOR
	
		Name : Action
		Package : asgard.process
		Version : 1.0.0.0
		Date :  2005-07-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- looping:Boolean
		
		- running:Boolean [Read Only]

	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void
		
		- clone() 
		
			override this method
		
		- getEventDispatcher():EventDispatcher
		
		- notifyChanged():Void
		
		- notifyCleared():Void
		
		- notifyFinished():Void 
		
		- notifyProgress():Void
		
		- notifyLooped():Void
		
		- notifyResumed():Void
		
		- notifyStarted():Void
		
		- notifyStopped():Void
		
		- removeEventListener(eventName:String, listener):EventListener
		
		- run():Void
		
			override this method
		
		- toSource():String
		
			override this method
		
		- toString():String

	EVENT
	
		ActionEvent

	EVENT TYPE SUMMARY
	
		- ActionEventType.CHANGE
		
		- ActionEventType.CLEAR
		
		- ActionEventType.FINISH
		
		- ActionEventType.LOOP
		
		- ActionEventType.PROGRESS
		
		- ActionEventType.RESUME
		
		- ActionEventType.START
		
		- ActionEventType.STOP

	INHERIT
	
		CoreObject → AbstractCoreEventDispatcher → AbstractAction

	IMPLEMENTS
	
		Action, ICloneable, IRunnable, IFormattable
	
*/

import asgard.events.ActionEvent;
import asgard.events.ActionEventType;
import asgard.process.Action;

import vegas.core.ICloneable;
import vegas.core.ISerializable;
import vegas.events.AbstractCoreEventDispatcher;

class asgard.process.AbstractAction extends AbstractCoreEventDispatcher implements Action, ICloneable, ISerializable {
	
	// ----o Constructor
	
	private function AbstractAction() {
		
		_eChange = new ActionEvent(ActionEventType.CHANGE, this) ;
		_eClear = new ActionEvent(ActionEventType.CLEAR, this) ;
		_eFinish = new ActionEvent(ActionEventType.FINISH, this) ;
		_eInfo = new ActionEvent(ActionEventType.INFO, this) ;
		_eLoop = new ActionEvent(ActionEventType.LOOP, this) ;
		_eProgress = new ActionEvent(ActionEventType.PROGRESS, this) ;
		_eResume = new ActionEvent(ActionEventType.RESUME, this) ;
		_eStart = new ActionEvent(ActionEventType.START, this) ;
		_eStop = new ActionEvent(ActionEventType.STOP, this) ;
		
	}
	
	// ----o Public Properties
	
	public var looping:Boolean ;
	// public var running:Boolean ; // [Read Only]
	
	// ----o Public Methods
	
	public function clone() {
		//
	}

	public function getRunning():Boolean {
		return _isRunning ;	
	}

	public function notifyChanged():Void {
		dispatchEvent(_eChange) ;
	}

	public function notifyCleared():Void {
		dispatchEvent(_eClear) ;
	}	

	public function notifyFinished():Void {
		dispatchEvent(_eFinish) ;
	}
	
	public function notifyInfo( oInfo ):Void {
		dispatchEvent(_eInfo) ;
	}
	
	public function notifyLooped():Void {
		dispatchEvent(_eLoop) ;
	}

	public function notifyProgress():Void {
		dispatchEvent(_eProgress) ;
	}
	
	public function notifyResumed():Void {
		dispatchEvent(_eResume) ;
	}
	
	public function notifyStarted():Void {
		dispatchEvent(_eStart) ;
	}
	
	public function notifyStopped():Void {
		dispatchEvent(_eStop) ;
	}
		
	public function run():Void {
		// 
	}

	public function toSource(indent:Number, indentor:String):String {
		return null ;
	}

	// ----o Virtual Properties
	
	public function get running():Boolean {
		return getRunning() ;	
	}
	
	// ----o Private Properties
	
	private var _eChange:ActionEvent ;
	private var _eClear:ActionEvent ;
	private var _eFinish:ActionEvent ;
	private var _eInfo:ActionEvent ;
	private var _eLoop:ActionEvent ;
	private var _eProgress:ActionEvent ;
	private var _eResume:ActionEvent ;
	private var _eStart:ActionEvent ;
	private var _eStop:ActionEvent ;
	
	private var _isRunning:Boolean ;

	// ----o Private Methods
	
	/*protected*/ private function _setRunning(b:Boolean):Void {
		_isRunning = b ;	
	}

}
