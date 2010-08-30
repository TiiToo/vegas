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
    import core.maths.clamp;
    
    import flash.display.DisplayObject;
    import flash.geom.ColorTransform;
    
    /**
     * This class is the basic extension of the actionscript Color class to changed light and contrast over a MovieClip. 
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.colors.LightColor;
     * 
     * var c:LightColor = new LightColor( display ) ; 
     * 
     * c.brightness = 255 ;
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
            _ct = _display.transform.colorTransform ; 
            var r:Number = ( _ct.redOffset ? ( 1 - _ct.redMultiplier ) : ( _ct.redMultiplier - 1 ) ) * 100 ;
            _ct = null ;
            return r ;
        }
        
        /**
         * @private
         */
        public function set brightness( n:Number ):void 
        {
            n = isNaN(n) ? 0 : n ;
            n /= 100 ;
            n  = clamp( n , -1 , 1 ) ;
            _ct = _display.transform.colorTransform ;
            _ct.redMultiplier = _ct.greenMultiplier = _ct.blueMultiplier = 1 - Math.abs (n) ;
            _ct.redOffset     = _ct.greenOffset     = _ct.blueOffset     = (n > 0) ? ( n * 256 ) : 0 ;
            _display.transform.colorTransform = _ct ;
            _ct = null ;
        }
        
        /**
         * Indicates the bright between -255 and 255 of the DisplayObject.
         */
        public function get brightOffset():Number 
        { 
            return _display.transform.colorTransform.redOffset ;
        }
        
        /**
         * @private
         */
        public function set brightOffset(n:Number):void 
        {
            n = isNaN(n) ? 0 : n ;
            n  = clamp( n , -255 , 255 ) ;
            _ct = _display.transform.colorTransform ;
            _ct.redOffset  = _ct.greenOffset = _ct.blueOffset = n ;
            _display.transform.colorTransform = _ct ;
            _ct = null ;
        }
        
        /**
         * Indicates the contrast value (percent) of the DisplayObject.
         */
        public function get contrast():Number 
        {
            return _display.transform.colorTransform.redMultiplier * 100 ;
        }
        
        /**
         * @private
         */
        public function set contrast( n:Number ):void 
        {
            n = isNaN(n) ? 0 : n ;
            n /= 100 ;
            n  = clamp( n , -1 , 1 ) ;
            _ct = _display.transform.colorTransform ;
            _ct.redMultiplier = _ct.greenMultiplier = _ct.blueMultiplier = n ;
            _ct.redOffset     = _ct.greenOffset     = _ct.blueOffset     = 128 - ( 128 * n ) ;
            _display.transform.colorTransform = _ct ;
            _ct = null ;
        }
        
        /**
         * Indicates the negative value of the DisplayObject.
         */
        public function get negative():Number 
        {
            return _display.transform.colorTransform.redOffset / 255 * 100 ;
        }
        
        /**
         * @private
         */
        public function set negative( n:Number ):void 
        {
            n = isNaN(n) ? 0 : n ;
            n /= 100 ;
            n  = clamp( n , 0 , 100 ) ;
            _ct = _display.transform.colorTransform ;
            _ct.redMultiplier = _ct.greenMultiplier = _ct.blueMultiplier = 1 - 2 * n ;
            _ct.redOffset     = _ct.greenOffset     = _ct.blueOffset     = n * 255 ;
            _display.transform.colorTransform = _ct ;
            _ct = null ;
        }
        
        /**
         * @private
         */
        private var _ct:ColorTransform ;
    }
}
