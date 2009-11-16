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
package asgard.filters 
{
    import asgard.filters.ShaderCustomFilter;
    
    import flash.display.Shader;
    
    /**
     * The SharpenFilter class applies a sharpen effect over a picture. 
     * The Shader must be defines with the Sharpen pixelbender implementation.
     */
    public class SharpenFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new SharpenFilter instance.
         * @param shader The Shader reference with the Sharpen pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function SharpenFilter(shader:Shader, init:Object = null)
        {
            super( shader , init ) ;
        }
        
        /**
         * The amount value of the sharpen filter (between 0 and 100).
         */
        public function get amount():Number
        {
            return shader.data.amount.value[0] ;
        }
        
        /**
         * @private
         */
        public function set amount( value:Number ):void
        {
            shader.data.amount.value[0] = value ;
        }
        
        /**
         * The radius value of the sharpen filter (between 0 and 1).
         */
        public function get radius():Number
        {
            return shader.data.radius.value[0] ;
        }
        
        /**
         * @private
         */
        public function set radius( value:Number ):void
        {
            shader.data.radius.value[0] = value ;
        }
    }
}
