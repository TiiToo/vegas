/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The InterpolationMethod class provides values for the interpolationMethod parameter in the MovieClip.beginGradientFill() and MovieClip.lineGradientStyle() methods.
 * @author eKameleon
 */
class asgard.display.InterpolationMethod 
{

	/**
	 * Specifies that the linear RGB interpolation method should be used. 
	 * This means that Flash Player uses an RGB color space based on a linear RGB color model.
 	 */
	public static var LINEAR_RGB:String = "linearRGB" ;
	
	/**
	 * Specifies that the RGB interpolation method should be used. 
	 * This means that Flash Player uses the exponential sRGB (standard RGB) space when rendering the gradient. 
	 * The sRGB space is a W3C-endorsed standard that defines a non-linear conversion between red, green, and blue component values and the actual intensity of the visible component color.
	 */
	public static var RGB:String = "rgb" ;
	
	private static var __ASPF__ = _global["ASSetPropFlags"](InterpolationMethod, null , 7, 7) ;

}
