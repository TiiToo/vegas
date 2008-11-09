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
    
    import vegas.core.ILockable;    

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
     * trace(ar) ; // 4:3
     * 
     * ar.verbose = true ;
     * trace(ar) ; // [AspectRatio width:320, height:240, ratio:{4:3}]
     * 
     * ar.lock() ;
     * 
     * ar.width = 640 ;
     * trace(ar) ; // [AspectRatio width:640, height:480, ratio:{4:3}]
     * 
     * ar.height = 120 ;
     * trace(ar) ; // [AspectRatio width:160, height:120, ratio:{4:3}]
     * 
     * ar.unlock() ;
     * 
     * ar.width = 320 ;
     * trace(ar) ; // [AspectRatio width:320, height:120, ratio:{8:3}]
     * 
     * trace("------ AspectRatio(1680,1050)") ;
     * 
     * ar = new AspectRatio(1680,1050) ;
     * 
     * trace(ar) ; // 8:5
     * 
     * ar.verbose = true ;
     * 
     * trace(ar) ; // [AspectRatio width:1680, height:1050, ratio:{8:5}]
     * 
     * trace("------ AspectRatio(0,0)") ;
     * 
     * ar = new AspectRatio(0) ;
     * 
     * trace(ar) ; // 0:0
     * 
     * ar.verbose = true ;
     * 
     * trace(ar) ; // [AspectRatio width:0, height:0, ratio:{0:0}]
     * </pre>
     * @author eKameleon
     */
    public class AspectRatio extends Dimension implements IGeometry, ILockable
    {

        /**
         * Creates a new <code class="prettyprint">AspectRatio</code> instance.
         * @param width The width int value use to defines the aspect ratio value.
         * @param height The height int value use to defines the aspect ratio value. 
         * @param lock This boolean flag indicates if the aspect ratio must be keeped when the width or height values changes.
         */
        public function AspectRatio( width:int=0 , height:int=0 , lock:Boolean=false )
        {
            super( width , height ) ;
            _lock = lock ;
        }
        
        /**
         * Determinates the greatest common divisor if the current object. 
         * <p>This property cast the width and the height Number in two int objects to calculate the value.</p>
         * <p>The floating values are ignored and convert in integers.</p> 
         */
        public function get gcd():int
        {
        	return _gcd ;
        }
        
        /**
         * @private
         */
        public override function set height( n:Number ):void
        {
            _h   = int(n) ;
            if ( _lock )
            {
                _w = int(_h * _aspW / _aspH ) ;
            }
            else
            {
                _GCD() ;
            }
        }       
        
        /**
         * @private
         */
        public override function set width( n:Number ):void
        {
            _w   = int(n) ;
            if ( _lock )
            {
                _h = int(_w * _aspH / _aspW ) ;
            }
            else
            {
                _GCD() ;
            }      
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
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */        
        public function isLocked():Boolean
        {
        	return _lock ;
        }        
        
        /**
         * Locks the object.
         */        
        public function lock():void
        {
        	_lock = true ;
        }
        
        /**
         * Unlocks the object.
         */        
        public function unlock():void
        {
        	_lock = false ;
        }        
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public override function toString():String 
        {
        	var s:String = _aspW + ":" + _aspH ;  
        	if ( verbose )
        	{
                return "[" + Reflection.getClassName(this) + " width:" + width + ", height:" + height + ", ratio:{" + s + "}]" ;
        	}
        	else
        	{
        		return s ;
        	}
        }        
        
        /**
         * @private
         */
        private var _aspW:int ;
        
        /**
         * @private
         */
        private var _aspH:int ;
        
        /**
         * @private
         */
        private var _gcd:int ;
        
        /**
         * @private
         */
        private var _lock:Boolean ;
        
        /**
         * @private
         */
        private function _GCD():void
        {
            _gcd  = Mathematics.gcd( int(_w) , int(_h) ) ;
            _aspW = int(int(_w) / _gcd) ;
            _aspH = int(int(_h) / _gcd) ;
        } 
        
        
    }
}
