﻿/*

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

/** EventType

	AUTHOR

		Name : EventType
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		AS3 API flash.events.EventType compatibility
	
	CONSTRUCTOR
	
		private
	
	STATIC PROPERTIES

		- ACTIVATE:String
			The activate event occurs when Flash Player has gained OS focus and is becoming active.
		
		- ALL:String
		
		- ADDED:String
			The added event occurs when a DisplayObject has been added to the display list.
		
		- CANCEL:String
			The cancel event occurs when a file upload or download is cancelled.
		
		- CHANGE:String
			The change event occurs after a control's value has been modified.
		
		- CLOSE:String
			A Socket or XMLSocket object generates the close event after a network connection is closed.
		
		- COMPLETE:String
			Flash Player dispatches the complete event when data has loaded successfully.
		
		- CONNECT:String
			The Flash Player dispatches the connect event when a network connection has been established.
		
		- DEACTIVATE:String
			The Stage object generates the deactivate event when the Flash Player is losing operating system focus and is becoming inactive.
		
		- ENABLED_CHANGE:String
		
		- ENTER_FRAME:String
			Flash Player generates the enterFrame event when the play head is entering a new frame.
		
		- ID3:String
			A Sound object will generate the id3 event when ID3 data is available for an MP3 sound.
		
		- INIT:String
			A Loader object generates the INIT event when the properties and methods of a loaded SWF file are accessible.
		
		- MOUSE_LEAVE:String
			The Stage object generates the mouseLeave event when the mouse pointer has moved out of the player window area.
		
		- OPEN:String
			A Loader, URLLoader, URLStream or FileReference object will generate the open event when a network operation has commenced.
		
		- REMOVED:String
			Flash Player dispatches the removed event when a DisplayObject is about to be removed from the display list.
		
		- RENDER:String
			Flash Player dispatches the render event when the display list is about to be updated and rendered.
		
		- RESIZE:String
			Flash Player dispatches the resize event when Stage.scaleMode is set to "noScale" and the SWF file has been resized.
		
		- SCROLL:String
			A TextField object generates the scroll event after the user scrolls.
		
		- SELECT:String
			A FileReference object generates the select event when an item has been selected.
		
		- SOUND_COMPLETE:String
			A Sound object generates the soundComplete event when a sound has finished playing.
		
		- TAB_CHILDREN_CHANGE:String
			An InteractiveObject instance generates the tabChildrenChange event when the value of the object's tabChildren flag changes.
		
		- TAB_ENABLED_CHANGE:String
			An InteractiveObject instance generates the tabEnabledChange event when the value of the object's tabEnabled flag changes.
		
		- TAB_INDEX_CHANGE:String
			An InteractiveObject instance generates the tabIndexChange event when the value of the object's tabIndex property changes.
		
		- UNLOAD:String
		A Loader object generates the unload event whenever a loaded SWF file is removed using the Loader.unload() method.

**/

class vegas.events.EventType {

	// ----o Constructor
	
	private function EventType() {
		//
	}

	// ----o Static Properties
	
	static public var ACTIVATE:String = "activate" ;
	static public var ADDED:String = "added" ;
	static public var ALL:String = "ALL" ;
	static public var CANCEL:String = "cancel" ;
	static public var CHANGE:String = "change" ;
	static public var CLOSE:String = "close" ;
	static public var COMPLETE:String = "complete" ;
	static public var CONNECT:String = "connect" ;
	static public var DEACTIVATE:String = "deactivate" ;
	static public var ENABLED_CHANGE:String = "enabled_change" ;
	static public var ENTER_FRAME:String = "enterframe" ;
	static public var ID3:String = "id3" ;
	static public var INIT:String = "init" ;
	static public var MOUSE_LEAVE:String = "mouseleave" ;
	static public var OPEN:String = "open" ;
	static public var REMOVED:String = "removed" ;
	static public var RENDER:String = "render" ;
	static public var RESIZE:String = "resize" ;
	static public var SCROLL:String = "scroll" ;
	static public var SELECT:String = "select" ;
	static public var SOUND_COMPLETE:String = "soundcomplete" ;
	static public var TAB_CHILDREN_CHANGE:String = "tab_children_change" ;
	static public var TAB_ENABLED_CHANGE:String = "tab_enabled_change" ;
	static public var TAB_INDEX_CHANGE:String = "tab_index_change" ;
	static public var UNLOAD:String = "unload" ;

	static private var __ASPF__ = _global.ASSetPropFlags(EventType, null , 7, 7) ;
	
}

