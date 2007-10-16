﻿/*

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
 * The SpreadMethod class provides values for the spreadMethod parameter in the beginGradientFill() and lineGradientStyle() methods of MovieClip class.
 * @author eKameleon
 */
class asgard.display.SpreadMethod 
{

	/**
	 * Specifies that the gradient use the pad spread method.
 	 */
	public static var PAD:String = "pad" ;
	
	/**
	 * Specifies that the gradient use the reflect spread method.
	 */
	public static var REFLECT:String = "reflect" ;
	
	/**
	 * Specifies that the gradient use the repeat spread method.
	 */
	public static var REPEAT:String = "repeat" ;
	
	
	private static var __ASPF__ = _global.ASSetPropFlags(SpreadMethod, null , 7, 7) ;

}
