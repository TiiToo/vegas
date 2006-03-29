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

/**	SystemEvent

	AUTHOR

		Name : SystemEvent
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2005-10-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTIES
	
		- context
		
			- context.id
			- context.value
		
		- target
		
		- type
	
	INHERIT
	
		BasicEvent
			|
			DynamicEvent
				|
				SystemEvent
				

	IMPLEMENTS
	
		Event
	

----------  */

import vegas.events.DynamicEvent;

// TODO changer le setContext... par 2 propriétés property et value en direct.

class asgard.system.SystemEvent extends DynamicEvent {

	// ----o Constructor
	
	public function SystemEvent(target, property, value){
		super( VIEW_SYSTEM_EVENT , target) ;
		setContext( {
			id : property || null , 
			value : value || null
		}) ;
	}

	// ----o Static Properties

	static public var VIEW_SYSTEM_EVENT:String = "viewSystem" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(SystemEvent, ["VIEW_SYSTEM_EVENT"] , 7, 7) ;

	// ----o Public Methods

	public function clone() {
		return new SystemEvent(_target, _context.property, _context.value) ;
	}
	
	public function getProperty() {
		return getContext().property ;
	}

	public function getValue() {
		return getContext().value ;
	}
	
}
