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

/** 	RemotingEvent

	AUTHOR

		Name : RemotingEvent
		Package : asgard.remoting
		Version : 1.0.0.0
		Date :  2005-11-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	EVENT TYPE SUMMARY
	
		- RemotingEventType.ERROR : "error"

		- RemotingEventType.FAULT : "fault"
		
		- RemotingEventType.FINISHED  : "onFinished"
		
		- RemotingEventType.PROGRESS : "onProgress"

		- RemotingEventType.RESULT : "result"
	
		- RemotingEventType.STARTED   : "onStarted"

	PROPERTY SUMMARY
	
		- code:String
		
	METHOD SUMMARY
	
		- clone()
		
		- getResults()
		
	INHERIT
	
		CoreObject > BasicEvent > DynamicEvent > RemotingEvent
		
	IMPLEMENTS
	
		Event

----------  */

import asgard.remoting.RemotingConnector;

import vegas.events.DynamicEvent ;

class asgard.events.RemotingEvent extends DynamicEvent {

	// ----o Constructor
	
	public function RemotingEvent(type:String, target:RemotingConnector){
		super(type, target) ;
	}

	// ----o Public Properties
	
	public var code:String ;
	
	public var fault:Object ;
	
	public var level:String ;
	
	public var result:Object ;
	
	// ----o Public Methods

	public function clone() {
		var re:RemotingEvent = new RemotingEvent(getType(), getTarget()) ;
		re.code = code ;
		re.fault = fault ;
		re.level = level ;
		re.result = result ;
		return re ;
	}
	
	public function getResults() {
		return RemotingConnector(getTarget()).getResults() ;	
	}
	
}
