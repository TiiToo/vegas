/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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
    import system.process.Lockable;

    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.KeyboardEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    /**
     * Creates a command ( or keywords, or cheat codes ) to type on the keyboard. This command can be notify with a simple callback or a classic Event.
     * @example Creates cheat codes in your applications.
     * <listing version="3.0">
     * <code class="prettyprint">
     * import vegas.ui.CheatCode;
     * 
     * ///////// konami code ( UP | UP | DOWN | DOWN | LEFT | RIGHT | LEFT | RIGHT | B | A ).
     * 
     * var selectKonami:Function = function( e:Event ):void
     * {
     *     trace( "hello konami code !" );
     * }
     * 
     * var konami:Array = [ 38 , 38 , 40 , 40 , 37 , 39 , 37 , 39 , 66 , 65 ] ;
     *
     * var cheat1:CheatCode = new CheatCode( stage , konami ) ;
     *
     * cheat1.addEventListener( Event.SELECT , selectKonami ) ;
     * 
     * ///////// custom code based String expression ("hello").
     * 
     * var selectHelloWorld:Function = function():void
     * {
     *     trace( "hello world !" );
     * }
     * 
     * var cheat2:CheatCode = CheatCode.createFromString( "hello" , stage ) ;
     * 
     * cheat2.onSelect = selectHelloWorld ; // use basic callback method
     * </code>
     * </listing>
     */
    public dynamic class CheatCode extends EventDispatcher implements Lockable
    {
        /**
         * Creates a new CheatCode instance.
         * @param keys The Array representation of all key codes to validate the cheat code.
         * @param stage a Stage reference to handle the keyboard events (This property must be defines to handle the keyboard events).
         * @param delay the amount of time to wait before reseting the keyboard input (default 1000 ms).
         */
        public function CheatCode( keys:Array = null , stage:Stage = null , delay:uint = 1000 )
        {
            _stage = stage ;
            _keys  = keys  ;
            _pos   = 0 ;
            _timer = new Timer( delay , 1 ) ;
            _timer.addEventListener( TimerEvent.TIMER_COMPLETE , _timeout , false , 0 , true ) ;
            this.stage = stage ;
        }
        
        /**
         * Indicates the amount of time to wait before reseting the keyboard input.
         */
        public function get delay():Number
        {
            return _timer.delay ;
        }
        
        /**
         * @private
         */
        public function set delay( value:Number ):void
        {
            _timer.delay = value ;
        }
        
        /**
         * Determinates the Array representation of all key codes to validate the cheat code.
         */
        public function get keys():Array
        {
            return _keys ;
        }
        
        /**
         * @private
         */
        public function set keys( ar:Array ):void
        {
            _keys = ar ;
        }
        
        /**
         * Indicates the Stage reference of the application. 
         * This property must be defines to handle the keyboard events.
         */
        public function get stage():Stage
        {
            return _stage ;
        }
        
        /**
         * @private
         */
        public function set stage( stage:Stage ):void
        {
            if ( _stage )
            {
                _stage.addEventListener(KeyboardEvent.KEY_UP, _keyUp , false ) ;
            }
            _stage = stage ;
            if ( _stage )
            {
                _stage.addEventListener(KeyboardEvent.KEY_UP, _keyUp, false , 0 , true ) ;
            }
        }
        
        /**
         * Generates a cheat code object with a specific String expression.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import vegas.ui.CheatCode;
         * 
         * var cheat:CheatCode = CheatCode.createFromString( "hello" , stage ) ;
         * 
         * cheat.onSelect = function():void
         * {
         *     trace( "hello world !" );
         * }
         * </pre>
         */
        public static function createFromString( code:String , stage:Stage = null , delay:uint = 1000 ):CheatCode
        {
            if ( code == null || code == "" )
            {
                throw new ArgumentError( "create a CheatCode from string failed, tne code expression not must be null") ;
            }
            var k:Array = [] ;
            var l:int   = code.length ;
            for( var i:int ; i<l ; i++ )
            {
                k[i] = code.charCodeAt(i) ;
            }
            return new CheatCode( k , stage , delay ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean
        {
            return _isLocked ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void
        {
            _isLocked = true ;
        }
        
        /**
         * Callback method invoked when the cheat code is selected.
         */
        prototype.onSelect = function():void
        {
            // overrides this dynamic method
        };
        
        /**
         * Unlocks the object.
         */
        public function unlock():void
        {
            _isLocked = false ;
        }
        
        /**
         * @private
         */
        private var _isLocked:Boolean ;
        
        /**
         * @private
         */
        private var _keys:Array ;
        
        /**
         * @private
         */
        private var _pos:int ;
        
        /**
         * @private
         */
        private var _stage:Stage;
        /**
         * @private
         */
        private var _timer:Timer;
        
        /**
         * @private
         */
        private function _keyUp( event:KeyboardEvent ):void
        {
            if ( _isLocked )
            {
                return ;
            }
            var key:uint      = _keys[ _pos ] ;
            var keyCode:uint  = event.keyCode ;
            var charCode:uint = event.charCode ;
            // trace( _pos + " key:" + key + " keyCode:" + keyCode + " charCode:" + charCode ) ;
            if ( _timer.running )
            {
                _timer.stop() ;
            }
            if ( key == charCode || key == keyCode ) 
            {
                _pos ++ ;
                if ( _pos == _keys.length ) 
                {
                    this["onSelect"]() ; // speed callback
                    dispatchEvent( new Event( Event.SELECT ) ) ; // W3C event propagation
                    _pos = 0 ;
                }
                else
                {
                    _timer.start();
                }
            } 
            else 
            {
                _pos = 0 ;
            }
        }
        
        /**
         * @private
         */
        private function _timeout( event:TimerEvent ):void
        {
            _pos = 0 ;
        }
    }
}