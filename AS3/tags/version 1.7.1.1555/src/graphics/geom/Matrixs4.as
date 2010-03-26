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
     * Static tool class to manipulate and transform <code class="prettyprint">Matrix4</code> references.
     */
    public class Matrixs4 
    {
        
        /**
         * Creates and returns a new identity Matrix4.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Matrix4 ;
         * import graphics.util.Matrix4Util ;
         * var m:Matrix4 = Matrix4Util.getIdentity() ;
         * // 1 0 0 0
         * // 0 1 0 0
         * // 0 0 1 0
         * // 0 0 0 1
         * </code>
         * @return a new identity Matrix4 object.
         */
        public static function getIdentity():Matrix4
        {
            return new Matrix4() ;
        }
    
        /**
         * Creates and returns a new Matrix4 with all this elements are 0.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Matrix4 ;
         * import graphics.util.Matrix4Util ;
         * var m:Matrix4 = Matrix4Util.getZero() ;
         * // 0 0 0 0
         * // 0 0 0 0
         * // 0 0 0 0
         * // 0 0 0 0
         * </code>
         * @return a new zero Matrix4 object.
         */
        public static function getZero():Matrix4
        {
            return new Matrix4(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) ;
        }

        /**
         * Returns <code class="prettyprint">true</code> if the Matrix4 is the identity.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Matrix4 ;
         * import graphics.util.Matrix4Util ;
         * 
         * var m:Matrix4 = new Matrix4() ;
         * var result:Boolean = Matrix4Util.isIdentity( m ) ;
         * trace(result) ; // true
         * 
         * var m:Matrix4 = new Matrix4(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16) ;
         * var result:Boolean = Matrix4Util.isIdentity( m ) ;
         * trace(result) ; // false
         * </code>
         * @return <code class="prettyprint">true</code> if the Matrix4 is the identity.
         */
        public static function isIdentity( m:Matrix4 ):Boolean
        {
            var a:Array = m.toArray() ;
            for( var i:Number = 0 ; i < 4 ; i++ )
            {
                for( var j:Number = 0; j < 4 ; j++ )
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
         * Sets the specified matrix with the Matrix4 reference passed in argument.
         * @param m1 the first Matrix4 reference to fill.
         * @param m2 the second Matrix4 reference.
         */
        public static function setByMatrix( m1:Matrix4, m2:Matrix4 ):Matrix4
        {
            m1.n11 = m2.n11 ; m1.n12 = m2.n12 ; m1.n13 = m2.n13 ; m1.n14 = m2.n14 ;
            m1.n21 = m2.n21 ; m1.n22 = m2.n22 ; m1.n23 = m2.n23 ; m1.n24 = m2.n24 ;
            m1.n31 = m2.n31 ; m1.n32 = m2.n32 ; m1.n33 = m2.n33 ; m1.n34 = m2.n34 ;
            m1.n41 = m2.n41 ; m1.n42 = m2.n42 ; m1.n43 = m2.n43 ; m1.n44 = m2.n44 ;
            return m1 ;
        }
        
        /**
         * Sets the specified matrix with the Quaternion reference passed in argument.
         * @param q the Quaternion reference.
         * @param m the Matrix4 reference to fill. 
         */
        public static function setByQuaternion( q:Quaternion , m:Matrix4 = null ):Matrix4
        {
            if ( m == null )
            {
               m = new Matrix4() ;
            }
            
            var xx:Number = q.x * q.x ;
            var xy:Number = q.x * q.y ;
            var xz:Number = q.x * q.z ;
            var xw:Number = q.x * q.w ;
            var yy:Number = q.y * q.y ;
            var yz:Number = q.y * q.z ;
            var yw:Number = q.y * q.w ;
            var zz:Number = q.z * q.z ;
            var zw:Number = q.z * q.w ;
            
            m.n11 = 1 - 2 * ( yy + zz ) ;
            m.n12 = 2 * ( xy - zw ) ;
            m.n13 = 2 * ( xz + yw ) ; 
            
            m.n21 = 2 * ( xy + zw ) ;
            m.n22 = 1 - 2 * ( xx + zz ) ; 
            m.n23 = 2 * ( yz - xw ) ; 
            
            m.n31 = 2 * ( xz - yw ) ; 
            m.n32 = 2 * ( yz + xw ) ; 
            m.n33 = 1 - 2 * ( xx + yy ) ;
            
            m.n41 = m.n42 = m.n43 = 0 ;
            m.n14 = m.n24 = m.n34 = 0 ;
            
            m.n44 = 1 ;
            
            return m ;
        }
    }
}
