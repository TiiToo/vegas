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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.geom 
{
    import system.Reflection;
    import system.numeric.Mathematics;        

    /**
     * The <code class="prettyprint">AspectRatio</code> class encapsulates the width and height of an object and indicates this aspect ratio.
     * <p>The aspect ratio of an image is the ratio of its width to its height. For example, a standard NTSC television set uses an aspect ratio of 4:3, and an HDTV set uses an aspect ratio of 16:9. A computer monitor with a resolution of 640 by 480 pixels also has an aspect ratio of 4:3. A square has an aspect ratio of 1:1.</p>
     * <p><b>Note :</b></p>This class use integers to specified the aspect ratio.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.geom.AspectRatio ;
     * 
     * var ar:AspectRatio ;
     * 
     * trace("------ AspectRatio(320,240)") ;
     * 
     * ar = new AspectRatio(320,240) ;
     * 
     * trace(ar) ; // [4:3]
     * 
     * ar.verbose = true ;
     * 
     * trace(ar) ; // [AspectRatio width:320, height:240, ratio:{4:3}]
     * 
     * trace("------ AspectRatio(1680,1050)") ;
     * 
     * ar = new AspectRatio(1680,1050) ;
     * 
     * trace(ar) ; // [8:5]
     * 
     * ar.verbose = true ;
     * 
     * trace(ar) ; // [AspectRatio width:1680, height:1050, ratio:{8:5}]
     * </pre>
     * @author eKameleon
     */
    public class AspectRatio extends Dimension implements IGeometry
    {

        /**
         * Creates a new <code class="prettyprint">AspectRatio</code> instance.
         * @param w The width int value use to defines the aspect ratio value.
         * @param h The height int value use to defines the aspect ratio value. 
         */
        public function AspectRatio( width:int=0 , height:int=0 )
        {
            super( width , height ) ;
        }
        
        /**
         * Determinates the greatest common divisor if the current object. 
         * <p>This property cast the width and the height Number in two int objects to calculate the value.</p>
         * <p>The floating values are ignored and convert in integers.</p> 
         */
        public function get gcd():int
        {
        	return Mathematics.gcd( int(width) , int(height) ) ;
        }
        
        /**
         * Indicates the verbose mode used in the toString() method.
         */
        public var verbose:Boolean ;
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */ 
        public override function clone():*
        {
        	return new AspectRatio( int(width) , int(height) ) ;
        }
    
        /**
         * Creates and returns a deep copy of the object.
         * @return A new object that is a deep copy of this instance.
         */ 
        public override function copy():*
        {
            return new AspectRatio( int(width) , int(height) ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * <p>Compares the GCD of the aspect ratio and the passed-in object.</p>
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */        
        public override function equals(o:*):Boolean
        {
        	return (o is AspectRatio) && ((o as AspectRatio).gcd == gcd) ;
        }
                
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public override function toString():String 
        {
        	var d:int = gcd ;
        	var s:String = (int(width) / d) + ":" + (int(height) / d ) ;  
        	if ( verbose )
        	{
                return "[" + Reflection.getClassName(this) + " width:" + width + ", height:" + height + ", ratio:{" + s + "}]" ;
        	}
        	else
        	{
        		return s ;
        	}
        }        
        
    }
}
