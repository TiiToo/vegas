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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * ECMA 262 Unicode IFormat-Control Characters tools.
 * <p><b>Example :</b></p>
 * {@code
 * UnicodeChar = vegas.string.UnicodeChar ;
 * 
 * trace("-----") ;
 * 
 * trace("Number of white space characters : " + UnicodeChar.WHITE_SPACE_CHARS.length) ;
 * 
 * trace("-----") ;
 * 
 * trace( "|" + UnicodeChar.TAB + "hello world" ) ;
 * 
 * trace("-----") ;
 * 
 * trace ("isWhiteSpace UnicodeChar.TAB : " + UnicodeChar.isWhiteSpace( UnicodeChar.TAB ) ) ;
 * 
 * trace("-----") ;
 * 
 * trace("UnicodeChar.toChar('0040') : " + UnicodeChar.toChar("0040")) ; // Char
 * trace("UnicodeChar.toChar('0040') : " + UnicodeChar.toString("0040")) ; // String
 * 
 * trace("UnicodeChar.toUnicode('220')  : " + UnicodeChar.toUnicode(220)) ;
 * trace("UnicodeChar.toChar(UnicodeChar.toUnicode('220')) : " + UnicodeChar.toChar(UnicodeChar.toUnicode(220))) ;
 * 
 * trace("-----") ;
 * 
 * u = new UnicodeChar() ;
 * trace( u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) ;
 * }
 * @author eKameleon
 * @see <a href='http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf'>ECMAScript 262 specifications</a>
 */
if (vegas.string.UnicodeChar == undefined) 
{
	
	/**
	 * @requires vegas.core.types.Char
	 */
	require("vegas.core.types.Char") ;
	
	/**
	 * Creates the UnicodeChar reference.
	 */
	vegas.string.UnicodeChar = function()
	{
		//
	}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.string.UnicodeChar.extend( vegas.core.CoreObject ) ;

	/**
	 * Back Slash utf8 representation (special char).
	 */
	vegas.string.UnicodeChar.BACK_SLASH /*String*/ = "\u005C" ;	

	/**
	 * Back Space utf8 representation (special char).
	 */
	vegas.string.UnicodeChar.BACK_SPACE /*String*/ = "\u0008" ;
	
	/**
	 * Simple Quote utf8 representation (special char).
	 */
	vegas.string.UnicodeChar.SIMPLE_QUOTE /*String*/ = "\u0027" ;

	/**
	 * Double Quote utf8 representation (special char).
	 */
	vegas.string.UnicodeChar.DOUBLE_QUOTE /*String*/ = "\u0022" ;
	
	/**
	 * Tab utf8 representation (whitespace).
	 */
	vegas.string.UnicodeChar.TAB /*String*/ = "\u0009" ; // Tab

	/**
	 * Vertical Tab utf8 representation (whitespace).
	 */
	vegas.string.UnicodeChar.VT /*String*/ = "\u000B" ; // Vertical Tab
	
	/**
	 * Form Feed utf8 representation (whitespace).
	 */
	vegas.string.UnicodeChar.FF /*String*/ = "\u000C" ; // Form Feed
	
	/**
	 * Space utf8 representation (whitespace).
	 */
	vegas.string.UnicodeChar.SP /*String*/ = "\u0020" ; // Space

	/**
	 * No-break space utf8 representation (whitespace).
	 */
	vegas.string.UnicodeChar.NBSP /*String*/ = "\u00A0" ; // 

	/**
	 * Array with all whitespace characters. NB : USP no implement (Any other Unicode "space separator")
	 */
	vegas.string.UnicodeChar.WHITE_SPACE_CHARS /*Array*/ = 
	[ 
		vegas.string.UnicodeChar.TAB , 
		vegas.string.UnicodeChar.VT , 
		vegas.string.UnicodeChar.FF , 
		vegas.string.UnicodeChar.SP , 
		vegas.string.UnicodeChar.NBSP ,
		" "
	] ;
	
	/**
	 * Line Feed utf8 representation (line terminators).
	 */
	vegas.string.UnicodeChar.LF /*String*/ = "\u000A" ; // Line Feed : UNIX Based Systems - DOS

	/**
	 * Carriage Return utf8 representation (line terminators).
	 */
	vegas.string.UnicodeChar.CR /*String*/ = "\u000D" ; // Carriage Return : Apple Machintosh - DOS

	/**
	 * Line Separator utf8 representation (line terminators).
	 */
	vegas.string.UnicodeChar.LS /*String*/ = "\u2028" ; 

	/**
	 * Paragraph Separator utf8 representation (line terminators).
	 */
	vegas.string.UnicodeChar.PS /*String*/ = "\u2029" ;	
	
	/**
	 * Array with all line terminators characters
	 */
	vegas.string.UnicodeChar.LINE_TERMINATOR_CHARS /*Array*/ = 
	[ 
		vegas.string.UnicodeChar.LF, 
		vegas.string.UnicodeChar.CR, 
		vegas.string.UnicodeChar.LS, 
		vegas.string.UnicodeChar.PS 
	] ;
	
	/**
	 * Returns {@code true} of the specified character is a whitespace.
	 * @return {@code true} of the specified character is a whitespace.
	 */
	vegas.string.UnicodeChar.isWhiteSpace = function ( ch /*String*/ ) /*Boolean*/ 
	{
		var c /*Char*/  = (ch || "").substring(0, 1) ;
		var ar/*Array*/ = vegas.string.UnicodeChar.WHITE_SPACE_CHARS ;
		var l /*Number*/ = ar.length ;
		while (--l > -1) 
		{
			if (ar[l] == c) return true ;
		}
		return false ;
	}

	/**
	 * Returns {@code true} of the specified character is a line terminator.
	 * @return {@code true} of the specified character is a line terminator.
	 */
	vegas.string.UnicodeChar.isLineTerminators = function ( ch /*String*/ ) /*Boolean*/ 
	{
		var c /*Char*/ = (ch || "").substring(0, 1) ;
		var ar /*Array*/ = vegas.string.UnicodeChar.LINE_TERMINATOR_CHARS ;
		var l /*Number*/ = ar.length ;
		while (--l > -1) {
			if (ar[l] == c) return true ;
		}
		return false ;
	}

	/**
	 * Converts a unicode representation and returns this char's string.
	 * @return The char of the unicode representation.
	 */
	vegas.string.UnicodeChar.toChar = function ( unicode /*String*/ ) /*Char*/ 
	{
		return new vegas.core.types.Char( vegas.string.UnicodeChar.toCharString( unicode ) ) ;
	}

	/**
	 * Converts a unicode representation and returns this char's string.
	 * @return The char of the unicode representation.
	 */
	vegas.string.UnicodeChar.toCharString = function ( unicode /*String*/ ) /*String*/ 
	{
		return String.fromCharCode(parseInt( unicode, 16)) ;
	}

	/**
	 * Converts an unicode number value and returns this string representation.
	 * @return The string representation of a unicode number.
	 */
	vegas.string.UnicodeChar.toUnicode = function (n /*Number*/) /*String*/ 
	{
		var hex /*String*/ = n.toString(16) ;
		while( hex.length < 4 ) {
			hex = "0" + hex ;
		}
		return hex ;
	}
	
	/**
	 * Resolve the methods used over this instance.
	 * If this instance receive an unknow method with the format "uXXXX" this method returns the unicode Char.  
	 */	
	proto.__resolve = function ( name /*String*/ ) 
	{
		return function() 
  		{ 
  			return String.fromCharCode( name.replace( /^u/ , "0x" ) ) ; 
  		} ;
	}

}