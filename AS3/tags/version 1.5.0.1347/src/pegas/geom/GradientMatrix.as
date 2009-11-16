/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.geom 
{
    import flash.geom.Matrix;
    
    /**
     * This Matrix fix the native implementation of the Matrix.createGradientBox() is unfortunately entirely 
     * useless as soon as you try to introduce rotation and scaling to a gradient because internally the order of matrix operations is unsuited for that task.
     */
    public class GradientMatrix extends Matrix
    {
        /**
         * Creates a new GradientMatrix instance with the specified parameters.
         * @param a The value that affects the positioning of pixels along the x axis when scaling or rotating an image.
         * @param b The value that affects the positioning of pixels along the y axis when rotating or skewing an image.
         * @param c The value that affects the positioning of pixels along the x axis when rotating or skewing an image.
         * @param d The value that affects the positioning of pixels along the y axis when scaling or rotating an image.
         * @param tx The distance by which to translate each point along the x axis.
         * @param ty The distance by which to translate each point along the y axis. 
         */
        public function GradientMatrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0)
        {
            super(a, b, c, d, tx, ty);
        }
        
        /**
         * Returns a new GradientMatrix object that is a clone of this matrix, with an exact copy of the contained object.
         * @return a new GradientMatrix object that is a clone of this matrix, with an exact copy of the contained object.
         */
        public override function clone():Matrix
        {
            return new GradientMatrix(a, b, c, d, tx, ty) ;
        }
        
        /**
         * Creates the specific style of matrix expected by the beginGradientFill() and lineGradientStyle() methods of the Graphics class. 
         * Width and height are scaled to a scaleX / scaleY pair and the tx / ty values are offset by half the width and height (This method fix the problem of order of matrix operations).
         * @param width The width of the gradient box.
         * @param height The height of the gradient box.
         * @param rotation The amount to rotate, in radians.
         * @param tx The distance, in pixels, to translate to the right along the x axis. This value is offset by half of the width parameter.
         * @param ty The distance, in pixels, to translate down along the y axis. This value is offset by half of the height parameter.
         */
        public override function createGradientBox(width:Number, height:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0):void
        {
            super.createGradientBox( 100, 100 );
            translate( -50, -50 );
            scale( width / 100, height / 100 );
            rotate( rotation );
            translate( tx, ty );
        }
    }
}
