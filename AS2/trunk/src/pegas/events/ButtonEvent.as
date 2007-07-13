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

import pegas.events.MouseEvent;

/**
 * The event invoqued in the button or thumbs of the applications.
 * @author eKameleon
 */
dynamic class pegas.events.ButtonEvent extends MouseEvent 
{

	/**
	 * Creates a new ButtonEvent instance.
	 */
	public function ButtonEvent
	(
		type:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number
		, p_localX:Number, p_localY:Number, p_relatedObject:Number, p_ctrlKey:Boolean, p_altKey:Boolean
		, p_shiftKey:Boolean, p_buttonDown:Boolean, p_delta:Number
	) 
	{
			
		super(
			type, target, context, bubbles, eventPhase, time, stop
			, p_localX, p_localY, p_relatedObject, p_ctrlKey, p_altKey, p_shiftKey, p_buttonDown, p_delta
		) ;
	
	}

	static public var CLICK:String = MouseEvent.CLICK ;
	
	static public var DISABLED:String = "disabled" ;
	
	static public var DOUBLE_CLICK:String = MouseEvent.DOUBLE_CLICK ;
	
	static public var DOWN:String = "down" ;

	static public var DRAG:String = "drag" ;
	
	static public var ICON_CHANGE:String = "onIconChanged" ;
	
	static public var LABEL_CHANGE:String = "onLabelChanged" ;
	
	static public var MOUSE_UP:String = MouseEvent.MOUSE_UP ;
	
	static public var MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN ;
	
	static public var OUT:String = "out" ;
	
	static public var OUT_SELECTED:String = "outSelected" ;
	
	static public var OVER:String = "over" ;
	
	static public var OVER_SELECTED:String = "overSelected" ;
	
	static public var ROLLOUT:String = MouseEvent.ROLLOUT ;
	
	static public var ROLLOVER:String = MouseEvent.ROLLOVER ;
		
	static public var SELECT:String = "select" ;
	
	static public var START_DRAG:String = "startDrag" ;
	
	static public var STOP_DRAG:String = "stopDrag" ;
	
	static public var UNSELECT:String = "unselect" ;
	
	static public var UP:String = "up" ;

	/**
	 * Returns a shallow copy of this objet.
	 * @return a shallow copy of this objet.
	 */
	public function clone() 
	{
		var prop:String ;
		var props:Array = ["localX", "localY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta"] ;
		var be:ButtonEvent = new ButtonEvent(_type, _target) ;
		var l:Number = props.length ;
		while(--l > -1) 
		{
			prop = props[l] ;
			be[prop] = this[prop] ;
		}
		return be ;
	}
	
}
