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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Enumeration static class with the principal event types.
 * @author eKameleon
 */
class vegas.events.EventType 
{

	/**
	 * The activate event occurs when Flash Player has gained OS focus and is becoming active.
	 */
	public static var ACTIVATE:String = "activate" ;

	/**
	 * The added event occurs when a DisplayObject has been added to the display list.
	 */
	public static var ADDED:String = "added" ;
	
	/**
	 * A constant to notify a global {@code EventListener} in the {@code EventDispatcher.addEventListener} method.
	 */
	public static var ALL:String = "ALL" ;
	
	/**
	 * The cancel event occurs when a file upload or download is cancelled.
	 */
	public static var CANCEL:String = "cancel" ;
	
	/**
	 * The change event occurs after a control's value has been modified.
	 */
	public static var CHANGE:String = "change" ;
	
	/**
	 * A Socket or XMLSocket object generates the close event after a network connection is closed.
	 */
	public static var CLOSE:String = "close" ;
	
	/**
	 * Flash Player dispatches the complete event when data has loaded successfully.
	 */
	public static var COMPLETE:String = "complete" ;
	
	/**
	 * The Flash Player dispatches the connect event when a network connection has been established.
	 */
	public static var CONNECT:String = "connect" ;
	
	/**
	 * The Stage object generates the deactivate event when the Flash Player is losing operating system focus and is becoming inactive.
	 */
	public static var DEACTIVATE:String = "deactivate" ;
	
	/**
	 * The enabled change event invoqued when a display or a component is enabled or diabled.
	 */
	public static var ENABLED_CHANGE:String = "enabled_change" ;
	
	/**
	 * Flash Player generates the enterFrame event when the play head is entering a new frame.
	 */
	public static var ENTER_FRAME:String = "enterframe" ;
	
	/**
	 * Defines the value of the type property of an id3 event object.
	 */
	public static var ID3:String = "id3" ;
	
	/**
	 * Defines the value of the type property of an init event object.
	 */
	public static var INIT:String = "init" ;
	
	/**
	 * Defines the value of the type property of a mouseLeave event object.
	 */
	public static var MOUSE_LEAVE:String = "mouseleave" ;
	
	/**
	 * Defines the value of the type property of an open event object.
	 */
	public static var OPEN:String = "open" ;
	
	/**
	 * Defines the value of the type property of a removed event object.
	 */
	public static var REMOVED:String = "removed" ;
	
	/**
	 * Defines the value of the type property of a render event object.
	 */
	public static var RENDER:String = "render" ;
	
	/**
	 * Defines the value of the type property of a resize event object.
	 */
	public static var RESIZE:String = "resize" ;
	
	/**
	 * Defines the value of the type property of a scroll event object.
	 */
	public static var SCROLL:String = "scroll" ;
	
	/**
	 * Defines the value of the type property of a select event object.
	 */
	public static var SELECT:String = "select" ;
	
	/**
	 * Defines the value of the type property of a soundComplete event object.
	 */
	public static var SOUND_COMPLETE:String = "soundcomplete" ;
	
	/**
	 * Defines the value of the type property of a tabChildrenChange event object.
	 */
	public static var TAB_CHILDREN_CHANGE:String = "tab_children_change" ;
	
	/**
	 * Defines the value of the type property of a tabEnabledChange event object.
	 */
	public static var TAB_ENABLED_CHANGE:String = "tab_enabled_change" ;
	
	/**
	 * Defines the value of the type property of a tabIndexChange event object.
	 */
	public static var TAB_INDEX_CHANGE:String = "tab_index_change" ;
	
	/**
	 * Defines the value of the type property of an unload event object.
	 */
	public static var UNLOAD:String = "unload" ;

	private static var __ASPF__ = _global["ASSetPropFlags"](EventType, null , 7, 7) ;
	
}

