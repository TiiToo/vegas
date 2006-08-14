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

/** UnicodeChar

	AUTHOR
	
		Name : UnicodeChar
		Package : vegas.string
		Version : 1.0.0.0
		Date :  2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		ECMA 262 Unicode IFormat-Control Characters
		>> http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf

	SPECIAL CHARACTERS
	
		- BACK_SLASH : Back Slash
		- BACK_SPACE : Back Space
		- DOUBLE_QUOTE : Double Quote
		- SIMPLE_QUOTE : Simple Quote
		
	WHITESPACE
	
		- TAB : Tab
		- VT : Vertical Tab
		- FF : Form Feed
		- SP : Space
		- NBSP : No-break space

		- WHITE_SPACE_CHARS : array with all whitespace characters
		
		NB : USP no implement (Any other Unicode "space separator")
	
	LINE TERMINATORS

		- LF : Line Feed
		- CR : Carriage Return
		- LS : Line Separator
		- PS : Paragraph Separator

		- LINE_TERMINATOR_CHARS : array with all line terminators characters
		
	METHOD SUMMARY
	
		- isWhiteSpace( char:String ):Boolean
		
		- isLineTerminators( char:String ):Boolean
		
		- toChar( unicode:String ):Char
		
		- toUnicode(n:Number):String	
	
	EXAMPLE
	
		import vegas.string.UnicodeChar ;
		import vegas.core.types.Char ;
		import flash.utils.trace ;
		
		trace (UnicodeChar.WHITE_SPACE_CHARS.length) ;
		
		var str:String = UnicodeChar.TAB + "coucou" ;
		trace (str) ;
		
		var s:Char = new Char('\t') ;
		var b:Boolean = UnicodeChar.isWhiteSpace(s) ;
		trace ("isWhiteSpace : " + b) ;
		
		var unicode:String = "0040" ;
		var char:Char = UnicodeChar.toChar(unicode) ;
		trace(">> " + char) ;
	
**/

package vegas.string
{
    
    import vegas.core.types.Char ;
    
    public class UnicodeChar
    {
    
           	// ---- Special Char
        
        	static public const BACK_SLASH:String = "\u005C" ;	
	        static public const BACK_SPACE:String = "\u0008" ;
    	    static public const SIMPLE_QUOTE:String = "\u0027" ;
    	    static public const DOUBLE_QUOTE:String = "\u0022" ;
	
        	// ---- WhiteSpace

        	static public const TAB:String = "\u0009" ;
        	static public const VT:String = "\u000B" ;
        	static public const FF:String = "\u000C" ;
        	static public const SP:String = "\u0020" ;
        	static public const NBSP:String = "\u00A0" ;

        	static public const WHITE_SPACE_CHARS:Array = [ TAB, VT, FF, SP, NBSP ] ;
	
	        // ---- Line Terminators
	
        	static public const LF:String = "\u000A" ;
        	static public const CR:String = "\u000D" ;
        	static public const LS:String = "\u2028" ;	
        	static public const PS:String = "\u2029" ;	

	        static public const LINE_TERMINATOR_CHARS:Array = [ LF, CR, LS, PS ] ;
	
        	// ----o Public Methods
	
	        static public function isWhiteSpace( char:String ):Boolean 
	        {
        		var c:Char = new Char(char) ;
		        return (WHITE_SPACE_CHARS.indexOf(c) != -1) ;
        	}

        	static public function isLineTerminators( char:String ):Boolean 
        	{
		        var c:Char = new Char(char) ;
        		return (LINE_TERMINATOR_CHARS.indexOf(c) != -1) ;
        	}

	        static public function toChar( unicode:String ):Char 
	        {
        		return new Char(String.fromCharCode(parseInt( unicode, 16))) ;
        	}

            static public function toUnicode(n:Number):String 
            {
    		    var hex:String = n.toString(16) ;
        		while( hex.length < 4 ) hex = "0" + hex ;
        		return hex ;
        	}
    }
}