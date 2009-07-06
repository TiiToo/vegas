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
     * The Trichromatic coordinates. Y represents the brightness and (x,y) hue and saturation.
     */
    public class Yxy implements Cloneable, Equatable, Serializable
    {
        use namespace hack ;
        
        /**
         * Creates a new Yxy instance.
         * @param Y The Y component.
         * @param x The x component.
         * @param y The y component. 
         */
        public function Yxy( Y:Number = 0 , x:Number = 0 , y:Number = 0 )
        {
            this.Y = Y ;
            this.x = x ;
            this.y = y ;
        }
        
        /**
         * The Y brightness component.
         */
        public function get Y():Number
        {
            return _Y ;
        }
        
        /**
         * @private
         */
        public function set Y( value:Number ):void
        {
            _Y = isNaN(value) ? 0 : value ;
        } 
        
        /**
         * The x component.
         */
        public function get x():Number
        {
            return _x ;
        }
        
        /**
         * @private
         */
        public function set x( value:Number ):void
        {
            _x = isNaN(value) ? 0 : value ;
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
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():* 
        {
            return new Yxy( _Y , _x , _y ) ;
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
            else if ( o is Yxy )
            {
                return ( (o as Yxy)._Y == _Y ) && ( (o as Yxy)._x == _x ) && ( (o as Yxy)._y == _y ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Interpolate the color and returns a new Yxy object.
         * @param color The Yxy reference used to interpolate the current Yxy object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The interpolate Yxy result of the specified color.
         */
        public function interpolate( color:Yxy , level:Number = 1 ):Yxy
        {
            var p:Number = Mathematics.clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            return new Yxy
            (
                _Y * q + color._Y * p ,
                _x * q + color._x * p ,
                _y * q + color._y * p  
            ) ;
        }
        
        /**
         * Sets all tree components of a color. 
         */
        public function set( ...args:Array ):void
        {
            Y = Number(args[0]) ;
            x = Number(args[1]) ;
            y = Number(args[2]) ;
        }
        
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public function toObject():Object 
        {
            return { Y:_y , x:_x , y:_y } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return "new " + Reflection.getClassPath(this) + "(" + _Y.toString() + "," + _x.toString() + "," + _y.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString():String
        {
            return "[Yxy Y:" + _Y + " x:" + _x + " y:" + _y + "]";
        }
        
        /**
         * @private
         */
        hack var _Y:Number ;
        
        /**
         * @private
         */        
        hack var _x:Number ;
        
        /**
         * @private
         */
        hack var _y:Number ;
    }
}
