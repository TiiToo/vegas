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

/* StringUtil

	AUTHOR
	
		Name : StringUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
		
		- clone()
		
		- static compare( strA:String , strB:String, ignoreCase:Boolean ):Number
		
		- static compareTo( o ):Number
		
		- static copy():*

		- static endsWith( value:String ):Boolean
	
		- static firstChar():String
		
		- static format( pattern:String=null , ...arguments:Array ):String
		
		- static indexOfAny(ar:Array):Number
		
		- static isEmpty():Boolean
		
		- static lastChar():String
		
		- static lastIndexOfAny(ar:Array):Number
		
		- static padLeft(i:Number, char:String):String 
		
		- static padRight(i:Number, char:String):String
		
		- static replace(search:String, replace:String):String
		
		- static reverse():String
		
			Warning : this method use String.split méthod !
		
		- static splice(startIndex:Number, deleteCount:Number, value):String
		
		- static startsWith( value:String ):Boolean
		
		- static toArray():Array
		
		- static toSource():String
		
		- static ucFirst():String
		
			Capitalize the first letter of a string, like the PHP function.
		
		- static ucWords():String
		
			Capitalize each word in a string, like the PHP function.

	INHERIT

		String → StringUtil

	IMPLEMENTS
	
		IHashable, IFormattable, Iterable, ISerializable

**/

