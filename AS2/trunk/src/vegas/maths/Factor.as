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

/* ----- Factor

	AUTHOR

		Name : Factor
		Package : vegas.maths
		Version : 1.0.0.0
		Date :  2003-05-15
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY


		- static factorial(n)
			Recursive method that defines the factorial of a positive integer.
		
		- static factorialApprox(n)
			Uses the Gamma function to approximate factorial - very fast	
		
		- static fibonacci(n)
			Calculates total fibonacci levels in 'n'.
		
		- static gammaApprox(n)
			Extends the domain of the factorial function by calculating the factorial of decimal numbers
		
		- static inverse(n)
			Defines the inverse of a number.
		
		- static ln(n)
			Defines the logarithm with base 'a' of 'n'.
		
		- static logA(a,n)
		
		- static nRoot(a,n)
			Defines the nth root of a number.
		
		- static pow(a,n)
			Solves the negative value input bug.
		
		- static productFactors(n)
			Calculates the product of factors of 'n'.
		
		- static square(n) 
			Defines the square of a number.		
		
		- static summation(n,x)
			Defines the sum of all the numbers between 1 and 'n' raised to the 'x' power.

	THANKS
	
		Richard Wright : [wisolutions2002@shaw.ca]

------------------------- */

import vegas.errors.ValueOutOfBoundsError;
import vegas.maths.Prime;

class vegas.maths.Factor {

	// ----- Constructor
	
	private function Factor() {
		//
	}

	// ----- Constant

	static public var maxRecursion:Number = 254 ;

	// ----- Static Methods

    static public function ln(n:Number):Number {
        return Math.log(n) ;
    }
	
    static public function logA(a:Number, n:Number):Number {
        return Math.log(n) / Math.log(a) ;
    }
	
	static public function summation(n:Number, x:Number):Number {
        var sum:Number = 0 ;
        var i:Number ;
		for (i=1; i<=n; i++) sum += Math.pow(i, x) ;
        return sum ;
    }
	
    static public function square(n:Number):Number {
        return n*n ;
    }

    static public function inverse(n:Number):Number {
        return 1/n ;
    }
	
	static public function pow(a:Number,n:Number):Number {
        return a==0 ? 0 : (a>0 ? Math.pow(a,n) : Math.pow(a*-1,n)*-1) ;
    }

    static public function nRoot(a:Number,n:Number):Number {
        return Factor.pow(a, 1/n) ;
    }

	static public function factorial(n:Number):Number {
		if (n > maxRecursion) throw new ValueOutOfBoundsError ;
		if (n!=0) return n * Factor.factorial(n-1) ;
		else return (1) ;
    }

	static public function gammaApprox(n:Number):Number {
        var x:Number = n-1 ;
        return Math.sqrt( (2*x+1/3) * Math.PI ) * Math.pow(x,x) * Math.exp(-x) ;
    }

	static public function factorialApprox(n:Number):Number {
        return Math.round(Factor.gammaApprox(n+1)) ;
    }
	
	static public function productFactors(n:Number):Number {
        var k:Number = 1 ;
        var i:Number ;
        for (i=3; i<=n; i+=2) if (Prime.isPrime(i)) k *= i ;
        if (n>2) k *= 2;
        return k;
    }
	
	static public function fibonacci(n:Number):Number {
        return Math.round((Math.pow((1+Math.sqrt(5))/2,n)-Math.pow((1-Math.sqrt(5))/2,n))/Math.sqrt(5));
    }
	

}