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

import vegas.core.types.Char;
import vegas.util.StringUtil;

/**
 * ECMA 262 Unicode IFormat-Control Characters tools.
 * <p><b>Example :</b></p>
 * {@code
 * import vegas.string.UnicodeChar ;
 * 
 * trace( "## The White space chars array." ) ;
 * 
 * // The length of the UnicodeChar.WHITE_SPACE_CHARS array : 5
 * trace ("The length of the UnicodeChar.WHITE_SPACE_CHARS array : " + UnicodeChar.WHITE_SPACE_CHARS.length) ;
 * 
 * trace("---------") ;
 * 
 * trace( "## Use the UnicodeChar constants." ) ;
 * // | UnicodeChar.TAB hello world : |	hello world
 * trace ("| UnicodeChar.TAB hello world : " +  "|" + UnicodeChar.TAB + "hello world" ) ;
 * 
 * trace("---------") ;
 * 
 * trace( "## Test if a charactere is a whitespace." ) ;
 * // UnicodeChar.TAB isWhiteSpace : true
 * trace ("UnicodeChar.TAB isWhiteSpace : " + UnicodeChar.isWhiteSpace( UnicodeChar.TAB ) ) ;
 * 
 * trace("---------") ;
 * 
 * trace( "## Converts a String unicode number representation in this character representation." ) ;
 * // UnicodeChar.toChar("0040" ) : @
 * trace( 'UnicodeChar.toChar("0040" ) : ' + UnicodeChar.toChar( "0040" ) ) ;
 * 
 * trace("---------") ;
 * 
 * trace( "## Use a UnicodeChar instance and this proxy process." ) ;
 * var u:UnicodeChar = new UnicodeChar() ;
 * // u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) : 小飼弾@
 * trace( 'u.u5c0f() + u.u98fc() + u.u5f3e()) : ' + u.u5c0f() + u.u98fc() + u.u5f3e()  ) ;
 * }
 * @author eKameleon
 * @see <a href='http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf'>ECMAScript 262 specifications</a>
 */
dynamic class vegas.string.UnicodeChar 
{

	/**
	 * Creates a new UnicodeChar instance.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var u:UnicodeChar = new UnicodeChar() ;
	 * trace( u.u0040() ) ; // @
	 * }
	 */
	public function UnicodeChar()
	{
		//	
	}
	
	/**
	 * Back Slash utf8 representation (special char).
	 */
	public static var BACK_SLASH:String = "\u005C" ;	

	/**
	 * Back Space utf8 representation (special char).
	 */
	public static var BACK_SPACE:String = "\u0008" ;
	
	/**
	 * Simple Quote utf8 representation (special char).
	 */
	public static var SIMPLE_QUOTE:String = "\u0027" ;
	
	/**
	 * Double Quote utf8 representation (special char).
	 */
	public static var DOUBLE_QUOTE:String = "\u0022" ;
	
	/**
	 * Tab utf8 representation (whitespace).
	 */
	public static var TAB:String = "\u0009" ;

	/**
	 * Vertical Tab utf8 representation (whitespace).
	 */
	public static var VT:String = "\u000B" ;
	
	/**
	 * Form Feed utf8 representation (whitespace).
	 */
	public static var FF:String = "\u000C" ;
	
	/**
	 * Space utf8 representation (whitespace).
	 */
	public static var SP:String = "\u0020" ;

	/**
	 * No-break space utf8 representation (whitespace).
	 */
	public static var NBSP:String = "\u00A0" ;

	/**
	 * Array with all whitespace characters. NB : USP no implement (Any other Unicode "space separator")
	 */
	public static var WHITE_SPACE_CHARS:Array = [ TAB, VT, FF, SP, NBSP ] ;
	
	/**
	 * Line Feed utf8 representation (line terminators).
	 */
	public static var LF:String = "\u000A" ;

	/**
	 * Carriage Return utf8 representation (line terminators).
	 */
	public static var CR:String = "\u000D" ;

	/**
	 * Line Separator utf8 representation (line terminators).
	 */
	public static var LS:String = "\u2028" ;

	/**
	 * Paragraph Separator utf8 representation (line terminators).
	 */
	public static var PS:String = "\u2029" ;	

	/**
	 * Array with all line terminators characters
	 */
	public static var LINE_TERMINATOR_CHARS:Array = [ LF, CR, LS, PS ] ;
	
	
	private static var __ASPF__ = _global.ASSetPropFlags(UnicodeChar, null , 7, 7) ;
	
	/**
	 * Returns {@code true} of the specified character is a whitespace.
	 * @return {@code true} of the specified character is a whitespace.
	 */
	public static function isWhiteSpace( char:String ):Boolean 
	{
		var c:String = (char || "").substring(0, 1) ;
		var ar:Array = WHITE_SPACE_CHARS ;
		var l:Number = ar.length ;
		while (--l > -1) 
		{
			if (ar[l] == char) 
			{
				return true ;
			}
		}
		return false ;
	}

	/**
	 * Returns {@code true} of the specified character is a line terminator.
	 * @return {@code true} of the specified character is a line terminator.
	 */
	public static function isLineTerminators( char:String ):Boolean 
	{
		var c:String = (char || "").substring(0, 1) ;
		var ar:Array = LINE_TERMINATOR_CHARS ;
		var l:Number = ar.length ;
		while (--l > -1) 
		{
			if (ar[l] == char) 
			{
				return true ;
			}
		}
		return false ;
	}

	/**
	 * Converts a unicode representation in a Char representation and returns this char's string.
	 * @return The char of the unicode representation.
	 */
	public static function toChar( unicode:String ):Char 
	{
		return new Char( toCharString(unicode) ) ;
	}

	/**
	 * Converts a unicode representation in a String representation and returns the new String.
	 * @return The char of the unicode representation.
	 */
	public static function toCharString( unicode:String ):String 
	{
		return String.fromCharCode( parseInt( unicode, 16) )  ;
	}

	/**
	 * Converts an unicode number value and returns this string representation.
	 * @return The string representation of a unicode number.
	 */
    public static function toUnicode(n:Number):String 
    {
		var hex:String = n.toString(16) ;
		while( hex.length < 4 )
		{
			hex = "0" + hex ;
		}
		return hex ;
	}
	
	/**
	 * Resolve the methods used over this instance.
	 * If this instance receive an unknow method with the format "uXXXX" this method returns the unicode Char.  
	 */
	private function __resolve( name:String ) 
	{
  		return function() 
  		{ 
  			return UnicodeChar.toCharString( "" + StringUtil.replace( name, 'u' , "" ) ) ; 
  		} ;
	};
}