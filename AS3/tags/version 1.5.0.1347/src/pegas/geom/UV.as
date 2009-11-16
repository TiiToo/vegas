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
    
    /**
     * Coordinates system for bitmaps and textures. It represents the position of a vertex in the Bitmap.
     */
    public class UV implements Geometry
    {
        /**
         * Creates a new UV instance.
         * @param u The horizontal coordinate value. The default value is zero.
         * @param v The vertical coordinate value. The default value is zero.
         */
        public function UV( u:Number = 0 , v:Number = 0  )
        {
            this.u = isNaN(u) ? 0 : u ;
            this.v = isNaN(v) ? 0 : v ;
        }
        
        /**
         * Defines the UVCoordinate object with the u and v properties set to zero.
         */
        public static var ZERO:UV = new UV(0,0) ;
        
        /**
         * Defines the horizontal coordinate value of the texture.
         */
        public var u:Number ;
            
        /**
         * Defines the vertical coordinate value of the texture.
         */
        public var v:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new UV(u,v) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if ( o is UV)
            {
                return ( o.u == u ) && ( o.v == v ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { u:u , v:v } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" +  u.toString()  + "," + v.toString() + ")" ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return "[UV u:" + u + " v:" + v + "]" ;
        }
    }
}
