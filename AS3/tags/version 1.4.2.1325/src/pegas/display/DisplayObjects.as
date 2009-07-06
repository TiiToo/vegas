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
    import pegas.draw.Align;
    import pegas.geom.AspectRatio;
    
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * The DisplayObject tool class.
     */
    public class DisplayObjects 
    {
        /**
         * Aligns a DisplayObject within specific bounds.
         * @param target The DisplayObject to align.
         * @param bounds The rectangle in which to align the target DisplayObject.
         * @param align The Align value to defines the position of the display in the specified bounds (default Align.TOP_LEFT). 
         * <p>You can use the Align values :</p>
         * <p>bottom : Align.BOTTOM, Align.BOTTOM_LEFT, Align.BOTTOM_RIGHT</p>
         * <p>center : Align.CENTER, Align.CENTER_LEFT, Align.CENTER_RIGHT</p>
         * <p>top    : Align.TOP   , Align.TOP_LEFT   , Align.TOP_RIGHT</p>
         */
        public static function align( target:DisplayObject, bounds:Rectangle, align:Number = 10 ):void
        {   
            var dh:Number = bounds.height - target.height ;
            var dw:Number = bounds.width  - target.width  ;
            switch( align )
            {
                case Align.BOTTOM :
                {
                    target.x = bounds.x + dw / 2 ;
                    target.y = bounds.y + dh ;
                    break ;
                }
                case Align.BOTTOM_LEFT :
                {
                    target.x = bounds.x ;
                    target.y = bounds.y + dh ;
                    break ;
                }
                case Align.BOTTOM_RIGHT :
                {
                    target.x = bounds.x + dw ;
                    target.y = bounds.y + dh ;
                    break ;
                }
                case Align.CENTER :
                {
                    target.x = bounds.x + dw / 2 ;
                    target.y = bounds.y + dh / 2 ;
                    break ;
                }
                case Align.CENTER_LEFT :
                {
                    target.x = bounds.x ;
                    target.y = bounds.y + dh / 2 ;
                    break ;
                }
                case Align.CENTER_RIGHT :
                {
                    target.x = bounds.x + dw ;
                    target.y = bounds.y + dh / 2 ;
                    break ;
                }
                case Align.TOP :
                {
                    target.x = bounds.x + dw / 2 ;
                    target.y = bounds.y ;
                    break ;
                }
                case Align.TOP_RIGHT :
                {
                    target.x = bounds.x + dw ;
                    target.y = bounds.y ;
                    break ;
                }
                case Align.TOP_LEFT  :
                default             :
                {
                    target.x = bounds.x ;
                    target.y = bounds.y ;
                }
            }
        }
        
        /**
         * Converts a point from the local coordinate system of one DisplayObject to the local coordinate system of another DisplayObject.
         * @param point the point to convert
         * @param first The original coordinate display system.
         * @param second The new coordinate display system.
         */
        public static function localToLocal(point:Point, first:DisplayObject, second:DisplayObject ):Point
        {
            point = first.localToGlobal(point) ;
            return second.globalToLocal(point) ;
        }
        
        /**
         * Resizes a DisplayObject to fit into specified bounds such that the aspect ratio of the target's width and height does not change.
         * @param target The DisplayObject to resize.
         * @param width The desired width for the target.
         * @param height The desired height for the target.
         * @param aspectRatio The optional desired aspect ratio (a Number or a AspectRatio object) or <code class=-"prettyprint">true</code> to use the current aspect ratio of the display.
         */
        public static function resize( target:DisplayObject, width:Number, height:Number, aspectRatio:* = null ):void
        {
            if ( aspectRatio == null )
            {
                target.width  = width ;
                target.height = height ;
            }
            else
            {
                var current:Number ;
                if ( aspectRatio is AspectRatio )
                {
                    current = (aspectRatio as AspectRatio).width / (aspectRatio as AspectRatio).height ;
                }
                else if ( aspectRatio is Number && !isNaN(aspectRatio) )
                {
                    current = aspectRatio as Number ; 
                }
                else
                {
                    current = target.width / target.height;
                }
                var bounds:Number = width / height ;
                if( current < bounds )
                {
                    target.width  = Math.floor( height * current ) ;
                    target.height = height;
                }
                else
                {
                    target.width  = width;
                    target.height = Math.floor( width / current );
                }
            }
        }
    }
}
