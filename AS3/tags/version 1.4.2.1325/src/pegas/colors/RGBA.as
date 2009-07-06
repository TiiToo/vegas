﻿/*

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
    import system.Reflection;
    import system.hack;
    import system.numeric.Mathematics;

    /**
     * The RGBA class encapsulates an rgba color.
     * <pre class="prettyprint">
     * import pegas.colors.RGBA ;
     * 
     * trace("---- black") ;
     * 
     * var black:RGBA = new RGBA() ;
     * 
     * trace( "black                  : " + black ) ; // [RGBA r:0 g:0 b:0 a:1 hex:0xFF000000]
     * trace( "black.toHexString('#') : " + black.toHexString("#") ) ; // #FF000000
     * trace( "black.a                : " + black.a ) ; // 1
     * trace( "black.r                : " + black.r ) ; // 0
     * trace( "black.g                : " + black.g ) ; // 0
     * trace( "black.b                : " + black.b ) ; // 0
     * trace( "black.percent          : " + black.percent ) ; // 100
     * trace( "black.offset           : " + black.offset  ) ; // 255
     * 
     * trace("---- red") ;
     * 
     * var red:RGBA = new RGBA(255 , 0 , 0 , 0.5 ) ;
     * 
     * trace( "red         : " + red ) ; // [RGBA r:255 g:0 b:0 a:0.5 hex:0x7FFF0000]
     * trace( "red.a       : " + red.a   ) ; // 0.5
     * trace( "red.r       : " + red.r     ) ; // 255
     * trace( "red.g       : " + red.g   ) ; // 0
     * trace( "red.b       : " + red.b    ) ; // 0
     * trace( "red.percent : " + red.percent ) ; // 50
     * trace( "red.offset  : " + red.offset  ) ; // 127.5
     * 
     * trace("---- blue") ;
     * 
     * var blue:RGBA = new RGBA(92, 160, 205, 0.4) ;
     * 
     * trace( "blue         : " + blue ) ; // [RGBA r:92 g:160 b:205 a:0.4 hex:0x665CA0CD]
     * trace( "blue.a       : " + blue.a ) ; // 0.4
     * trace( "blue.r       : " + blue.r ) ; // 92
     * trace( "blue.g       : " + blue.g ) ; // 160
     * trace( "blue.b       : " + blue.b ) ; // 205
     * trace( "blue.percent : " + blue.percent ) ; // 40
     * trace( "blue.offset  : " + blue.offset  ) ; // 102
     * 
     * blue.offset = 255 ;
     * trace( "blue : " + blue ) ; // [RGBA r:92 g:160 b:205 a:1 hex:0xFF5CA0CD]
     * 
     * blue.percent = 50 ;
     * trace( "blue : " + blue ) ; // [RGBA r:92 g:160 b:205 a:0.5 hex:0x7F5CA0CD]
     * 
     * blue.fromNumber( 0x23516D ) ;
     * trace( "blue : " + blue ) ; // [RGBA r:35 g:81 b:109 a:0 hex:0x0023516D]
     * </pre>
     */
    public class RGBA extends RGB 
    {
        
        use namespace hack ;
        
        /**
         * Creates a new RGBA instance.
         * @param r The red component, an interger value between 0 and 255 (default 0).
         * @param g The green component, an interger value between 0 and 255 (default 0).
         * @param b The blue component, an interger value between 0 and 255 (default 0).
         * @param a The alpha component, an interger value between 0 and 1 (default 1).
         */
        public function RGBA( r:uint = 0 , g:uint = 0 , b:uint = 0 , a:Number = 1 )
        {
            super( r , g , b ) ;
            this.a = a ;
        }
        
        /**
         * The alpha component (between 0 and 1)
         */
        public function get a():Number
        {
            return _alpha ;
        }
        
        /**
         * @private
         */
        public function set a( value:Number ):void
        {
            _alpha = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 1 ) ;
        }
        
        /**
         * Defines the alpha component value with an offset representation (between 0 and 255)
         */
        public function get offset():Number
        {
            return _alpha * maximum ;
        }
        
        /**
         * @private
         */
        public function set offset( value:Number ):void
        {
            _alpha = Mathematics.clamp( isNaN(value) ? 0 : value , 0, maximum ) / maximum ;
        }          
        
        /**
         * Defines the alpha component value with a percent representation (between 0 and 100)
         */
        public function get percent():Number
        {
            return _alpha * 100 ;
        }
        
        /**
         * @private
         */
        public function set percent( value:Number ):void
        {
            a = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 100 ) / 100 ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */    
        public override function clone():* 
        {
            return new RGBA( _red , _green , _blue , _alpha ) ;
        }
        
        /**
         * Transforms the red, green and blue components of the color in this difference color representation.
         */
        public override function difference():void
        {
            super.difference() ;
            _alpha = 1 - _alpha ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public override function equals( o:* ):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is RGBA )
            {
                return ( (o as RGBA)._red == _red ) && ( (o as RGBA)._green == _green ) && ( (o as RGBA)._blue == _blue && ( (o as RGBA)._alpha == _alpha ) ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Sets the red, green and blue component with the specified number value.
         */
        public override function fromNumber( value:Number ):void 
        {
            offset = value >> 24 & 0xFF ;
            r      = value >> 16 & 0xFF ;
            g      = value >> 8  & 0xFF ;
            b      = value       & 0xFF ;
        }
        
        /**
         * Interpolate the color and returns a new RGB object.
         * @param color The RGB reference used to interpolate the current RGB object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The interpolate RGB reference of the current color.
         */
        public override function interpolate( color:RGB , level:Number = 1 ):RGB
        {
            var rbga:RGBA = color as RGBA ;
            var p:Number = Mathematics.clamp( isNaN(level) ? 1 : level , 0, 1) ;
            var q:Number = 1 - p ;
            return new RGBA
            (
                q * _red   + p * rbga._red   ,
                q * _green + p * rbga._green ,
                q * _blue  + p * rbga._blue  ,
                q * _alpha + p * rbga._alpha   
            ) ;
        }
        
        /**
         * Sets all foor components of a color. 
         */
        public override function set( ...args:Array ):void
        {
            super.set( args[0] , args[1], args[2] ) ;
            a = isNaN(args[3]) ? 1 : args[3] ;
        }
           
        /**
         * Returns the full hexadecimal String representation of the color.
         * @param prefix The optional expression to defines the prefix of the final String result (default "0x").
         * @return the full hexadecimal String representation of the color.
         */
        public override function toHexString( prefix:String = "0x" ):String
        {
            return prefix + toHex( _alpha * maximum ) + toHex( _red ) + toHex( _green ) + toHex( _blue );
        }
                
        /**
         * Returns the Object representation of the instance.
         * @return the Object representation of the instance.
         */
        public override function toObject():Object 
        {
            return { r:_red , g:_green , b:_blue , a:_alpha } ;  
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public override function toSource( indent:int = 0 ):String
        {
            return "new " + Reflection.getClassPath(this) + "(" + _red.toString() + "," + _green.toString() + "," + _blue.toString() + "," + _alpha.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public override function toString():String
        {
            return "[RGBA r:" + _red + " g:" + _green + " b:" + _blue + " a:" + _alpha + " hex:" + toHexString() + "]";
        }         
        
        /**
         * Returns the real value of the object.
         * @return the real value of the object.
         */
        public override function valueOf():uint
        {
            return ( _alpha * maximum << 24 ) | ( _red << 16 ) | ( _green << 8 ) | _blue ;
        }
        
        /**
         * @private
         */        
        hack var _alpha:Number ;
        
    }
}
