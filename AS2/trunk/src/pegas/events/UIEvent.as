﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * The UIEvent class.
 * @author eKameleon
 */
class pegas.events.UIEvent extends DynamicEvent 
{

	/**
	 * Creates a new UIEvent instance.
	 */
	public function UIEvent( type:String, target, p_child, p_index:Number, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number) 
	{
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		child = p_child || null ;
		index = isNaN(p_index) ? null : p_index ;
	}

	/**
	 * The added event occurs when a DisplayObject has been added to the display list.
	 */
	public static var ADDED:String = "added" ;
	
	public static var CANCEL:String = "cancel" ;
	
	public static var CHANGE:String = "change" ;
	
	public static var CLOSE:String = "close" ;
	
	public static var COMPLETE:String = "complete" ;
	
	public static var CONNECT:String = "connect" ;
	
	public static var CREATE:String = "create" ;
	
	public static var DESTROY:String = "destroy" ;
	
	public static var ENABLED_CHANGE:String = "enabled_change" ;
	
	public static var ENTER_FRAME:String = "enterframe" ;

	public static var ICON_CHANGE:String = "onIconChanged" ;
	
	/**
	 * A Loader object generates the INIT event when the properties and methods of a loaded SWF file are accessible.
	 */
	public static var INIT:String = "init" ;

	public static var LABEL_CHANGE:String = "onLabelChanged" ;
	
	public static var OPEN:String = "open" ;	

	/**
	 * Flash Player dispatches the removed event when a DisplayObject is about to be removed from the display list.
	 */
	public static var REMOVED:String = "removed" ;
	
	/**
	 * Flash Player dispatches the render event when the display list is about to be updated and rendered.
	 */
	public static var RENDER:String = "render" ;
	
	/**
	 * Flash Player dispatches the resize event when Stage.scaleMode is set to "noScale" and the SWF file has been resized.
	 */
	public static var RESIZE:String = "resize" ;
	
	/**
	 * A TextField object generates the scroll event after the user scrolls.
	 */
	public static var SCROLL:String = "scroll" ;
	
	/**
	 * A FileReference object generates the select event when an item has been selected.
	 */
	public static var SELECT:String = "select" ;

	public static var STYLE_CHANGE:String = "styleChange" ;
	
	/**
	 * A Loader object generates the unload event whenever a loaded SWF file is removed using the Loader.unload() method.
	 */
	public static var UNLOAD:String = "unload" ;

	public static var UNSELECT:String = "unselect" ;

	public var child ;

	public var index:Number ;

	public function clone() 
	{
		return new UIEvent( getType(), getTarget() ) ;
	}
	
	/*protected*/ private function _getParams():Array 
	{
		var ar:Array = super._getParams() ;
		ar.splice(2, null, Serializer.toSource(child)) ;
		ar.splice(3, null, Serializer.toSource(index)) ;
		return ar ;
	}
	
}
