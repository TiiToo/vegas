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
    import core.maths.degreesToRadians;

    import graphics.FillGradientStyle;
    import graphics.IFillStyle;
    import graphics.ILineStyle;
    import graphics.display.MOB;
    import graphics.drawing.PolyLinePen;

    import flash.events.Event;
    import flash.geom.Matrix;
    
    /**
     * This background use a PolyLine pen to draw this visual shape.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.display.PolyLineBackground ;
     * 
     * import vegas.FillStyle ;
     * import vegas.LineStyle ;
     * 
     * stage.align = "tl" ;
     * stage.scaleMode = "noScale" ;
     * 
     * var bg:PolyLineBackground = new PolyLineBackground() ;
     * 
     * bg.x = 25 ;
     * bg.y = 25 ;
     * 
     * var data:Array =
     * [
     *     {x :  10 , y :  10 } ,
     *     {x : 110 , y :  10 } ,
     *     {x : 110 , y :  45 } ,
     *     {x : 120 , y :  55 } ,
     *     {x : 110 , y :  65 } ,
     *     {x : 110 , y : 110 } ,
     *     {x :  10 , y : 110 } 
     * ] ;
     * 
     * bg.fill = new FillStyle( 0xFF0000 ) ;
     * bg.line = new LineStyle( 2, 0xFFFFFF ) ;
     * bg.data = data ;
     * 
     * addChild( bg ) ;
     * </pre>
     */
    public class PolyLineBackground extends MOB 
    {
        /**
         * Creates a new PolyLineBackground instance.
         * @param data An Array of all points to defines the polyline pen.
         */
        public function PolyLineBackground( data:Array = null )
        {
            _pen = initBackgroundPen() ;
            this.data = data ;  
        }
        
        /**
         * Determinates the array representation of all points of this polyline pen.
         * <p>This Array can contains graphics.geom.Vector2, flash.geom.Point or all objects with a numeric x an y properties.</p>
         */
        public function get data():Array
        {
            return _pen.data ;
        }
        
        /**
         * @private
         */
        public function set data( ar:Array ):void
        {
            if( _pen != null )
            {
                _pen.data = ar || [] ;
            }
            update() ;
        }
        
        /**
         * Determinates the IFillStyle reference of this display.
         */
        public function get fill():IFillStyle
        {
            return _fillStyle ;
        }
        
        /**
         * @private
         */
        public function set fill( style:IFillStyle ):void
        {
            _fillStyle = style ;
            if( _pen != null )
            {
                _pen.fill = _fillStyle ;
            }
            update() ;
        }
        
        /**
         * The rotation value to draw the linearGradientFill method when draw the background.
         */
        public var gradientRotation:Number = 0  ;
        
        /**
         * Determinates the <code class="prettyprint">ILineStyle</code> reference of this display.
         */
        public function get line():ILineStyle
        {
            return _lineStyle ;
        }
        
        /**
         * @private
         */
        public function set line( style:ILineStyle ):void
        {
            _lineStyle = style ;
            if( _pen != null )
            {
                _pen.line = style ;
            }
            update() ;
        }
        
        /**
         * Indicates if the IFillStyle of this display use gradient box matrix (only if the IFillStyle is a FillGradientStyle).
         */
        public var useGradientBox:Boolean ;
        
        /**
         * Draw the display.
         * @param data The optional Array of points to draw the polyline shape of the background.
         * @return the <code class="prettyprint">Dimension</code> object who defines the width and the height use in the method to draw the background.
         */
        public function draw( data:Array = null ):void
        {
            if ( data != null )
            {
                _pen.data = data ;
            }
            if ( useGradientBox && fill is FillGradientStyle )
            {
                var matrix:Matrix = new Matrix() ;
                // TODO calculate the bound
                // matrix.createGradientBox( $w, $h );
                matrix.rotate( degreesToRadians( gradientRotation ) ) ;
                ( fill as FillGradientStyle ).matrix = matrix ;
            }
            _pen.draw() ;
         }
         
        /**
         * Init the pen to draw the background of this display.
         * This method is invoked in the constructor of the class.
         * You can override this method to change the shape of the background.
         * @return the IPen reference to draw the background of the display.
         */
        public function initBackgroundPen():PolyLinePen
        {
            var p:PolyLinePen = new PolyLinePen( this ) ;
            p.fill         = _fillStyle ;
            p.line         = _lineStyle ;
            return p ;    
        }
        
        /**
         * Notify an event when you resize the component.
         */
        public function notifyResized():void 
        {
            dispatchEvent( new Event( Event.RESIZE ) ) ;
        }
         
        /**
         * Update the display.
         */
        public override function update():void 
        {
            if ( isLocked() ) 
            {
                return ;
            }
            draw() ;
            viewChanged() ;
            super.update() ;
        }
        
        /**
         * This method is invoked after the draw() method in the update() method.
         * Overrides this method.
         */
        public function viewChanged():void
        {
            // overrides
        }
        
        /**
         * @private
         */
        private var _fillStyle:IFillStyle ;
        
        /**
         * @private
         */
        private var _lineStyle:ILineStyle ;
        
        /**
         * @private
         */
        private var _pen:PolyLinePen ;
    }
}
