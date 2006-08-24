﻿/*

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

/**	PanelEventType

	AUTHOR

		Name : PanelEventType
		Package : lunas.events
		Version : 1.0.0.0
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		- CREATE:PanelEventType 
		
			"onCreate"
		
		- DESTROY:PanelEventType
		
			"onDestroy"
		
		- HIDE:PanelEventType
		
			"onHide"
		
		- SHOW:PanelEventType 
		
			"onShow"
		
**/

class lunas.events.PanelEventType {

	// ----o Constructor
	
	private function PanelEventType() {
		//
	}

	// ----o Static Properties

	static public var CREATE:String = "onCreate" ;
	
	static public var DESTROY:String = "onDestroy" ;

	static public var HIDE:String = "onHide" ;
	
	static public var SHOW:String = "onShow" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(PanelEventType, null , 7, 7) ;
	
}
