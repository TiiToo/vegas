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

import vegas.errors.IllegalArgumentError;

/**
 * The {@code MathUtil} utility class is an all-static class with methods for working with numbers.
 * @author eKameleon
 */
class vegas.util.MathsUtil 
{
	
	/**
	 * Bounds a numeric value between 2 numbers.
	 * @param value the value to clamp.
	 * @param min the min value of the range.
	 * @param max the max value of the range.
	 * @return a bound numeric value between 2 numbers.
	 */
	static public function clamp(value:Number, min:Number, max:Number):Number 
	{
		if (isNaN(value)) 
		{
			throw new IllegalArgumentError("MathsUtils.clamp, argument 'value' must not be 'null' or 'undefined' or 'NaN'") ;
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
	 * Returns a percentage or null.
	 * @param nValue the current value.
	 * @param nMax the max value.
	 * @return a percentage value or null.
	 */
	static public function getPercent(nValue:Number, nMax:Number):Number 
	{
		var nP:Number = (nValue / nMax) * 100 ;
		return (isNaN(nP) || !isFinite(nP)) ? null : nP ;
	}
	
	/**
	 * Rounds and returns a number by a count of floating points.
	 * @param n the number to round.
	 * @param floatCount the count of number after the point.
	 * @return the round of a number by a count of floating points.
	 */
	static public function round(n:Number, floatCount:Number):Number 
	{
		if (isNaN(n)) 
		{
			throw new IllegalArgumentError("MathsUtil.round, Argument 'n' must not be 'null' or 'undefined'.") ;
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
	 * @param n the number to defined this sign.
	 * @return 1 if the value is positive or -1.
	 */
	static public function sign( n:Number ):Number 
	{
		if (isNaN(n)) 
		{
			throw new IllegalArgumentError("MathsUtil.sign, Argument 'n' must not be 'null' or 'undefined'.") ;
		}
		return n<0 ? -1 : 1 ;
	}

}