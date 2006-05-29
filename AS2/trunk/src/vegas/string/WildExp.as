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

/** WildExp

	AUTHOR
	
		Name : WildExp
		Package : vegas.string
		Version : 1.0.0.0
		Date :  2005-05-27
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
		
		A wild expression is constructed like a regular expression but is based 
		on a globbing algorithm like the one you found for searching files on a hard-drive.
	
	CONSTANT SUMMARY
	
		- IGNORECASE
		
		- MULTILINE
		
		- MULTIWORD
		
		- NONE
	
	PROPERTY SUMMARY
	
		- questionsMarks:Array
		
		- source:String
		
		- wildcards:Array
	
	METHOD SUMMARY
	
		- addToQuestionMarks(chr:String):Void
		
		- addToWildcards(chr:String):Void
		
		- test(str:String)
	
	SYNTAX
	
		1. ? : match any unique char - exactly 1 char must be found
		2. * : match any number of chars - at least 0 or more any chars can be found
		3. ! : ignore next char
	
	RULES :
	
		1. "*" is equal to "**" to "***" to an infinity number of "*" chars      
		2. "*?" is concatened to "*" (more precisely "*?*")
		3. "*" if for zero char to infinity chars
		4. "!*" ignore the pattern and look for the char "*" in string
		4. "!?" ignore the pattern and look for the char "?" in string
	
	TIPS AND TRICKS :
		
		1. find all the words in a string
			
			import vegas.string.WildExp ;
			var we:WildExp = new WildExp( "*", WildExp.IGNORECASE | WildExp.MULTIWORD );
			result = we.test( "any phrases with words inside" );
			//result = [ "any", "phrases", "with", "words", "inside" ];
		
		2. find comments in a string
			import vegas.string.WildExp ;
			var we:WildExp = new WildExp( "*\/!**!*!/\*", WildExp.IGNORECASE | WildExp.MULTIWORD );
			result = we.test( "toto = \"123\"; /\*hello world*\/" );
			//result = [ "toto = \"123\"; ", "hello world" ] ;
      
		3. find the name, arguments and body of a function
			import vegas.string.WildExp ;
			var we:WildExp = new WildExp( "function *(*)*{*}", WildExp.IGNORECASE | WildExp.MULTIWORD );
			result = we.test( "function toto( a, b, c )\r\n{\treturn \"hello world\";\r\n\t}" );
			//result = [ "toto", " a, b, c ", "\r\n", "\treturn \"hello world\";\r\n\t" ];
      

	THANKS
		
		Zwetan : Flashcodeurs mailing list [FMX] WildExp 2004/11/23
		J'ai juste traduis la classe de Zwetan en AS2 ^_^ 
		Les commentaires au dessus sont aussi de Zwetan. 

	SEE ALSO
	
		- vegas.string.StringUtil : replace()
		- vegas.string.UnicodeChar : WHITE_SPACE_CHARS and LINE_TERMINATOR_CHARS constants

**/	

import vegas.core.CoreObject;
import vegas.string.UnicodeChar;
import vegas.util.StringUtil;

class vegas.string.WildExp extends CoreObject {

	// -----o Constructor
	
	public function WildExp (pattern:String, flag:Number) {
		
		if( isNaN(flag) ) flag = NONE ;
       	wildcards = [] ;
		questionMarks = [] ;
		
		_caseSensitive = true ;
		_multiline = false ;
		_multiword = false ;
		_wildcardFound = false;
		_questionMarksFound = false ;
    
		switch(flag) {
        	case IGNORECASE : // 1
				_caseSensitive = false ;
				break;
        	case MULTILINE :
				_multiline = true ; // 2
				break;
			case IGNORECASE | MULTILINE : //3
				_caseSensitive = false ;
				_multiline = true ;
				break ;
			case MULTIWORD : // 4
				_multiword = true ;
				break;
			case IGNORECASE | MULTIWORD : // 5
				_caseSensitive = false ;
				_multiword = true ;
				break ;
			case MULTILINE | MULTIWORD : // 6
				_multiline = true ;
				_multiword = true ;
				break;
			case IGNORECASE | MULTILINE | MULTIWORD : // 7
				_caseSensitive = false ;
				_multiline = true ;
				_multiword = true ;
				break ;
			case NONE : 
			default:
        }
		
		if( _caseSensitive ) pattern = pattern.toLowerCase();
        
		source = pattern ;
    
    }
	
	// -----o CONSTANT
	
	static public var NONE:Number = 0 ;
	static public var IGNORECASE:Number = 1 ;
	static public var MULTILINE:Number = 2 ;
	static public var MULTIWORD:Number = 4 ;

	static private var __ASPF__ = _global.ASSetPropFlags(WildExp, null , 7, 7) ;

	// -----o Public Properties
	
	public var wildcards:Array ;
	public var questionMarks:Array ;
	public var source:String ;
	
	// -----o Public Methods

