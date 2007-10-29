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
 * The GradientType class provides values for the type parameter 
 * in the beginGradientFill() and lineGradientFill() of the MovieClip draw apis.
 * @author eKameleon
 */
class asgard.display.GradientType 
{

	/**
	 * Value used to specify a linear gradient fill.
 	 */
	public static var LINEAR:String = "linear" ;
	
	/**
	 * Value used to specify a radial gradient fill.
	 */
	public static var RADIAL:String = "radial" ;
	
	private static var __ASPF__ = _global["ASSetPropFlags"](GradientType, null , 7, 7) ;

}
