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

import vegas.util.MathsUtil;

/**
 * The {@code NumberUtil} utility class is an all-static class with methods for working with number.
 * @author eKameleon
 */
class vegas.util.NumberUtil 
{

	/**
	 * Returns a copy by reference of this Number.
	 */
	static public function clone(n:Number):Number 
	{
		return n ;
	}

	/**
	 * Returns a copy by value of this Number.
	 */
	static public function copy(n:Number):Number 
	{
		return Number(n.valueOf()) ;
	}

	/**
	 * compare if two Numbers are equal by value
	 */
	static public function equals( n1:Number, n2:Number ):Boolean 
	{
		if (! n2 ) return false ;
		if(n1.valueOf() == n2.valueOf()) 
		{
			return true ;
		}
		return false ;
    }
	
	/**
	 * Converts to an equivalent Boolean value.
	 */
	static public function toBoolean(n:Number):Boolean 
	{
		if (isNaN(n) || n.valueOf() == 0) 
		{
			return false ;
		}
		return true ;
	}
	
	/***
	 * Returns the exponential string reprsentation of the number passsed in argument.
	 */
	static public function toExponential(p_n:Number, fractionDigits:Number):String 
	{
		var str:String ;
        var x:Number = p_n ;
       	var s:String = "+" ;
        if( isNaN( x ) ) 
        {
        	return "NaN" ;
        }
        if( x < 0 ) 
        {
			s = "-";
			x = -x ;
		}
		if( x == Infinity ) 
		{
			return s + "Infinity" ;
		}
        var l:Number = Math.floor( Math.log(x) / Math.LN10 ) ;
        var lm:Number = Math.pow( 10, l ) ;
        var n:Number = x/lm ;
        if( fractionDigits == null ) 
        {
            str = n.toString();
        }
        else 
        {
        	fractionDigits = MathsUtil.clamp(fractionDigits, 0, 20) ;
            str = NumberUtil.toFixed( n, fractionDigits );
        }
        str += "e" + s + l;
        return str ;
	}
	
	/**
	 * Returns a string representing the number in fixed-point notation (*ECMA-262*).
	 */
	static public function toFixed(p_n:Number, fractionDigits:Number):String 
	{
        var x:Number = p_n ;
        if( isNaN( x )) 
        {
        	return "NaN" ;
        }
        if (fractionDigits == null) fractionDigits = 0 ;
       	fractionDigits = MathsUtil.clamp(fractionDigits, 0, 20) ;
        var m:Number = Math.pow( 10, fractionDigits );
        var r:Number = Math.round( x*m ) / m;
        var str:String = r.toString() ;
        var d = str.split( "." )[1] ;
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
	static public function toObject(n:Number):Number 
	{
		return new Number( n.valueOf() ) ;	
	}
	
	/**
	 * Returns a string representing the number to a specified precision in fixed-point notation (*ECMA-262*).
	 */
	static public function toPrecision(p_n:Number, precision:Number):String 
	{
		var x:Number = p_n ;
		var str:String = x.toString() ;
		if ( isNaN(x) ) 
		{
			return "NaN" ;
		}
		if( (precision == null) || (x == Infinity) || (x == -Infinity) ) 
		{
			return x.toString();
		}
		precision = MathsUtil.clamp(precision, 1, 21) ;
		if (str.length > precision) 
		{
			return NumberUtil.toExponential( x, precision - 1 ) ;	
		}
		var l:Number = Math.floor( Math.log(x) / Math.LN10 ) ;
		var m:Number = Math.pow( 10 , l+1 - precision ) ;
		var r:Number = Math.round(x/m) * m ;
		str = r.toString() ;
		var d = str.split( "." ).join( "" ) ;
		if( d && (d.length < precision) ) 
		{
			if( str.indexOf( "." ) == -1 ) 
			{
				str += "." ;
			}
			var len:Number = precision - d.length ;
            for( var i:Number = 0 ; i < len; i++ ) 
            {
            	str += "0" ;
            }
        }
        return str ;
	}
	
}