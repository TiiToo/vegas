/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */





import lunas.display.components.button.AbstractButton;
import lunas.display.components.button.EasyButtonBuilder;
import lunas.display.components.button.EasyButtonStyle;

/**
 * The EasyButton component class.
 */
class lunas.display.components.button.EasyButton extends AbstractButton 
{

	/**
	 * Creates a new EasyButton instance.
	 */
	public function EasyButton () 
	{ 
		super() ;
	}
	
	public var background:MovieClip ;

	public var field:TextField ;

	public function getBuilderRenderer():Function 
	{
		return EasyButtonBuilder ;
	}
	
	public function getStyleRenderer():Function 
	{
		return EasyButtonStyle ;
	}
	
	public function viewLabelChanged():Void 
	{
		update() ;
	}

	private var _h:Number = 20 ;
	private var _w:Number = 150 ;

}
