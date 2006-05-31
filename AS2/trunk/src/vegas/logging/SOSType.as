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

/** SOSType

	AUTHOR
	
		Name : SOSType
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-01-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- const static ALL_COLOR:Number
		
		- const static CLEAR:String
		
		- const static DEBUG_COLOR:Number
		
		- const static DEFAULT_COLOR:Number
		
		- const static DISABLE:Number
		
		- const static ENABLE:Number
		
		- const static ERROR_COLOR:Number
		
		- const static EXIT:String
		
		- const static FATAL_COLOR:Number
		
		- const static HOST:String
		
		- const static INFO_COLOR:Number
		
		- const static PORT:Number
		
		- const static WARN_COLOR:Number

**/	

class vegas.logging.SOSType {
	
	// ----o Constructor 
	
	private function SOSType() {
		//		
	}

	// ----o Constant

	static public var ALL_COLOR:Number = 0xD7EEFD ;
	static public var CLEAR:String = "!SOS<clear/>\n" ;
	static public var DEBUG_COLOR:Number = 0xDEECFE ;
	static public var DEFAULT_COLOR:Number = 0xFFFFFF ;
	static public var DISABLE:Number = 0 ;
	static public var ENABLE:Number = 1 ;
	static public var ERROR_COLOR:Number = 0xEDCC81 ;
	static public var EXIT:String = "!SOS<exit/>" ;
	static public var FATAL_COLOR:Number = 0xFDD1B5 ;
	static public var HOST:String = "localhost" ;
	static public var INFO_COLOR:Number = 0xD2FAB8 ;
	static public var PORT:Number = 4444 ;
	static public var WARN_COLOR:Number = 0xFDFDB5 ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(SOSType, null , 7, 7) ;

}