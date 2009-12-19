/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
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

package vegas.ui
{
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.utils.Dictionary;
    
    /**
     * The key inspector listenen all keyboard event of a specific InterativeObject display and indicates if a specific key is down or up (with the isDown and isUp methods). 
     * In AS3 the Key.isDown() and Key.isUp() method don't exist, this inspector use composition to emulate this feature.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples
     * {
     *     import vegas.ui.KeyInspector;
     *     
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.Event;
     *     import flash.geom.Point;
     *     import flash.ui.Keyboard;
     *     
     *     [SWF(width="980", height="720", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class KeyInspectorExample extends Sprite
     *     {
     *         public function KeyInspectorExample()
     *         {
     *             ////////
     *             
     *             ball = new Sprite() ;
     *             
     *             ball.graphics.beginFill( 0xFF0000 ) ;
     *             ball.graphics.drawCircle(0, 0, 24) ;
     *             
     *             ball.x = 50 ;
     *             ball.y = 50 ;
     *             
     *             addChild( ball ) ;
     *             
     *             ////////
     *             
     *             key = new KeyInspector( stage );
     *             
     *             ////////
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             stage.addEventListener( Event.ENTER_FRAME, enterFrame );
     *         }
     *         
     *         protected var ball:Sprite ;
     *         
     *         protected var key:KeyInspector ;
     *         
     *         public var speed:Point = new Point(10,10) ;
     *         
     *         protected function enterFrame( e:Event ):void
     *         {
     *             if ( key.isDown( Keyboard.LEFT ) )
     *             {
     *                 ball.x -= speed.x ;
     *             }
     *             
     *             if ( key.isDown( Keyboard.RIGHT ) )
     *             {
     *                 ball.x += speed.x ;
     *             }
     *             
     *             if ( key.isDown( Keyboard.UP ) )
     *             {
     *                 ball.y -= speed.y ;
     *             }
     *             
     *             if ( key.isDown( Keyboard.DOWN ) )
     *             {
     *                 ball.y += speed.y ;
     *             }
     *             
     *         }
     *     }
     * }
     * </pre>
     */
    public class KeyInspector
    {
        /**
         * Creates a new KeyInspector instance.
         * @param display An interactive display object on which to listen for keyboard events.
         * To catch all key events, this should be a reference to the stage.
         */
        public function KeyInspector( display:InteractiveObject )
        {
            target = display ;
            _codes = new Dictionary(true) ;
        }
        
        /**
         * The interactive display object reference on which to listen for keyboard events.
         */
        public function get target():InteractiveObject
        {
            return _target ;
        }
        
        /**
         * @private
         */
        public function set target( display:InteractiveObject ):void
        {
            if ( _target != null )
            {
                _target.removeEventListener( Event.ACTIVATE         , _clear ) ;
                _target.removeEventListener( Event.DEACTIVATE       , _clear ) ;
                _target.removeEventListener( KeyboardEvent.KEY_DOWN , _down  ) ;
                _target.removeEventListener( KeyboardEvent.KEY_UP   , _up    ) ;
            }
            _target = display ;
            if ( _target != null )
            {
                _target.addEventListener( Event.ACTIVATE         , _clear , false , 0 , true ) ;
                _target.addEventListener( Event.DEACTIVATE       , _clear , false , 0 , true ) ;
                _target.addEventListener( KeyboardEvent.KEY_DOWN , _down  , false , 0 , true ) ;
                _target.addEventListener( KeyboardEvent.KEY_UP   , _up    , false , 0 , true ) ;
            }
        }
        
        /**
         * Clear the inspector key code buffering.
         */
        public function clear():void
        {
            _codes = new Dictionary(true) ;
        }
        
        /**
         * To test whether a key is down.
         * @param keyCode code for the key to test.
         * @return true if the key is down, false otherwise.
         * @see #isUp()
         */
        public function isDown( keyCode:uint ):Boolean
        {
            return _codes[keyCode] == PRESENT ;
        }
        
        /**
         * Tests whether a key is up.
         * @param keyCode code for the key to test.
         * @return true if the key is up, false otherwise.
         * @see #isDown()
         */
        public function isUp( keyCode:uint ):Boolean
        {
            return _codes[keyCode] != PRESENT ;
        }
        
        /**
         * @private
         */
        private var _codes:Dictionary;
        
        /**
         * @private
         */
        private var PRESENT:Object = {} ;
        
        /**
         * @private
         */
        private var _target:InteractiveObject ;
        
        /**
         * @private
         */
        private function _clear( e:Event ):void
        {
            clear() ;
        }
        
        /**
         * @private
         */
        private function _down( e:KeyboardEvent ):void
        {
            _codes[ e.keyCode ] = PRESENT ;
        }
        
        /**
         * @private
         */
        private function _up( e:KeyboardEvent ):void
        {
            delete _codes[ e.keyCode ] ;
        }
    }
}
