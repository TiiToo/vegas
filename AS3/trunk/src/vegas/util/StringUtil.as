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
	 * This class complete the system.Strings static class.
	 * @author eKameleon
	 */
    public class StringUtil
    {
        
        /**
  		 * Represents the empty string.
  		 * This property should be read-only.
		 */
        public static const EMPTY:String = "" ;
        
        /**
         * Reprensents the space string value.
         */ 
        public static const SPC:String = " " ; // SPACE

		/**
	 	 * Returns 0 if the passed string is lower case else 1.
	 	 * @return 0 if the passed string is lower case else 1.
	 	 */
		public static function caseValue( str:String ):Number
		{
			return ( str.toLowerCase() == str ) ? 0 : 1 ;
		}

        /**
         * Returns a shallow copy of the specified string.
         * @return a shallow copy of the specified string.
         */
        public static function clone( s:String ):String 
        {
		    return s ;	
    	}
        
        /**
         * Compares the two specified String objects.
         */
      	public static function compare( strA:String=null , strB:String=null, ignoreCase:Boolean=false ):Number 
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
		public static function compareChars( charA:String, charB:String ):Number
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
        public static function copy(str:String):String 
        {
		    return str.valueOf() ;
	    }
        
        /**
         * Determines whether the start of this instance matches the specified String.
         */
    	public static function firstChar( str:String ):String 
    	{
    		return str.charAt(0) ;
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
	    public static function isEmpty(str:String):Boolean 
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
 	    public static function lastChar(str:String):String 
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
    	public static function lastIndexOfAny(str:String, ar:Array):int 
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
		 * Replaces the 'search' string with the 'replace' String.
	 	 * <p><b>Example :</b></p>
	 	 * {@code
		 * vegas.util.StringUtil.replace("hello world", "hello", "hi") ; // "hello world" -> "hi world"
		 * }
		 * @param the string to transform.
		 * @return the new string transform with this method.
		 */
		public static function replace(str:String, search:String, replace:String):String 
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
		public static function reverse(str:String):String 
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
	    public static function splice(str:String, startIndex:uint, deleteCount:uint=0, value:* = null ):String 
	    {
			var a:Array = StringUtil.toArray(str) ;
			a.splice(startIndex, deleteCount, value) ;
			return a.join("") ;
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
	    public static function toArray(str:String):Array 
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
	    public static function toSource( ...arguments ):String 
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
    			if( code > 0xFF ) 
    			{
    				str += "\\u" + toUnicode( code ) ;
    			}
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
		 * Returns the value of this specified string with the first character in uppercase.
		 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.util.StringUtil ;
		 * trace( StringUtil.ucFirst("hello world" )) ; // Hello world
		 * }
		 * @return the value of this string with the first character in uppercase.
	 	 */
	 	public static function ucFirst(str:String):String 
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
	    public static function ucWords(str:String):String 
	    {
		    var ar:Array = str.split(" ") ;
		    var l:uint = ar.length ;
		    while(--l > -1) 
		    {
		        ar[l] = StringUtil.ucFirst(ar[l]) ;
		    }
		    return ar.join(" ") ;
	    }
 
    }

}