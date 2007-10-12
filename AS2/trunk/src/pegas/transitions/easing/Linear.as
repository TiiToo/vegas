/*
	LICENCE
	
		Easing Equations v2.0
		September 1, 2003
		(c) 2003 Robert Penner, all rights reserved. 
		This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.
		
*/

import pegas.transitions.Ease;

class pegas.transitions.easing.Linear extends Ease 
{

	/*override*/ public static function easeNone (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return c*t/d + b;
	}
	
	/*override*/ public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return c*t/d + b;
	}
	
	/*override*/ public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return c*t/d + b;
	}
	
	/*override*/ public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return c*t/d + b;
	}
	
}
