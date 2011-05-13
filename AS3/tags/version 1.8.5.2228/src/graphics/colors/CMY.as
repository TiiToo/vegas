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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package graphics.colors 
{
    import core.maths.clamp;

    import system.hack;

    /**
     * CMY is the complement of RGB, it’s a subtractive systems with 3 components: Cyan, Magenta and Yellow.
     * <p>The conversion from RGB is a simple subtraction, since they complement each other. 
     * When painting on a paper you are subtracting colors, meaning they will be reflected.</p>
     */
    public class CMY implements ColorSpace
    {
        use namespace hack ;
        
        /**
         * Creates a new CMY instance.
         * @param c The cyan component, value between 0 and 1 (default 0).
         * @param m The magenta component, value between 0 and 1 (default 0).
         * @param y The yellow component, value between 0 and 1 (default 0). 
         */
        public function CMY( c:Number = 0 , m:Number = 0 , y:Number = 0 )
        {
            this.c = c ;
            this.m = m ;
            this.y = y ;
        }
        
        /**
         * The cyan component (between 0 and 1)
         */
        public function get c():Number
        {
            return _c ;
        }
        
        /**
         * @private
         */
        public function set c( value:Number ):void
        {
            _c = clamp( isNaN(value) ? 0 : value , 0, 1 ) ;
        } 
        
        /**
         * The magenta component (between 0 and 1)
         */        
        public function get m():Number
        {
            return _m ;
        }
        
        /**
         * @private
         */
        public function set m( value:Number ):void
        {
            _m = clamp( isNaN(value) ? 0 : value , 0, 1 ) ;
        }
        
        /**
         * The yellow component (between 0 and 1)
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
            _y = clamp( isNaN(value) ? 0 : value , 0, 1 ) ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */    
        public function clone():* 
        {
            return new CMY( _c , _m , _y ) ;
        }
        
        /**
         * Transforms the cyan, magenta and yellow components of the color in this difference color representation.
         */
        public function difference():void
        {
            _c = 1 - _c ;
            _m = 1 - _m ;
            _y = 1 - _y ;
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
            else if ( o is CMY )
            {
                return ( (o as CMY)._c == _c ) && ( (o as CMY)._m == _m ) && ( (o as CMY)._y == _y ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Interpolate the color and returns a new CMY object.
         * @param color The CMY reference used to interpolate the current CMY object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The new interpolate CMY reference.
         */
        public function interpolate( color:CMY , level:Number = 1 ):CMY
        {
            var p:Number = clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            return new CMY
            (
                _c * q + color._c * p ,
                _m * q + color._m * p ,
                _y * q + color._y * p  
            ) ;
        }
        
        /**
         * Sets all tree components of a color. 
         */
        public function set( ...args:Array ):void
        {
            c = Number(args[0]) ;
            m = Number(args[1]) ;
            y = Number(args[2]) ;
        }
        
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public function toObject():Object 
        {
            return { c:_c , m:_m , y:_y } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return "new graphics.colors.CMY(" + _c.toString() + "," + _m.toString() + "," + _y.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString():String
        {
            return "[CMY c:" + _c + " m:" + _m + " y:" + _y + "]";
        }
        
        /**
         * @private
         */
        hack var _c:Number ;
        
        /**
         * @private
         */
        hack var _m:Number ;
        
        /**
         * @private
         */
        hack var _y:Number ;
    }
}
