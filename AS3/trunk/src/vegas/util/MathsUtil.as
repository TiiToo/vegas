﻿/*

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
    import vegas.errors.IllegalArgumentError;    

    /**
     * The <code class="prettyprint">MathUtil</code> utility class is an all-static class with methods for working with numbers.
     * @author eKameleon
     */ 
    public class MathsUtil
    {
     
        /**
         * Rounds and returns the ceiling of the specified number or expression. 
         * The ceiling of a number is the closest integer that is greater than or equal to the number.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * 
         * var n = MathsUtil.ceil(4.572525153, 2) ;
         * trace ("n : " + n) ; // n : 4.58
         * 
         * var n = MathsUtil.ceil(4.572525153, -1) ;
         * trace ("n : " + n) ; // n : 5
         * </pre>
         * @param n the number to round.
         * @param floatCount the count of number after the point.
         * @return the ceil value of a number by a count of floating points.
         */
        public static function ceil( n:Number, floatCount:Number ):Number 
        {
            if (isNaN(n)) 
            {
                return NaN ;
            }   
            var r:Number = 1 ;
            var i:Number = -1 ;
            while (++i < floatCount) 
            {
                r *= 10 ;
            }
            return Math.ceil(n*r) / r  ;
        }     
        
        /**
         * Bounds a numeric value between 2 numbers.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * 
         * var n = MathsUtil.clamp(4, 5, 10) ;
         * trace ("n : " + n) ; // 5
         * 
         * var n = MathsUtil.clamp(12, 5, 10) ;
         * trace ("n : " + n) ; // 10
         * 
         * var n = MathsUtil.clamp(6, 5, 10) ;
         * trace ("n : " + n) ; // 5
         * 
         * var n = MathsUtil.clamp(NaN, 5, 10) ;
         * trace ("n : " + n) ; // NaN
         * </pre>
         * @param value the value to clamp.
         * @param min the min value of the range.
         * @param max the max value of the range.
         * @return a bound numeric value between 2 numbers.
         */
        public static function clamp(value:Number, min:Number, max:Number):Number 
        {
            if (isNaN(value)) 
            {
                return NaN ;
            }
            if (isNaN(min)) 
            {
                min = value ;
            }
            if (isNaN(max)) 
            {
                max = value ;
            }
            return Math.max(Math.min(value, max), min) ;
        }
        
        /**
         * Rounds and returns a number by a count of floating points.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * 
         * var n = MathsUtil.floor(4.572525153, 2) ;
         * trace ("n : " + n) ; // n : 4.57
         * 
         * var n = MathsUtil.floor(4.572525153, -1) ;
         * trace ("n : " + n) ; // n : 4
         * </pre>
         * @param n the number to round.
         * @param floatCount the count of number after the point.
         * @return the floor value of a number by a count of floating points.
         */
        public static function floor(n:Number, floatCount:Number):Number 
        {
            if (isNaN(n)) 
            {
                return NaN ;
            }
            var r:Number = 1 ;
            var i:Number = -1 ;
            while (++i < floatCount) 
            {
                r *= 10 ;
            }
            return Math.floor(n*r) / r  ;
        }
        
        /**
         * Returns a percentage or null.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * trace( MathsUtil.getPercent( 50 , 100 ) + "%" ) ; // 50%
         * trace( MathsUtil.getPercent( 68 , 425 ) + "%" ) ; // 16% 
         * </pre>
         * @param value the current value.
         * @param maximum the max value.
         * @return a percentage value or null.
         */
        public static function getPercent(value:Number = NaN, maximum:Number = NaN):Number 
        {
            var nP:Number = (value / maximum) * 100 ;
            return (isNaN(nP) || !isFinite(nP)) ? NaN : nP ;
        }
        
        /**
         * With a number value and a range this method returns the actual value for the interpolated value in that range.
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * trace( MathsUtil.interpolate( 0.5, 0 , 100 ) ) ; // 50
         * </pre>
         * @param value The normal number value to interpolate (value between 0 and 1).
         * @param minimum The minimum value of the interpolation.
         * @param maximum The maximum value of the interpolation.
         * @return the actual value for the interpolated value in that range.
         */
        public static function interpolate( value:Number, minimum:Number, maximum:Number ):Number
        {
        	return minimum + (maximum - minimum) * value ;
        } 
        
        /**
         * Takes a value in a given range (minimum1, maximum1) and finds the corresponding value in the next range(minimum2, maximum2).
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * trace( MathsUtil.map( 10,  0, 100, 20, 80  ) ) ; // 26
         * trace( MathsUtil.map( 26, 20,  80,  0, 100 ) ) ; // 10
         * </pre>
         * @param value The number value to map.
         * @param minimum1 The minimum value of the first range of the value.
         * @param maximum1 The maximum value of the first range of the value.
         * @param minimum2 The minimum value of the second range of the value.
         * @param maximum2 The maximum value of the second range of the value.
         * @return value in a given range (minimum1, maximum1) and finds the corresponding value in the next range(minimum2, maximum2).
         */
        public static function map( value:Number, minimum1:Number, maximum1:Number, minimum2:Number, maximum2:Number):Number
        {
            return interpolate( normalize(value, minimum1, maximum1), minimum2, maximum2);
        }
                
        /**
         * Takes a value within a given range and converts it to a number between 0 and 1.
         * Actually it can be outside that range if the original value is outside its range.
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * trace( MathsUtil.normalize( 10, 0 , 100 ) ) ; // 0.1
         * </pre>         
         * @param value The number value to normalize.
         * @param minimum The minimum value of the normalization.
         * @param maximum The maximum value of the normalization.
         */
        public static function normalize(value:Number, minimum:Number, maximum:Number):Number
        {
           return (value - minimum) / (maximum - minimum) ;
        }
                
        /**
         * Rounds and returns a number by a count of floating points.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * 
         * var n = MathsUtil.round(4.572525153, 2) ;
         * trace ("n : " + n) ; // 4.57
         * 
         * var n = MathsUtil.round(4.572525153, -1) ;
         * trace ("n : " + n) ; // 5
         * </pre>
         * @param n the number to round.
         * @param floatCount the count of number after the point.
         * @return the round of a number by a count of floating points.
         */
        public static function round(n:Number, floatCount:Number):Number 
        {
            if (isNaN(n)) 
            {
                return NaN ;
            }
            var r:Number = 1 ;
            var i:Number = -1 ;
            while (++i < floatCount) 
            {
            	r *= 10 ;
            }
            return Math.round(n*r) / r  ;
        }
        
        /**
         * Returns 1 if the value is positive or -1.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.util.MathsUtil ;
         * 
         * n = MathsUtil.sign(-150) ;
         * trace ("n : " + n) ; // -1
         * 
         * n = MathsUtil.sign(200) ;
         * trace ("n : " + n) ; // 1
         * 
         * n = MathsUtil.sign(0) ;
         * trace ("n : " + n) ; // 1
         * </pre>
         * @param n the number to defined this sign.
         * @return 1 if the value is positive or -1.
         * @throws IllegalArgumentError if the passed-in value is NaN.
         */
        public static function sign( n:Number ):Number 
        {
            if (isNaN(n)) 
            {
                throw new IllegalArgumentError("MathsUtil.sign, Argument 'n' must not be 'null' or 'undefined'.") ;
            }
            return ( n < 0 ) ? -1 : 1 ;
        }
        
    }
    
}