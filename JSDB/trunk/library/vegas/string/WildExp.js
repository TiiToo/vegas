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
 * A wild expression is constructed like a regular expression but is based on a globbing algorithm like the one you found for searching files on a hard-drive.
 * <p><b>Syntax :</b>
 * <p>1. ? : match any unique char - exactly 1 char must be found</p>
 * <p>2. * : match any number of chars - at least 0 or more any chars can be found</p>
 * <p>3. ! : ignore next char</p>
 * </p>
 * <p><b>Rules :</b>
 * <p>1. "*" is equal to "**" to "***" to an infinity number of "*" chars</p>
 * <p>2. "*?" is concatened to "*" (more precisely "*?*")</p>
 * <p>3. "*" if for zero char to infinity chars</p>
 * <p>4. "!*" ignore the pattern and look for the char "*" in string</p>
 * <p>5. "!?" ignore the pattern and look for the char "?" in string</p>
 * </p>
 * <p><b>Example : find all the words in a string</b>
 * {@code 
 * WildExp = vegas.string.WildExp ;
 *
 * var pattern = "*" ;
 * var expression = "any phrases with words inside" ;
 *	
 * var we = new WildExp( "*", WildExp.IGNORECASE | WildExp.MULTIWORD );
 *	
 * trace( "> pattern    : [" + pattern + "]" );
 * trace( "> expression : " + expression );
 * 
 * result = we.test( "any phrases with words inside" );
 * 
 * trace( "> result        : " + "[" + result.join( "],[" ) + "]" );
 * trace( "> wildcards     : [" + we.wildcards.join( "][" ) + "]" );
 * trace( "> questionMarks : [" + we.questionMarks.join( "][" ) + "]" );
 * }
 * </p>
 * <p>Thanks Zwetan : <a href='http://groups.google.com/group/FCNG/browse_thread/thread/467e11b594bb180d/4baedfcc0d2cd95f?lnk=st&q=%5BFMX%5D+WildExp&rnum=1#4baedfcc0d2cd95f'>WildExp in FCNG</a></p>
 * @see vegas.string.UnicodeChar WHITE_SPACE_CHARS and LINE_TERMINATOR_CHARS constants
 * @author eKameleon
 */
