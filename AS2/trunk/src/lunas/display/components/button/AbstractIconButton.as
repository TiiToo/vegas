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

/** AbstractIconButton

	AUTHOR

		Name : AbstractIconButton
		Package : lunas.display.components.button
		Version : 1.0.0.0
		Date :  2006-02-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY

		- icon:String

		- index:Number
		
		- data:Object
		
		- label:String [R/W]
		
		- selected:Boolean [R/W]
		
		- toggle:Boolean [R/W]
			

	METHOD SUMMARY
		
		- attachIcon(depth:Number):MovieClip
		
		- getIcon():String
		
		- getIconDepth():String
		
		- getIconTarget():MovieClip
		
		- getLabel():String
		
		- getSelected():Boolean
		
		- getToggle():Boolean

		- resetIconColor():Void
	
		- setIcon(str:String):Void
		
		- setIconColor(hex:Number):Void
		
		- setLabel(str:String):Void
		
		- setSelected(b:Boolean, noEvent:Boolean):Void
		
		- setToggle(b:Boolean):Void
		
		- final viewEnabled():Void

		- viewIconChanged():Void
			override this method !
		
		- viewLabelChanged():Void
			override this method !

	EVENT SUMMARY
	
		ButtonEvent
		
		- CLICK:MouseEventType
		
		- UP:ButtonEventType
		
		- DISABLED:ButtonEventType
		
		- DOUBLE_CLICK:MouseEventType
		
		- DOWN:ButtonEventType
		
		- ICON_CHANGE:ButtonEventType
		
		- LABEL_CHANGE:ButtonEventType
		
		- MOUSE_UP:MouseEventType
		
		- MOUSE_DOWN:MouseEventType
		
		- OUT:ButtonEventType
		
		- OUT_SELECTED:ButtonEventType
		
		- OVER:ButtonEventType
		
		- OVER_SELECTED:ButtonEventType
		
		- ROLLOUT:MouseEventType
		
		- ROLLOVER:MouseEventType
		
		- SELECT:ButtonEventType
		
		- UNSELECT:ButtonEventType
		
		- UP:ButtonEventType

	IMPLEMENTS 
	
		IButton, IEventTarget

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractButton → AbstractIconButton

	SEE ALSO
	
		IButton, IBuilder, IStyle
	
**/

import asgard.colors.ColorUtil;
import asgard.events.ButtonEvent;
import asgard.events.ButtonEventType;

import lunas.display.components.button.AbstractButton;

class lunas.display.components.button.AbstractIconButton extends AbstractButton {

	/**
	 * Abstract constructor.
	 * @private
	 */
	private function AbstractIconButton () 
	{ 
		//	
	}

	// ----o Public Properties
	
	// public var icon:String ; // [R/W]

	// ----o Public Methods
	
	public function attachIcon(depth:Number):MovieClip 
	{
		if (_mcIcon) 
		{
			_mcIcon.removeMovieClip() ;
		}
		if (getIcon() != undefined) 
		{
			return attachMovie( getIcon(), "_mcIcon", isNaN(depth) ? 4 : depth ) ;
		} else {
			return null ;
		}
	}
	
	public function getIcon():String 
	{ 
		return _sIcon ;
	}
	
	public function getIconDepth():Number 
	{ 
		return _mcIcon.getDepth() ;
	}
	
	public function getIconTarget():MovieClip 
	{ 
		return _mcIcon ;
	}

	public function resetIconColor():Void 
	{
		if (_mcIcon) ColorUtil.reset(new Color(_mcIcon)) ;
	}

	public function setIcon( str:String ) : Void 
	{
		_sIcon = str ; 
		viewIconChanged() ;
		dispatchEvent(new ButtonEvent( ButtonEventType.ICON_CHANGE )) ;
	}

	public function setIconColor(hex:Number):Void 
	{
		resetIconColor() ; 
		if ( _mcIcon && !isNaN(hex) ) {
			(new Color(_mcIcon)).setRGB (hex) ;
		}
	}

	public function viewIconChanged():Void 
	{
		// override this method when icon property change
	}
	
	// ----o Virtual Properties
	
	public function get icon():String 
	{
		return getIcon() ;	
	}
	
	public function set icon(sIcon:String):Void 
	{
		setIcon(sIcon) ;	
	}
	
	// ----o Private Properties
	
	private var _mcIcon:MovieClip ;
	private var _sIcon:String ;
	

}
