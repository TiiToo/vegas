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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.HashCode;
import vegas.core.IComparable;
import vegas.core.ICopyable;
import vegas.core.ISerializable;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.iterator.StringIterator;
import vegas.errors.ArgumentsError;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

/**
 * The {@code StringUtil} utility class is an extended String class with methods for working with string.
 * @author eKameleon
 */
class vegas.util.StringUtil extends String implements IComparable, ICopyable, Iterable, ISerializable 
{

	/**
	 * Creates a new StringUtil instance.
	 */
	public function StringUtil(s:String) 
	{
		super(s || "") ;
	}

	/**
	 * Returns a shallow copy of this object.
	 */
	public function clone() 
	{
		return this ;	
	}

	/**
	 * Compares its two arguments for order. You can ignore the case of the 2 strings parameters.
	 */
	static public function compare( strA:String , strB:String, ignoreCase:Boolean ):Number 
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
	 * Compares this object with the specified object for order.
	 */
	public function compareTo( o ):Number 
	{
		if (! TypeUtil.typesMatch(o, String)) 
		{
			throw new ArgumentsError("StringUtil.compareTo('"+ o + "' value must be a string") ;
		}
		if (o == null) 
		{
			return 1 ;
		}
		return StringUtil.compare(String(this.valueOf()), String(o.valueOf()) ) ;
	}
	
	/**
	 * Returns a deep copy of this object.
	 * @return a deep copy of this object.
	 */
	public function copy() 
	{
		return new StringUtil( String(this.valueOf()) )  ;
	}
	
	/**
	 * Returns {@code true} if the string contains the specified caractere at the end.
	 * @return {@code true} if the string contains the specified caractere at the end.
	 */
	public function endsWith( value:String ):Boolean 
	{
		if (value == null) return false ;
		if ( this.length < value.length ) return false ;
		return StringUtil.compare( this.substr( this.length-value.length ), value) == 0;
	}
	
	/**
	 * Returns the first character in the string.
	 */
	public function firstChar():String 
	{
		return charAt(0) ;
	}

	/**
	 * Returns a hash code value for the object.
	 * @return a hash code value for the object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}
	
	/**
	 * Reports the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
	 */
	public function indexOfAny(ar:Array):Number 
	{
		var index:Number ;
		var l:Number = ar.length ;
		for (var i:Number = 0 ; i<l ; i++) 
		{
			index = this.indexOf(ar[i]) ;
			if (index > -1) return index ;
		}
		return -1 ;
	}
	
	/**
	 * Inserts a specified instance of String at a specified index position in this instance.
	 */
	public function insert( startIndex:Number, value:String):String 
	{
		var str:String = this.copy() ;
		if( value == null ) return str ;
		if( str == "" ) return value ;
        if( startIndex == 0 ) return value + str ;
       	else if( (startIndex == null) || (startIndex == str.length) ) return str + value ;
       	var strA:String = str.substr( 0, startIndex );
    	var strB:String = str.substr( startIndex ) ;
    	return strA + value + strB ;
	}
	
	/**
	 * Returns {@code true} if this string is empty.
	 */
	public function isEmpty():Boolean 
	{
		return length == 0 ;
	}
	
	/**
	 * Returns a StringIterator reference of this string instance.
	 * @return a StringIterator reference of this string instance.
	 */
	public function iterator():Iterator 
	{
		return new StringIterator(this.toString()) ;
	}	
	
	/**
	 * Returns the last char of the string. 
	 */
	public function lastChar():String 
	{
		return charAt(length - 1) ;
	}

	/**
	 * Reports the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
	 */
	public function lastIndexOfAny(ar:Array):Number 
	{
		var index:Number = -1 ;
		var l:Number = ar.length ;
		for (var i:Number = 0 ; i<l ; i++) 
		{
			index = this.lastIndexOf(ar[i]) ;
			if (index > -1) 
			{
				return index ;
			}
		}
		return index ;
	}
	
	/**
	 * Right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
	 */
	public function padLeft(i:Number /*Int*/, char:String):String 
	{
		char = char || " " ;
		var s:String = new String(this) ;
        var l:Number = s.length ;
        for (var k:Number = 0 ; k < (i - l) ; k++) 
        {
        	s = char + s ;
        }
        return s ;
    }
	
	/**
	 * Left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
	 */
	public function padRight(i:Number /*Int*/ , char:String):String 
	{
		char = char || " " ;
        var s:String = new String(this) ;
        var l:Number = s.length ;
		for (var k:Number = 0 ; k < (i - l) ; k++) 
		{
			s = s + char ;
		}
        return s ;
    }
	
	/**
	 * Repleace the 'search' string with the 'replace' String.
	 */
	public function replace(search:String, replace:String):String 
	{
		return split(search).join(replace) ;
	}
	
	/**
	 * Reverse the current instance.
	 */
	public function reverse():String 
	{  
		var ar:Array = split("") ;
		ar.reverse() ;
		return ar.join("") ;
	}
	
	/**
	 * Adds and removes elements in the string.
	 * @param startIndex Index at which to start changing the string.
	 * @param deleteCount Indicating the number of old character elements to remove.
	 * @param value The elements to add to the string. If you don't specify any elements, splice simply removes elements from the string.
	 */
	public function splice(startIndex:Number, deleteCount:Number, value):String 
	{
		var a:Array = toArray() ;
		a = a.splice.apply(a, arguments) ;
		return a.join("") ;
	}

	/**
	 * Determines whether a specified string is a prefix of the current instance. 
	 * @return {@code true} if the specified string is a prefix of the current instance.
	 */
	public function startsWith( value:String ):Boolean
   	{
	   	if( value == null )
		{
    	   	return false;
        }
	    
	    if( this.length < value.length )
        {
        	return false;
        }
	    
	    if( this.charAt( 0 ) != value.charAt( 0 ) )
        {
        	return false;
        }
	    
	   	return( StringUtil.compare( this.substr( 0, value.length), value) == 0);
	}

	/**
	 * Returns an array representation of this instance.
	 * @return an array representation of this instance.
	 */
	public function toArray():Array 
	{
		return split("") ;
	}
	
	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		return Serializer.getSourceOf(this, [toString()]) ;
	}
	
	/**
	 * Returns the value of this string with the first character in uppercase.
	 */
	public function ucFirst():String 
	{
		return this.charAt(0).toUpperCase() + this.substring(1) ;
	}
	
	/**
	 * Uppercase the first character of each word in a string.
	 */
	public function ucWords():String 
	{
		var ar:Array = split(" ") ;
		var l:Number = ar.length ;
		while(--l > -1) 
		{
			ar[l] = (new StringUtil(ar[l])).ucFirst() ;
		}
		return ar.join(" ") ;
	}
	
	static private var _initHashCode:Boolean = HashCode.initialize( StringUtil.prototype ) ;
	
	
}