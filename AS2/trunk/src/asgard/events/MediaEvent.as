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

/**	MediaEvent

	AUTHOR

		Name : MediaEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-05-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	EVENT SUMMARY

		- MediaEventType.onMediaFinishedEVENT:String
		
		- MediaEventType.onMediaProgressEVENT:String
		
		- MediaEventType.onMediaResumedEVENT:String
		
		- MediaEventType.onMediaStartedEVENT:String
		
		- MediaEventType.onMediaStoppedEVENT:String

	METHOD SUMMARY
	
		- getInfo()
	
		- clone():ActionEvent

		- setInfo(oInfo):Void
		
	INHERIT
	
		CoreObject → BasicEvent → DynamicEvent → ActionEvent → MediaEvent
		
	IMPLEMENTS
	
		Event, IFormattable, IHashable

----------  */

import asgard.events.ActionEvent ;

class asgard.events.MediaEvent extends ActionEvent {

	// ----o Constructor
	
	public function MediaEvent(type:String, target:Object){
		super(type, target) ;
	}

	// ----o Public Methods

	public function clone() {
		return new MediaEvent(getType(), getTarget()) ;
	}

}
