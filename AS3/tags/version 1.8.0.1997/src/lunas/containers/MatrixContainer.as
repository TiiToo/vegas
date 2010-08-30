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
package lunas.containers 
{
    import graphics.Direction;
    import graphics.layouts.Layout;
    
    import system.hack;
    
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    
    /**
     * This container use a matrix layout pattern.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * import flash.filters.DropShadowFilter ;
     * 
     * import lunas.containers.MatrixContainer ;
     * 
     * import graphics.Direction;
     * import graphics.FillStyle ;
     * import graphics.drawing.RectanglePen ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var container:MatrixContainer = new MatrixContainer() ;
     * container.x = 25 ;
     * container.y = 25 ;
     * container.space = 10 ;
     * 
     * container.columns   = 10 ;
     * container.lines     = 10 ;
     * container.direction = Direction.HORIZONTAL ;
     * 
     * addChild( container ) ;
     * 
     * var createNewSquare:Function = function()
     * {
     *     var square:Shape            = new Shape() ;
     *     var shadow:DropShadowFilter = new DropShadowFilter( 2, 90, 0x000000, 0.7, 10, 10, 1, 2) ;
     *     var pen:RectanglePen        = new RectanglePen( square ) ;
     *     
     *     pen.fill = new FillStyle( Math.random() * 0xFFFFFF ) ;
     *     pen.draw(0,0,10,10) ;
     *     
     *     square.filters = [ shadow ] ;
     *     
     *     container.addChild( square  )  ;
     * }
     * 
     * for (var i:int = 0 ; i<12 ; i++ )
     * {
     *     createNewSquare() ;
     * }
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.UP :
     *         {
     *             container.clear() ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *              container.direction = container.direction == Direction.HORIZONTAL ? Direction.VERTICAL : Direction.HORIZONTAL ;
     *              break ;
     *         }
     *         default :
     *         {
     *             createNewSquare() ;
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     */
    public class MatrixContainer extends ListContainer 
    {
        use namespace hack ;
        
        /**
         * Creates a new MatrixContainer instance.
         * @param columns The number of columns in the matrix layout if the direction of this container is Direction.HORIZONTAL.
         * @param lines The number of lines in the matrix layout if the direction of this container is Direction.VERTICAL.
         * @param direction The direction value of the bar ("horizontal" or "vertical", see <code class="prettyprint">graphics.Direction</code>).
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function MatrixContainer( columns:int = 3 , lines:int = 3 , direction:String = "horizontal" , id:* = null , isFull:Boolean=false , name:String = null )
        {
            lock() ;
            this.columns = columns ;
            this.lines   = lines ;
            unlock() ;
            super( direction, id, isFull, name ) ;
        }
        
        /**
         * Determinates the number of columns in the matrix layout if the direction of this container is Direction.HORIZONTAL.
         * @see graphics.Direction
         */
        public function get columns():int 
        {
            return _columns ;
        }
        
        /**
         * @private
         */
        public function set columns(n:int):void 
        {
            _columns = (n>1) ? n : 1 ;
            update() ;
        }
        
        /**
         * Determinates the number of lines in the matrix layout if the direction of this container is Direction.VERTICAL.
         * @see graphics.Direction
         */
        public function get lines():int 
        {
            return _lines ;
        }
        
        /**
         * @private
         */
        public function set lines(n:int):void 
        {
            _lines = (n>1) ? n : 1 ;
            update() ;
        }
        
        /**
         * Refreshs the childs position in the container.
         */
        public override function changeChildsPosition():void 
        {
            var n:int = numChildren ;
            if ( n == 0 )
            {
                return ;
            }
            if ( ( _columns > 1 && direction == Direction.HORIZONTAL ) ||  ( _lines > 1 && direction == Direction.VERTICAL ) ) 
            {
                var d:DisplayObject ;
                var c:Number ;
                var l:Number ;
                var s:Number = isNaN(space) ? 0 : space ;
                var isHorizontal:Boolean = direction == Direction.HORIZONTAL ;
                for ( var i:int ; i<n ; i++ ) 
                {
                    c = isHorizontal ? ( i%_columns ) : Math.floor( i/_lines ) ;
                    l = isHorizontal ? Math.floor( i/_columns ) : ( i%_lines ) ;
                    d = getChildAt(i) ;
                    d.x = c * ( d[propWidth]  + ( isNaN(spaceH) ? s : spaceH ) ) ;
                    d.y = l * ( d[propHeight] + ( isNaN(spaceV) ? s : spaceV ) ) ;
                }
            }
            else 
            {
                super.changeChildsPosition() ;
            }
        }
        
        /**
         * Invoked when the container layout change.
         */
        protected override function updateLayout( layout:Layout = null ):void 
        {
            _bound.setEmpty() ;
            if ( ( _lines > 1 && direction == Direction.VERTICAL) || ( _columns > 1 && direction == Direction.HORIZONTAL ) ) 
            {
                if ( autoSize ) 
                {
                    var b:Rectangle = _container.getBounds(this) ;
                    _bound.x        = b.x ;
                    _bound.y        = b.y ;
                    _bound.width    = b.width  ;
                    _bound.height   = b.height ;
                }
                else
                {
                    _bound.width  = w ;
                    _bound.height = h ;
                }
            } 
            else 
            {
                super.updateLayout() ;
            }
        }
        
        /**
         * @private
         */
        hack var _lines:int ;
        
        /**
         * @private
         */
        hack var _columns:int ; 
    }
}

