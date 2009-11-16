/*

The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at 
  
http://www.mozilla.org/MPL/ 
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the License. 
  
The Original Code is PEGAS Framework.
  
The Initial Developer of the Original Code is
ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
Portions created by the Initial Developer are Copyright (C) 2004-2009
the Initial Developer. All Rights Reserved.
  
Contributor(s) :
  
*/

package pegas.numeric 
{
    /**
     * Implements the static behaviours of the hyperbolic Functions.
     */
    public final class Hyperbolic 
    {
        /**
         * Anti-hyperbolic cosine.
         * <pre>
         * acoshm = ln(x-√(x^2-1))
         * </pre>
         */
        public static function acoshm(x:Number):Number 
        {
            return Math.log(x - Math.sqrt(x * x - 1));
        }
        
        /**
         * Anti-hyperbolic cosine.
         * <pre>
         * acoshp = ln(x+√(x^2-1))
         * </pre>
         */
        public static function acoshp(x:Number):Number 
        {
            return Math.log(x + Math.sqrt(x * x - 1));
        }
        
        /**
         * Anti-hyperbolic sine.
         */
        public static function asinh(x:Number):Number 
        {
            return Math.log(x + Math.sqrt(x * x + 1));
        }
        
        /**
         * Anti-hyperbolic tangent.
         */
        public static function atanh(x:Number):Number 
        {
            return Math.log((1 + x) / (1 - x)) / 2 ;
        }
        
        /**
         * Hyperbolic cosine.
         */
        public static function cosh(x:Number):Number 
        {
            return ( Math.exp(x) + Math.exp(-x) ) / 2;
        }
        
        /**
         * Hyperbolic sine.
         */
        public static function sinh( x:Number ):Number 
        {
            return (Math.exp(x) - Math.exp(-x)) / 2;
        }
        
        /**
         * Hyperbolic tangent.
         */
        public static function tanh(x:Number):Number 
        {
            return sinh(x) / cosh(x) ;
        }
    }
}
