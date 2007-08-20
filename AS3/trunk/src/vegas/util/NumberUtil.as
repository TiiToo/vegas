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
     * The {@code NumberUtil} utility class is an all-static class with methods for working with number.
     * @author eKameleon
     */
    public class NumberUtil
    {
        
    	/**
    	 * Returns a copy by reference of this Number.
    	 */
    	static public function clone(n:Number=NaN):Number 
    	{
    		return n ;
    	}

	    /**
    	 * Returns a copy by value of this Number.
    	 */
    	static public function copy(n:Number=NaN):Number 
    	{
    		return Number(n.valueOf()) ;
    	}

    	/**
    	 * compare if two Numbers are equal by value
    	 */
    	static public function equals( n1:Number=NaN, n2:Number=NaN ):Boolean 
    	{
       		if ( n1.toString() == n2.toString() )
    		{
    		    return true ;
    		}
    		if(n1.valueOf() == n2.valueOf()) 
    		{
    		    return true ;
    		}
    		return false ;
        }
    	
    	/**
    	 * Converts to an equivalent Boolean value.
    	 */
    	static public function toBoolean(n:Number=NaN):Boolean 
    	{
    		if (isNaN(n) || n.valueOf() == 0) return false ;
    		return true ;
    	}
    	
        /**
         * Returns a string representation of the specified number.
         * @return a string representation of the specified number.
         */
    	static public function toSource( n:Number ):String 
    	{
		    return n.toString() ;
        }
    
        
    }
}