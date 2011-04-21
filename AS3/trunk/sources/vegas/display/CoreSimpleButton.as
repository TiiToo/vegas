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

package vegas.display 
{
    import core.reflect.getClassPath;
    
    import system.logging.Log;
    import system.logging.Logger;
    
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    
    /**
     * The CoreSimpleButton class extends the flash.display.SimpleButton class and implements the IDisplayObject interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.display.CoreSimpleButton ;
     * 
     * import flash.events.MouseEvent ;
     * 
     * var click:Function = function( e:MouseEvent ):void
     * {
     *     trace(e) ;
     * }
     * 
     * var button:CoreSimpleButton = new CoreSimpleButton( new UpState() , new OverState(), new DownState(), new HitTestState() ) ;
     * button.addEventListener( MouseEvent.CLICK , click ) ;
     * 
     * addChild( button ) ;
     * </pre>
     */
    public class CoreSimpleButton extends SimpleButton implements IDisplayObject
    {
        /**
         * Creates a new CoreSimpleButton instance.
         * @param upState The initial value for the SimpleButton up state. 
         * @param overState The initial value for the SimpleButton over state. 
         * @param downState The initial value for the SimpleButton down state.
         * @param hitTestState The initial value for the SimpleButton hitTest state.  
         */
        public function CoreSimpleButton
        ( 
            upState:DisplayObject   = null , overState:DisplayObject    = null , 
            downState:DisplayObject = null , hitTestState:DisplayObject = null
        )
        {
            super( upState, overState, downState, hitTestState ) ;
            logger = null ;
        }
        
        /**
         * Determinates the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">Logable</code> object.
         */
        public function get logger():Logger
        {
            return _logger ;
        }
        
        /**
         * @private
         */
        public function set logger( log:Logger ):void 
        {
            _logger = ( log == null ) ? Log.getLogger( getClassPath(this, true) ) : log ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ > 0 ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ ++ ;
        }
        
        /**
         * Reset the lock security of the display.
         */
        public function resetLock():void 
        {
            ___isLock___ = 0 ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = Math.max( ___isLock___ - 1  , 0 ) ;
        }
        
        /**
         * @private
         */ 
        private var ___isLock___:uint ;
        
        /**
         * @private
         */ 
        private var _logger:Logger ;
    }
}
