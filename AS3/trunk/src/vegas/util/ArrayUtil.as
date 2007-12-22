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

	/**
	 * Array static tool class.
	 * @author eKameleon
	 */
    public class ArrayUtil 
    {
		
		import buRRRn.eden.Serializer ;
		
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
    				a[i] = Copier.copy(ar[i]) ;
    			}
    		}
    		return a ;
    	}

        /**
         * Returns a string representing the source code of the array.
         * @return a string representing the source code of the array.
         */
	    public static function toSource( ar:Array ):String 
	    {
    		return buRRRn.eden.Serializer.emitArray(ar) ;
        }

    }    
    
}

