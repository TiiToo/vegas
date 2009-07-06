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
    import pegas.geom.Geometry;
    import pegas.geom.Matrixs2;
    
    import system.Reflection;
    import system.numeric.Mathematics;    

    /**
     * Matrix with 4 rows and 4 columns.
     * @example
     * <pre class="prettyprint">
     * import pegas.geom.Matrix2 ;
     * var m:Matrix2 = new Matrix2() ;
     * // 1 0
     * // 0 1
     * </pre>
     */
    public class Matrix2 implements Geometry 
    {
        
        /**
         * Creates a new <code class="prettyprint">Matrix2</code> instance.
         */
        public function Matrix2( ...arguments:Array )
        {
            if (arguments.length == 4)
            {
                n11 = arguments[0]  ; n12 = arguments[1]  ; 
                n21 = arguments[2]  ; n22 = arguments[3]  ; 
            }
            else if ( arguments.length == 2 && arguments[0] is Vector2 && arguments[1] is Vector2 )
            {
                Matrixs2.setByVector( this , arguments[0] as Vector2 , arguments[1] as Vector2 ) ;
            }
            else if ( arguments[0] is Matrix2 )
            {
                Matrixs2.setByMatrix(this, arguments[0] as Matrix2) ;    
            }
            else if ( arguments[0] is Number )
            {
            	Matrixs2.setByAngle(this, arguments[0] as Number) ;
            }
            else
            {
                identity() ;
            }
        }
        
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 1 0
         * 0 0
         * </pre>
         */
        public var n11:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 0 1
         * 0 0
         * </pre>
         */
        public var n12:Number;
        

        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 0 0
         * 1 0
         * </pre>
         */
        public var n21:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 0 0
         * 0 1
         * </pre>
         */
        public var n22:Number;

        /**
         * Returns a shallow copy of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * trace( m + " clone() : " + m.clone() ) ;
         * </pre>
         * @return a shallow copy of this instance.
         */    
        public function clone():*
        {
            return new Matrix2( this ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if (o is Matrix2)
            {
            	var m:Matrix2 = o as Matrix2 ;
                return m.n11 == n11 && m.n12 == n12 && m.n21 == n21 && m.n22 == n22 ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the matrix[x][y] value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * trace( m + " getEntry(1,0) : " + m.getEntry(1,0) ) ; // [Matrix2:[1,2],[3,4]] getEntry(1,0) : 3
         * </pre>
         * @return the matrix[x][y] value.
         */
        public function getEntry( x:Number, y:Number ):*
        {
            var m:Array = toArray() ;
            return m[x][y] ;
        }
        
        /**
         * Transforms the matrix in this identity representation.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * m.identity() ;
         * trace( m + " identity : " + m ) ;
         * </pre>
         */
        public function identity():void
        {
            n11 = 1 ; n12 = 0 ; 
            n21 = 0 ; n22 = 1 ; 
        }
        
        /**
         * Sets matrix[x][y] with the specified value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * m.setEntry( 1 , 0 , 5 ) ; // [Matrix2:[1,2],[5,4]]
         * trace( m ) ;
         * </pre>
         */
        public function setEntry( x:Number , y:Number , value:* ):void
        {
            x = Mathematics.clamp(x, 0, 1) ;
            y = Mathematics.clamp(y, 0, 1) ;
            if ( x == 0 )
            {
                if ( y == 0 )
                {
                    n11 = value ;
                }
                else if ( y == 1 )
                {
                    n21 = value ;
                }
            }
            else if ( x == 1 ) 
            {
                if ( y == 0 )
                {
                    n21 = value ;
                }
                else if ( y == 1 )
                {
                    n22 = value ;
                }
            }
        }
        
        /**
         * Returns the Array representation of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * var a:Array = m.toArray() ;
         * trace( m + " toArray() : [" + a.join(",") + "]" ) ;
         * </pre>
         * @return the Array representation of this instance.
         */
        public function toArray():Array
        {
            var m:Array = 
            [
                [n11, n12] ,
                [n21, n22] 
            ] ;
            return m ;
        }
        
        /**
         * Returns the Object representation of this object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * import system.eden ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * var o:Object = m.toObject() ;
         * trace( m + " toObject() : " + eden.serialize(o) ) ;
         * </pre>
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            var o:Object = {} ;
            o.n11 = this.n11 ; o.n12 = this.n12 ;
            o.n21 = this.n21 ; o.n22 = this.n22 ;
            return o ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import pegas.geom.Matrix2 ;
         * import system.eden ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * trace( m + " toSource() : " + m.toSource() ) ; // new pegas.geom.Matrix2(1,2,3,4)
         * </pre>
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" + n11 + "," + n12 + "," + n21 + "," + n22 + ")"  ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            var s:String = "[" + Reflection.getClassName(this) + ":" ;
            s += "[" + n11 + "," + n12 + "]" ;
            s += "," ;
            s += "[" + n21 + "," + n22 + "]" ;
            s += "]" ;
            return s ;
        }
    
    }

}

