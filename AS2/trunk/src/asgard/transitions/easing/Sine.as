/* ---------- Sine

	AUTHOR

		Name : Sine
		Package : asgard.transitions.easing
		Version : 1.0.0.0
		Date :  2005-11-26
		Author : RobertPenner
		URL : http://www.ekameleon.net

	LICENCE
	
		Easing Equations v2.0
		September 1, 2003
		(c) 2003 Robert Penner, all rights reserved. 
		This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.
		
----------  */	

import asgard.transitions.Ease ;

class asgard.transitions.easing.Sine extends Ease {

	// ----o Static Methods

	/*override*/ static public function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
		return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
	}
	
	/*override*/ static public function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
		return c * Math.sin(t/d * (Math.PI/2)) + b;
	}
	
	/*override*/ static public function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
		return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
	}
	
}
