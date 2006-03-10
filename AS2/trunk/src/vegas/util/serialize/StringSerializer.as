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

/* ------- StringSerializer

	AUTHOR
	
		Name : StringSerializer
		Package : vegas.util.serialize
		Version : 1.0.0.0
		Date :  2005-12-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		EDEN Compatibility to serialize ECMAScript data.

	METHOD SUMMARY
	
		- toSource(s:String):String
	
----------  */

import vegas.string.UnicodeChar;

class vegas.util.serialize.StringSerializer {

	// ----o Construtor
	
	private function StringSerializer() {
		//
	}
	
	// ----o Static Methods

	static public function toSource(s:String):String {
		s = new String(s) ;
		var ch:String ;
		var code:Number ;
		var quote:String = "\"" ;
		var str:String = "" ;
		var pos:Number = 0 ;
		var toUnicode:Function = UnicodeChar.toUnicode ;
		var l:Number = s.length ;
		while( pos < l ) {
			ch = s.charAt(pos) ;
			code = s.charCodeAt(pos) ;
			if( code > 0xFF ) str += "\\u" + toUnicode( code ) ;
			else if (ch == UnicodeChar.BACK_SPACE)  str += "\\b" ; // backspace
			else if (ch == UnicodeChar.TAB) str += "\\t" ; // horizontal tab
			else if (ch == UnicodeChar.LF) str += "\\n" ; // line feed
			else if (ch == UnicodeChar.VT) str += "\\v" ; // vertical tab
			else if (ch == UnicodeChar.FF) str += "\\f" ; // form feed
			else if (ch == UnicodeChar.CR) str += "\\r"; // carriage return
			else if (ch == UnicodeChar.DOUBLE_QUOTE) str += "\\\"" ; // double quote
           	else if (ch == UnicodeChar.SIMPLE_QUOTE) str += "\\\'" ; // single quote
			else if (ch == UnicodeChar.BACK_SLASH) str += "\\\\" ; // backslash
			else str += ch ;
			pos++ ;
		}
		return quote + str + quote ;
    }

}