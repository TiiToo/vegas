/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples.display 
{
    import system.process.Lockable;

    import flash.display.Sprite;

    /**
     * This sprite draw a rectangle with a virtual width and height value.
     */
    public class RectangleSprite extends Sprite implements Lockable
    {
        /**
         * Creates a new RectangleSprite instance.
         */
        public function RectangleSprite()
        {
            super() ;
            update() ;
        }
        
        /**
         * The color of the rectangle shape.
         */
        public function get color():uint 
        {
            return _color ;
        }
        
        /**
         * @private
         */
        public function set color( value:uint ):void 
        {
            _color = value ;
            update() ;
        }
        
        /**
         * Determinates the virtual height value of this sprite.
         */
        public function get h():Number 
        {
            return _h ;  
        }
        
        /**
         * @private
         */
        public function set h( n:Number ):void 
        {
            _h = isNaN(n) ? 0 : n ;
            update() ;
        }
        
        /**
         * Determinates the virtual height value of this sprite.
         */
        public function get w():Number 
        {
            return _w ;
        }
        
        /**
         * @private
         */
        public function set w( n:Number ):void 
        {
            _w = isNaN(n) ? 0 : n ;
            update() ;
        }
        
        /**
         * Draw the display.    
         */
        public function draw():void
        {
            graphics.clear() ;
            graphics.beginFill( color , 1 ) ;
            graphics.drawRect( 0, 0, w, h ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ == true ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ = true ;
        } 
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = false ;
        }
        
        /**
         * Update the display.
         */ 
        public function update():void
        {
            if ( isLocked() ) 
            {
                return ;
            }
            trace(this + " update") ;
            draw() ;
        }
        
        /**
         * @private
         */
        protected var _color:uint = 0xFF0000 ;
        
        /**
         * @private
         */
        protected var _h:Number = 0 ;
        
        /**
         * @private
         */
        protected var _w:Number = 0 ;
        
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */ 
        private var ___isLock___:Boolean ;
    }
}
