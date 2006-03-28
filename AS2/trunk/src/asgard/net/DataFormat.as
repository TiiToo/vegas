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

/* -------- DataFormat

	AUTHOR

		Name : DataFormat
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-03-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

 	CONSTANT SUMMARY
  
 		static const BINARY:String = "binary"
			Specifies that downloaded data is received as raw binary data.
  	
 		static const TEXT:String = "text"
			Specifies that downloaded data is received as text.
 
 		static const VARIABLES:String = "variables"
			Specifies that downloaded data is received as URL-encoded variables.

------------*/

/**
 * @author eKameleon
 */
 
 
class asgard.net.DataFormat {

	// ----o Constructor
	
	private function DataFormat(){
		//	
	}
	
	// ----o Constants
	
	static public var BINARY:String = "binary" ;
		
	static public var TEXT:String = "text" ;
	
	static public var VARIABLES:String = "variables" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(DataFormat, null , 7, 7) ;

	// ----o Public Methods

	static public function validate(sFormat:String):Boolean {
		return (sFormat == DataFormat.BINARY) || (sFormat == DataFormat.TEXT) || (sFormat == DataFormat.VARIABLES) ;
	}

}