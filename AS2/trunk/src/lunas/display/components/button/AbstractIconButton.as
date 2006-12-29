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

import lunas.display.components.button.AbstractButton;

import pegas.colors.ColorUtil;
import pegas.events.ButtonEvent;
import pegas.events.ButtonEventType;

/**
 * @author eKameleon
 */
class lunas.display.components.button.AbstractIconButton extends AbstractButton 
{

	/**
	 * Creates a AbstractIconButton instance.
	 */
	private function AbstractIconButton () 
	{ 
		//	
	}

	public function get icon():String 
	{
		return getIcon() ;	
	}
	
	public function set icon(sIcon:String):Void 
	{
		setIcon(sIcon) ;	
	}
	
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
	
	// ----o Private Properties
	
	private var _mcIcon:MovieClip ;
	private var _sIcon:String ;
	

}
