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
     * Implements the static behaviours of the Degrees manipulations.
     */
    public final class Degrees 
    {
        /**
         * Returns the inverse cosine of a slope ratio and returns its angle in degrees.
         * @param ratio a value between -1 and 1 inclusive.
         * @return the inverse cosine of a slope ratio and returns its angle in degrees.
         */
        public static function acosD (ratio:Number) : Number 
        {
            return Math.acos(ratio) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the arcsine of the passed angle.
         * @param ratio a value between -1 and 1 inclusive.
         * @return the arcsine of the passeds angle in degrees.
         */
        public static function asinD (ratio:Number) : Number 
        {
            return Math.asin(ratio) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the arctangent of the passed angle.
         * @param n a real number
         * @return the arctangent of the passed angle, a number between -Math.PI/2 and Math.PI/2 inclusive.
         */
        public static function atanD( angle:Number ):Number 
        {
            return Math.atan( angle ) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the arctangent2 of the passed angle.
         * @param y a value representing y-axis of angle vector.
         * @param x a value representing x-axis of angle vector.
         * @return the arctangent2 of the passed angle.
         */
        public static function atan2D( y:Number , x:Number ):Number 
        {
            return Math.atan2(y, x) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the cosine of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the cosine of the passed angle, a number between -1 and 1 inclusive.
         */
        public static function cosD(angle:Number):Number 
        {
            return Math.cos( angle * Trigo.DEG2RAD ) ;
        }
        
        /**
         * Calculates the sine of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the sine of the passed angle, a number between -1 and 1 inclusive.
         */
        public static function sinD(angle:Number):Number 
        {
            return Math.sin( angle * Trigo.DEG2RAD ) ;
        }
        
        /**
         * Calculates the tangent of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the tangent of the passed angle.
         */
        public static function tanD(angle:Number):Number 
        {
            return Math.tan( angle * Trigo.DEG2RAD ) ;
        }
    }
}
