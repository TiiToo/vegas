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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** AntiAliasType

	AUTHOR

		Name : AntiAliasType
		Package : asgard.text
		Version : 1.0.0.0
		Date :  2006-05-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		A class that provides values for anti-aliasing in the TextField class.

	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		- static ADVANCED:String = "advanced"
			
			[static] Sets anti-aliasing to advanced anti-aliasing.
	
		- static NORMAL:String = "normal"
		
			[static] Sets anti-aliasing to the anti-aliasing that is used in Flash Player 7 and earlier.

**/


/**
 * AntiAliasType.
 * @author eKameleon
 * @version 1.0.0.0
 **/
 
class asgard.text.AntiAliasType {
	
	// ----o Constructor
	
	private function AntiAliasType(){
		//
	}
	
	// ----o Constant
	
	static public var ADVANCED:String = "advanced" ;
	
	static public var NORMAL:String = "normal" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(AntiAliasType, null , 7, 7) ;

}