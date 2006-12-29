/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.events.DynamicEvent;
import vegas.util.serialize.Serializer;

/**
 * @author eKameleon
 */
class pegas.events.MouseEvent extends DynamicEvent 
{

	/**
	 * Creates a new MouseEvent instance.
	 */
	public function MouseEvent
	(
		type:String, target, context, bubbles:Boolean, eventPhase:Number, time:Number, stop:Number
		, p_localX:Number, p_localY:Number, p_relatedObject:Number, p_ctrlKey:Boolean, p_altKey:Boolean
		, p_shiftKey:Boolean, p_buttonDown:Boolean, p_delta:Number
	)
	{
			
		super(type, target, context, bubbles, eventPhase, time, stop) ;
		
		localX = isNaN(p_localX) ? 0 : p_localX ;
		localY = isNaN(p_localY) ? 0 : p_localY ;
		relatedObject = p_relatedObject || null ;
		ctrlKey = p_ctrlKey || false ;
		altKey = p_altKey || false ;
		shiftKey = p_shiftKey || false ;
		buttonDown = p_buttonDown || false ;
		delta = isNaN(p_delta) ? 0 : p_delta ;
		
	}

	/**
	 * Reserved for future use (not currently functional).
	 */
	public var altKey:Boolean = false ;

	/**
	 * Indicates whether the left mouse button is depressed.
	 */
	public var buttonDown:Boolean = false ;

	/**
	 * Indicates whether the control(Ctrl) key modifier is activated.
	 */
	public var ctrlKey:Boolean = false ;

	/**
	 * A number indicating how many lines should be scrolled for each notch the user rolls the mouse wheel.
	 * A positive delta value indicates an upward scroll.
	 * A negative value indicates a downward scroll.
	 * Typical values are 1 to 3, but faster scrolling may produce larger values.
	 * This parameter is used only for the MouseEventType.mouseWheel event.
	 */
	public var delta:Number = 0 ;

	/**
	 * The horizontal coordinate at which the event occurred relative to the containing sprite.
	 */
	public var localX:Number = 0 ;

	/**
	 * The vertical coordinate at which the event occurred relative to the containing sprite.
	 */
	public var localY:Number = 0 ;

	/**
	 * Indicates the complementary InteractiveObject instance that is affected by the event.
	 * For example, when a mouseOut event occurs, the relatedObject represents the display list object to which the pointing device now points.
	 */
	public var relatedObject:Number = null ;

	/**
	 * Indicates whether the Shift(Shift) key modifier is activated.
	 */
	public var shiftKey:Boolean = false ;

	public function clone() 
	{
		var prop:String ;
		var props:Array = ["localX", "localY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta"] ;
		var me:MouseEvent = new MouseEvent(getType(), getTarget()) ;
		var l:Number = props.length ;
		while(--l > -1) 
		{
			prop = props[l] ;
			me[prop] = this[prop];
		}
		return me ;
	}

	/*protected*/ private function _getParams():Array 
	{
		var ar1:Array = super._getParams() ;
		var ar2:Array = [] ;
		var props:Array = ["localX", "localY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "buttonDown", "delta"] ;
		var len:Number = props.length ;
		for (var i:Number = 0 ; i<len ; i++) {
			ar2[i] = Serializer.toSource( this[props[i]] ) ;
		} ;
		return ar1.concat(ar2) ;
	}
	
}