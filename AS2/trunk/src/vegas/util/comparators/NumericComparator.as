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

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.errors.ClassCastError;
import vegas.util.comparators.StringComparator;
import vegas.util.TypeUtil;

// finish unit tests.

/**
 * A Comparator which deals with alphabet characters 'naturally', but deals with numerics numerically. 
 * Leading 0's are ignored numerically, but do come into play if the number is equal. 
 * Thus aaa119yyyy comes before aaa0119xxxx regardless of x or y.
 * 
 * The comparison should be very performant as it only ever deals with issues at a character level 
 * and never tries to consider the numerics as numbers.
 * <p><b>Example :</b></p>
 * {@code
 * import vegas.events.Delegate ;
 * import vegas.util.comparators.NumericComparator ;
 * 
 * var ar:Array =
 * [
 *     "a0" , "a1",  "a2",  "a10" , "a11" , "b1" , "b2" , "b0" , "b01", "b001", "c0"
 * ] ;
 * 
 * var c:NumericComparator = new NumericComparator.getIgnoreCaseInstance() ;
 * 
 * ar.sort( Delegate.create( c , c.compare ) , Array.CASEINSENSITIVE ) ;
 * trace( ar ) ; // a0,a1,a2,a10,a11,b1,b2,b0,b01,b001,c0
 * 
 * ar.sort( Delegate.create( c , c.compare ) , Array.CASEINSENSITIVE | Array.DESCENDING ) ;
 * trace(ar ) ; // c0,b001,b01,b0,b2,b1,a11,a10,a2,a1,a0
 * }
 * @author eKameleon
 */
class vegas.util.comparators.NumericComparator extends CoreObject implements IComparator
{

	/**
	 * Creates a new NumericComparator instance.
	 * @param ignoreCase a boolean to define if the comparator ignore case or not.
	 */
	function NumericComparator( ignoreCase:Boolean ) 
	{
		this.ignoreCase = ignoreCase ;
	}

	/**
	 * Allow to take into account the case for comparison.
	 */
	public var ignoreCase:Boolean ;

	/**
	 * Returns an integer value to compare two String objects.
	 * @param o1 the first String object to compare.
	 * @param o2 the second String object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws ClassCastError if compare(a, b) and 'a' or 'b' aren't String objects.
	 */
	public function compare(o1, o2):Number 
	{
		if ( o1 == null || o2 == null) 
		{
			if (o1 == o2) 
			{
				return 0 ;
			}
			else if (o1 == null) 
			{
				return -1 ;
			}
			else 
			{
				return 1 ;
			}
		}
		else 
		{
			if ( !TypeUtil.typesMatch(o1, String) || !TypeUtil.typesMatch(o2, String)) 
			{
				throw new ClassCastError(this + " compare method failed, Arguments string expected.") ;
			}
			else 
			{
				
				var comp:IComparator = ( ignoreCase ) ? StringComparator.getIgnoreCaseStringComparator() : StringComparator.getStringComparator() ;
				
				o1 = o1.toString() ;
				o2 = o2.toString() ;
				
				// find the first digit.
        		var idx1:Number = _getFirstDigitIndex( o1 );
        		var idx2:Number = _getFirstDigitIndex( o2 );
				
				if( ( idx1 == -1 ) || ( idx2 == -1 ) || ( ! ( o1.substring(0,idx1) == o2.substring(0,idx2) ) ) )
		        {
		        	comp.compare(o1, o2) ;
        		}
			
		        // find the last digit
		        var edx1:Number = _getLastDigitIndex( o1, idx1 ) ;
		        var edx2:Number = _getLastDigitIndex( o2, idx2 ) ;
		        
		        var sub1:String = null ;
		        var sub2:String = null ;
		        
		 		if( edx1 == -1 ) 
		 		{
            		sub1 = o1.substring(idx1) ;
        		} 
        		else 
        		{
            		sub1 = o1.substring( idx1, edx1 ) ;
        		}

		        if( edx2 == -1 ) 
		        {
            		sub2 = o2.substring(idx2) ;
        		}
        		else 
        		{
            		sub2 = o2.substring(idx2, edx2) ;
		        }
		        
		        // deal with zeros at start of each number
        		
        		var zero1:Number = _countZeroes( sub1 ) ;
        		var zero2:Number = _countZeroes( sub2 ) ;

        		sub1 = sub1.substring( zero1 ) ;
        		sub2 = sub2.substring( zero2 ) ;
		        
		        // if equal, then recurse with the rest of the string need to deal with zeroes so that 00119 appears after 119.
        		if( sub1 == sub2 ) 
        		{
            		
            		var ret:Number = 0 ;
            		
            		if( zero1 > zero2 ) 
            		{
                		ret = 1;
            		}
            		else if( zero1 < zero2 ) 
            		{
                		ret = -1 ; 
            		}
            		
            		if(edx1 != -1) 
            		{
                		
                		var r:Number = comp.compare( o1.substring(edx1) , o2.substring(edx2) ) ;
                		if ( r != 0 )
                		{
                			ret = r ;
                		}
	                }
		           	
		           	return ret ;
				} 
        		else // if a numerical string is smaller in length than another then it must be less. 
        		{
		            if( sub1.length != sub2.length ) 
		            {
                		return ( sub1.length < sub2.length ) ? -1 : 1 ;
            		}
        		
        		}
		
		        var chr1:Array = sub1.split("");
        		var chr2:Array = sub2.split("") ;

        		var sz:Number = chr1.length ;	
        		for( var i:Number =0 ; i<sz ; i++ ) 
        		{
 		           // this should give better speed
					if( chr1[i] != chr2[i] ) 
            		{
	                	return ( chr1[i] < chr2[i] ) ? -1 : 1 ;
    	        	}
        		}
	        	
	        	return 0 ;
	        	
			}
		}
	}

