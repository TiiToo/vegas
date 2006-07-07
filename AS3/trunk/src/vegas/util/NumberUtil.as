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

/** NumberUtil

	AUTHOR
	
		Name : NumberUtil
		Package : vegas.util.type
		Version : 1.0.0.0
		Date :  2006-04-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static clone(f:Function):Function
		
		- static copy(f:Function):Function
		
		- static equals( f1:Function, f2:Function ):Boolean

		- static toBoolean(n:Number):Boolean
		
		- static toExponential(p_n:Number, fractionDigits:Number)
		
		- static toFixed(p_n:Number, fractionDigits:Number):String
		
		- static toNumber(n:Number):Number
		
		- static toObject(n:Number):Number
		
		- static toPrecision(p_n:Number, precision:Number):String

		- static toSource(n:Number):String

**/

package vegas.util
{
    public class NumberUtil
    {
        
    	/**
    	 * Returns a copy by reference of this Number.
    	 */
    	static public function clone(n:Number=NaN):Number {
    		return n ;
    	}

	    /**
    	 * Returns a copy by value of this Number.
    	 */
    	static public function copy(n:Number=NaN):Number {
    		return Number(n.valueOf()) ;
    	}

    	/**
    	 * compare if two Numbers are equal by value
    	 */
    	static public function equals( n1:Number=NaN, n2:Number=NaN ):Boolean {
    		if (isNaN(n2)) return false ;
    		if(n1.valueOf() == n2.valueOf()) return true ;
    		return false ;
        }
    	
    	/**
    	 * Converts to an equivalent Boolean value.
    	 */
    	static public function toBoolean(n:Number=NaN):Boolean {
    		if (isNaN(n) || n.valueOf() == 0) return false ;
    		return true ;
    	}
    	
    	static public function toExponential(p_n:Number, fractionDigits:Number=NaN):String 
    	{
    		var str:String ;
            var x:Number = p_n ;
       	    var s:String = "+" ;
            if( isNaN( x ) ) return "NaN" ;
            if( x < 0 ) 
            {
			    s = "-";
    			x = -x ;
	    	}
    		if( x == Infinity ) return s + "Infinity" ;
            var l:Number = Math.floor( Math.log(x) / Math.LN10 ) ;
            var lm:Number = Math.pow( 10, l ) ;
            var n:Number = x/lm ;
            if( isNaN(fractionDigits) ) {
                str = n.toString();
            } else {
        	    fractionDigits = MathsUtil.clamp(fractionDigits, 0, 20) ;
                str = NumberUtil.toFixed( n, fractionDigits );
            }
            str += "e" + s + l;
            return str ;
	    }
	
    	/**
    	 * Returns a string representing the number in fixed-point notation (*ECMA-262*).
    	 */
    	static public function toFixed(p_n:Number, fractionDigits:Number=NaN):String 
    	{
            var x:Number = p_n ;
            if( isNaN( x )) return "NaN" ;
            if (isNaN(fractionDigits)) fractionDigits = 0 ;
            fractionDigits = MathsUtil.clamp(fractionDigits, 0, 20) ;
            var m:Number = Math.pow( 10, fractionDigits );
            var r:Number = Math.round( x*m ) / m;
            var str:String = r.toString() ;
            var d:Array = str.split( "." )[1] ;
            if( d && (d.length < fractionDigits) ) 
            {
			    var len:Number = fractionDigits - d.length  ;
			    for( var i:Number=0; i< len ; i++ ) str += "0" ;
		    }
            return str;
        }
	
    	/**
    	 * Converts to an equivalent Number value.
    	 */
    	static public function toNumber(n:Number):Number 
    	{
    		return n.valueOf() ;	
    	}
	
    	/**
    	 * Converts to an equivalent Object value
    	 */
    	static public function toObject(n:Number=NaN):Number 
    	{
		    return new Number( n.valueOf() ) ;	
    	}
	
	    /**
    	 * Returns a string representing the number to a specified precision in fixed-point notation (*ECMA-262*).
    	 */
    	static public function toPrecision(p_n:Number=NaN, precision:Number=NaN):String 
    	{
    		var x:Number = p_n ;
    		var str:String = x.toString() ;
    		if ( isNaN(x) ) return "NaN" ;
    		if( isNaN(precision) || (x == Infinity) || (x == -Infinity) ) return x.toString();
    		precision = MathsUtil.clamp(precision, 1, 21) ;
    		if (str.length > precision) 
    		{
    			return NumberUtil.toExponential( x, precision - 1 ) ;	
    		}
    		var l:Number = Math.floor( Math.log(x) / Math.LN10 ) ;
    		var m:Number = Math.pow( 10 , l+1 - precision ) ;
    		var r:Number = Math.round(x/m) * m ;
    		str = r.toString() ;
    		var d:String = str.split( "." ).join( "" ) ;
    		if( d && (d.length < precision) ) 
    		{
    			if( str.indexOf( "." ) == -1 ) str += "." ;
    			var len:Number = precision - d.length ;
                for( var i:Number = 0 ; i < len; i++ ) str += "0" ;
            }
            return str ;
	    }
	
        /**
         * Returns a string representing the source code of the number.
         */
    	static public function toSource( ...arguments ):String 
    	{
		    return arguments[0].toString() ;
        }
    
        
    }
}