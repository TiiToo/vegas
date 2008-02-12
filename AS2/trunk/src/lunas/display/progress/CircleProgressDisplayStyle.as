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
import flash.filters.DropShadowFilter;

import lunas.core.AbstractStyle;

/**
 * The IStyle object of the CircleProgressDisplay component.
 * @author eKameleon
 */
class lunas.display.progress.CircleProgressDisplayStyle extends AbstractStyle 
{

	/**
	 * Creates a new CircleProgressDisplayStyle instance.
	 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
	 */
	public function CircleProgressDisplayStyle(init:Object)
	{
		super( init );
	}
	
	/**
	 * The alpha value of the arc.
	 */
	public var arcAlpha:Number = 100 ;

	/**
	 * The border alpha value of the arc.
	 */
	public var arcBorderAlpha:Number = 100 ;

	/**
	 * The border color value of the arc.
	 */
	public var arcBorderColor:Number = 0x404040 ;

	/**
	 * The border thickness value of the arc.
	 */
	public var arcBorderThickness:Number = 2 ;

	/**
	 * The color value of the arc.
	 */
	public var arcColor:Number = 0x621D15 ;

	/**
	 * The color value of the arc.
	 */
	public var arcShadow:DropShadowFilter ;

	/**
	 * The padding of this arc.
	 */
	public var padding:Number = 0 ;

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
	
	public function initialize():Void
	{
		if ( arcShadow == null )
		{
			arcShadow = new DropShadowFilter(2, 45, 0x000000, 0.7, 6, 6, 0.8, 2 ) ;
		}	
	}
	
}
