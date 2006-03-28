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

/** UIEvent

	AUTHOR

		Name : UIEvent
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-02-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new UIEvent(type:String, target, context) ;

	PROPERTY SUMMARY

		- child
		
		- index:Number
	
	METHOD SUMMARY
	
		- getTarget():Object
		
		- getType():String
		
		- setTarget(target:Object):Void
		
		- setType(type:String):Void
		
		- toString():String
		
	INHERIT
	
		Object 
			|
			BasicEvent
				|
				DynamicEvent
					|
					UIEvent
		
	IMPLEMENTS
	
		Event
		
----------  */

import vegas.events.DynamicEvent ;

class asgard.events.UIEvent extends DynamicEvent {

	// ----o Constructor
	
	public function UIEvent(type:String, target) {
		super(type, target) ;
	}

	// ----o Public Properties
	
	public var child ;
	public var index:Number ;

	// ----o Public Methods
	
	public function clone() {
		return new UIEvent(getType(), getTarget()) ;
	}

}
