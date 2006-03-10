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

/* -------- MathsUtil

	AUTHOR

		Name : MathsUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-11-02
		Author : eKameleon
		URL : http://www.ekameleon.net

	METHOD SUMMARY

		- clamp(value:Number, min:Number, max:Number) 
		
			bound a numeric value between 2 numbers.
			
		- getPercent(nValue:Number, nMax:Number):Number
		
			return a percentage or null.
			
		- round(n:Number, floatCount:Number) 
		
			rounds a number by a count of floating points

		- sign(n:Number)
			
			return 1 if the value is positive or -1

	HISTORY
	
		2005-11-02 : add round(n, floatcount) method
		2005-11-06 : add IllegalArgumentException in methods
		2005-11-06 : add sign(n) method
		2005-11-09 : change line 52, 57, 65 : throw condition (isNaN(value))
		2005-11-16 : add min & max test in clamp method
		2006-01-11 : change namespace vegas.maths > vegas.util
		2006-03-01 : add getPercent() method
	
----------------*/

import vegas.errors.IllegalArgumentError;

class vegas.util.MathsUtil {
	
	// ----o Constructor
	
	private function MathsUtil() {
		//
	}

	//  ------o static public Methods
	
	static public function clamp(value:Number, min:Number, max:Number):Number {
		if (isNaN(value)) {
			throw new IllegalArgumentError("MathsUtils.clamp, argument 'value' must not be 'null' or 'undefined' or 'NaN'") ;
		}
		if (isNaN(min)) min = value ;
		if (isNaN(max)) max = value ;
		return Math.max(Math.min(value, max), min) ;
	}
	
	static public function getPercent(nValue:Number, nMax:Number):Number {
		var nP:Number = (nValue / nMax) * 100 ;
		return isNaN(nP) || !isFinite(nP) ? null : nP ;
	}
		
	static public function round(n:Number, floatCount:Number):Number {
		if (isNaN(n)) throw new IllegalArgumentError() ; // "Argument 'n' must not be 'null' or 'undefined'.
		var r:Number = 1 ;
		var i:Number = -1 ;
		while (++i < floatCount) r *= 10 ;
		return Math.round(n*r) / r  ;
	}
	
	static public function sign( n:Number ):Number {
		if (isNaN(n)) throw new IllegalArgumentError() ; // "Argument 'n' must not be 'null' or 'undefined'.
		return n<0 ? -1 : 1 ;
	}

}