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

/** TextFieldAutoSize

	AUTHOR

		Name : TextFieldAutoSize
		Package : asgard.text
		Version : 1.0.0.0
		Date :  2006-03-21
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		The TextFieldAutoSize class is an enumeration of constant values used in setting the autoSize property of the TextField class.

	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
		static const CENTER:String = "center"
			
			Specifies that the text is to be treated as center-justified text.
		
		static const LEFT:String = "left"
			
			Specifies that the text is to be treated as left-justified text, meaning that the left side of the text field remains fixed and any resizing of a single line is on the right side.
		
		static const NONE:String = "none"
			
			Specifies that no resizing is to occur.
		
		static const RIGHT:String = "right"
			
			Specifies that the text is to be treated as right-justified text, meaning that the right side of the text field remains fixed and any resizing of a single line is on the left side.

**/


/**
 * The TextFieldAutoSize class is an enumeration of constant values used in setting the autoSize property of the TextField class.
 * @author eKameleon
 * @version 1.0.0.0
 **/
 
class asgard.text.TextFieldAutoSize {
	
	// ----o Constructor
	
	private function TextFieldAutoSize(){
		//
	}
	
	// ----o Constant
	
	static public var CENTER:String = "center" ;
	
	static public var LEFT:String = "left" ;
	
	static public var NONE:String = "none" ;
	
	static public var RIGHT:String = "right" ;

	static private var __ASPF__ = _global.ASSetPropFlags(TextFieldAutoSize, null , 7, 7) ;

}