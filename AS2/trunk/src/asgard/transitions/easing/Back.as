﻿/* ---------- Back

	AUTHOR

		Name : Back
		Package : asgard.transitions.easing
		Version : 1.0.0.0
		Date :  2005-11-26
		Author : RobertPenner
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	LICENCE
	
		Easing Equations v2.0
		September 1, 2003
		(c) 2003 Robert Penner, all rights reserved. 
		This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.

----------  */	

import asgard.transitions.Ease;

class asgard.transitions.easing.Back extends Ease {
	
	// ----o Static Methods
	
	/*override*/ static public function easeIn (t:Number, b:Number, c:Number, d:Number, s:Number):Number {
		s = ( isNaN(s)) ? 1.70158 : s ;
		return c * (t/=d) * t * ( (s+1) * t -  s) + b ;
	}
	
	/*override*/ static public function easeOut (t:Number, b:Number, c:Number, d:Number, s:Number):Number {
		if (s == undefined) s = 1.70158;
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	}
	
	/*override*/ static public function easeInOut (t:Number, b:Number, c:Number, d:Number, s:Number):Number {
		if (s == undefined) s = 1.70158; 
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	}
	
}
