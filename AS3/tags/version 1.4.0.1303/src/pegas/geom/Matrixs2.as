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

package pegas.geom 
{
    
    /**
     * Static tool class to manipulate and transform <code class="prettyprint">Matrix2</code> references.
     */
    public class Matrixs2 
    {
        
        /**
         * Returns the angle value of the specified Matrix2 object.
         * @return the angle value of the specified Matrix2 object.
         */
        public function getAngle( m:Matrix2 ) :Number
        {
            return Math.atan2(m.n21, m.n11 );
        }        
        
        /**
         * Creates and returns a new identity Matrix2.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * import pegas.util.Matrix2Util ;
         * var m:Matrix2 = Matrix2Util.getIdentity() ;
         * // 1 0
         * // 0 1
         * </code>
         * @return a new identity Matrix2 object.
         */
        public static function getIdentity():Matrix2
        {
            return new Matrix2(1,0,0,1) ;
        }
    
        /**
         * Creates and returns a new Matrix2 with all this elements are 0.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * import pegas.util.Matrix2Util ;
         * var m:Matrix4 = Matrix2Util.getZero() ;
         * // 0 0
         * // 0 0
         * </code>
         * @return a new zero Matrix4 object.
         */
        public static function getZero():Matrix2
        {
            return new Matrix2(0,0,0,0) ;
        }

        /**
         * Returns <code class="prettyprint">true</code> if the Matrix2 is the identity.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * import pegas.util.Matrix2Util ;
         * 
         * var m:Matrix2 = new Matrix2() ;
         * var result:Boolean = Matrix2Util.isIdentity( m ) ;
         * trace(result) ; // true
         * 
         * var m:Matrix2 = new Matrix2(1,2,3,4) ;
         * var result:Boolean = Matrix2Util.isIdentity( m ) ;
         * trace(result) ; // false
         * </code>
         * @return <code class="prettyprint">true</code> if the Matrix2 is the identity.
         */
        public static function isIdentity( m:Matrix2 ):Boolean
        {
            var a:Array = m.toArray() ;
            for( var i:Number = 0 ; i < 2 ; i++ )
            {
                for( var j:Number = 0; j < 2 ; j++ )
                {
                    if( i == j ) 
                    {
                        if( a[i][j] != 1 )
                        {
                            return false ;
                        }
                    }
                    else 
                    {
                        if( a[i][j] != 0 ) 
                        {
                            return false ;
                        }
                    }
                }
            }
            return true ;
        }
        
        /**
         * Invert the specified Matrix2 object.
         */
        public function invert( m:Matrix2 , out:Matrix2 = null  ):Matrix2
        {
            if ( out == null )
            {
            	out = getIdentity() ;
            }
            var a:Number = m.n11; var b:Number = m.n21;
            var c:Number = m.n12; var d:Number = m.n22;
            var det:Number = a * d - b * c;
            det = 1 / det ;
            out.n11 =  det * d ; out.n21 = -det * b ;
            out.n12 = -det * c ; out.n22 =  det * a ;
            return out;
        }
        
        /**
         * Sets the specified matrix with the passed-in angle value.
         */
        public static function setByAngle( m:Matrix2, angle:Number):void
        {
            var c:Number = Math.cos(angle);
            var s:Number = Math.sin(angle);
            m.n11 = c ; m.n12 = -s ;
            m.n21 = s ; m.n22 = c  ;
        }
        
        /**
         * Sets the specified matrix with the Matrix2 reference passed in argument.
         * @param m1 the first Matrix2 reference to fill.
         * @param m2 the second Matrix2 reference.
         */
        public static function setByMatrix( m1:Matrix2, m2:Matrix2 ):Matrix2
        {
            m1.n11 = m2.n11 ; m1.n12 = m2.n12 ;
            m1.n21 = m2.n21 ; m1.n22 = m2.n22 ;
            return m1 ;
        }
        
        /**
         * Sets the specified matrix with the two passed-in Vector2 objects. 
         * The first vector is the first column of the matrix and the second the other.
         */
        public static function setByVector( m:Matrix2, v1:Vector2 , v2:Vector2):void
        {
            m.n11 = v1.x ; m.n12 = v2.x ;
            m.n21 = v1.y ; m.n22 = v2.y ;
        }
    }
}
