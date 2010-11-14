﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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
package graphics.drawing 
{
    import graphics.Align;
    
    import system.hack;
    
    import flash.geom.Rectangle;
    
    /**
     * This pen draw a rectangle shape with a Graphics object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.Align ;
     * import graphics.FillStyle ;
     * import graphics.LineStyle ;
     * 
     * import graphics.drawing.RectanglePen ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align = "" ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 740 / 2 ;
     * shape.y = 420 / 2 ;
     * 
     * var pen:RectanglePen = new RectanglePen( shape.graphics , 0, 0, 50, 50,  Align.CENTER ) ;
     * pen.useClear   = true ;
     * 
     * pen.useEndFill = true ;
     * pen.fill       = new FillStyle( 0xFF0000 , 0.5 ) ;
     * pen.line       = new LineStyle( 2, 0xFFFFFF , 1 ) ;
     * pen.draw() ;
     * </pre>
     */
    public dynamic class RectanglePen extends Pen 
    {
        use namespace hack ;
        
        /**
         * Creates a new RectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function RectanglePen( graphic:* , x:Number = 0 , y:Number = 0 , width:Number = 0 , height:Number = 0 , align:uint = 10 )
        {
            super( graphic );
            setPen( x, y, width, height , align ) ;
        }
        
        /**
         * Defines the height of the shape rectangle. 
         */
        public var height:Number ;
        
        /**
         * Returns the Rectangle reference of this pen.
         */
        public function get rectangle():Rectangle 
        {
            return new Rectangle( x, y, width, height ) ;
        }
        
        /**
         * Defines the width of the shape rectangle. 
         */
        public var width:Number ;
        
        /**
         * Defines the x position of the shape rectangle. 
         */
        public var x:Number ;
        
        /**
         * Defines the y position of the shape rectangle. 
         */
        public var y:Number ;
        
        /**
         * Draws the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param align (optional) The align value of the pen.
         */
        public override function draw( ...args:Array ):void 
        {
            if ( args.length > 0 ) 
            {
                setPen.apply( this , args ) ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            _graphics.drawRect( _x , _y , width , height ) ;
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param align (optional) The align value of the pen.
         */
        public function setPen( ...args:Array  ):void 
        {
            if ( args[0] != null && args[0] is Number )
            {
                this.x = isNaN( args[0] ) ? 0 : args[0] ;
            }
            if ( args[1] != null && args[1] is Number )
            {
                this.y = isNaN( args[1] ) ? 0 : args[1] ;
            }
            if ( args[2] != null && args[2] is Number )
            {
                this.width = isNaN( args[2] ) ? 0 : args[2] ;
            }
            if ( args[3] != null && args[3] is Number )
            {
                this.height = isNaN( args[3] ) ? 0 : args[3] ;
            }
            if ( args[4] != null )
            {
                this.align = args[4] ;
            }
        }
        
        /**
         * The offset x position of the rectangle with the align transformation.
         */
        hack var _x:Number ;
        
        /**
         * The offset y position of the rectangle with the align transformation.
         */
        hack var _y:Number ;
        
        /**
         * Invoked to refresh the offset x and y position defines by the align property.
         */
        protected function _refreshAlign():void
        {
            _x = x ;
            _y = y ;
            if( align == Align.BOTTOM ) 
            {
                _x -= width / 2 ;
                _y -= height ;
            }
            else if ( align == Align.BOTTOM_LEFT )
            {
                _y -= height ;
            }
            else if ( align == Align.BOTTOM_RIGHT )
            {
                _x -= width ;
                _y -= height ;
            }
            else if ( align == Align.CENTER )
            {
                _x -= width / 2 ;
                _y -= height / 2 ;
            }
            else if ( align == Align.LEFT )
            {
                _y -= height / 2 ;
            }
            else if ( align == Align.RIGHT )
            {
                _x -= width ;
                _y -= height / 2 ;
            }
            else if ( align == Align.TOP )
            {
                _x -= width / 2 ;
            }
            else if ( align == Align.TOP_RIGHT )
            {
                _x -= width ;
            }
            else // Align.TOP_LEFT
            {
                //
            }
        }
    }
}
