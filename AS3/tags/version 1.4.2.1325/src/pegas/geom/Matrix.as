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
    import system.Reflection;
    import system.eden;

    /**
     * Defines a <code class="prettyprint">Matrix</code> with n rows and n columns.
     */
    public class Matrix implements Geometry
    {

        /**
         * Creates a new <code class="prettyprint">Matrix</code> instance.
         * @param r the number of rows in the matrix.
         * @param c the number of columns in the matrix.
         * @param ar the optional Matrix instance to fill the current Matrix.
         */
        public function Matrix( r:uint, c:uint , ar:Array=null )
        {
            super();
            this.m = new Array(r);
            for (var i:int ; i<r ; i++)
            {
                m[i] = new Array(c) ;
            }
            this.r = r ;
            this.c = c ;
        }

        /**
         * Defined the number of columns in the Matrix.
         */
        public var c:Number ;
            
        /**
         * The matrix array
         */
        public var m:Array ;
        
        /**
         * Defined the number of rows in the Matrix.
         */
        public var r:Number ;

        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            var matrix:Matrix = new Matrix(r, c) ;
            // fill the matrix !!
            return matrix ;    
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if ( o is Matrix )
            {
                // test if all elements are equals in the 2 matrix
                return (o.r == r) && (o.c == c) ;
            }
            else
            {
                return false ;
            }     
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + Reflection.getClassPath(this) + "(" + eden.serialize(r) + "," + eden.serialize(c) + "," + eden.serialize(m) + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            return "[" + Reflection.getClassName(this) + ":{" + r + "," + c + "}]" ;
        }
        
    }
    
}

