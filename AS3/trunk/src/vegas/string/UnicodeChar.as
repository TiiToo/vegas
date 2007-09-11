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

package vegas.string
{
    
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
    
    import vegas.core.types.Char;
    import vegas.util.StringUtil;

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
     * trace("UnicodeChar.toChar('0040') : " + UnicodeChar.toChar("0040")) ;
     * 
     * trace("UnicodeChar.toUnicode('220')  : " + UnicodeChar.toUnicode(220)) ;
     * trace("UnicodeChar.toChar(UnicodeChar.toUnicode('220')) : " + UnicodeChar.toChar(UnicodeChar.toUnicode(220))) ;
     * 
     * trace("-----") ;
     * 
     * u = new UnicodeChar() ;
     * trace( u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) ; // 小飼弾@
     * }
     * @author eKameleon
     * @see <a href='http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf'>ECMAScript 262 specifications</a>
     */
    dynamic public class UnicodeChar extends Proxy
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
       	static public const BACK_SLASH:String = "\u005C" ;	

	    /**
    	 * Back Space utf8 representation (special char).
    	 */
	    static public const BACK_SPACE:String = "\u0008" ;

	    /**
    	 * Simple Quote utf8 representation (special char).
    	 */
        static public const SIMPLE_QUOTE:String = "\u0027" ;

	    /**
    	 * Double Quote utf8 representation (special char).
    	 */
        static public const DOUBLE_QUOTE:String = "\u0022" ;
	
    	/**
    	 * Tab utf8 representation (whitespace).
    	 */
        static public const TAB:String = "\u0009" ;

	    /**
    	 * Vertical Tab utf8 representation (whitespace).
    	 */
        static public const VT:String = "\u000B" ;
        
    	/**
    	 * Form Feed utf8 representation (whitespace).
    	 */
        static public const FF:String = "\u000C" ;
   
   	   /**
	    * Space utf8 representation (whitespace).
	    */
        static public const SP:String = "\u0020" ;

    	/**
    	 * No-break space utf8 representation (whitespace).
    	 */
        static public const NBSP:String = "\u00A0" ;

    	/**
    	 * Array with all whitespace characters. NB : USP no implement (Any other Unicode "space separator")
    	 */
        static public const WHITE_SPACE_CHARS:Array = [ TAB, VT, FF, SP, NBSP ] ;
        
       	/**
	     * Line Feed utf8 representation (line terminators).
	     */
        static public const LF:String = "\u000A" ;
        
    	/**
    	 * Carriage Return utf8 representation (line terminators).
    	 */
        static public const CR:String = "\u000D" ;

    	/**
    	 * Line Separator utf8 representation (line terminators).
	     */        
        static public const LS:String = "\u2028" ;	

    	/**
    	 * Paragraph Separator utf8 representation (line terminators).
	     */   
        static public const PS:String = "\u2029" ;	

    	/**
    	 * Array with all line terminators characters
    	 */
	    static public const LINE_TERMINATOR_CHARS:Array = [ LF, CR, LS, PS ] ;

        /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {
            if ( String(methodName) != null )
            {
                return String.fromCharCode( String(methodName).replace( /^u/ , "0x" ) ) ;
            }
            else
            {
                return "" ;
            } 
        }

    	/**
    	 * Returns {@code true} of the specified character is a whitespace.
    	 * @return {@code true} of the specified character is a whitespace.
    	 */
	    static public function isWhiteSpace( char:String ):Boolean 
	    {
            var c:Char = new Char(char) ;
		    return (WHITE_SPACE_CHARS.indexOf(c) != -1) ;
        }

    	/**
    	 * Returns {@code true} of the specified character is a line terminator.
    	 * @return {@code true} of the specified character is a line terminator.
    	 */
        static public function isLineTerminators( char:String ):Boolean 
        {
		    var c:Char = new Char(char) ;
        	return (LINE_TERMINATOR_CHARS.indexOf(c) != -1) ;
        }

    	/**
    	 * Converts a unicode representation and returns this char's string.
    	 * @return The char of the unicode representation.
    	 */
	    static public function toChar( unicode:String ):String
	    {
            return String.fromCharCode(parseInt( unicode, 16)) ;
        }

	    /**
    	 * Converts an unicode number value and returns this string representation.
	     * @return The string representation of a unicode number.
    	 */
        static public function toUnicode(n:Number):String 
        {
    	    var hex:String = n.toString(16) ;
        	while( hex.length < 4 ) hex = "0" + hex ;
        	return hex ;
        }
    
    }

}