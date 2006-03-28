﻿/*

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

/* -------- StageAlign

	AUTHOR

		Name : TextFieldAutoSize
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-03-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net


	DESCRIPTION
	
		The TextFieldType class is an enumeration of constant values used in setting the type property of the TextField class.

	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		static const DYNAMIC:String = "dynamic"
			
			Used to specify a dynamic TextField.
		
		static const INPUT:String = "input"
			
			Used to specify an input TextField.

------------*/


/**
 * The TextFieldType class is an enumeration of constant values used in setting the type property of the TextField class.
 * @author eKameleon
 * @version 1.0.0.0
 **/
 
class asgard.display.TextFieldType {
	
	// ----o Constructor
	
	private function TextFieldType () {
		//
	}
	
	// ----o Constant
	
	static public var DYNAMIC:String = "dynamic" ;
	
	static public var INPUT:String = "input" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(TextFieldType, null , 7, 7) ;

}