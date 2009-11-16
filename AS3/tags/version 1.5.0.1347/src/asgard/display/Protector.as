/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.display 
{
    import asgard.display.Background;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.ui.Mouse;
    
    /**
     * This display protect the application with a stage.align mode "top left".
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageAlign ;
     * import flash.display.StageScaleMode ;
     * 
     * import asgard.display.Protector ;
     * 
     * import pegas.draw.FillStyle ;
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
    public class Protector extends Background 
    {
        /**
         * Creates a new Protector instance.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not (default <code class="prettyprint">true</code>).
         * @param name Indicates the instance name of the object.
         */
        public function Protector(id:* = null, isFull:Boolean = true, name:String = null)
        {
            super(id, isFull, name);
            autoSize = true ; // default
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
            if ( _cursor != null && _cursor is MovieClip )
            {
                (cursor as MovieClip).stop() ;
            }
            _cursor = target ;
            if ( _cursor != null && _cursor is MovieClip )
            {
                (cursor as MovieClip).stop() ;
            }
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
            _magnetic = b ;
            _refreshCursor() ;
        }
        
        /**
         * This method is invoked after the draw() method in the update() method.
         */
        public override function viewChanged():void
        {
            if ( cursor != null && _magnetic == false )
            {
                cursor.x = w / 2 ;
                cursor.y = h / 2 ;
            }
        }
        
        /**
         * Invoked when the display is added to the stage.
         */
        protected override function addedToStage( e:Event = null ):void
        {
            super.addedToStage(e) ;
            if ( cursor != null )
            {
               addChild( cursor ) ;
               if( cursor is MovieClip )
               {
                   (cursor as MovieClip).play() ;
               }
               _refreshCursor() ;
            }
        }
        
        /**
         * Invoked when the display is removed from the stage.
         */
        protected override function removedFromStage( e:Event = null ):void
        {
            super.removedFromStage(e) ;
            Mouse.show() ;
            if ( cursor != null && contains(cursor) )
            {
               if( cursor is MovieClip )
               {
                   (cursor as MovieClip).stop() ;
               }
               removeChild( cursor ) ;
               _refreshCursor() ;
            }
        }
        
        /**
         * @private
         */
        private var _cursor:Sprite ;
        
        /**
         * @private
         */
        private var _magnetic:Boolean ;
        
        /**
         * @private
         */
        private function _refreshCursor():void
        {
            if ( cursor != null && contains(cursor) )
            {
                if ( _magnetic )
                {
                    cursor.startDrag(true) ;
                    Mouse.hide() ;
                }
                else
                {
                    Mouse.show() ;
                    cursor.stopDrag() ;
                }
            }
            if ( cursor != null && _magnetic == false )
            {
                cursor.x = w / 2 ;
                cursor.y = h / 2 ;
            }
        }
    }
}