if (vegas.string.WildExp == undefined) 
{
	
	/**
	 * Creates a new WildExp instance.
	 */
	vegas.string.WildExp = function( pattern /*String*/ , flag /*Number*/ ) 
	{
		
		var WildExp = vegas.string.WildExp ;
		
		if( flag == null ) 
		{
			flag = WildExp.NONE ;
		}
		
		this.wildcards = [] ;
		this.questionMarks = [] ;
		
		this._caseSensitive      = true ;
		this._multiline          = false ;
		this._multiword          = false ;
		this._wildcardFound      = false;
		this._questionMarksFound = false ;
    
		switch(flag) 
		{
        	
			case WildExp.IGNORECASE : // 1
			{
				this._caseSensitive = false ;
				break;
			}	
        	case WildExp.MULTILINE : // 2
			{
				this._multiline = true ; 
				break;
			}
			case WildExp.IGNORECASE | WildExp.MULTILINE : //3
			{
				this._caseSensitive = false ;
				this._multiline = true ;
				break ;
			}
			case WildExp.MULTIWORD : // 4
			{
				this._multiword = true ;
				break;
			}
			case WildExp.IGNORECASE | WildExp.MULTIWORD : // 5
			{
				this._caseSensitive = false ;
				this._multiword = true ;
				break ;
			}
			case WildExp.MULTILINE | WildExp.MULTIWORD : // 6
			{
				this._multiline = true ;
				this._multiword = true ;
				break;
			}	
			case WildExp.IGNORECASE | WildExp.MULTILINE | WildExp.MULTIWORD : // 7
			{
				this._caseSensitive = false ;
				this._multiline = true ;
				this._multiword = true ;
				break ;
			}
			case WildExp.NONE : 
			default:
				//
        }
		
		if( this._caseSensitive ) 
		{
			pattern = pattern.toLowerCase();
		}
        
		this.source = pattern ;
		
	}

	vegas.string.WildExp.extend(vegas.core.CoreObject) ;

	vegas.string.WildExp.NONE /*Number*/ = 0 ;
	
	vegas.string.WildExp.IGNORECASE /*Number*/ = 1 ;
	
	vegas.string.WildExp.MULTILINE /*Number*/ = 2 ;
	
	vegas.string.WildExp.MULTIWORD /*Number*/ = 4 ;

	vegas.string.WildExp.prototype.wildcards /*Array*/ = null ;

	vegas.string.WildExp.prototype.questionMarks /*Array*/ = null ;

	vegas.string.WildExp.prototype.source /*String*/ = null ;

	vegas.string.WildExp.prototype.addToQuestionMarks = function (chr /*String*/) /*Void*/ 
	{
		var l /*Number*/ = this.questionMarks.length ;
		if( l == 0 ) 
		{
			return ;
		}
		this.questionMarks[ l - 1 ] += chr ;
    }
	
	vegas.string.WildExp.prototype.addToWildcards = function (chr /*String*/) /*Void*/ 
	{
		var l /*Number*/ = this.wildcards.length ;
		if( l == 0 ) 
		{
			return ;
		}
		this.wildcards[l-1] += chr ;
    }

	/**
	 * Test the specified expression.
	 */
	vegas.string.WildExp.prototype.test = function ( str /*String*/ ) 
	{
		
		var segment /*Array*/ ;
		var result /*Array*/ ;
		var i, j, k, l /*Number*/ ;
		
		var lineTerminatorChars = [ "\u000A", "\u000D", "\u2028", "\u2029" ] ;
		var whiteSpaceChars = [ "\u0009", "\u000B", "\u000C", "\u0020", "\u00A0", " " ] ; 
		
		var ORC  = "\uFFFC";
    	var CRLF = "\r\n";
		
		if( this._caseSensitive ) 
		{
			str = str.toLowerCase();
		}
		
        if( this._multiline ) 
        {
			
			if( str.indexOf( CRLF ) > -1 ) 
			{
				str = str.replace( CRLF, ORC ) ;
			}

			for( i=0 ; i<lineTerminatorChars.length ; i++ ) 
			{
				if( str.indexOf( lineTerminatorChars[i] ) > -1 ) 
				{
					str = str.replace( lineTerminatorChars[i] , ORC ) ;
				}
            }
        }
		
		if( this._multiword ) 
		{
			for( j=0 ; j < whiteSpaceChars.length ; j++ ) 
			{
				if( str.indexOf( whiteSpaceChars[j] ) > -1 ) 
				{
					str = str.replace( whiteSpaceChars[j], ORC ) ;
				}
            }
			
        }
		
		if( str.indexOf( ORC ) > -1 ) 
		{
			
			segment = str.split( ORC ) ;
			result = [] ;
			
			for( k=0 ; k<segment.length ; k++ ) 
			{
				if( this._testMatch( segment[k], this.source ) ) 
				{
					result.push( segment[k] ) ;
				}
		    }
			if ( result.length != 0 ) 
			{
				return result  ;
			}
			return false ;
        }
		
		var result = this._testMatch( str, this.source ) ;
		
		return result ;
		
    }

	
	vegas.string.WildExp.prototype.toString = function () /*String*/ 
	{
		return this.source ;
	}

	
	vegas.string.WildExp.prototype._caseSensitive /*Boolean*/ = null ;

	vegas.string.WildExp.prototype._multiline /*Boolean*/ = null ;

	vegas.string.WildExp.prototype._multiword /*Boolean*/ = null ;

	vegas.string.WildExp.prototype._wildcardFound /*Boolean*/ = null ;

	vegas.string.WildExp.prototype._questionMarksFound /*Boolean*/ = null ;
	
	/**
	 * Test the pattern.
	 */
	vegas.string.WildExp.prototype._testMatch = function ( str /*String*/ , pattern/*String*/, ignoreChar /*Char*/) 
	{
		
		//str = new String(str) ; // optimization
		//pattern = new String(pattern) ; // optimization
		
		var c    = str.charAt( 0 ) ;
		var c1   = str.charAt( 1 ) ;
		var pat  = pattern.charAt( 0 ) ;
		var pat1 = pattern.charAt( 1 ) ;
		
		if( pat != "?" ) 
		{
			this._questionMarksFound = false ;
		}
		
        if( pat == "!" ) 
        {
			return this._testMatch( str, pattern.substr( 1 ), pat1 );
		}
        
		if( pat == "?" && ignoreChar != "?" ) 
		{
			if( c != "" ) 
			{
				if( this._questionMarksFound )
				{
					this.addToQuestionMarks( c ) ;
				}
                else 
				{
					this.questionMarks.push( c ) ;
				}
				this._questionMarksFound = true ;
				if ((pat1 == "") && (this._wildcardFound == true)) 
				{
					pattern += "*" ;
				}
                return this._testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
            } 
            else 
            {
				return false ;
            }
        }
		
		if( pat == "*" && (ignoreChar != "*") ) 
		{
			
			this._wildcardFound = true ;
			
			if( pat1 != "*" ) 
			{
				this.wildcards.push( "" );
			}
            
			if( pat1 == "" ) 
			{
				this.addToWildcards( str ) ;
				return true ;
            }
			
			if( (pattern.substr(1)).indexOf( "*" ) > -1 ) 
			{
				
				while( str != "" ) 
				{
					if( pat1 == "*" ) 
					{
						break ;
					}
					if( pat1 == "?" ) 
					{
						pattern = pattern.substr(1) ;
						break ;
					}
					if( str == "" ) 
					{
						return false ;
					}
					if( str.charAt(0) == pat1 ) 
					{
						break ;
					}
					if( pat1 == "!" ) 
					{
						ignoreChar = pattern.charAt( 2 ) ;
						pattern    = pattern.substr( 2 ) ;
						pat1       = pattern.charAt( 1 ) ;
					}
					if( str.charAt(0) == ignoreChar ) 
					{
						str = str.substr(1) ; 
						continue ;
					}
					this.addToWildcards( str.charAt( 0 ) ) ;
					str = str.substr(1) ;
				}
				
				return this._testMatch( str, pattern.substr( 1 ), ignoreChar ) ;
				
			} 
			else 
			{
				
				var found /*Number*/ = str.lastIndexOf( pat1 ) ;
				
				if( found != -1 ) 
				{
					
					this.addToWildcards( str.substring( 0, found ) ) ;
					return this._testMatch( str.substr( found ), pattern.substr( 1 ) ) ;
					
                }
                else if( pat1 == "?" ) 
                {
					
					if( pattern.charAt(2) == "" ) 
					{
						return str.length >= 1 ;
					}
					else 
					{
						return this._testMatch( str.substr( 1 ), pattern.substr( 1 ) );
					}
					
                }
				return false;
            }
        }
		
		if( pat == "" ) 
		{
			return( c == "" ) ;
		}
		
        if( c != pat ) 
        {
			return false ;
		}
		
        if( c != "" ) 
        {
			return this._testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
		}
		else 
		{
			return false ;
		}
        
    }

}