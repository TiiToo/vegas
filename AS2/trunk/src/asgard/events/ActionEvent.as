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

/**	ActionEvent

	AUTHOR

		Name : ActionEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2005-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	EVENT SUMMARY

		- ActionEventType.CHANGED : "changed"
		
		- ActionEventType.CLEARED : "cleared"
		
		- ActionEventType.FINISHED  : "finished"
		
		- ActionEventType.LOOPED : "looped"
		
		- ActionEventType.PROGRESS : "progress"
		
		- ActionEventType.RESUMED  : "resumed"
		
		- ActionEventType.STARTED   : "started"
		
		- ActionEventType.STOPPED   : "stopped"

	METHODS
	
		- clone():ActionEvent

----------  */

import vegas.events.DynamicEvent;

class asgard.events.ActionEvent extends DynamicEvent {

	// ----o Constructor
	
	public function ActionEvent(type:String, target:Object){
		super(type, target) ;
	}

	// ----o Public Methods

	public function getInfo() {
		return _oInfo ;
	}

	public function clone() {
		return new ActionEvent(_type, _target) ;
	}
	
	public function setInfo( oInfo ):Void {
		_oInfo = oInfo ;	
	}
	
	// ----o Private Properties
	
	private var _oInfo ;
	
}
