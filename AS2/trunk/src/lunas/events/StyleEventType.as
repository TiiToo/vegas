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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** StyleEvent

	AUTHOR
	
		Name : StyleEvent
		Package : lunas.events
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- STYLE_CHANGED:StyleEventType
	
		- STYLE_SHEET_CHANGED:StyleEventType
	
*/

class lunas.events.StyleEventType {
	
	// ----o Constructor
	
	private function StyleEventType() {
		//
	}
	
	// ----o Constant
	
	static public var STYLE_CHANGED:String = "onStyleChanged" ;

	static public var STYLE_SHEET_CHANGED:String = "onStyleSheetChanged" ;

	static private var __ASPF__ = _global.ASSetPropFlags(StyleEventType, null , 7, 7) ;

}