package vegas.util
{
    
    import vegas.string.UnicodeChar ;
    
    public class StringUtil
    {
        
        // ----o Constants
        
        static public const SPC:String = " " ; // SPACE
        
        // ----o Public Methods
        
        /**
         * Returns a copy by reference of this string.
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
    			if( strA == strB ) return 0 ; //both null
                else if( strA == null ) return -1 ; //strA is null -1
                else return 1 ; //strB is null 1
    		}
		    strA = strA.toString() ;
    		strB = strB.toString() ;
	    	if( ignoreCase ) 
	    	{
            	strA = strA.toLowerCase() ;
        	    strB = strB.toLowerCase() ;
            }
            if( strA == strB ) return 0 ;
            else if( strA.length > strB.length ) return 1 ;
            else return -1 ;
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
		    if (value == null) return false ;
    		if ( str.length < value.length ) return false ;
    		return StringUtil.compare( str.substr( str.length - value.length ), value) == 0;
    	}

        /**
         * Determines whether the start of this instance matches the specified String.
         */
    	static public function firstChar( str:String ):String {
    		return str.charAt(0) ;
    	}
 
 		/** 
 		 * StringUtil.format(pattern:String, ...arguments:Array):String
 		 * 
 		 * Replaces the pattern item in a specified String with the text equivalent of the value of a specified Object instance.
 		 * 
 		 * @usage
 		 * 
 		 *  import vegas.util.StringUtil ;
 		 * 
 		 * 	var result:String ;
		 *
		 *	result = StringUtil.format("Brad's dog has {0,6:#} fleas.", 41) ;
		 *	trace("> " + result) ;
		 *
		 * 	result = StringUtil.format("Brad's dog has {0,-6} fleas.", 12) ;
		 *	trace("> " + result) ;
		 *
		 * 	result = StringUtil.format("{3} {2} {1} {0}", "a", "b", "c", "d") ;
		 *	trace("> " + result) ;
 		 *
 		 *  @thanks Zwetan and Core2 Library.
 		 * 
 		 */
 
 		static public function format( pattern:String=null , ...arguments:Array ):String 
 		{

			if( ! pattern ) return "" ;
			
			var str:String = "" ;
			var args:Array  = [].concat(arguments) ;
			
			var format:String = pattern ;
			
			if ( format.indexOf( "{" ) == -1 ) 
			{
				return format ;	
			}
			
			var ch:String = "" ;
			var pos:uint = 0 ;
			
			var next:Function = function():String 
			{
				ch = format.charAt( pos );
				pos++ ;
				return ch ;
			};
		
			var getIndexValue:Function = function( index:uint ):String 
			{
				var cur:* = args[index] ;
				if( cur ) return cur.toString() ;
				if (cur == undefined ) return "" ;
				else if (cur == null) return null ;
				else return cur.toString() ;
			} ;
		
			var expression:String ; 
			var run:Boolean ;
			var index:Number ;
			var expValue:String ; 
			var paddingChar:String ;
			var spaceAlign:int ;
		
			var l:uint = format.length ;
			while( pos < l ) 
			{
				next() ; 
				if( ch == "{" ) 
				{
					expression = next() ;
					run = true ;
					while( run ) 
					{
						next() ;
						if( ch != "}" ) expression += ch ;
						else run = false ;
					}
					index = undefined ;
					paddingChar = SPC ;
					expValue = "" ;
					if( StringUtil.indexOfAny(expression, [ ",", ":" ] ) == -1 ) 
					{
						index = parseInt( expression.toString() ) ;
						expValue = getIndexValue( index ) ;
						str += expValue ;
					}
					else 
					{
						var vPos:int = expression.indexOf( "," ) ;
						var fPos:int = expression.indexOf( ":" ) ;
						if( vPos == -1 ) {
							vPos = fPos ;
							fPos = -1 ;
						}
						index = parseInt( expression.substring( 0, vPos ) ) ;
						expValue = getIndexValue( index ) ;
						if( fPos == -1 ) 
						{
							spaceAlign = parseInt( expression.substr( vPos+1 ) ) ;
						}
						else 
						{
							spaceAlign  = parseInt( expression.substring( vPos+1, fPos ) ) ;
							paddingChar = expression.substr( fPos+1 ) ;
						}
						if ( isNaN( spaceAlign ) ) 
						{
							// 
						}
						else if( spaceAlign > 0 ) 
						{
							expValue = StringUtil.padLeft(expValue, spaceAlign, paddingChar ) ;
						}
						else 
						{
							expValue = StringUtil.padRight(expValue, -spaceAlign, paddingChar ) ;
						}
						str += expValue ;
					}
				}
				else
				{
					str += ch ;
				}
			}
			return str ;		
		}
 
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
	
	    static public function isEmpty(str:String):Boolean 
	    {
		    return str.length == 0 ;
    	}
 
 	    static public function lastChar(str:String):String 
 	    {
    		return str.charAt(length - 1) ;
	    }

    	static public function lastIndexOfAny(str:String, ar:Array):int 
    	{
    		var index:int = -1 ;
    		var l:uint = ar.length ;
    		for (var i:uint = 0 ; i<l ; i++) {
    			index = str.lastIndexOf(ar[i]) ;
    			if (index > -1) return index ;
    		}
    		return index ;
	    }
	
	    static public function padLeft(str:String, i:int, char:String):String 
	    {
		    char = char || " " ;
    		var s:String = new String(str) ;
            var l:uint = s.length ;
            for ( var k:uint = 0 ; k < (i - l) ; k++)
            {
                s = char + s ;
            }
            return s ;
        }
	
	    static public function padRight(str:String, i:int , char:String):String 
	    {
		    char = char || " " ;
            var s:String = new String(str) ;
            var l:uint = s.length ;
		    for (var k:uint = 0 ; k < (i - l) ; k++) 
		    {
			    s = s + char ;
    		}
            return s ;
        }
 
		static public function replace(str:String, search:String, replace:String):String 
 	   	{
		    return str.split(search).join(replace) ;
	    }
	
	    static public function reverse(str:String):String 
	    {  
		    var ar:Array = str.split("") ;
    		ar.reverse() ;
	    	return ar.join("") ;
	    }
	
	    static public function splice(str:String, startIndex:uint, deleteCount:uint, value:*):String 
	    {
		    var a:Array = StringUtil.toArray(str) ;
		    a = a.splice.apply(a, arguments) ;
		    return a.toString() ;
	    }

	    /**
	     *  Method: startsWith
   	     * Determines whether a specified string is a prefix
   	     * of the current instance.
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
	    
	        return( StringUtil.compare( str.substr( 0, value.length), value) == 0);
	        
	    }


	    static public function toArray(str:String):Array 
	    {
		    return str.split("") ;
	    }
	
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
	
	    static public function ucFirst(str:String):String 
	    {
		    return str.charAt(0).toUpperCase() + str.substring(1) ;
	    }
	
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
 
    }
}