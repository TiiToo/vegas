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

package pegas.colors 
{
    import system.Cloneable;
    import system.Equatable;
    import system.Reflection;
    import system.Serializable;
    import system.hack;
    import system.numeric.Mathematics;

    /**
     * The RGB class encapsulates an rgb color.
     * <pre class="prettyprint">
     * import pegas.colors.RGB ;
     * 
     * trace("---- black") ;
     * 
     * var black:RGB = new RGB() ;
     * 
     * trace( "black : " + black ) ; // [RGB r:0 g:0 b:0 hex:0x000000]
     * trace( "black.toHexString('#') : " + black.toHexString("#") ) ; // #000000
     * 
     * black.difference() ;
     * trace( "black difference : " + black ) ; // [RGB r:255 g:255 b:255 hex:0xFFFFFF]
     * 
     * trace("---- red") ;
     * 
     * var red:RGB = new RGB(255, 0, 0) ;
     * trace( "red : " + red ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]
     * trace( "red.toHexString('#') : " + red.toHexString("#") ) ; // #FF0000
     * 
     * red.difference() ; 
     * trace( "red difference : " + red ) ; // [RGB r:0 g:255 b:255 hex:0x00FFFF]
     * 
     * trace("---- blue") ;
     * 
     * var blue:RGB = new RGB(92, 160, 205) ;
     * trace( "blue : " + blue ) ; // [RGB r:92 g:160 b:205 hex:0x5CA0CD]
     * trace( "blue.toHexString('#') : " + blue.toHexString("#") ) ; // #5CA0CD
     * 
     * blue.difference() ;
     * trace( "blue difference       : " + blue ) ; // [RGB r:163 g:95 b:50 hex:0xA35F32]
     * 
     * blue.fromNumber( 0x23516D ) ;
     * trace( "blue                  : " + blue ) ; // [RGB r:35 g:81 b:109 hex:0x23516D]
     * trace( "blue.r                : " + blue.r ) ; // 35
     * trace( "blue.g                : " + blue.g ) ; // 81
     * trace( "blue.b                : " + blue.b ) ; // 109
     * </pre>
     */
    public class RGB implements Cloneable, Equatable, Serializable
    {
        
        use namespace hack ;
        
        /**
         * Creates a new RGB instance.
         * @param r The red component, between 0 and 255 (default 0).
         * @param g The green component, between 0 and 255 (default 0).
         * @param b The blue component, between 0 and 255 (default 0). 
         */
        public function RGB( r:uint = 0 , g:uint = 0 , b:uint = 0 )
        {
            this.r   = r ;
            this.g = g ;
            this.b  = b ;
        }
        
        /**
         * The blue component, between 0 and 255.
         */
        public function get b():uint
        {
            return _blue ;
        }
        
        /**
         * @private
         */
        public function set b( value:uint ):void
        {
            _blue = Math.min( value, maximum ) as uint ;
        } 
        
        /**
         * The green component, between 0 and 255.
         */        
        public function get g():uint
        {
            return _green ;
        }
        
        /**
         * @private
         */
        public function set g( value:uint ):void
        {
            _green = Math.min( value, maximum ) as uint ;
        }        

        /**
         * The red component, between 0 and 255.
         */
        public function get r():uint
        {
            return _red ;
        }

        /**
         * @private
         */
        public function set r( value:uint ):void
        {
            _red = Math.min( value, maximum ) as uint ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */    
        public function clone():* 
        {
            return new RGB( _red , _green , _blue ) ;
        }
        
        /**
         * Transforms the red, green and blue components of the color in this difference color representation.
         */
        public function difference():void
        {
            _red   = maximum - _red   ;
            _green = maximum - _green ;
            _blue  = maximum - _blue  ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is RGB )
            {
                return ( (o as RGB)._red == _red ) && ( (o as RGB)._green == _green ) && ( (o as RGB)._blue == _blue ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Sets the red, green and blue components with the specified number value.
         */
        public function fromNumber( value:Number ):void 
        {
            var gb:int ;
            r  = value >> 16 ;
            gb = value ^ r << 16 ;
            g  = gb >> 8 ;
            b  = gb^g << 8 ;
        }        
        
        /**
         * Interpolate the color and returns a new RGB object.
         * @param color The RGB reference used to interpolate the current RGB object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The interpolate RGB reference of the current color.
         */
        public function interpolate( color:RGB , level:Number = 1 ):RGB
        {
            var p:Number = Mathematics.clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            return new RGB
            (
                _red   * q + color._red   * p ,
                _green * q + color._green * p ,
                _blue  * q + color._blue  * p  
            ) ;
        }
        
        /**
         * Sets all tree components of a color. 
         */
        public function set( ...args:Array ):void
        {
            r = uint(args[0]) ;
            g = uint(args[1]) ;
            b = uint(args[2]) ;
        }
        
        /**
         * Returns the full String representation of the color.
         * @return the full String representation of the color.
         */
        public function toHexString( prefix:String = "0x" ):String
        {
            return prefix + toHex( _red ) + toHex( _green ) + toHex( _blue );
        }
        
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public function toObject():Object 
        {
            return { r:_red , g:_green , b:_blue } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return "new " + Reflection.getClassPath(this) + "(" + _red.toString() + "," + _green.toString() + "," + _blue.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString():String
        {
            return "[RGB r:" + _red + " g:" + _green + " b:" + _blue + " hex:" + toHexString() + "]";
        }
        
        /**
         * Returns the real value of the object.
         * @return the real value of the object.
         */
        public function valueOf():uint
        {
            return (_red << 16) | (_green << 8) | _blue;
        }
        
        /**
         * Basic method use to convert the specified uint value in a hexadecimal String representation.
         * @return The String representation of the specified color.
         */
        protected function toHex( value:uint ):String
        {
            var hex:String = value.toString( 16 ) ;
            return (( hex.length % 2 ) == 0 ? hex : "0" + hex).toUpperCase() ;
        }
        
        /**
         * @private
         */
        hack var _blue:uint ;
        
        /**
         * @private
         */        
        hack var _green:uint ;
        
        /**
         * @private
         */
        hack var _red:uint ;
        
        /**
         * The maximum value specified with a color component.
         */
        hack const maximum:uint = 0xFF ;
    }
}
