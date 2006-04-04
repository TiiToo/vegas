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

/* ------- ArrayUtil

	AUTHOR
	
		Name : ArrayUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	STATIC METHOD SUMMARY
	
		- clone(ar:Array):Array 
		
		- contains(ar:Array, value:Object):Boolean
		
		- copy(ar:Array):Array 
		
			!!!! ici faire en sorte d'avoir une classe Copy.toCopy(o)
		
		- every(ar:Array, callback:Function, o:Object):Boolean
			
			DESCRIPTION
			
				Tests whether all elements in the array pass the test implemented by the provided function.
		
		- forEach(callback:Function, o:Object):Void
		
			Calls a function for each element in the array.
			
			note:
				callback is invoked with three arguments:
					- the value of the element
					- the index of the element
					- the Array object being traversed
		
		- fromArguments( ar:Array, args:Array ):Array
		
			Returns an Array object from a function Arguments object.
		
		- indexOf( ar:Array, value:Object, startIndex:Number, count:Number):Number
			
			DESCRIPTION
			
				Returns the index of the first occurrence of a value in a one-dimensional Array 
				or in a portion of the Array .
   
			PARAMETERS
				
				- startIndex 
					optionnal, allows to specify the starting index of the search.
				
				- count 
					allows to limit the number of elements to search in the array
		
		- initialize(index:Number, value:Object):Array 
			
			DESCRIPTION
				
				Initializes a new Array with an arbitrary number of elements (index) ,
				with every element containing the passed parameter value or by default the null value.
			
		- lastIndexOf(ar:Array, o):Number
		
		- toString(ar:Array):String

	HISTORY
	
		2005-12-16 - CHANGE :: exists > contains
	
	TODO
	
		2005-12-22 :: créer une classe Copy qui permette de renvoyer la copy de n'importe quel objet.
	
----------  */

import vegas.errors.ArgumentOutOfBoundsError;

class vegas.util.ArrayUtil {

	// ----o Construtor
	
	public function ArrayUtil() {}
	
// ----o Static Methods

	static public function clone(ar:Array):Array {
		return ar.slice() ;
	}

	static public function contains( ar:Array , value:Object) :Boolean {
		return (indexOf(ar, value) > -1) ;
	}

	static public function copy(ar:Array):Array {
		// TODO unstable
		var a:Array = [] ;
		var i:Number ;
		var l:Number = ar.length ;
		for (i = 0 ; i < l ; i++) {
			if( ar[i] === undefined ) {
				a[i] = undefined ;
			} else if( ar[i] === null ) {
				a[i] = null ;
				continue ;
            } else {
				 a[i] = ar[i].copy() ; // ici faire en sorte d'avoir une classe Copy.toCopy(o)
			}
    		return a ;
		}
	}

	static public function every(ar:Array, callback:Function, o:Object ):Boolean {
		if(!o) o = _global ;
		var len:Number = ar.length ;
		for (var i:Number = 0 ; i<len ; i++) {
			if( !callback.call( o, ar[i], i, ar ) ) return false ;
        }
		return true ;
    }

	static public function forEach(ar:Array, callback:Function, o):Void {
        var len:Number = ar.length ; 
		var i:Number ;
        if( o == null ) o = _global ;
        for( i=0; i<len ; i++ ) callback.call(o, ar[i], i, ar) ;
    }

	static public function fromArguments( ar:Array, args:Array ):Array {
		return ar.concat(args) ;	
    }

	static public function indexOf( ar:Array, value:Object, startIndex:Number, count:Number):Number {
		var l:Number = ar.length ;
		if(isNaN(startIndex) ) startIndex = 0 ;
        if(isNaN(count)) count = ar.length  - startIndex ;
		if (startIndex < 0 || startIndex > l) throw new ArgumentOutOfBoundsError("ArrayUtil.indexOf : 'startIndex' must be between 0 and 1.");
		if (count < 0 || count > (l - startIndex)) throw new ArgumentOutOfBoundsError("ArrayUtil.indexOf : 'count' must be between 'startIndex' and the array size -1.") ;
		for (var i:Number = 0 ; startIndex < l ; startIndex++ , i++) {
			if (ar[startIndex] == value) return startIndex ; 
			if (i == count) break ;
		}
		return -1 ;
	}

	static public function initialize(index:Number, value:Object):Array {
		if( isNaN(index) ) index = 0 ;
		if( value === undefined ) value = null ;
        var ar:Array = [] ;
		for( var i:Number = 0 ; i<index ; i++ ) ar[i] = value ;
		return ar ;
    }

	static public function lastIndexOf( ar:Array, o ) :Number {
		var l:Number = ar.length;
		while ( --l > -1 ) if (ar[l] == o) return l ; 
		return -1 ;
	}

	static public function toString(ar:Array):String {
		return ar.join("") ;
	}
	
}