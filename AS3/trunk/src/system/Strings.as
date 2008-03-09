﻿/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)
	  Use this version only with Vegas AS3 Framework Please.

*/
package system
{

	/**
	 * A static class for String utilities.
	 */
	public class Strings
	{

		/**
		 * Contains a read-only list of white space chars.
		 * Note :
		 * - http://developer.mozilla.org/es4/proposals/string.html
		 * - http://www.fileformat.info/info/unicode/category/Zs/list.htm
		 * - http://www.fileformat.info/info/unicode/category/Zl/list.htm
		 * - http://www.fileformat.info/info/unicode/category/Zp/list.htm
		 * - http://www.fileformat.info/info/unicode/char/200b/index.htm
		 * - http://www.fileformat.info/info/unicode/char/feff/index.htm
		 * - http://www.fileformat.info/info/unicode/char/2060/index.htm
		 * TODO we maybe could also define 0xFFEF and/or 0x2060, but not completely sure of all the implication, 0xFFEF in byte order mark etc.
		 */
		public static const whiteSpaceChars:Array = 
		[ 
			"\u0009" , /*Horizontal tab*/
            "\u000A" , /*Line feed or New line*/
            "\u000B" , /*Vertical tab*/
            "\u000C" , /*Formfeed*/
            "\u000D" , /*Carriage return*/
			"\u0020" , /*Space*/
			"\u00A0" , /*Non-breaking space*/
			"\u1680" , /*Ogham space mark*/
			"\u180E" , /*Mongolian vowel separator*/
			"\u2000" , /*En quad*/
			"\u2001" , /*Em quad*/
			"\u2002" , /*En space*/
			"\u2003" , /*Em space*/
			"\u2004" , /*Three-per-em space*/
			"\u2005" , /*Four-per-em space*/
			"\u2006" /*Six-per-em space*/,
			"\u2007" /*Figure space*/,
			"\u2008" /*Punctuation space*/,
			"\u2009" /*Thin space*/,
			"\u200A" /*Hair space*/,
			"\u200B" /*Zero width space*/,
			"\u2028" /*Line separator*/,
			"\u2029" /*Paragraph separator*/,
			"\u202F" /*Narrow no-break space*/,
			"\u205F" /*Medium mathematical space*/,
			"\u3000" /*Ideographic space*/ 
		];

        /**
         * Compares the two specified String objects.
         * @param o1 first string to compare with the second string.
         * @param o2 second string to compare with the first string.
         * @param strict (optionnal) useCase boolean, default to false.
         * allows to take into account the string case for comparison. 
         */		 
		public static function compare( o1:*, o2:*, strict:Boolean = false ):int
		{
            
			/* TODO: review and test the logic */
			if( (o1 == null) || (o2 == null) )
			{
				if( o1 == o2 )
				{
					return 0; //both null
				}
                else if( o1 == null )
				{
					return -1; //o1 is null -1
				}
                else
				{
					return 1; //o2 is null 1
				}
			}
            
			if( !(o1 is String) || !(o2 is String) )
			{
				throw new Error( "Arguments String expected." );
			}
            
			if( !strict )
			{
				o1 = o1.toLowerCase( );
				o2 = o2.toLowerCase( );
			}
            
			if( o1 == o2 )
			{
				return 0;
			}
            else if( o1.length == o2.length )
			{
				/* TODO:
				implement a string diff algorithm
				 */
				//return difference( o1, o2, option );
				return 0;
			}
            else if( o1.length > o2.length )
			{
				return 1;
			}
            else
			{
				return -1;
			}
		}

        /**
         * Determines whether the end of this instance matches the specified String.
         */
		public static function endsWith( str:String, value:String ):Boolean
		{
			if( (value == null) || (str.length < value.length) )
			{
				return false;
			}
			return compare( str.substr( str.length - value.length ), value ) == 0;
		}

 		/** 
 		 * Format a string using indexed or named parameters.
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
 		 * <pre class="prettyprint">
 		 * import system.Strings ;
 		 * 
 		 * var result:String ;
		 * 
		 * // indexed from the arguments
		 * 
		 * result = Strings.format( "hello {1} {0} world", "big", "the" ); 
		 * trace("> " + result) ; //"hello the big world"
		 *
		 * result = Strings.format("Brad's dog has {0,6:#} fleas.", 41) ;
		 * trace("> " + result) ;
		 *
		 * result = Strings.format("Brad's dog has {0,-6} fleas.", 12) ;
		 * trace("> " + result) ;
		 *
		 * result = Strings.format("{3} {2} {1} {0}", "a", "b", "c", "d") ;
		 * trace("> " + result) ;
		 * 
		 * // named from an object
		 * 
		 * result = Strings.format( "hello I'm {name}", {name:"HAL"} );
		 * trace("> " + result) ; //"hello I'm HAL"
		 * 
		 * // indexed from an array
		 * 
		 * var names:Array = ["A","B","C","D"];
		 * var scores:Array = [16,32,128,1024];
		 * for( var i:int=0; i<names.length; i++ )
		 * {
		 *     trace( Strings.format( "{0} scored {1,5}", [names[i], scores[i]] ) );
		 * }
		 * // "A scored    16"
		 * // "B scored    32"
		 * // "C scored   128"
		 * // "D scored  1024"
		 * 
		 * // resolve toString
		 * var x:Object = {};
		 * x.toString = function() { return "john doe"; } ;
		 * trace( Strings.format( "Who is {0} ?", x ) ) ; //"Who is john doe ?"
		 * 
		 * // you can off course reuse the index
		 * var fruits:Array = ["apple", "banana", "pineapple"] ;
		 * trace( Strings.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}", fruits ) ); // "I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
		 * 
		 * // indexed from an array + the arguments
		 * var fruits:Array = ["apple", "banana", "pineapple"];
		 * trace( Strings.format( "fruits: {0}, {1}, {2}, {3}, {4}, {5}", fruits, "grape", "tomato" ) ); //"fruits: apple, banana, pineapple, grape, tomato, undefined"
		 * 
		 * // passing reference and padding
		 * var what = "answer" ;
		 * result = Strings.format( "your {0} is within {answer,20:.}", {answer:"my answer"}, what ) ; 
		 * trace("> " + result ) // "your answer is within ...........my answer"
 		 * </pre>
 		 */
		public static function format( format:String, ...args ):String
		{
			if( (args == null) || (args.length == 0) || (format == "") )
			{
				return format; //nothing to format
			}
            
			var paddingChar:String = " "; 
			//default padding char is SPC
			var indexedValues:Array = [];  
			//cf {0} {1} etc.
			var namedValues:Object = {};  
			//cf {toto} {titi} etc.
			//var numeric:RegExp      = /^[0-9]*/;
			//var alphabetic:RegExp   = /^[A-Za-z]./;
			//var alphaLetter:RegExp  = /^[A-Za-z]/;
            
			//parse arguments
			if( args.length >= 1 )
			{
				if( args[0] is Array )
				{
					indexedValues = indexedValues.concat( args[0] );
					args.shift( );
				}
                else if( (args[0] is Object) && (String( args[0] ) == "[object Object]") )
				{
					for( var prop:String in args[0] )
					{
						namedValues[ prop ] = args[0][ prop ];
					}
					args.shift( );
				}
			}
            
			indexedValues = indexedValues.concat( args );
            
			//escape {{ and }}
			var ORC1:String = "\uFFFC"; 
			//Object Replacement Character
			var ORC2:String = "\uFFFD"; 
			//Object Replacement Character
			if( indexOfAny( format, [ "{{", "}}" ] ) > -1 )
			{
				/* note:
				little limitation here
				we cover the case of {{{0}}} -> to be able
				to escape and inject within the escaped
				Strings.format( "{{{0}}}", "hello" ) -> "{hello}"
				but in more complex cases as {{{{{0}}}}} this scenario will fail
                   
				workaround:
				if you really really really need to escape
				as much as {{{{ and }}}} do that
				Strings.format( "{left}{0}{right}", {left:"{{{{", "}}}}"}, "hello" ) -> "{{{{hello}}}}"
                   
				TODO:
				use regexp once String.format for JS/AS1 is stable
				 */
				format = format.split( "{{{" ).join( ORC1 + "{" );
				format = format.split( "{{" ).join( ORC1 );
				format = format.split( "}}}" ).join( "}" + ORC2 );
				format = format.split( "}}" ).join( ORC2 );
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
				var value:String = "";
				var spaceAlign:int = 0;
				var isAligned:Boolean = false;
				var padding:String = paddingChar;  //default
				
				if( indexOfAny( expression, [ ",", ":" ] ) > -1 )
				{
					var vPos:int = expression.indexOf( "," );
					if( vPos == -1 )
					{
						throw new Error( "malformed format, could not find [,] before [:]." );
					}
                    
					var fPos:int = expression.indexOf( ":" );
                    
					if( fPos == -1 )
					{
						spaceAlign = int( expression.substr( vPos + 1 ) );
					}
                    else
					{
						spaceAlign = int( expression.substring( vPos + 1, fPos ) );
						padding = expression.substr( fPos + 1 );
					}
                    
					isAligned = true;
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
                
				/*
				if( alphabetic.test(expression) || alphaLetter.test(expression) )
				{
				value = String( namedValues[ expression ] );
				}
				else if( numeric.test(expression) )
				{
				value = String( indexedValues[ int(expression) ] );
				}
				 */
				var c:String = expression.split( "" )[0];
				if( (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z")) )
				{
					value = String( namedValues[ expression ] );
				}
                else if( ("0" <= c) && (c <= "9") )
				{
					value = String( indexedValues[ int( expression ) ] );
				}
                
				if( isAligned )
				{
					if( (spaceAlign > 0) && (value.length < spaceAlign) )
					{
						value = padLeft( value, spaceAlign, padding );
					}
                    else if ( -value.length < spaceAlign )
					{
						value = padRight( value, -spaceAlign, padding );
					}
				}
                
				return value;
			} ;
            
			var expression:String = "";
			var formated:String = "";
			var ch:String = "";
			var pos:int = 0;
			var len:int = format.length;
            
			var next:Function = function():String
			{
				ch = format.charAt( pos );
				pos++;
				return ch;
			} ;
            
			//parsing
			while( pos < len )
			{
				next( );
				if( ch == "{" )
				{
					expression = next( );
					while( next( ) != "}" )
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
            
			if( indexOfAny( format, [ ORC1, ORC2 ] ) > -1 )
			{
				formated = formated.split( ORC1 ).join( "{" );
				formated = formated.split( ORC2 ).join( "}" );
			}
            
			return formated;
		}

	 	/**
		 * Reports the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import system.Strings ;
		 * 
		 * Strings.indexOfAny("hello world", [2, "hello", 5]) ; // 0
		 * Strings.indexOfAny("Five = 5", [2, "hello", 5]) ; // 7
	 	 * Strings.indexOfAny("actionscript is good", [2, "hello", 5]) ; // -1
		 * </pre>
	 	 * @return the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
	 	 */
		public static function indexOfAny( str:String, anyOf:Array, startIndex:int = 0, count:int = -1 ):int
		{
			var i:int;
			var endIndex:int;
            
			if( str.length == 0 )
			{
				return -1;
			}
            
			if( startIndex < 0 )
			{
				startIndex = 0;
			}
            
			if( (count < 0) || (count > anyOf.length - startIndex) )
			{
				endIndex = anyOf.length - 1;
			}
            else
			{
				endIndex = startIndex + count - 1;
			}
            
			for( i = startIndex; i <= endIndex ; i++ )
			{
				if( str.indexOf( anyOf[i] ) > -1 )
				{
					return i;
				}
			}
            
			return -1;
		}

		/**
		 * Inserts a specified instance of String at a specified index position in this instance.
		 * note :
		 * if index is null, we directly append the value to the end of the string.
		 * if index is zero, we directly insert it to the begining of the string.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import system.Strings ;
		 * 
		 * var result:String ;
		 * 
		 * result = Strings.insert("hello", 0, "a" ) ;  // ahello
		 * trace(result) ;
		 * 
		 * result = Strings.insert("hello", -1, "a" ) ; // ahello
		 * trace(result) ;
		 * 
		 * result = Strings.insert("hello", 10, "a" ) ; // helloa
		 * trace(result) ;
		 * 
		 * result = Strings.insert("hello", 1, "a" ) ;  // haello
		 * trace(result) ;
		 * </pre>
		 * @return the string modified by the method.
		 */		 
		public function insert( str:String, startIndex:int=0, value:String=null ):String
		{
			
			if( value == null ) 
			{
				return str ;
			}
			
			if( str == "" ) 
			{
				return value ;
			}
			
			if( startIndex == 0 )
			{
				return value + str;
			}
            else if( isNaN(startIndex) || (startIndex == str.length) )
			{
				return str + value;
			}
            
			var strA:String = str.substr( 0, startIndex );
			var strB:String = str.substr( startIndex );
            
			return strA + value + strB;
		}

		/**
		 * Right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
		 * <pre class="prettyprint">
		 * import system.Strings ;
		 * 
		 * var result:String = Strings.padLeft("hello", 8) ;
		 * trace(result) ; //  "   hello"
		 * 
		 * var result:String = Strings.padLeft("hello", 8, ".") ;
		 * trace(result) ; //  "...hello" 
		 * </pre>
		 * @return The right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
		 */
		public static function padLeft( str:String, totalWidth:int, paddingChar:String = " " ):String
		{
			return _padHelper( str, totalWidth, paddingChar, false );
		}


		/**
		 * Left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
	 	 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * import system.Strings ;
		 * 
		 * var result:String = Strings.padRight("hello", 8) ;
		 * trace(result) ; //  "hello   "
		 * 
		 * var result:String = Strings.padRight(hello", 8, ".") ;
		 * trace(result) ; //  "hello..." 
		 * </pre>
		 * @return The left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
	 	 */

		public static function padRight( str:String, totalWidth:int, paddingChar:String = " " ):String
		{
			return _padHelper( str, totalWidth, paddingChar, true );
		}

		/**
		 * Determines whether a specified string is a prefix of the current instance. 
		 * <p><b>Example : </b></p>
		 * <pre class="prettyprint">
		 * import system.Strings ;
		 * 
		 * trace( Strings.startsWith("hello world", "h") ) ; // true
	  	 * trace( Strings.startsWith("hello world", "hello") ) ; // true
		 * trace( Strings.startsWith("hello world", "a") ) ; // false
		 * </pre>
		 * @return <code>true</code> if the specified string is a prefix of the current instance.
		 */
		public static function startsWith( str:String, value:String ):Boolean
		{
			if( (value == null) || (str.length < value.length) )
			{
				return false;
			}
            
			if( str.charAt( 0 ) != value.charAt( 0 ) )
			{
				return false;
			}
            
			return compare( str.substr( 0, value.length ), value ) == 0;
		}

		/**
		 * Removes all occurrences of a set of specified characters (or strings) from the beginning and end of this instance.
		 */
		public static function trim( str:String, trimChars:Array = null ):String
		{
			if( trimChars == null )
			{
				trimChars = whiteSpaceChars;
			}
            
			return _trimHelper( str, trimChars, true, true );
		}

		/**
		 * Removes all occurrences of a set of characters specified in an array from the end of this instance.
		 */
		public static function trimEnd( str:String, trimChars:Array = null ):String
		{
			if( trimChars == null )
			{
				trimChars = whiteSpaceChars;
			}
            
			return _trimHelper( str, trimChars, false, true );
		}

		/**
		 * Removes all occurrences of a set of characters specified in an array from the beginning of this instance.
		 */
		public static function trimStart( str:String, trimChars:Array = null ):String
		{
			if( trimChars == null )
			{
				trimChars = whiteSpaceChars;
			}
            
			return _trimHelper( str, trimChars, true, false );
		}

		/**
		 * Helper method for the padLeft and padRight method.
		 */
		private static function _padHelper( str:String, totalWidth:int, paddingChar:String = " ", isRightPadded:Boolean = true ):String
		{
			if( (totalWidth < str.length) || (totalWidth < 0) )
			{
				return str;
			}
			// we want to limit the string to ONLY ONE char for now we do that but perharps it would better to throw an Error
			if( paddingChar.length > 1 )
			{
				paddingChar = paddingChar.charAt( 0 );
			}
            
			while( str.length != totalWidth )
			{
				if( isRightPadded == true )
				{
					str += paddingChar;
				}
                else
				{
					str = paddingChar + str;
				}
			}
            
			return str;
		}

		/**
		 * Helper method used by trim, trimStart and trimEnd methods.
		 */
		private static function _trimHelper( str:String, trimChars:Array, trimStart:Boolean = false, trimEnd:Boolean = false ):String
		{
			
			var iLeft:int;
			var iRight:int;
            
			if( trimStart )
			{
				for( iLeft = 0; (iLeft < str.length) && (trimChars.indexOf( str.charAt( iLeft ) ) > -1) ; iLeft++ )
				{
					//
				}
				str = str.substr( iLeft );
			}
            
			if( trimEnd )
			{
				for( iRight = str.length - 1; (iRight >= 0) && (trimChars.indexOf( str.charAt( iRight ) ) > -1) ; iRight-- )
				{            
					//                
                }
				str = str.substring( 0, iRight + 1 );
			}
			return str;
		}

	}

}

