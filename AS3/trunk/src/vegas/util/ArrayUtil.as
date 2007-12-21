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
	import system.Arrays;    

	/**
	 * Array static tool class.
	 * @author eKameleon
	 */
    public class ArrayUtil 
    {

        /**
         * Creates the shallow copy of the Array.
         * @return the shallow copy of the Array.
         */
    	public static function clone(ar:Array):Array 
    	{
    		return ar.slice() ;
    	}
    
        /**
         * Returns whether the Array contains a particular item.
         */
    	public static function contains( ar:Array , value:Object):Boolean 
    	{
    		return ar.indexOf(value) > -1 ;
    	}
    
    	/**
    	 * Creates the deep copy of the Array.
    	 * @return the deep copy of the Array.
    	 */
    	public static function copy(ar:Array):Array 
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
		 * @return an new array from arguments in a function.
		 */
    	public static function fromArguments( ar:Array, args:Array ):Array 
    	{
    		return ar.concat(args) ;	
        }

	    /**
    	 * Tests whether some element in the array passes the test implemented by the provided function.
    	 * <p><b>Example :</b></p>
    	 * {@code
    	 * var scope:Object = {} ;
    	 * scope.toString = function():String
    	 * {
    	 *     return "myScope" ;
    	 * }
    	 * 
    	 * var callback:Function = function ( value:* , index:uint , ar:Array ):void
    	 * {
    	 *     trace( this + " index:" + index + " test the value '" + value + "' in the Array : " + ar ) ;
    	 * }
    	 * 
    	 * ArrayUtil.some( [2, 3, 4] , callback , scope) ;
    	 * 
    	 * // myScope index:0 test the value '2' in the Array : 2,3,4
    	 * // myScope index:1 test the value '3' in the Array : 2,3,4
    	 * // myScope index:2 test the value '4' in the Array : 2,3,4
    	 * }
    	 */
    	public static function some( ar:Array , callback:Function , thisObject:* = null ):Boolean 
    	{
            var len:uint = ar.length ;
            for( var i:uint=0; i<len; i++ ) 
            {    
                if( callback.call( thisObject, ar[i], i, ar ) ) return true ;
            }
            return false;
        }

        /**
         * Returns a string representing the source code of the array.
         */
	    public static function toSource(ar:Array, indent:Number = NaN , indentor:String = null ):String 
	    {
    		var i:Number;
    		var source:Array = [] ;
    		if( !isNaN(indent) ) indent++ ;
    		var l:Number = ar.length ;
            for( i = 0 ; i<l ; i++ ) 
            {
    			if( ar[i] === undefined ) source[i] = "undefined" ;
    			else if( ar[i] === null ) source[i] = "null" ;
                else source[i] = Serializer.toSource(ar[i], indent, indentor) ;
    		}
    		if( isNaN(indent) ) 
    		{
    		    return "[" + source.join( "," ) + "]" ;
    		}
    		if( indentor == null ) indentor = "    ";
    		if( isNaN(indent) ) 
    		{
    		    indent = 0 ;
    		}
            var decal:String = "\n" + Arrays.initialize( indent, indentor ).join( "" );
    		return decal + "[" + decal + source.join( "," + decal ) + decal + "]" ;
        }

    }    
    
}

