/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Luna Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * The StageDisplayState class provides constant values to enter and leave full screen mode.
 * @since Flash Player 9.0.28.0
 * @author eKameleon
 */
class asgard.display.StageDisplayState 
{

	/**
	 * Specifies the state to enter full screen mode.
	 */
	static public var FULLSCREEN:String = "fullScreen" ;
	
	/**
	 * The name of the Stage method to change the display state mode. Only in AS2 with intrinsic class not configured.
	 */
	static public var METHOD_NAME:String = "displayState" ;
	
	/**
	 * Specifies the state to leave full screen mode.
	 */
	static public var NORMAL:String = "normal" ;
	
}