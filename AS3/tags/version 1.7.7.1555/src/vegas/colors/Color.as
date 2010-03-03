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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
  
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
    import flash.geom.ColorTransform;
    
    /**
     * <code class="prettyprint">Color</code> extends the Color Object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.colors.Color;
     * var c:Color = new Color ( display ); // assuming 'display' is a DisplayObject
     * c.setRGB(0xFF9900);
     * </pre>
     */
    public class Color
    {
        /**
         * Creates a new Color instance.
         * <p><code class="prettyprint"> new BasicColor(mc);</code></p>
         * @param display a DisplayObject reference.
         * @throws ArgumentError if the display argument is null or undefined.
         */
        public function Color( display:DisplayObject )
        {
            if ( display == null )
            {
                throw new ArgumentError( this + " constructor failed, the passed-in DisplayObject must not be null or undefined.") ;
            }
            _display   = display ;
        }
        
        /**
         * The color evaluator singleton reference.
         */
        public static const EVALUATOR:ColorEvaluator = new ColorEvaluator() ;
        
        /**
         * A ColorTransform object containing values that universally adjust the colors in the display object.
         */
        public function get colorTransform():ColorTransform 
        {
            return _display.transform.colorTransform ;
        }
        
        /**
         * @private
         */
        public function set colorTransform( transform:ColorTransform ):void 
        {
            _display.transform.colorTransform = transform ;
        }
        
        /**
         * The DisplayObject reference of this object.
         */
        public function get display():DisplayObject
        {
            return _display ;
        }
        
        /**
         * Indicates the R+G+B combination currently in use by the color object. The rgb property returns a Number but can be defines with a Number, a RGB object or a String color expression.
         * @see setRGB
         */
        public function get rgb():* 
        {
            return getRGB() ;
        }
        
        /**
         * @private
         */
        public function set rgb( hex:* ):void 
        {
            setRGB( hex ) ;
        }
        
        /**
         * Returns the R+G+B combination currently in use by the color object
         * @return A number that represents the RGB numeric value for the color specified.
         */
        public function getRGB():Number 
        {
            return _display.transform.colorTransform.color ;
        }
        
        /**
         * Returns the transform value set by the last setTransform() call.
         * @return An object whose properties contain the current offset and percentage values for the specified color.
         */
        public function getTransform():Object 
        {
            var ct:ColorTransform = _display.transform.colorTransform ;
            return {ra: ct.redMultiplier*100, rb: ct.redOffset, ga: ct.greenMultiplier*100, gb: ct.greenOffset, ba: ct.blueMultiplier*100, bb: ct.blueOffset, aa:ct.alphaMultiplier*100, ab: ct.alphaOffset};
        }
        
        /**
         * Inverts the color of the specified Color reference in argument.
         */
        public function invert():void 
        {
            var t:Object = getTransform();
            setTransform 
            ( 
                {
                    ra : -t.ra      , ga : -t.ga      , ba : -t.ba      ,
                    rb : 255 - t.rb , gb : 255 - t.gb , bb : 255 - t.bb 
                } 
            ) ;
        }
        
        /**
         * Resets the color of the specified Color reference in argument, the MovieClip display the original view since Color transformation.
         */
        public function reset():void 
        { 
            setTransform ( {ra:100, ga:100, ba:100, rb:0, gb:0, bb:0} ) ;
        }
        
        /**
         * Specifies an RGB color for a Color object.
         * @param hex 0xRRGGBB The hexadecimal or RGB color to be set. RR, GG, and BB each consist of two hexadecimal digits that specify the offset of each color component. The 0x tells the ActionScript compiler that the number is a hexadecimal value.
         */
        public function setRGB( hex:* ):void 
        {
            if ( hex is String )
            {
                hex = EVALUATOR.eval( hex as String ) ;
            }
            else if ( hex is RGB )
            {
                hex = (hex as RGB).valueOf() ;
            }
            else if ( hex is Number )
            {
                hex = hex as Number ;
            }
            else
            {
                hex = 0 ;
            }
            var ct:ColorTransform = new ColorTransform();
            ct.color = hex ;
            _display.transform.colorTransform = ct;
        }
        
        /**
         * Sets color transform information for a Color object.
         * The colorTransformObject parameter is a generic object that you create from the new Object constructor. It has parameters specifying the percentage and offset values for the red, green, blue, and alpha (transparency) components of a color, entered in the format 0xRRGGBBAA.
         * @param transformObject An object created with the new Object constructor. This instance of the Object class must have the following properties that specify color transform values: ra, rb, ga, gb, ba, bb, aa, ab. These properties are explained in the above summary for the setTransform() method. 
         */
        public function setTransform( transformObject:Object ):void 
        {
            var t:Object = {ra:100, rb:0, ga:100, gb:0, ba:100, bb:0, aa:100, ab:0};
            for (var p:String in transformObject)
            {
                t[p] = transformObject[p];
            }
            var ct:ColorTransform = new ColorTransform( t.ra/100 , t.ga/100 , t.ba/100 , t.aa/100 , t.rb , t.gb, t.bb, t.ab );
            _display.transform.colorTransform = ct;
        }
        
        /**
         * Returns the string representation of the passed color with ECMAScript formatting (0xrrggbb).
         * @return the string representation of the passed color with ECMAScript formatting (0xrrggbb).
         */
        public function toRGBString():String 
        {
            var str:String = getRGB().toString(16);
            var toFill:Number = 6 - str.length;
            while ( toFill-- ) 
            {
                str = "0" + str ;
            }   
            return str.toUpperCase();
        }
        
        /**
         * @private
         */
        protected var _display:DisplayObject ;
    }
}
