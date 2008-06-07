
package test.display 
{
    import flash.display.Sprite;
    
    import vegas.core.ILockable;    

    /**
     * This sprite draw a rectangle with a virtual width and height value.
     * @author eKameleon
     */
    public class RectangleSprite extends Sprite implements ILockable
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
         * You must override this method. This method is launch by the setup() method when the Config is checked.
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
