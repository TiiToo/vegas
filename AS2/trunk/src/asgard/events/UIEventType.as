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

/** UIEventType

	AUTHOR

		Name : UIEventType
		Package : asgard.events
		Version : 1.0.0.0
		Date :  2006-02-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		private
	
	CONSTANT SUMMARY

		- ADDED:UIEventType
		
			The added event occurs when a DisplayObject has been added to the display list.
		
		- CANCEL:UIEventType
			
		- CHANGE:UIEventType
		
		- CLOSE:UIEventType
		
		- COMPLETE:UIEventType
		
		- CONNECT:UIEventType
		
		- CREATE:UIEventType
		
		- DESTROY:UIEventType
		
		- ENABLED_CHANGE:UIEventType
		
		- ENTER_FRAME:UIEventType
					
		- INIT:UIEventType
			A Loader object generates the INIT event when the properties and methods of a loaded SWF file are accessible.
		
		- OPEN:UIEventType
		
		- REMOVED:UIEventType
			Flash Player dispatches the removed event when a DisplayObject is about to be removed from the display list.
		
		- RENDER:UIEventType
			Flash Player dispatches the render event when the display list is about to be updated and rendered.
		
		- RESIZE:UIEventType
			Flash Player dispatches the resize event when Stage.scaleMode is set to "noScale" and the SWF file has been resized.
		
		- SCROLL:UIEventType
			A TextField object generates the scroll event after the user scrolls.
		
		- SELECT:UIEventType
			A FileReference object generates the select event when an item has been selected.
		
		- STYLE_CHANGE:UIEventType
				
		- UNLOAD:UIEventType
			A Loader object generates the unload event whenever a loaded SWF file is removed using the Loader.unload() method.
		
		- UNSELECT:UIEventType

----------  */

class asgard.events.UIEventType {

	// ----o Constructor
	
	private function UIEventType() {
		//
	}

	// ----o Static Properties
		
	static public var ADDED:String = "added" ;
	
	static public var CANCEL:String = "cancel" ;
	
	static public var CHANGE:String = "change" ;
	
	static public var CLOSE:String = "close" ;
	
	static public var COMPLETE:String = "complete" ;
	
	static public var CONNECT:String = "connect" ;
	
	static public var CREATE:String = "create" ;
	
	static public var DESTROY:String = "destroy" ;
	
	static public var ENABLED_CHANGE:String = "enabled_change" ;
	
	static public var ENTER_FRAME:String = "enterframe" ;

	static public var ICON_CHANGE:String = "onIconChanged" ;
	
	static public var INIT:String = "init" ;

	static public var LABEL_CHANGE:String = "onLabelChanged" ;
	
	static public var OPEN:String = "open" ;	

	static public var REMOVED:String = "removed" ;
	
	static public var RENDER:String = "render" ;
	
	static public var RESIZE:String = "resize" ;
	
	static public var SCROLL:String = "scroll" ;
	
	static public var SELECT:String = "select" ;

	static public var STYLE_CHANGE:String = "styleChange" ;
	
	static public var UNLOAD:String = "unload" ;

	static public var UNSELECT:String = "unselect" ;

	static private var __ASPF__ = _global.ASSetPropFlags(UIEventType, null , 7, 7) ;
	
}

