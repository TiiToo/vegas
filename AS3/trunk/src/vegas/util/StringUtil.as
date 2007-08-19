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

package vegas.util
{
    
    import vegas.errors.ClassCastError;
    import vegas.string.UnicodeChar;
 
	/**
	 * The {@code StringUtil} utility class is an extended String class with methods for working with string.
	 * @author eKameleon
	 */
    public class StringUtil
    {
        
        /**
  		 * Represents the empty string.
  		 * This property should be read-only.
		 */
        static public const EMPTY:String = "" ;
        
        /**
         * Reprensents the space string value.
         */ 
        static public const SPC:String = " " ; // SPACE

		/**
	 	 * Contains a list of all white space chars.
	 	 */
		static public var WHITE_SPACE_CHARS:Array = 
		[ 
			"\u0009", "\u000A", "\u000B", "\u000C", "\u000D",
			"\u0020", "\u00A0", "\u2000", "\u2001", "\u2002",
			"\u2003", "\u2004", "\u2005", "\u2006", "\u2007",
			"\u2008", "\u2009", "\u200A", "\u200B", "\u3000",
        	"\uFEFF" 
    	];

		/**
	 	* Returns 0 if the passed string is lower case else 1.
	 	* @return 0 if the passed string is lower case else 1.
	 	*/
		static public function caseValue( str:String ):Number
		{
			return ( str.toLowerCase() == str ) ? 0 : 1 ;
		}

        /**
         * Returns a shallow copy of the specified string.
         * @return a shallow copy of the specified string.
         */
        static public function clone( s:String ):String 
        {
		    return s ;	
    	}
        
        /**
         * Compares the two specified String objects.
         */
      	static public function compare( strA:String=null , strB:String=null, ignoreCase:Boolean=false ):Number 
      	{
		    
		    if( (strA == null) || (strB == null) ) 
		    {
    			if( strA == strB ) 
    			{
    				return 0 ;
    			}
                else if( strA == null ) 
                {
                	return -1 ;
                }
                else 
                {
                	return 1 ;
                }
    		}
    		
    		if ( !( strA is String ) || !( strB is String ) ) 
			{
				throw new ClassCastError( "compare method failed, Arguments string expected." ) ;
			}
    		else
    		{
    			strA = strA.toString() ;
    			strB = strB.toString() ;
    			if( ignoreCase ) 
	    		{
	            	strA = strA.toLowerCase() ;
        	    	strB = strB.toLowerCase() ;
            	}
            	if( strA == strB ) 
            	{
            		return 0 ;
            	}
            	
            	var size:Number = Math.min(strA.length, strB.length) ;
            	if (size > 0)
            	{
           			var i:Number = 0 ;
					var c:Number ;
					while ( i < size )
					{
						c = StringUtil.compareChars( strA.charAt(i), strB.charAt(i));
						if ( c != 0 ) 
						{
							return c;
						}
						i++ ;
					}          		
            	}
            	
            	if( strA.length > strB.length ) 
            	{
            		return 1 ;
            	}
            	else
            	{
            		return -1 ;
            	}
    		}
    	}  
        
		/**
		 * Compares the two caracteres passed in argument for order.
		 * @return <p>
		 * <li>-1 if charA is "lower" than (less than, before, etc.) charB ;</li>
		 * <li> 1 if charA is "higher" than (greater than, after, etc.) charB ;</li>
		 * <li> 0 if charA and charB are equal.</li>
		 * </p>
		 */
		static public function compareChars( charA:String, charB:String ):Number
		{
			var a:String = charA.charAt(0) ;
			var b:String = charB.charAt(0) ;
			if ( caseValue(a) < caseValue(b) ) 
			{
				return -1;
			}
			if ( caseValue(a) > caseValue(b) ) 
			{
				return 1 ;
			}	
			if ( a < b ) 
			{
				return -1;
			}
			if ( a > b ) 
			{
				return 1;
			}
			return 0 ;
		}
        
        /**
         * Returns a copy by value of this object.
         */
        static public function copy(str:String):String 
        {
		    return str.valueOf() ;
	    }
        
        /**
         * Determines whether the end of this instance matches the specified String.
         */
        static public function endsWith( str:String=null, value:String=null ):Boolean 
        {
		    if (value == null) 
		    {
		    	return false ;
		    }
    		if ( str.length < value.length ) 
    		{
    			return false ;	
    		}
    		return compare( str.substr( str.length - value.length ), value) == 0;
    	}

        /**
         * Determines whether the start of this instance matches the specified String.
         */
    	static public function firstChar( str:String ):String 
    	{
    		return str.charAt(0) ;
    	}
 
 		/** 
 		 * Format a string.
 		 * <p>Method call :</p>
 		 * <li>StringUtil.format(pattern:String, ...arguments:Array):String</li>
 		 * <li>StringUtil.format(pattern:String, [arg0:*,arg1:*,arg2:*, ...] ):String</li>
 		 * <li>StringUtil.format(pattern:String, [arg0:*,arg1:*,arg2:*, ...], ...args:Array ):String</li>
 		 * <li>StringUtil.format(pattern:String, {name0:value0,name1:value1,name2:value2, ...} ):String</li>
 		 * <li>StringUtil.format(pattern:String, {name0:value0,name1:value1,name2:value2, ...} , ...args:Array ) :String</li>
 		 * </p>
 		 * <p>Replaces the pattern item in a specified String with the text equivalent of the value of a specified Object instance.</p>
 		 * <p>Formats item : {token[,alignment][:paddingChar]}</p>
 		 * <p>If you want to use the "{" and "}" chars use "{{" and "}}"
 		 * <li>"some {{formatitem}} to be escaped" -> "some {formatitem} to be escaped"</li>
 		 * <li>"some {{format {0} item}} to be escaped", "my" -> "some {format my titem} to be escaped"</li>
         * </p>
 		 * </p>
 		 * <p><b>Example :</b></p>
 		 * {@code
 		 * import vegas.util.StringUtil ;
 		 * 
 		 * var result:String ;
		 *
		 * result = StringUtil.format("Brad's dog has {0,6:#} fleas.", 41) ;
		 * trace("> " + result) ;
		 *
		 * result = StringUtil.format("Brad's dog has {0,-6} fleas.", 12) ;
		 * trace("> " + result) ;
		 *
		 * result = StringUtil.format("{3} {2} {1} {0}", "a", "b", "c", "d") ;
		 * trace("> " + result) ;
 		 * }
 		 * thanks Zwetan and Core2 Library and system package.
 		 * TODO : in the next version use the system package !
 		 */
 		static public function format( pattern:String=null , ...args:Array ):String 
 		{
			
			
			if( (args == null) || (args.length == 0) || (pattern == "") )
			{
				return pattern ; // nothing to format
			}
            
            var paddingChar:String  = " " ; //default padding char is SPC
            var indexedValues:Array = [] ;  //cf {0} {1} etc.
            var namedValues:Object  = {} ;  //cf {toto} {titi} etc.
            var hasIndexes:Boolean  = false ;
            var hasNames:Boolean    = false ;
            var numeric:RegExp      = /^[0-9]*/ ;
            var alphabetic:RegExp   = /^[A-Za-z]./ ;
            var alphaLetter:RegExp  = /^[A-Za-z]/ ;
            
			if( args.length >= 1 )
			{
                if( args[0] is Array )
				{
					indexedValues = indexedValues.concat( args[0] );
					hasIndexes = true;
					args.shift();
				}
                else if( (args[0] is Object) && (String(args[0]) == "[object Object]") )
				{
					for( var prop:String in args[0] )
					{
						namedValues[ prop ] = args[0][ prop ];
					}
                    hasNames = true;
                    args.shift();
				}
			}
            
            indexedValues = indexedValues.concat( args );
            
            //escape {{ and }}
            
            var ORC1:String = "\uFFFC"; //Object Replacement Character
            var ORC2:String = "\uFFFD"; //Object Replacement Character
            
            if( StringUtil.indexOfAny( pattern, [ "{{", "}}" ] ) > -1 )
			{
				pattern = StringUtil.replace( pattern, "{{" , ORC1 );
				pattern = StringUtil.replace( pattern, "}}" , ORC2 );
			}
            
            if( indexedValues.length > 0 )
			{
				hasIndexes = true;
			}
            
            // {0} {1}
            // {0,5} {0,-5}
            // {0,5:_} {0,-5:_}
            // {toto} {titi}
            // {toto,5} {toto,-5}
            // {titi,5:_} {titi,-5:_}
            var parseExpression:Function = function( expression:String ):String
            {
                
                use namespace AS3 ; //to avoid 3594 warning
				var value:String      = "";
				var spaceAlign:int    = 0;
				var isAligned:Boolean = false;
				var padding:String    = paddingChar; //default
                
				if( StringUtil.indexOfAny( expression, [ ",", ":" ] ) > -1 )
				{
                    
                    var vPos:int = expression.indexOf( "," );
                    if( vPos == -1 )
					{
                        throw new Error( "malformed pattern, could not find [,] before [:]." );
					}
                    
                    var fPos:int = expression.indexOf( ":" );
                    
                    if( fPos == -1 )
                    {
                        spaceAlign = int( expression.substr( vPos+1 ) );
                    }
                    else
                    {
                        spaceAlign  = int( expression.substring( vPos+1, fPos ) );
                        padding     = expression.substr( fPos+1 );
                    }
                    
                    isAligned  = true;
                    expression = expression.substring( 0, vPos );
				}
                
                /* note:
                   there must be a bug in playerglobal.swc
                   when compiling this warning occurs
                   "3594: test is not a recognized method of the dynamic class RegExp"
                   but Global.as shows
                    (code)
                    public dynamic class RegExp
                    {
                        //...
                    	public native function test(str:String):Boolean;
                        //...
                    }
                    (end)
                    
                    to solve that little bug:
                    use namespace AS3;
                    apparently when you define an inner function
                    or an internal function outside a package
                    the AS3 namespace is not found anymore
                */
                if( alphabetic.test(expression) || alphaLetter.test(expression) )
				{
                    value = String( namedValues[ expression ] ) ;
				}
                else if( numeric.test(expression) )
				{
                    value = String( indexedValues[ int(expression) ] ) ;
				}
                
                if( isAligned )
				{
                    if( (spaceAlign > 0) && (value.length < spaceAlign) )
					{
                        value = StringUtil.padLeft( value, spaceAlign, padding );
					}
                    else( -value.length < spaceAlign )
					{
                        value = StringUtil.padRight( value, -spaceAlign, padding );
					}
				}
                
                return value.toString();
			}
            
            var expression:String = "";
            var formated:String   = "";
            var ch:String         = "";
            var pos:int           = 0;
            var len:int           = pattern.length;
            
            var next:Function = function():String
			{
				ch = pattern.charAt( pos );
				pos++;
				return ch;
			}
            
            while( pos < len )
			{
                next();
                if( ch == "{" )
				{
                    expression = next();
                    while( next() != "}" )
					{
                        expression += ch;
					}
                    formated += parseExpression( expression );
				}
                else
				{
                    formated += ch;
				}
			}
            
            if( StringUtil.indexOfAny( pattern, [ ORC1, ORC2 ] ) > -1 )
			{
                formated = formated.split( ORC1 ).join( "{" );
                formated = formated.split( ORC2 ).join( "}" );
            }
            
            return formated ;
				
		}
 
	 	/**
		 * Reports the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
	 	 * StringUtil.indexOfAny("hello world", [2, "hello", 5]) ; // 0
		 * StringUtil.indexOfAny("Five = 5", [2, "hello", 5]) ; // 7
	 	 * StringUtil.indexOfAny("actionscript is good", [2, "hello", 5]) ; // -1
		 * }
	 	 * @return the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
	 	 */
     	static public function indexOfAny(str:String, ar:Array):int
     	{
    		var index:int ;
    		var l:uint = ar.length ;
    		for (var i:uint = 0 ; i<l ; i++) 
    		{
    			index = str.indexOf(ar[i]) ;
    			if (index > -1) return index ;
    		}
    		return -1 ;
    	}
	
		/**
		 * Inserts a specified instance of String at a specified index position in this instance.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * var result:String ;
		 * result = StringUtil.insert("hello", 0, "a" ) ;  // ahello
		 * result = StringUtil.insert("hello", -1, "a" ) ; // ahello
		 * result = StringUtil.insert("hello", 10, "a" ) ; // helloa
		 * result = StringUtil.insert("hello", 1, "a" ) ;  // haello
		 * }
		 * @return the string modified by the method.
		 */
    	static public function insert( str:String, startIndex:uint=0, value:String=null):String 
    	{
    		if( value == null ) return str ;
    		if( str == "" ) return value ;
            if( startIndex == 0 ) return value + str ;
           	else if( isNaN(startIndex) || (startIndex == str.length) ) return str + value ;
           	var strA:String = str.substr( 0, startIndex );
        	var strB:String = str.substr( startIndex ) ;
        	return strA + value + strB ;
       	}
	
		/**
		 * Returns {@code true} if this string is empty.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * var b1:Boolean = StringUtil.isEmpty("") ; // true
		 * var b2:Boolean = StringUtil.isEmpty("hello world") ; // false
		 * }
		 * @param str the string object.
		 * @return {@code true} if this string is empty.
	 	 */
	    static public function isEmpty(str:String):Boolean 
	    {
		    return str.length == 0 ;
    	}
 
 		/**
		 * Returns the last char of the string. 
		 * <p><b>Example :</b></p>
	 	 * {@code
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.firstChar("hello world") ; // d
		 * }
		 * @param str the string object.
		 * @return the last char of the string.
	 	 */
 	    static public function lastChar(str:String):String 
 	    {
    		return str.charAt(length - 1) ;
	    }

		/**
		 * Reports the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
	 	 * <p><b>Example :</b></p>
	 	 * {@code
		 * vegas.util.StringUtil.lastChar("hello world") ; // the last char is 'd'.
		 * }
	 	 * @return the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
	 	 */
    	static public function lastIndexOfAny(str:String, ar:Array):int 
    	{
    		var index:int = -1 ;
    		var l:uint = ar.length ;
    		for (var i:Number = 0 ; i<l ; i++) 
    		{
    			index = str.lastIndexOf(ar[i]) ;
    			if (index > -1) return index ;
    		}
    		return index ;
	    }
	
		/**
		 * Right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
		 * {@code
		 * import vegas.util.StringUtil ;
		 * 
		 * var result:String = StringUtil.padLeft("hello", 8) ;
		 * trace(result) ; //  "   hello"
		 * 
		 * var result:String = StringUtil.padLeft("hello", 8, ".") ;
		 * trace(result) ; //  "...hello" 
		 * }
		 * @return The right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
		 */
	    static public function padLeft(str:String, i:int, char:String):String 
	    {
		    char = char || " " ;
    		var s:String = new String(str) ;
            var l:uint = s.length ;
            for ( var k:Number = 0 ; k < (i - l) ; k++)
            {
                s = char + s ;
            }
            return s ;
        }
	
		/**
		 * Left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
	 	 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * 
		 * var result:String = StringUtil.padRight("hello", 8) ;
		 * trace(result) ; //  "hello   "
		 * 
		 * var result:String = StringUtil.padRight(hello", 8, ".") ;
		 * trace(result) ; //  "hello..." 
		 * }
		 * @return The left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
	 	 */
	    static public function padRight(str:String, i:int , char:String):String 
	    {
		    char = char || " " ;
            var s:String = new String(str) ;
            var l:Number = s.length ;
		    for (var k:Number = 0 ; k < (i - l) ; k++) 
		    {
			    s = s + char ;
    		}
            return s ;
        }
 
	 	/**
		 * Replaces the 'search' string with the 'replace' String.
	 	 * <p><b>Example :</b></p>
	 	 * {@code
		 * vegas.util.StringUtil.replace("hello world", "hello", "hi") ; // "hello world" -> "hi world"
		 * }
		 * @param the string to transform.
		 * @return the new string transform with this method.
		 */
		static public function replace(str:String, search:String, replace:String):String 
 	   	{
		    return str.split(search).join(replace) ;
	    }
	
		/**
	 	 * Reverses the current instance.
		 * <p><b>Example :</b></p>
	 	 * {@code
		 * var reverse:String = vegas.util.StringUtil.reverse("hello") ; // "olleh"
		 * }
	 	 * @return the reverse string of the specified string passed-in argument.
		 */
		static public function reverse(str:String):String 
	    {  
		    var ar:Array = str.split("") ;
    		ar.reverse() ;
	    	return ar.join("") ;
	    }

		/**
		 * Adds and removes elements in the string.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * 
		 * var result:String = StringUtil.splice("hello world", 0, 1, "H") ;
		 * trace(result) ; // Hello world
		 * 
		 * var result:String = StringUtil.splice("hello world", 6, 0, "life") ;
		 * trace(result) ; // hello lifeworld
		 * 
		 * var result:String = StringUtil.splice("hello world", 6, 5, "life") ;
		 * trace(result) ; // hello life
		 * }
		 * @param startIndex Index at which to start changing the string.
	 	 * @param deleteCount Indicating the number of old character elements to remove.
		 * @param value The elements to add to the string. If you don't specify any elements, splice simply removes elements from the string.
	 	 */	
	    static public function splice(str:String, startIndex:uint, deleteCount:uint=0, value:*=undefined):String 
	    {
			var a:Array = StringUtil.toArray(str) ;
			a.splice(startIndex, deleteCount, value) ;
			return a.join("") ;
	    }

		/**
		 * Determines whether a specified string is a prefix of the current instance. 
		 * <p><b>Example : </b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * 
		 * trace( StringUtil.startsWith("hello world", "h") ) ; // true
	  	 * trace( StringUtil.startsWith("hello world", "hello") ) ; // true
		 * trace( StringUtil.startsWith("hello world", "a") ) ; // false
		 * }
		 * @return {@code true} if the specified string is a prefix of the current instance.
		 */
    	static public function startsWith( str:String, value:String=null ):Boolean
    	{
    	    
        	if( value == null )
	        {
            	return false;
        	}
	    
	        if( str.length < value.length )
        	{
        	    return false;
        	}
	    
	        if( str.charAt( 0 ) != value.charAt( 0 ) )
        	{
        	    return false;
        	}
	    
	        return( compare( str.substr( 0, value.length), value) == 0);
	        
	    }

		/**
		 * Returns an array representation of this instance.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.toArray("hello world" )) ; // h,e,l,l,o, ,w,o,r,l,d
		 * }
		 * @return an array representation of this instance.
	 	 */
	    static public function toArray(str:String):Array 
	    {
		    return str.split("") ;
	    }

		/**
		 * Returns a Eden representation of the object.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * var source:String = StringUtil.toSource("hello world") ;
	 	 * trace(source) ; // "hello world"
		 * }
	 	 * @return a string representing the source code of the object.
		 */
	    static public function toSource( ...arguments ):String 
	    {
		    var s:String = arguments[0] ;
    		var ch:String ;
    		var code:Number ;
    		var quote:String = "\"" ;
    		var str:String = "" ;
    		var pos:Number = 0 ;
    		var toUnicode:Function = UnicodeChar.toUnicode ;
    		var l:uint = s.length ;
    		while( pos < l ) 
    		{
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
	    
    	/**
		 * Removes all occurrences of a set of specified characters (or strings)
		 * from the beginning and end of this instance.
		 */
		static public function trim( str:String,  trimChars:Array ):String
    	{
	    	if( (trimChars == null) || (trimChars.length == 0) )
        	{
	        	trimChars = WHITE_SPACE_CHARS ;
        	}
    		return _trimHelper( str, trimChars, true, true );
    	}

		/**
		 * Removes all occurrences of a set of characters specified in an array from the end of this instance.
	 	 */
		static public function trimEnd( str:String , trimChars:Array ):String
    	{
	    	if( (trimChars == null) || (trimChars.length == 0) )
        	{
	        	trimChars = WHITE_SPACE_CHARS;
        	}
    		return _trimHelper( str, trimChars, false, true );
    	}

		/**
		 * Removes all occurrences of a set of characters specified 
		 * in an array from the beginning of this instance.
		 */
		static public function trimStart( str:String, trimChars:Array ):String
    	{
	    	if( (trimChars == null) || (trimChars.length == 0) )
        	{
	        	trimChars = WHITE_SPACE_CHARS;
        	}
    		return _trimHelper( str, trimChars, true ) ;
    	}

		/**
		 * Returns the value of this specified string with the first character in uppercase.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.ucFirst("hello world" )) ; // Hello world
		 * }
		 * @return the value of this string with the first character in uppercase.
	 	 */
	 	static public function ucFirst(str:String):String 
	    {
		    return str.charAt(0).toUpperCase() + str.substring(1) ;
	    }

		/**
		 * Uppercase the first character of each word in a string.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
	 	 * trace( StringUtil.ucWords("hello world" )) ; // Hello World
		 * }
		 * @return the string value with the first character in uppercase of each word in a string.
		 */	
	    static public function ucWords(str:String):String 
	    {
		    var ar:Array = str.split(" ") ;
		    var l:uint = ar.length ;
		    while(--l > -1) 
		    {
		        ar[l] = StringUtil.ucFirst(ar[l]) ;
		    }
		    return ar.join(" ") ;
	    }
 
 		/**
		 * Helper method used by trim, trimStart and trimEnd methods.
		 */
		static private function _trimHelper( str:String, trimChars:Array, trimStart:Boolean = false, trimEnd:Boolean = false ):String
    	{
	    	
            var iLeft:int;
            var iRight:int;
    		var s:String = copy(str) ;
    		
	    	if( trimStart )
        	{
	        	for( iLeft=0; (iLeft<s.length) && (trimChars.contains( s.charAt( iLeft ) )); iLeft++ )
        		{
					    	    
    	    	}
        		s = s.substr( iLeft );
        	}
    
    		if( trimEnd )
        	{
        		for( iRight=s.length-1; (iRight>=0) && (trimChars.contains( s.charAt( iRight ) )); iRight-- )
            	{            
				            
            	}
				s = s.substring( 0, iRight+1 );
        	}
    		return s ;
	    }
 
 
    }
}