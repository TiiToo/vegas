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
package lunas.components.bars 
{
    import core.maths.map;
    import core.maths.replaceNaN;

    import graphics.Align;
    import graphics.Direction;
    import graphics.FillStyle;
    import graphics.IFillStyle;
    import graphics.ILineStyle;
    import graphics.LineStyle;
    import graphics.drawing.RectanglePen;

    import system.hack;

    import flash.display.Shape;

    /**
     * The SimpleProgressbar component.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * 
     * import graphics.Align ;
     * import graphics.Direction ;
     * import graphics.FillStyle ;
     * import graphics.LineStyle ;
     * import graphics.geom.EdgeMetrics ;
     * 
     * import lunas.components.bars.SimpleProgressbar ;
     * import lunas.events.ComponentEvent ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var change:Function = function( e:ComponentEvent ):void
     * {
     *     trace( e.type + " : " + bar.position ) ;
     * }
     * 
     * var bar:SimpleProgressbar = new SimpleProgressbar() ;
     * bar.addEventListener( ComponentEvent.CHANGE , change ) ;
     * bar.x = 50 ;
     * bar.y = 50 ;
     * bar.position = 50 ;
     * 
     * addChild(bar) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             bar.position -= 10 ;
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             bar.position += 10 ;
     *             break ;
     *         }
     *         case Keyboard.SPACE :
     *         {
     *             bar.lock() ;
     *             bar.align               = Align.CENTER ; // Align.LEFT or Align.RIGHT or Align.CENTER
     *             bar.direction           = Direction.HORIZONTAL ;
     *             bar.backgroundFillStyle = new FillStyle( 0xB5C7CA , 1 ) ;
     *             bar.backgroundLineStyle = new LineStyle( 2 , 0xFFFFFF , 1 ) ;
     *             bar.barFillStyle        = new FillStyle( 0x921085 , 1 ) ;
     *             bar.barLineStyle        = new LineStyle( 1 , 0x6A9195, 1 ) ;
     *             bar.border              = new EdgeMetrics(2, 2, 2, 2) ;
     *             bar.unlock() ;
     *             bar.setSize( 200, 8 ) ;
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             bar.minimum = 20  ;
     *             bar.maximum = 200 ;
     *             break ;
     *         }
     *         default :
     *         {
     *             bar.direction = ( bar.direction == Direction.VERTICAL ) ? Direction.HORIZONTAL : Direction.VERTICAL ;
     *             if ( bar.direction == Direction.VERTICAL )
     *             {
     *                 bar.setSize( 8, 200 ) ;
     *             }
     *             else
     *             {
     *                 bar.setSize( 200, 8 ) ;
     *             }
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * 
     * trace("Press Keyboard.LEFT or Keyboard.RIGHT or Keyboard.SPACE or other keyboard touch to test this example.") ;
     * </pre>
     */
    public class SimpleProgressbar extends CoreProgressbar
    {
        use namespace hack ;
        
        /**
         * Creates a new SimpleProgressbar instance.
         * @param direction The direction value of the bar ("horizontal" or "vertical", see <code class="prettyprint">graphics.Direction</code>).
         * @param w The prefered width of the button (default 120 pixels).
         * @param h The prefered height of the button (default 20 pixels).
         */
        public function SimpleProgressbar( direction:String = null, w:Number = 150 , h:Number = 6 )
        {
            background    = new Shape() ;
            bar           = new Shape() ;
            
            backgroundPen = new RectanglePen( background ) ;
            barPen        = new RectanglePen( bar ) ;
            
            addChild( background ) ;
            addChild( bar ) ;
            
            backgroundPen.fill = new FillStyle( 0xFFFFFF, 1 ) ;
            backgroundPen.line = new LineStyle( 1, 0xA2A2A2 , 1) ;
            barPen.fill        = new FillStyle( 0xFF0000, 1 ) ;
            barPen.line        = null ;
            
            super( direction , w , h ) ;
        }
        
        /**
         * The background reference of this component.
         */
        public var background:Shape ;
        
        /**
         * @private
         */
        public override function set align( align:uint ):void
        {
            super.align = (align == Align.LEFT || align == Align.RIGHT || align == Align.CENTER) ? align : Align.LEFT ;
            update() ;
        }
        
        /**
         * Determinates the fill style object of the background.
         */
        public function get backgroundFillStyle():IFillStyle
        {
            return backgroundPen.fill ;
        }
        
        /**
         * @private
         */
        public function set backgroundFillStyle( style:IFillStyle ):void
        {
            backgroundPen.fill = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the background.
         */
        public function get backgroundLineStyle():ILineStyle
        {
            return backgroundPen.line ;
        }
        
        /**
         * @private
         */
        public function set backgroundLineStyle( style:ILineStyle ):void
        {
            backgroundPen.line = style ;
            update() ;
        }
       
        /**
         * The thumb reference of this bar.
         */
        public var bar:Shape ;
        
        /**
         * Determinates the fill style object of the bar.
         */
        public function get barFillStyle():IFillStyle
        {
            return barPen.fill ;
        }
        
        /**
         * @private
         */
        public function set barFillStyle( style:IFillStyle ):void
        {
            barPen.fill = style ;
            update() ;
        }
        
        /**
         * Determinates the line style object of the bar.
         */
        public function get barLineStyle():ILineStyle
        {
            return barPen.line ;
        }
        
        /**
         * @private
         */
        public function set barLineStyle( style:ILineStyle ):void
        {
            barPen.line = style ;
            update() ;
        }
        
        /**
         * Draws the view of the component.
         */
        public override function draw( ...arguments:Array ):void
        {
            backgroundPen.draw( 0, 0, w, h ) ;
        }
        
        /**
         * Invoked when the position of the bar is changed.
         * @param flag (optional) An optional boolean. By default this flag is passed-in the setPosition method.
         */
        public override function viewPositionChanged( flag:Boolean = false ):void 
        {
            var isVertical:Boolean = direction == Direction.VERTICAL ;
            
            var horizontal:Number  = replaceNaN( border.horizontal ) ;
            var vertical:Number    = replaceNaN( border.vertical   ) ;
            
            var margin:Number      = isVertical ? vertical : horizontal ;
            var max:Number         = isVertical ? h : w ;
            
            var size:Number        =  map( position , minimum, maximum , 0 , (max - margin) ) ;
            
            var $b:Number          = replaceNaN( border.bottom ) ;
            var $l:Number          = replaceNaN( border.left ) ;
            var $r:Number          = replaceNaN( border.right ) ;
            var $t:Number          = replaceNaN( border.top ) ;
            
            var $w:Number          = isVertical ? ( w - horizontal ) : size  ;
            var $h:Number          = isVertical ? size : ( h - vertical ) ;
            
            if ( align == Align.RIGHT )
            {
                bar.x         = isVertical ? $l : w - $r ;
                bar.y         = isVertical ? h - $b : $t ;
                barPen.align  = isVertical ? Align.BOTTOM_LEFT : Align.TOP_RIGHT ;
            }
            else if ( align == Align.CENTER )
            {
                bar.x         = w / 2 ;
                bar.y         = h / 2 ;
                barPen.align  = Align.CENTER ;
            }
            else // Align.LEFT (default)
            {
                bar.x = $l ;
                bar.y = $t ;
                barPen.align = Align.TOP_LEFT ;
            }
            barPen.draw( 0, 0, $w, $h) ;
            bar.visible = position > 0 ;
        }
        
        /**
         * @private
         */
        hack var backgroundPen:RectanglePen ;
        
        /**
         * @private
         */
        hack var barPen:RectanglePen ;
    }
}
