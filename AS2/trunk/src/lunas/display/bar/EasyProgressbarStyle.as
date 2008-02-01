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
import lunas.core.AbstractStyle;

/**
 * The IStyle object of the EasyProgressbar component.
 * @author eKameleon
 */
class lunas.display.bar.EasyProgressbarStyle extends AbstractStyle 
{

	/**
	 * Creates a new EasyProgressbarStyle instance.
	 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
	 */
	public function EasyProgressbarStyle(init:Object)
	{
		super( init );
	}
	
	/**
	 * The alpha value of the bar.
	 */
	public var barAlpha:Number = 100 ;

	/**
	 * The border alpha value of the bar.
	 */
	public var barBorderAlpha:Number = 100 ;
	
	/**
	 * The border color value of the bar.
	 */
	public var barBorderColor:Number = 0xFFFFFF ;

	/**
	 * The border thickness value of the bar.
	 */
	public var barBorderThickness:Number = 1 ;

	/**
	 * The color value of the bar.
	 */
	public var barColor:Number = 0xEEED55 ;

	/**
	 * The border thickness of this bar.
	 */
	public var border:Number = 0 ;

	/**
	 * The alpha value of the background.
	 */
	public var themeAlpha:Number = 100 ;

	/**
	 * The border alpha value of the background.
	 */
	public var themeBorderAlpha:Number = 100 ;

	/**
	 * The border alpha value of the background.
	 */
	public var themeBorderColor:Number = 0xFFFFFF ;

	/**
	 * The border thickness value of the background.
	 */
	public var themeBorderThickness:Number = 1 ;

	/**
	 * The border color value of the background.
	 */
	public var themeColor:Number = 0xD0330D ;
	
}
