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

package vegas.display 
{
    import graphics.display.DisplayObjects;

    import system.process.Startable;
    import system.process.Stoppable;

    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.ui.Mouse;

    /**
     * This display protect the application with a stage.align mode "top left".
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageAlign ;
     * import flash.display.StageScaleMode ;
     * 
     * import vegas.display.Protector ;
     * 
     * import graphics.FillStyle ;
     * 
     * stage.align     = StageAlign.TOP_LEFT ; // important
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var protect:Protector = new Protector() ;
     * 
     * protect.cursor = new Cursor() ;
     * 
     * addChild( protect ) ;
     * 
     * protect.fill = new FillStyle( 0xD97BD0 , 0.2 ) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     protect.magnetic = !protect.magnetic ;
     * }
     * </pre>
     * <p><b>Note : </b> The Cursor class is a linked MovieClip symbol in your application with a little animation.</p>
     */
    public class Protector extends Background implements Startable, Stoppable
    {
        /**
         * Creates a new Protector instance.
         * @param cursor The optional cursor reference.
         * @param magnetic Indicates the magnetic state value of the cursor.
         * @param cursorAlign The alignement of the cursor when is showing and not magnetic (default Align.CENTER).
         */
        public function Protector( cursor:Sprite = null , magnetic:Boolean = false , cursorAlign:uint = 1 )
        {
            lock() ;
            super( null , true );
            autoSize         = true ;
            this.cursor      = cursor ;
            this.cursorAlign = cursorAlign ;
            this.magnetic = magnetic ;
            unlock() ;
            update() ;
        }
        
        /**
         * The optional cursor reference.
         */
        public function get cursor():Sprite
        {
            return _cursor ;
        }
        
        /**
         * The cursor of this protector object.
         */
        public function set cursor( target:Sprite ):void
        {
            if ( _cursor && _cursor is MovieClip )
            {
                (cursor as MovieClip).stop() ;
            }
            _cursor = target ;
            if ( _cursor && _cursor is MovieClip )
            {
                (cursor as MovieClip).stop() ;
            }
        }
        
        /**
         * The alignement of the cursor when is showing and not magnetic (default Align.CENTER).
         * @see graphics.Align
         */
        public function get cursorAlign():uint
        {
            return _cursorAlign ;
        }
        
        /**
         * @private
         */
        public function set cursorAlign( align:uint ):void
        {
            _cursorAlign = align ;
            update() ;
        }
        
        /**
         * The offset of the cursor when is showing and not magnetic (default is new flash.geom.Point(0,0)).
         * @see flash.geom.Point
         */
        public function get cursorOffset():Point
        {
            return _cursorOffset ;
        }
        
        /**
         * @private
         */
        public function set cursorOffset( offset:Point ):void
        {
            _cursorOffset = offset ;
            update() ;
        }
        
        /**
         * Indicates the magnetic state value of the cursor.
         */
        public function get magnetic():Boolean
        {
            return _magnetic ; 
        }
        
        /**
         * @private
         */
        public function set magnetic( b:Boolean ):void
        {
            if (_magnetic == b)
            {
                return ;
            }
            _magnetic = b ;
            if ( !_magnetic )
            {
                viewChanged() ;
            }
        }
        
        /**
         * Indicates if the mouse is visible when the protector is started.
         */
        public function get mouseVisible():Boolean
        {
            return _mouseVisible ;
        }
        
        /**
         * @private
         */
        public function set mouseVisible( b:Boolean ):void
        {
            _mouseVisible = b ;
            if ( !_stopped )
            {
                if ( _mouseVisible )
                {
                    Mouse.show() ;
                }
                else
                {
                    Mouse.hide() ;
                }
            }
        }
        
        /**
         * Indicates if the protector is stopped.
         */
        public function get stopped():Boolean
        {
            return _stopped ; 
        }
        
        /**
         * Start the protector.
         */
        public function start():void
        {
            if( _stopped )
            {
                _stopped = false ;
                if ( _mouseVisible )
                {
                    Mouse.show() ;
                }
                else
                {
                    Mouse.hide() ;
                }
                if ( _cursor )
                {
                    addChild( _cursor ) ;
                    update() ;
                    if( _cursor is MovieClip )
                    {
                        ( _cursor as MovieClip ).play() ;
                    }
                    stage.addEventListener( Event.ENTER_FRAME , refreshCursor ) ;
                }
            }
        }
        
        /**
         * Stop the protector.
         */
        public function stop():void
        {
            if ( !_stopped )
            {
                _stopped = true ;
                Mouse.show() ;
                if( cursor )
                {
                    if( cursor is MovieClip )
                    {
                        (cursor as MovieClip).stop() ;
                    }
                    if( contains( cursor ) )
                    {
                        removeChild( cursor ) ;
                    }
                }
                stage.removeEventListener( Event.ENTER_FRAME , refreshCursor ) ;
            }
        }
        
        /**
         * Invoked when the view is changed.
         */
        public override function viewChanged():void
        {
            if ( _cursor && !_magnetic )
            {
                DisplayObjects.align( _cursor , new Rectangle(0,0,width,height) , _cursorAlign , _cursorOffset ) ;
            }
        }
        
        /**
         * @private
         */
        protected var _cursor:Sprite ;
        
        /**
         * @private
         */
        protected var _cursorAlign:uint ;
        
        /**
         * @private
         */
        protected var _cursorOffset:Point = new Point(0,0) ;
        
        /**
         * @private
         */
        protected var _magnetic:Boolean ;
        
        /**
         * @private
         */
        protected var _mouseVisible:Boolean = true ;
        
        /**
         * @private
         */
        protected var _stopped:Boolean = true ;
        
        /**
         * @private
         */
        protected function refreshCursor( e:Event = null ):void
        {
            if ( _cursor && _magnetic )
            {
                _cursor.x = mouseX ;
                _cursor.y = mouseY ;
            }
        }
    }
}
