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

    import system.numeric.Mathematics;

    import flash.display.Shader;

    /**
     * The ReflectionFilter class applies a wave reflection over a display or a bitmap. 
     * The Shader must be defines with the WaveReflection pixelbender implementation.
     */
    public class WaveReflectionFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new WaveReflectionFilter instance.
         * @param shader The Shader reference.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function WaveReflectionFilter(shader:Shader, init:Object = null)
        {
            super( shader , init ) ;
        }
        
        /**
         * The amplitude of the wave reflection (between 0 and 1).
         */
        public function get amplitude():Number
        {
            return shader.data.amplitude.value[0] ;
        }
        
        /**
         * @private
         */
        public function set amplitude( value:Number ):void
        {
            shader.data.amplitude.value[0] = Mathematics.clamp(isNaN(value) ? 0 : value , 0 , 1 ) ;
        }
        
        /**
         * The frequency of the wave reflection (between 0 and 1).
         */
        public function get frequency():Number
        {
            return shader.data.frequency.value[0] ;
        }
        
        /**
         * @private
         */
        public function set frequency( value:Number ):void
        {
            shader.data.frequency.value[0] = Mathematics.clamp(isNaN(value) ? 0 : value , 0 , 1 ) ;
        }
        
        /**
         * The progress component of the wave reflection (between 0 and 1). Specify the value to create the wave effect and animate it.
         */
        public function get progress():Number
        {
            return shader.data.progress.value[0] ;
        }
        
        /**
         * @private
         */
        public function set progress( value:Number ):void
        {
            shader.data.progress.value[0] = Mathematics.clamp(isNaN(value) ? 0 : value , 0 , 1 ) ;
        }
    }
}