	public function addToQuestionMarks(chr:String):Void {
		var l:Number = questionMarks.length ;
		if( l == 0 ) return ;
        questionMarks[l-1] += chr ;
    }
	
	public function addToWildcards(chr:String):Void {
		var l:Number = wildcards.length ;
		if( l == 0 ) return ;
		wildcards[l-1] += chr ;
    }

	public function test(str:String) {
		var segment, result:Array ;
		var i, j, k, l:Number ;
		var ORC:String  = "\uFFFC";
		var CRLF:String = "\r\n";
		if( _caseSensitive ) str = str.toLowerCase();
        if(_multiline) {
			var lineTerminatorChars:Array = UnicodeChar.LINE_TERMINATOR_CHARS ;
			if( str.indexOf( CRLF ) > -1 ) str = (new StringUtil(str)).replace(CRLF, ORC ) ;
			l = lineTerminatorChars.length ;
			for( i=0 ; i<l ; i++ ) {
				if( str.indexOf( lineTerminatorChars[i] ) > -1 ) {
					str = (new StringUtil(str)).replace(lineTerminatorChars[i], ORC ) ;
				}
            }
        }
		if( _multiword ) {
			var whiteSpaceChars:Array = UnicodeChar.WHITE_SPACE_CHARS ; 
			l = whiteSpaceChars.length ;
			for( j=0 ; j<l ; j++ ) {
				if( str.indexOf( whiteSpaceChars[j] ) > -1 ) {
					str = (new StringUtil(str)).replace(whiteSpaceChars[j], ORC ) ;
				}
            }
        }
		if( str.indexOf( ORC ) > -1 ) {
			segment = str.split( ORC ) ;
			result = [] ;
			l = segment.length ;
			for( k=0 ; k<l ; k++ ) {
				if( _testMatch( segment[k], source ) ) result.push( segment[k] ) ;
		    }
			return ( result.length > 0 ) ? result : false ;
        }
		return _testMatch( str, source ) ;
    }

	
	public function toString():String {
		return source ;
	}
	
	// -----o Private Properties
	
	private var _caseSensitive:Boolean ;
	private var _multiline = false ;
	private var _multiword = false ;
	private var _wildcardFound = false;
	private var _questionMarksFound = false;

	// -----o Private Methods
	
	private function _testMatch(str:String, pattern:String, ignoreChar:String ):Boolean {
		
		str = new String(str) ;
		pattern = new String(pattern) ;
				
		var c, c1, pat, pat1:String ;
		c = str.charAt( 0 ) ;
		c1 = str.charAt( 1 ) ;
		pat = pattern.charAt( 0 ) ;
		pat1 = pattern.charAt( 1 ) ;
    
		if( pat != "?" ) _questionMarksFound = false ;
        if( pat == "!" ) return _testMatch( str, pattern.substr( 1 ), pat1 );
        
		if( pat == "?" && ignoreChar != "?" ) {
			if( c != "" ) {
				if( _questionMarksFound ) addToQuestionMarks( c );
                else questionMarks.push( c ) ;
				_questionMarksFound = true ;
				if ((pat1 == "") && (_wildcardFound == true)) pattern += "*" ;
                return _testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
            } else {
				return false ;
            }
        }
		
		if( pat == "*" && ignoreChar != "*" ) {
			_wildcardFound = true ;
			if( pat1 != "*" ) wildcards.push( "" );
            if( pat1 == "" ) {
				addToWildcards( str ) ;
				return true ;
            }
			if( pattern.substr(1).indexOf( "*" ) > -1 ) {
				while( str != "" ) {
					if( pat1 == "*" ) break ;
					if( pat1 == "?" ) {
						pattern = pattern.substr(1) ;
						break ;
					}
					if( str == "" ) return false ;
					if( str.charAt(0) == pat1 ) break ;
					if( pat1 == "!" ) {
						ignoreChar = pattern.charAt( 2 ) ;
						pattern = pattern.substr( 2 ) ;
						pat1 = pattern.charAt( 1 ) ;
					}
					if( str.charAt(0) == ignoreChar ) {
						str = str.substr(1) ; continue ;
					}
					addToWildcards( str.charAt( 0 ) ) ;
					str = str.substr(1) ;
				}
				return _testMatch( str, pattern.substr( 1 ), ignoreChar ) ;
			} else {
				var found:Number = str.lastIndexOf( pat1 ) ;
				if( found != -1 ) {
					addToWildcards( str.substring( 0, found ) ) ;
					return _testMatch( str.substr( found ), pattern.substr( 1 ) ) ;
                } else if( pat1 == "?" ) {
					if( pattern.charAt(2) == "" ) return str.length >= 1 ;
                    else return _testMatch( str.substr( 1 ), pattern.substr( 1 ) );
                }
				return false;
            }
        }
		
		if( pat == "" ) return( c == "" );
        if( c != pat ) return false ;
		
        if( c != "" ) return _testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
        else return false ;
        
    }


}