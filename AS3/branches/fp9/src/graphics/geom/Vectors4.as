﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package graphics.geom 
{
    /**
     * Static tool class to manipulate and transform <code class="prettyprint">Vector4</code> references.
     */
    public class Vectors4 
    {
        
        /**
         * Computes the addition of two Vector4 and returns the first vector.
         * @param v1 the first Vector4.
         * @param v2 the second Vector4.
         * @return the addition result of two Vector4.
         */
        public static function addition( v1:Vector4, v2:Vector4 ):Vector4
        {
             v1.x += v2.x ;
             v1.y += v2.y ;
             v1.z += v2.z ;
             v1.w += v2.w ;
             return v1 ;    
        }
        
        /**
         * Returns the cross product of two Vector4.
         * The returned Vector4 is orthogonal to the other two Vector4 and when ignoring the fourth 
         * component the resulting Vector3 is also orthogonal.
         */
        public static function cross(v1:Vector4, v2:Vector4):Vector4
        {
            v1.x = (v2.y * v1.z) - (v2.z * v1.y) ;
            v1.y = (v2.z * v1.x) - (v2.x * v1.z) ;
            v1.z = (v2.x * v1.y) - (v2.y * v1.x) ;
            v1.w = 0 ;
            return v1 ;
        }
        
        /**
         * Computes the addition of two Vector4.
         * @param v1 a Vector4 to concat.
         * @param v2 a Vector4 to concat.
         * @return the addition result of two Vector4.
         */
        public static function getAddition( v1:Vector4, v2:Vector4 ):Vector4
        {
            return new Vector4( (v1.x + v2.x) , (v1.y + v2.y) , (v1.z + v2.z) , (v1.w + v2.w)) ;    
        }
    
        /**
         * Returns the angle in radian between the two 3D vectors. The formula used here is very simple.
         * It comes from the definition of the dot product between two vectors.
         * @param v1    Vector4 The first Vector4.
         * @param v2    Vector4 The second Vector4.
         * @return the angle in radian between the two vectors.
         */
        public static function getAngle( v1:Vector4, v2:Vector4 ):Number
        {
            var ncos:Number = ( Vectors4.getDot( v1, v2 ) ) / ( getNorm(v1) * getNorm(v2) );
            var sin2:Number = 1 - (ncos * ncos) ;
            if (sin2<0)
            {
                //trace(" wrong "+ ncos ) ;
                sin2 = 0 ;
            }
            // I took long time to find this bug. Who can guess that (1-cos*cos) is negative ? !
            // sqrt returns a NaN for a negative value !
            return  Math.atan2( Math.sqrt(sin2), ncos );
        }
        
        /**
         * Computes the cross product of the two Vector4s.
         * @param v1 a <code class="prettyprint">Vector4</code>.
         * @param v2 a <code class="prettyprint">Vector4</code>.
         * @return the <code class="prettyprint">Vector4</code> resulting of the cross product.
         */
        public static function getCross( v1:Vector4, v2:Vector4 ):Vector4
        {
            return new Vector4
            (     
                (v2.y * v1.z) - (v2.z * v1.y) ,
                (v2.z * v1.x) - (v2.x * v1.z) ,
                (v2.x * v1.y) - (v2.y * v1.x) ,
                0
            );
        }
    
        /**
         * Computes the dot product of the two Vector4s.
         * @param v1 a <code class="prettyprint">Vector4</code>.
         * @param v2 a <code class="prettyprint">Vector4</code>.
         * @return the dot product of the 2 Vector4.
         */
        public static function getDot( v1:Vector4, v2:Vector4 ):Number
        {
            return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z) + (v1.w * v2.w) ;    
        }
            
        /**
         * Returns the length of the vector.
         * @param v the vector.
         * @return the length of the vector.
         */
        public static function getLength( v:Vector4 ):Number
        {
            return Math.sqrt( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) + (v.w * v.w) ) ;
        }
        
        /**
         * Computes the oposite Vector4 of the <code class="prettyprint">Vector4</code>.
         * @param v the Vector4 reference to negate.
         * @return a new negate <code class="prettyprint">Vector4</code> reference.
         */
        public static function getNegate( v:Vector4 ):Vector4
        {
            return new Vector4( - v.x, - v.y, - v.z , - v.w );
        }    
        
        /**
         * Computes the norm of the <code class="prettyprint">Vector4</code>.
         * @param v a Vector4 reference.
         * @return the norm of the specified <code class="prettyprint">Vector4</code>.
         */
        public static function getNorm( v:Vector4 ):Number
        {
            return Math.sqrt( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) + (v.w * v.w) );
        }
        
        /**
         * Computes the power of the specified Vector4.
         * @param v the Vector4 reference.
         * @param value the value of the pow..
         * @return A new Vector4 powered by the method.
         */
        public static function getPow( v:Vector4, value:Number ):Vector4
        {
            return new Vector4( Math.pow( v.x, value ) , Math.pow( v.y, value ) ,  Math.pow( v.z, value ) , Math.pow( v.w, value ) ) ;
        }
            
        /**
         * Scales the specified Vector4 with the input value.
         * @param vector the Vector4 reference to transform.
         * @param value a real number to scale the current Vector4.
         * @return A new Vector4 scaled by the value passed in second argument in this method.
         */
        public static function getScale( v:Vector4, value:Number ):Vector4
        {
            return new Vector4 ( v.x * value , v.y * value , v.z * value , v.w * value ) ;
        }
        
        /**
         * Returns the squared length of this vector.
         * @param v the vector.
         * @return the squared length of this vector.
         */
        public static function getSquaredLength( v:Vector4 ):Number
        {
            return (v.x * v.x) + (v.y * v.y) + (v.z * v.z) + + (v.w * v.w) ;
        }
        
        /**
         * Computes the substraction of two Vector4.
         * @param v1 a Vector4 to substract.
         * @param v2 a Vector4 to substract.
         * @return the substraction result of two Vector4.
         */
        public static function getSubstraction( v1:Vector4 , v2:Vector4 ):Vector4
        {
            return new Vector4( (v1.x - v2.x) , (v1.y - v2.y) , (v1.z - v2.z) , (v1.w - v2.w) ) ;
        }
        
        /**
         * Normalize the specified <code class="prettyprint">Vector4</code> in parameter.
         * @param v a Vector4 reference.
         * @return <code class="prettyprint">true</code> of the normalize method is success else false for mistake.
         */    
        public static function normalize( v:Vector4 ):Boolean
        {
            var norm:Number = getNorm( v );
            if( norm == 0 || norm == 1) 
            {
                return false ;
            }
            v.x /= norm ;
            v.y /= norm ;
            v.z /= norm ;
            v.w /= norm ;
            return true ;
        }
        
        /**
         * Sets the specified <code class="prettyprint">Vector4</code> object with the second <code class="prettyprint">Vector4</code> object passed in argument.
         * @param v1 the first <code class="prettyprint">Vector4</code>.
         * @param v2 the second <code class="prettyprint">Vector4</code>.
         * @return the first <code class="prettyprint">Vector4</code> transformed.
          */
        public static function setByVector4( v1:Vector4, v2:Vector4):Vector4
        {
            v1.x = v2.x ;
            v1.y = v2.y ;
            v1.z = v2.z ;
            v1.w = v2.w ;
            return v1 ;
        }
        
        /**
         * Scales the specified Vector4 with the input value.
         * @param vector the Vector4 reference to transform.
         * @param value a real number to scale the current Vector4.
         */
        public static function scale( v:Vector4, value:Number ):void
        {
            v.x *= value ;
            v.y *= value ;
            v.z *= value ;
            v.w *= value ;
        }
    }
}
