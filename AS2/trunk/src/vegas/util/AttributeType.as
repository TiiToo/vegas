/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** AttributeType

	AUTHOR

		Name : AttributeType
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2006-01-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		based on ECMA-262 property attributes specification [chapter 8.6.1 - PDF p38/188]

	CONSTANT SUMMARY
	
		- DELETE_ONLY:Number
		
		- DONT_DELETE:Number
		
		- DONT_ENUM:Number
		
		- ENUM_ONLY:Number
		
		- LOCKED:Number
		
		- NONE:Number
		
		- OVERRIDE_ONLY:Number
		
		- READ_ONLY:Number
	
	THANKS
	
		Zwetan : Core2 AS2 Framework inspiration for refactoring !
		
	TODO [2006-01-09] Use Number Constants.
	
**/

class vegas.util.AttributeType {

	// ----o Construtor
	
	private function AttributeType() {
		//
	}
	
	// ----o Constant
	
	static public var NONE:Number = 0 ;
	static public var DONT_ENUM:Number = 1 ;
	static public var DONT_DELETE:Number = 2 ;
	static public var READ_ONLY:Number = 4 ;
	static public var OVERRIDE_ONLY:Number = DONT_ENUM | DONT_DELETE ; // 3
	static public var DELETE_ONLY:Number = DONT_ENUM | READ_ONLY ; // 5
	static public var ENUM_ONLY:Number = READ_ONLY | DONT_DELETE ; // 6
	static public var LOCKED:Number = DONT_DELETE | DONT_ENUM | READ_ONLY ; // 7

	static private var __ASPF__ = _global.ASSetPropFlags(AttributeType, null, 7, 7) ;
	
}