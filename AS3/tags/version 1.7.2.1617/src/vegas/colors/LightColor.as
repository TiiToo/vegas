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
    import flash.display.DisplayObject;
    
    /**
     * This class is the basic extension of the actionscript Color class to changed light and contrast over a MovieClip. 
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.colors.LightColor;
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
