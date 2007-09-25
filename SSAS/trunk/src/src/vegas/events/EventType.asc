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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Enumeration static class with the principal event types.
 * @author eKameleon
 */
if (vegas.events.EventType == undefined) 
{
	
	/**
	 * Creates a new EventType singleton
	 */
	vegas.events.EventType = {} ;

	/**
	 * The activate event occurs when Flash Player has gained OS focus and is becoming active.
	 */
	vegas.events.EventType.ACTIVATE /*String*/ = "activate" ;

	/**
	 * The added event occurs when a DisplayObject has been added to the display list.
	 */
	vegas.events.EventType.ADDED /*String*/ = "added" ;
	
	/**
	 * A constant to notify a global {@code EventListener} in the {@code EventDispatcher.addEventListener} method.
	 */
	vegas.events.EventType.ALL /*String*/ = "ALL" ;

	/**
	 * The cancel event occurs when a file upload or download is cancelled.
	 */
	vegas.events.EventType.CANCEL /*String*/ = "cancel" ;
	
	/**
	 * The change event occurs after a control's value has been modified.
	 */
	vegas.events.EventType.CHANGE /*String*/ = "change" ;

	/**
	 * A Socket or XMLSocket object generates the close event after a network connection is closed.
	 */
	vegas.events.EventType.CLOSE /*String*/ = "close" ;

	/**
	 * Flash Player dispatches the complete event when data has loaded successfully.
	 */
	vegas.events.EventType.COMPLETE /*String*/ = "complete" ;

	/**
	 * The Flash Player dispatches the connect event when a network connection has been established.
	 */
	vegas.events.EventType.CONNECT /*String*/ = "connect" ;

	/**
	 * The Stage object generates the deactivate event when the Flash Player is losing operating system focus and is becoming inactive.
	 */
	vegas.events.EventType.DEACTIVATE /*String*/ = "deactivate" ;

	/**
	 * The enabled change event invoqued when a display or a component is enabled or diabled.
	 */
	vegas.events.EventType.ENABLED_CHANGE /*String*/ = "enabled_change" ;

	/**
	 * Flash Player generates the enterFrame event when the play head is entering a new frame.
	 */
	vegas.events.EventType.ENTER_FRAME /*String*/ = "enterframe" ;

	/**
	 * Defines the value of the type property of an id3 event object.
	 */
	vegas.events.EventType.ID3 /*String*/ = "id3" ;

	/**
	 * Defines the value of the type property of an init event object.
	 */
	vegas.events.EventType.INIT /*String*/ = "init" ;

	/**
	 * Defines the value of the type property of a mouseLeave event object.
	 */
	vegas.events.EventType.MOUSE_LEAVE /*String*/ = "mouseleave" ;

	/**
	 * Defines the value of the type property of an open event object.
	 */
	vegas.events.EventType.OPEN /*String*/ = "open" ;

	/**
	 * Defines the value of the type property of a removed event object.
	 */
	vegas.events.EventType.REMOVED /*String*/ = "removed" ;

	/**
	 * Defines the value of the type property of a render event object.
	 */
	vegas.events.EventType.RENDER /*String*/ = "render" ;

	/**
	 * Defines the value of the type property of a resize event object.
	 */
	vegas.events.EventType.RESIZE /*String*/ = "resize" ;

	/**
	 * Defines the value of the type property of a scroll event object.
	 */
	vegas.events.EventType.SCROLL /*String*/ = "scroll" ;

	/**
	 * Defines the value of the type property of a select event object.
	 */
	vegas.events.EventType.SELECT /*String*/ = "select" ;

	/**
	 * Defines the value of the type property of a soundComplete event object.
	 */
	vegas.events.EventType.SOUND_COMPLETE /*String*/ = "soundcomplete" ;

	/**
	 * Defines the value of the type property of a tabChildrenChange event object.
	 */
	vegas.events.EventType.TAB_CHILDREN_CHANGE /*String*/ = "tab_children_change" ;

	/**
	 * Defines the value of the type property of a tabEnabledChange event object.
	 */
	vegas.events.EventType.TAB_ENABLED_CHANGE /*String*/ = "tab_enabled_change" ;

	/**
	 * Defines the value of the type property of a tabIndexChange event object.
	 */
	vegas.events.EventType.TAB_INDEX_CHANGE /*String*/ = "tab_index_change" ;

	/**
	 * Defines the value of the type property of an unload event object.
	 */
	vegas.events.EventType.UNLOAD /*String*/ = "unload" ;

}