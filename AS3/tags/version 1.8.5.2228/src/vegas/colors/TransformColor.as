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
     * Transformation class to modify the filters on a Color object with Photoshop filters.
     */
    public class TransformColor extends Color 
    {
        /**
         * Creates a new LightColor instance.
         * @param display a DisplayObject reference.
         */
        public function TransformColor(display:DisplayObject)
        {
            super( display );
        }
        
        /**
         * Corresponding a filter in mode "addition" in photoshop over a display object. 
         */
        public function addition(n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ( { rb:o.r , gb:o.g , bb:o.b });
        }
        
        /**
         * Corresponding a filter in mode "colorDodge" in photoshop over a display object. 
         */
        public function colorDodge(n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ ra:_dodge(o.r) , ga:_dodge(o.g) , ba:_dodge(o.b) } );
        }
        
        /**
         * Corresponding a filter in mode "difference" in photoshop over a display object. 
         */
        public function difference (n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ( { rb:-o.r , gb:-o.g , bb:-o.b });
        }
        
        /**
         * Corresponding a filter in mode "divide" in photoshop over a display object. 
         */
        public function divide(n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ ra:_div(o.r) , ga:_div(o.g) , ba:_div(o.b) } );
        }
            
        /**
         * Corresponding a filter in mode "linearBurn" in photoshop over a display object. 
         */
        public function linearBurn (n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ rb:o.r - 255 , gb:o.g-255, bb:o.b-255 });
        }
        
        /**
         * Corresponding a filter in mode "linearDodge" in photoshop over a display object. 
         */
        public function linearDodge (n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ rb:o.r , gb:o.g, bb:o.b });
        }
            
        /**
         * Corresponding a filter in mode "multiply" in photoshop over a display object. 
         */
        public function multiply(n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ ra:o.r/2.55 , ga:o.g/2.55 , ba:o.b/2.55 });
        }
        
        /**
         * Corresponding a filter in mode "negative" in photoshop over a display object. 
         */
        public function negative (n:Number):void 
        {
            setTransform ({ ra:-100, ga:-100, ba:-100, rb:255, gb:255, bb:255 });
        }
            
        /**
         * Corresponding a filter in mode "screen" in photoshop over a display object. 
         */
        public function screen (n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ ra:_scr(o.r), ga:_scr(o.g), ba:_scr(o.b), rb:o.r, gb:o.g, bb:o.b } );
        }
        
        /**
         * Corresponding a filter in mode "substraction" in photoshop over a movieclip. 
         */
        public function substraction (n:Number):void 
        {
            var o:RGB = RGB.fromNumber(n) ;
            setTransform ({ ra:-100, ga:-100, ba:-100, rb:o.r, gb:o.g, bb:o.b } );
        }
        
        /**
         * @private
          */
        private function _div(n:Number):Number 
        {
            return 100 / ( (n + 1) /256 ) ;
        }
        
        /**
         * @private
         */
        private function _dodge(n:Number):Number 
        {
            return 100 / ((258 - n) / 256);
        }
            
        /**
         * @private
         */
        private function _scr(n:Number):Number 
        {
            return 100 * (255 - n) / 255;
        }
    }
}