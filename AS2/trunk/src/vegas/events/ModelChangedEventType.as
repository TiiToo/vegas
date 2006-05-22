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

/** ModelChangedEvent

	AUTHOR

		Name : ModelChangedEvent
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net


	CONSTANT SUMMARY

		- ADD_ITEMS:String 
		
			"addItems"
		
		- MODEL_CHANGED:String 
			
			"modelChanged"
		
		- REMOVE_ITEMS:String
			
			"removeItems"
		
		- SORT_ITEMS:String
		
			"sortItems"
		
		- UPDATE_ALL:String
		
			"updateAll"
		
		- UPDATE_FIELD:String
		
			"updateField"
		
		- UPDATE_ITEMS:String
		
			"updateItems"
		
		- MODEL_CHANGED::String
		
			"modelChanged"
	
**/

class vegas.events.ModelChangedEventType {

	// ----o Constructor
	
	public function ModelChangedEventType() {
		//
	}

	// ----o Constant
	
	static public var ADD_ITEMS:String = "addItems" ; 
	static public var CLEAR_ITEMS:String = "clear" ;
	static public var MODEL_CHANGED:String = "modelChanged" ;
	static public var REMOVE_ITEMS:String = "removeItems" ;
	static public var SORT_ITEMS:String = "sortItems" ;
	static public var UPDATE_ALL:String = "updateAll" ;
	static public var UPDATE_FIELD:String = "updateField" ;
	static public var UPDATE_ITEMS:String = "updateItems" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(ModelChangedEventType, null , 7, 7) ;
	
}
