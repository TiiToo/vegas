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

/** TextFormatAlign

	AUTHOR

		Name : TextFormatAlign
		Package : asgard.text
		Version : 1.0.0.0
		Date :  2006-05-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		A class that provides values for text alignment in the TextFormat class.

	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		- static const CENTER:String = "center"
			
			[static] Centers the text in the text field.
		
		- static const JUSTIFY:String = "justify"
			
			[static] Justifies text within the text field.(only >= FP8).

		- static const LEFT:String = "left"

			[static] Aligns text to the left within the text field.

		- static const RIGHT:String = "right"

			[static] Aligns text to the right within the text field.

**/

/**
 * TextFormatAlign
 * @author eKameleon
 * @version 1.0.0.0
 **/
 
class asgard.text.TextFormatAlign {
	
	// ----o Constructor
	
	private function TextFormatAlign () {
		//
	}
	
	// ----o Constant
	
	static public var CENTER:String = "center" ;
	
	static public var JUSTIFY:String = "justify" ;
	
	static public var LEFT:String = "left" ;
	
	static public var RIGHT:String = "right" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(TextFormatAlign, null , 7, 7) ;

}