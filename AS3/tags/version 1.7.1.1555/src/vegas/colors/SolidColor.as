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
     * Controls the solid color of a Color Object.
     */
    public class SolidColor extends Color 
    {
        /**
         * Creates a new SolidColor instance.
         * @param display a DisplayObject reference.
         */
        public function SolidColor( display:DisplayObject )
        {
            super( display );
        }
        
        /**
         * Returns the blue color value of a Color object.
         * @return the blue color value of a Color object.
         */
        public function get blue():Number 
        {
            return getTransform().bb ;
        }
        
        /**
         * Specifies a blue color value for a Color object.
         */
        public function set blue(n:Number):void 
        {
            var t:Object = getTransform() ;
            setRGB ( RGB.toNumber(t.rb, t.gb, n) ) ;
        }
        
        /**
         * Determinates the blue offset color value of a Color object.
         */
        public function get blueOffset():Number 
        {
            return getTransform().bb ; 
        }
        
        /**
         * @private
         */
        public function set blueOffset( n:Number ):void 
        {
            var t:Object = getTransform() ;
            t.bb = n ; 
            setTransform (t) ;
        }
        
        /**
         * Determinates the blue percentage color value of a Color object.
         */
        public function get bluePercent():Number 
        {
            return getTransform().ba ;
        }
        
        /**
         * @private
         */
        public function set bluePercent( n:Number ):void 
        {
            var t:Object = getTransform();
            t.ba = n ; 
            setTransform (t);
        }
        
        /**
         * Determinates the green color value for a Color object.
         */
        public function get green():Number 
        {
            return getTransform().gb ;
        }
        
        /**
         * @private
         */
        public function set green(n:Number):void 
        {
            var t:Object = getTransform();
            setRGB ( RGB.toNumber(t.rb, n, t.bb) ) ;
        }
        
        /**
         * Determinates the green offset color value of a Color object.
         */
        public function get greenOffset():Number 
        {
            return getTransform().gb ; 
        }
        
        /**
         * @private
         */
        public function set greenOffset(n:Number):void 
        {
            var t:Object = getTransform();
            t.gb = n ; 
            setTransform (t);
        }
        
        /**
         * Returns the green percentage color value of a Color object.
         * @return the green percentage color value of a Color object.
         */
        public function get greenPercent():Number 
        {
            return getTransform().ga ;
        }
        
        /**
         * @private
         */
        public function set greenPercent( n:Number ):void 
        {
            var t:Object = getTransform();
            t.ga = n ; 
            setTransform (t);
        }
        
        /**
         * Returns the red color value of a Color object.
         * @return the red color value of a Color object.
         */
        public function get red():Number 
        {
            return getTransform().rb ; 
        }
        
        /**
         * @private
         */
        public function set red(n:Number):void 
        {
            var t:Object = getTransform();
            setRGB ( RGB.toNumber( n , t.gb , t.bb ) ) ;
        }
        
        /**
         * Returns the red offset percentage color value of a Color object.
         * @return the red offset percentage color value of a Color object.
         */
        public function get redOffset():Number 
        {
            return getTransform().rb ; 
        }
        
        /**
         * Specifies a red offset color value for a Color object.
         */
        public function set redOffset(n:Number):void 
        {
            var t:Object = getTransform() ;
            t.rb = n ; 
            setTransform (t) ;
        }
        
        /**
         * Returns the red percentage color value of a Color object.
         * @return the redn percentage color value of a Color object.
         */
        public function get redPercent():Number 
        {
            return getTransform().ra ; 
        }
        
        /**
         * @private
         */
        public function set redPercent( n:Number ):void 
        {
            var t:Object = getTransform();
            t.ra = n ; 
            setTransform( t ) ; 
        }
        
        /**
         * Specifies an RGB color for a Color object using individual red, green, and blue values.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var color:SolidColor = new SolidColor( display );
         * color.fromRGB( 255 , 0 , 255 ) ;
         * </code>
         * @param r The red color value.
         * @param g The green color value.
         * @param b The blue color value.
         */
        public function fromRGB(r:Number, g:Number, b:Number):void  
        { 
            setRGB( RGB.toNumber(r,g,b) ) ; 
        }
        
        /**
         * Returns the R+G+B values currently in use by the Color object as individual red, green, and blue values.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var color:Color = new Color( display );
         * color.fromRGB( 255 , 0 , 255 ) ;
         * var rgb:RGB = color.toRGB();
         * trace ( rgb );
         * </code>
         */
        public function toRGB():RGB 
        {
            var t:Object = getTransform() ;
            return new RGB( t.rb , t.gb, t.bb ) ;
        }
    }
}
