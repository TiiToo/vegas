/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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
package lunas.containers 
{
    import graphics.Direction;
    
    import lunas.events.ButtonEvent;
    
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    /**
     * This auto scrollable container use an auto scroll effect.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * 
     * import graphics.Direction;
     * 
     * import lunas.containers.AutoScrollContainer ;
     * import lunas.events.ComponentEvent ;
     * 
     * var onScroll:Function = function( e:ComponentEvent ):void
     * {
     *     trace( container.scroll + " / " + container.maxscroll ) ;
     * }
     * 
     * var container:AutoScrollContainer = new AutoScrollContainer() ;
     * container.addEventListener( ComponentEvent.SCROLL , onScroll ) ;
     * 
     * container.direction  = Direction.HORIZONTAL ;
     * container.x          = 25 ;
     * container.y          = 25 ;
     * container.space      = 10 ;
     * container.childCount = 8 ;
     * 
     * //container.useScrollRect = true ;
     * 
     * addChild( container ) ;
     * 
     * var s:Sprite ;
     * 
     * for (var i:uint ; i &lt; 20 ; i++ )
     * {
     *     s = new Sprite() ; 
     *     s.graphics.beginFill( Math.random() &#42; 0xFFFFFF ) ;
     *     s.graphics.drawRect( 0, 0, 30, 30) ;
     *     s.buttonMode = true ;
     *     container.addChild( s ) ;
     * }
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             container.scroll -- ;
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             container.scroll ++ ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *             container.direction = ( container.direction == Direction.HORIZONTAL ) ? Direction.VERTICAL : Direction.HORIZONTAL ;
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             container.fixScroll = !container.fixScroll ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             container.autoScroll = !container.autoScroll ;
     *             break ;
     *         }
     *     }
     * }
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     */
    public class AutoScrollContainer extends ScrollContainer 
    {
        /**
         * Creates a new AutoScrollContainer instance.
         */
        public function AutoScrollContainer( direction:String = "vertical", id:* = null, isFull:Boolean=false, name:String = null )
        {
            
            _timer = new Timer(200);
            _timer.addEventListener(TimerEvent.TIMER, _mouseEvent );
            
            lock() ;
            super( direction );
            unlock() ;
            
            area.buttonMode   = true ;
            area.useHandCursor = false ;
            area.mouseEnabled  = true ;
            area.addEventListener( MouseEvent.MOUSE_OVER, _mouseOver ) ;
            
            stopMouseEvent() ;
            
            update() ;
        }
        
        /**
         * Determinates the auto scroll activity.
         */
        public function get autoScroll():Boolean 
        {
            return _auto ;
        }
        
        /**
         * Sets the auto scroll activity value.
         */
        public function set autoScroll(b:Boolean):void 
        {
            _auto = b ; 
            stopMouseEvent() ;
        }
        
        /**
         * The mouse x property name.
         */
        public var propMouseX:String = "mouseX" ;
        
        /**
         * The mouse y property name.
         */
        public var propMouseY:String = "mouseY" ;
        
        /**
         * Defines a value between 0 and 50%.
         */
        public var scrollAutoRatio:Number = 15 ;
        
        /**
         * Determinates the delay in ms to refresh the scroll value.
         */
        public function get scrollInterval():Number 
        {
            return _timer.delay ;
        }
        
        /**
         * @private
         */
        public function set scrollInterval(n:Number):void 
        { 
            _timer.delay = n ;
        } 
        
        /**
         * Draws the view of the component.
         */
        public override function draw( ...arguments:Array ):void 
        {
            stopMouseEvent(true) ;
            super.draw() ;
        }
        
        /**
         * Returns the string representation of the coordinate attribute used in this display with the current direction value.
         * @return the string representation of the coordinate attribute used in this display with the current direction value.
         */
        public function getMouseProperty():String 
        {
            return (direction == Direction.VERTICAL) ? propMouseY : propMouseX ;
        }
        
        /**
         * Start the mouse event activity.
         */
        public function startMouseEvent():void 
        {
            if ( _timer.running == false )
            {
                dispatchEvent(new ButtonEvent( ButtonEvent.ROLL_OVER , this) ) ;
                if ( _auto ) 
                {
                    _area.visible = false ;
                    _timer.start() ;
                }
            }
        }
        
        /**
         * Stops the mouse event activity.
          */
        public function stopMouseEvent( noEvent:Boolean=false ):void 
        {
            if ( _timer.running )
            {
                _timer.stop() ;
            }
            if (_auto && enabled) 
            {
                _area.visible = true ;
            }
            if (noEvent != true) 
            {
                dispatchEvent( new ButtonEvent( ButtonEvent.ROLL_OUT, this ) ) ;
            }
        }
        
        /**
         * Invoked when the view enabled value change.
         */
        public override function viewEnabled():void 
        {
            if (enabled) 
            {
                startMouseEvent();
            }
            else
            {
                stopMouseEvent() ;
            }
        }
        
        /**
         * @private
         */
        private var _auto:Boolean = true;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private function _mouseOver( e:MouseEvent ):void
        {
            startMouseEvent() ;
        }
        
        /**
         * @private
         */
        private function _mouseEvent( e:Event ):void 
        {
            var ratio:Number = Math.round ( _area[ getMouseProperty() ] * 100 / _area[ getSizeProperty() ] )  ;
            var max:Number   = scrollAutoRatio > 0 ? scrollAutoRatio : 0 ;
            if (  _area.mouseX < 0 || _area.mouseX > _area.width || _area.mouseY < 0 || _area.mouseY > _area.height ) 
            {
                stopMouseEvent() ;
            }
            else if (ratio < max) 
            {
                setScroll( scroll - 1 ) ;
            }
            else if ( ratio > (100-max)) 
            {
                setScroll( scroll + 1 ) ;
            }
        }
    }
}
