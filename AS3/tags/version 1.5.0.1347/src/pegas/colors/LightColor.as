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

package pegas.colors 
{
    import flash.display.DisplayObject;
    
    /**
     * This class is the basic extension of the actionscript Color class to changed light and contrast over a MovieClip. 
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.colors.LightColor;
     * var c:LightColor = new LightColor( display ) ; 
     * c.brightness     = 255 ;
     * </pre>
     */
    public class LightColor extends Color 
    {
        /**
         * Creates a new LightColor instance.
         * @param display a DisplayObject reference.
         */
        public function LightColor( display:DisplayObject )
        {
            super( display );
        }
        
        /**
         * Indicates the bright between 0 and 100 of the DisplayObject.
         */
        public function get brightness():Number 
        {
            var t:Object = getTransform();
            return t.rb ? 100-t.ra : t.ra-100;
        }
        
        /**
         * @private
         */
        public function set brightness(n:Number):void 
        {
            var t:Object = getTransform() ;
            t.ra = t.ga = t.ba = 100 - Math.abs (n) ;
            t.rb = t.gb = t.bb = (n > 0) ? (n*2.56) : 0 ;
            setTransform (t);
        }
        
        /**
         * Indicates the bright between -255 and 255 of the DisplayObject.
         */
        public function get brightOffset():Number 
        { 
            return getTransform().rb ;
        }
        
        /**
         * @private
         */
        public function set brightOffset(n:Number):void 
        {
            var t:Object = getTransform();
            t.rb = t.gb = t.bb = n ;
            setTransform (t);
        }
        
        /**
         * Indicates the contrast value (percent) of the DisplayObject.
         */
        public function get contrast():Number 
        {
            return getTransform().ra ;
        }
        
        /**
         * @private
         */
        public function set contrast(n:Number):void 
        {
            var t:Object = {};
            t.ra = t.ga = t.ba = n ;
            t.rb = t.gb = t.bb = 128 - (128/100 * n);
            setTransform(t);
        }
        
        /**
         * Indicates the negative value of the DisplayObject.
         */
        public function get negative():Number 
        {
            return getTransform().rb * 2.55 ;
        }
        
        /**
         * @private
         */
        public function set negative( n:Number ):void 
        {
            var t:Object = {} ;
            t.ra = t.ga = t.ba = 100 - 2 * n;
            t.rb = t.gb = t.bb = n * (2.55) ;
            setTransform (t);
        }
    }
}
