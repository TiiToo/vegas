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

/* ------- StringUtil

	AUTHOR
	
		Name : StringUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- firstChar():String
		
		- indexOfAny(ar:Array):Number
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- lastChar():String
		
		- lastIndexOfAny(ar:Array):Number
		
		- padLeft(i:Number, char:String):String 
		
		- padRight(i:Number, char:String):String
		
		- replace(search:String, replace:String):String
		
		- reverse():String
		
			Warning : this method use String.split méthod !
		
		- splice(startIndex:Number, deleteCount:Number, value):String
		
		- toArray():Array
		
		- toSource():String
		
		- ucFirst():String
		
			capitalize the first letter of a string, like the PHP function
		
		- ucWords():String
		
			capitalize each word in a string, like the PHP function

	IMPLEMENTS
	
		IHashable, IFormattable, Iterable, ISerializable

	INHERIT

		String
			|
			StringUtil

----------  */

import vegas.core.HashCode;
import vegas.core.ISerializable;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.iterator.StringIterator;
import vegas.util.ArrayUtil;
import vegas.util.serialize.Serializer;

class vegas.util.StringUtil extends String implements Iterable, ISerializable {

	// ----o Construtor
	
	public function StringUtil(s:String) {
		super(s || "") ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(StringUtil.prototype) ;

	// ----o Public Methods
	
	public function firstChar():String {
		return charAt(0) ;
	}

	public function hashCode():Number {
		return null ;
	}
	
	public function indexOfAny(ar:Array):Number {
		var index:Number ;
		var l:Number = ar.length ;
		for (var i:Number = 0 ; i<l ; i++) {
			index = this.indexOf(ar[i]) ;
			if (index > -1) return index ;
		}
		return -1 ;
	}
	
	public function isEmpty():Boolean {
		return length == 0 ;
	}
	
	public function iterator():Iterator {
		return new StringIterator(this.toString()) ;
	}	
	
	public function lastChar():String {
		return charAt(length - 1) ;
	}

	public function lastIndexOfAny(ar:Array):Number {
		var index:Number = -1 ;
		var l:Number = ar.length ;
		for (var i:Number = 0 ; i<l ; i++) {
			index = this.lastIndexOf(ar[i]) ;
			if (index > -1) return index ;
		}
		return index ;
	}
	
	public function padLeft(i:Number /*Int*/, char:String):String {
		char = char || " " ;
		var s:String = new String(this) ;
        var l = s.length ;
        for (var k:Number = 0 ; k < (i - l) ; k++) s = char + s ;
        return s ;
    }
	
	public function padRight(i:Number /*Int*/ , char:String):String {
		char = char || " " ;
        var s:String = new String(this) ;
        var l = s.length ;
		for (var k:Number = 0 ; k < (i - l) ; k++) {
			s = s + char ;
		}
        return s ;
    }
	
	public function replace(search:String, replace:String):String {
		return split(search).join(replace) ;
	}
	
	public function reverse():String {  
		var ar:Array = split("") ;
		ar.reverse() ;
		return ar.join("") ;
	}
	
	public function splice(startIndex:Number, deleteCount:Number, value):String {
		var a:Array = toArray() ;
		a.splice.apply(a, arguments) ;
		return ArrayUtil.toString(a) ;
	}

	public function toArray():Array {
		return split("") ;
	}
	
	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [toString()]) ;
	}
	
	public function ucFirst():String {
		return this.charAt(0).toUpperCase() + this.substring(1) ;
	}
	
	public function ucWords():String {
		var ar:Array = split(" ") ;
		var l:Number = ar.length ;
		while(--l > -1) ar[l] = (new StringUtil(ar[l])).ucFirst() ;
		return ar.join(" ") ;
	}
	
}