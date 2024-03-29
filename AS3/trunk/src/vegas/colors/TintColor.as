﻿/*

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

package vegas.colors 
{
    import graphics.colors.RGB;
    
    import flash.display.DisplayObject;
    
    /**
     * Controls the tint of a Color object.
     */
    public class TintColor extends Color 
    {
        /**
         * Creates a new TintColor instance.
         * @param display a DisplayObject reference.
         */
        public function TintColor( display:DisplayObject )
        {
            super( display );
        }
        
        /**
         * Returns the tint of a Color object.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var color:TintColor = new TintColor(my_mc);
         * color.setTint( 0, 0, 128, 50 ) ;
         * var tint:Object = color.getTint();
         * trace ("r : " + tint.r);
         * trace ("g : " + tint.g);
         * trace ("b : " + tint.b);
         * trace ("percent : " + tint.percent);
         * </pre>
         * @return The tint value object with r, g, b, and percent properties.
         */
        public function getTint():Object 
        {
            var t:Object = getTransform() ;
            var percent:uint = 100 - (t.ra as Number) ;
            var ratio:Number = 100 / percent ;
            return { percent : percent , r : ( t.rb * ratio ) , g : ( t.gb * ratio ) ,     b : ( t.bb * ratio ) } ;
        }
        
        /**
         * Returns the tint of a Color object.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var cTint:TintColor = new TintColor(my_mc);
         * cTint.setTint2( 0x0000FF, 100 ) ;
         * var tint:Object = cTint.getTint2();
         * trace ("rgb     : " + tint.rgb);
         * trace ("percent : " + tint.percent);
         * </pre>
         * @return The tint value object with rgb and percent properties.
         */
        public function getTint2():Object 
        {
            var t:Object = getTransform();
            var percent:Number = 100 - t.ra ;
            var ratio:Number = 100 / percent ;
            return { percent : percent , rgb : RGB.toNumber( t.rb*ratio , t.gb*ratio , t.bb*ratio ) } ;
        }
        
        /**
         * Returns the tint offset of a Color object.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var color:TintColor = new TintColor(my_mc);
         * color.setTintOffset(0, 0, 128);
         * var tint:Object = color.getTintOffset();
         * trace ("r : " + tint.r);
         * trace ("g : " + tint.g);
         * trace ("b : " + tint.b);
         * </pre>
         * @return The tint offset value object with r, g, and b properties.
         */
        public function getTintOffset():Object 
        {    
            var t:Object = getTransform() ;
            return {r:t.rb, g:t.gb, b:t.bb} ;
        }
        
        /**
         * Tints a color object with a Color according to a certain percentage.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var color:TintColor = new TintColor(my_mc);
         * color.setTint( 0, 0, 128, 50 ) ;
         * </pre>
         * @param r The red color value.
         * @param g The green color value.
         * @param b The blue color value.
         * @param percent
         */
        public function setTint(r:Number, g:Number, b:Number, percent:Number):void 
        {
            var ratio:Number = percent / 100;
            var t:Object = { rb:r*ratio, gb:g*ratio, bb:b*ratio } ;
            t.ra = t.ga = t.ba = 100-percent ;
            setTransform (t);
        }
        
        /**
         * Tints a color object with a Color according to a certain percentage.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var color:TintColor = new TintColor(my_mc);
         * color.setTint2( 0x0000FF, 100 ) ;
         * </pre>
         * @param hex The rgb value.
         * @param percent The tint percentage.
         */
        public function setTint2(hex:Number, percent:Number):void 
        {    
            var c:RGB = RGB.fromNumber( hex ) ;
            var ratio:Number = percent / 100 ;
            var t:Object = 
            {
                rb : c.r * ratio , 
                gb : c.g * ratio , 
                bb : c.b * ratio 
            };
            t.ra = t.ga = t.ba = 100 - percent ;
            setTransform (t);
        }
        
        /**
         * Tints a Color object with a color according to red, green, and blue values.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var color:TintColor = new TintColor(my_mc);
         * color.setTintOffset( 0, 0, 128 ) ;
         * </pre>
         * @param r The red color value.
         * @param g The green color value.
         * @param b The blue color value.
         */
        public function setTintOffset(r:Number, g:Number, b:Number):void 
        {
            var t:Object = getTransform();
            t.rb = r ; 
            t.gb = g ; 
            t.bb = b ;
            setTransform (t);
        }
    }
}