	/**
	 * Returns the {@code NumericComparator} singleton with the a {@code false} ignoreCase property.
	 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple StringComparators may be used in the same application.
	 * @return the {@code NumericComparator} singleton with the a {@code false} ignoreCase property.
	 */
	static public function getInstance():NumericComparator
	{
		if ( _comparator == null )
		{
			_comparator = new NumericComparator(false) ;	
		}
		return _comparator ;
	}
		

	/**
	 * Returns the {@code NumericComparator} singleton with the a {@code true} ignoreCase property.
	 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple StringComparators may be used in the same application.
	 * @return the {@code NumericComparator} singleton with the a {@code true} ignoreCase property.
	 */
	static public function getIgnoreCaseInstance():NumericComparator
	{
		if ( _ignoreCaseComparator == null )
		{
			_ignoreCaseComparator = new NumericComparator(true) ;	
		}
		return _ignoreCaseComparator ;
	}
	
	/**
	 * Returns a Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent : Number, indentor : String):String 
	{
		return "new vegas.util.comparators.NumericComparator(" + ( (ignoreCase == true) ? "true" : "false") + ")" ;
	}

	/**
	 * The internal Case NumericComparator.
	 */
	static private var _comparator:NumericComparator ;

	/**
	 * The internal ignoreCase NumericComparator.
	 */
	static private var _ignoreCaseComparator:NumericComparator ;
	
	/**
	 * Counts and returns the number of '0' in the passed-in string.
	 * @return the number of '0' in the passed-in string.
	 */
	private function _countZeroes( str:String ) 
	{
        var count:Number = 0 ;
        var size:Number  = str.length ;
        // The str must be small please
        for( var i:Number=0; i<size ; i++ ) 
        {
            if(str.charAt(i) == '0')
            {
                count++;
            }
            else 
            {
                break ;
            }
        }
        return count ;
    }
	
	/**
	 * Returns the first digit index position in a char list (String or Array of chars)
	 * @return the first digit index position in a char list (String or Array of chars)
	 */
    private function _getFirstDigitIndex( chars , start:Number ):Number
    {
    	if ( isNaN(start) )
    	{
    		start = 0 ;
    	}
        
        var chrs:Array ;
        
        if ( TypeUtil.typesMatch( chars, String ) )
        {
        	chrs = String(chars).split("") ;	
        }
        else if ( chars instanceof Array )
        {
        	chrs = [].concat(chars) ;
        }
		else
		{
			return -1 ;	
		}
        
        var size:Number = chrs.length ;

        for( var i:Number = start ; i<size ; i++ ) 
        {
            if( _isDigit(chrs[i])) 
            {
                return i ;
            }
        }
        
        return -1;
    }

	/**
	 * Returns the last digit index position in a char list (String or Array of chars)
	 * @return the last digit index position in a char list (String or Array of chars)
	 */
    private function _getLastDigitIndex( chars, start:Number ):Number 
    {

		var chrs:Array ;
        
        if ( TypeUtil.typesMatch( chars, String ) )
        {
        	chrs = String(chars).split("") ;	
        }
        else if ( chars instanceof Array )
        {
        	chrs = [].concat(chars) ;
        }
		else
		{
			return -1 ;	
		}
        var size:Number = chrs.length ;

        for( var i:Number = start ; i<size ; i++ ) 
        {
            if( !_isDigit(chrs[i])) 
            {
                return i ;
            }
        }
        
        return -1;
    }

	/**
	 * Returns {@code true} if the passed-in character is a digit.
	 * @return {@code true} if the passed-in character is a digit.
	 */
	private function _isDigit( /*char*/ c:String ):Boolean
    {
         return( ("0" <= c) && (c <= "9") );
    }
    

}