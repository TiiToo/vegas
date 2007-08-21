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
    
    import vegas.errors.ArgumentOutOfBoundsError;

	/**
	 * Array static tool class.
	 * @author eKameleon
	 */
    public class ArrayUtil 
    {

        /**
         * Creates a shallow copy of the Array.
         */
    	static public function clone(ar:Array):Array 
    	{
    		return ar.slice() ;
    	}
    
        /**
         * Returns whether the Array contains a particular item.
         */
    	static public function contains( ar:Array , value:Object):Boolean 
    	{
    		return ar.indexOf(value) > -1 ;
    	}
    
    	/**
    	 * Creates a deep copy of the Array.
    	 */
    	static public function copy(ar:Array):Array 
    	{
    		var a:Array = [] ;
    		var l:uint = ar.length ;
    		for (var i:uint = 0 ; i < l ; i++) 
    		{
    			if( ar[i] === undefined ) 
    			{
    				a[i] = undefined ;
    			}
    			else if( ar[i] === null ) 
    			{
    				a[i] = null ;
    			}
            	else 
            	{
    				a[i] = Copier.copy(ar[i]) ; // TODO test !!
    			}
    		}
    		return a ;
    	}

		/**
		 * Returns an new array from arguments in a function.
		 */
    	static public function fromArguments( ar:Array, args:Array ):Array 
    	{
    		return ar.concat(args) ;	
        }

	   	/**
		 * Returns the index of the first occurrence of a value in a one-dimensional Array or in a portion of the Array.
		 * @param ar the array reference.
		 * @param value the value to search in the array.
		 * @param startIndex optionnal, allows to specify the starting index of the search.
		 * @param count	allows to limit the number of elements to search in the array.
		 * @return the index of the first occurrence of a value in a one-dimensional Array or in a portion of the Array.
		 */
    	static public function indexOf( ar:Array, value:Object, startIndex:Number, count:Number):Number 
    	{
    		var l:Number = ar.length ;
    		if(isNaN(startIndex) ) startIndex = 0 ;
            if(isNaN(count)) count = ar.length  - startIndex ;
    		if (startIndex < 0 || startIndex > l)
    		    {
    		    throw new ArgumentOutOfBoundsError("ArrayUtil.indexOf : 'startIndex' must be between 0 and 1.");
    		    }
    		if (count < 0 || count > (l - startIndex)) 
    		    {
    		    throw new ArgumentOutOfBoundsError("ArrayUtil.indexOf : 'count' must be between 'startIndex' and the array size -1.") ;
    		    }
    		for (var i:Number = 0 ; startIndex < l ; startIndex++ , i++) 
    		    {
    			if (ar[startIndex] == value) return startIndex ; 
    			if (i == count) break ;
        		}
    		return -1 ;
        }
    
    	/**
    	 * Create and Initialize an Array.
    	 */
    	static public function initialize(index:Number, value:*=null):Array 
    	{
    		if( isNaN(index) ) index = 0 ;
            var ar:Array = [] ;
    		for( var i:Number = 0 ; i<index ; i++ )
    		    {
    		    ar[i] = value ;
    		    }
    		return ar ;
        }

	    /**
    	 * Tests whether some element in the array passes the test implemented by the provided function.
    	 */
    	static public function some( ar:Array, callback:Function, thisObject:*):Boolean 
    	{
            var len:Number = ar.length ;
            var i:Number = 0 ;
            if( thisObject == null ) thisObject = global ;
            for( i=0; i<len; i++ ) 
                {
                if( callback.call( thisObject, ar[i], i, ar ) ) return true ;
                }
            return false;
        }

        /**
         * Returns a string representing the source code of the array.
         */
	    static public function toSource(ar:Array, indent:Number=NaN, indentor:String=null):String 
	    {
    		var i:Number;
    		var source:Array = [] ;
    		if( !isNaN(indent) ) indent++ ;
    		var l:Number = ar.length ;
            for( i = 0 ; i<l ; i++ ) {
    			if( ar[i] === undefined ) source[i] = "undefined" ;
    			else if( ar[i] === null ) source[i] = "null" ;
                else source[i] = Serializer.toSource(ar[i], indent, indentor) ;
    		}
    		if( isNaN(indent) ) {
    		    return "[" + source.join( "," ) + "]" ;
    		}
    		if( indentor == null ) indentor = "    ";
    		if( isNaN(indent) ) {
    		    indent = 0 ;
    		}
            var decal:String = "\n" + ArrayUtil.initialize( indent, indentor ).join( "" );
    		return decal + "[" + decal + source.join( "," + decal ) + decal + "]" ;
        }

    }    
    
}

