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
     * The ReflectionFilter class applies a reflection over a display or a bitmap. 
     * The Shader must be defines with the Reflection pixelbender implementation.
     */
    public class ReflectionFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new ReflectionFilter instance.
         * @param shader The Shader reference.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function ReflectionFilter(shader:Shader, init:Object = null)
        {
            super( shader , init ) ;
        }
        
        /**
         * The alpha of the reflection.
         */
        public function get alpha():Number
        {
            return shader.data.alpha.value[0] ;
        }
        
        /**
         * @private
         */
        public function set alpha( value:Number ):void
        {
            shader.data.alpha.value[0] = value ;
        }
        
        /**
         * The height of the reflection.
         */
        public function get height():Number
        {
            return shader.data.height.value[0] ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void
        {
            shader.data.height.value[0] = value ;
        }
        
        /**
         * The size of the reflection.
         */
        public function get size():Number
        {
            return shader.data.size.value[0] ;
        }
        
        /**
         * @private
         */
        public function set size( value:Number ):void
        {
            shader.data.size.value[0] = value ;
        }
    }
}
