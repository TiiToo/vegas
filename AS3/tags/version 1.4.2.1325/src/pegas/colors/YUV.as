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
     * The YUV defines a color space in terms of one luma (Y') and two chrominance (UV) components. 
     * The YUV color model is used in the NTSC, PAL, and SECAM composite color video standards.
     */
    public class YUV implements Cloneable, Equatable, Serializable
    {
        use namespace hack ;
        
        /**
         * Creates a new YUV instance.
         * @param y The y component.
         * @param u The u component.
         * @param v The v component. 
         */
        public function YUV( y:Number = 0 , u:Number = 0 , v:Number = 0 )
        {
            this.y = y ;
            this.u = u ;
            this.v = v ;
        }
        
        /**
         * The y component.
         */
        public function get y():Number
        {
            return _y ;
        }
        
        /**
         * @private
         */
        public function set y( value:Number ):void
        {
            _y = isNaN(value) ? 0 : value ;
        } 
        
        /**
         * The u component.
         */        
        public function get u():Number
        {
            return _u ;
        }
        
        /**
         * @private
         */
        public function set u( value:Number ):void
        {
            _u = isNaN(value) ? 0 : value ;
        }
        
        /**
         * The v component.
         */
        public function get v():Number
        {
            return _v ;
        }
        
        /**
         * @private
         */
        public function set v( value:Number ):void
        {
            _v = isNaN(value) ? 0 : value ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */    
        public function clone():* 
        {
            return new YUV( _y , _u , _v ) ;
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
            else if ( o is YUV )
            {
                return ( (o as YUV)._y == _y ) && ( (o as YUV)._u == _u ) && ( (o as YUV)._v == _v ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Interpolate the color and returns a new XYZ object.
         * @param color The YUV reference used to interpolate the current YUV object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The interpolate YUV result of the specified color.
         */
        public function interpolate( color:YUV , level:Number = 1 ):YUV
        {
            var p:Number = Mathematics.clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            return new YUV
            (
                _y * q + color._y * p ,
                _u * q + color._u * p ,
                _v * q + color._v * p  
            ) ;
        }
        
        /**
         * Sets all tree components of a color. 
         */
        public function set( ...args:Array ):void
        {
            y = Number(args[0]) ;
            u = Number(args[1]) ;
            v = Number(args[2]) ;
        }
        
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public function toObject():Object 
        {
            return { y:_y , u:_u , v:_v } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return "new " + Reflection.getClassPath(this) + "(" + _y.toString() + "," + _u.toString() + "," + _v.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString():String
        {
            return "[YUV y:" + _y + " u:" + _u + " v:" + _v + "]";
        }
        
        /**
         * @private
         */
        hack var _u:Number ;
        
        /**
         * @private
         */
        hack var _v:Number ;
        
        /**
         * @private
         */
        hack var _y:Number ;
    }
}
