
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

package pegas.display 
{
    import pegas.draw.FillGradientStyle;
    import pegas.draw.RectanglePen;

    import system.numeric.Mathematics;

    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.geom.Matrix;
    import flash.geom.Point;

    /**
     * The ReflectionBitmapData class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.display.ReflectionBitmapData ;
     * 
     * import flash.display.Bitmap       ;
     * import flash.display.BitmapData   ;
     * 
     * var reflect:BitmapData = new ReflectionBitmapData( new MyBitmapData(0,0) , 0.3) ; // MyBitmapData is a linked symbol in the swf.
     * var bitmap:Bitmap      = new Bitmap( reflect ) ;
     * 
     * bitmap.x = 25 ;
     * bitmap.y = 25 ;
     * 
     * addChild( bitmap ) ;
     * </pre>
     */
    public class ReflectionBitmapData extends BitmapData
    {
        /**
         * Creates a new ReflectionBitmapData instance of the passed-in BitmapData and add in the view a transparent reflection effect.
         * @param bitmapData The BitmapData to transform.
         * @param alpha A value between 0 and 1 to defines the alpha ratio of the reflection effect (default 0.5).
         */
        public function ReflectionBitmapData( bitmapData:BitmapData , alpha:Number = 0.5 )
        {
            super( bitmapData.width , bitmapData.height * 2 , true , 0 ) ;
            
            alpha = Mathematics.clamp( ( isNaN(alpha) ? 1 : alpha ) , 0, 1) ;
            
            draw(bitmapData);
            
            var m:Matrix ;
            
            m = new Matrix();
            m.createGradientBox(bitmapData.width, bitmapData.height, Math.PI * .5);
            
            var fill:FillGradientStyle =  _pen.fill as FillGradientStyle ;
            fill.alphas = [0, alpha] ;
            fill.matrix = m ;
            
            _pen.draw( 0, 0, bitmapData.width, bitmapData.height) ;
            
            var g:BitmapData = new BitmapData( _shape.width , _shape.height , true, 0 ) ;
            g.draw( _shape ) ;
            
            _pen.clear() ;
            
            var res:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, true, 0) ;
            res.copyPixels(bitmapData, res.rect, _origin, g, _origin, true);
            
            m = new Matrix(1, 0, 0, -1, 0, bitmapData.height * 2);
            
            draw(res, m);
        }
        
        /**
         * @private
         */
        private static var _origin:Point = new Point() ;
        
        /**
         * @private
         */
        private static var _shape:Shape = new Shape() ;
        
        /**
         * @private
         */
        private static var _pen:RectanglePen = new RectanglePen( _shape ) ;
        _pen.fill = new FillGradientStyle(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [0, 1], [0, 0xFF] ) ;
    }
}
