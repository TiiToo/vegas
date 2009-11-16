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
    import system.numeric.Mathematics;

    import flash.display.Shader;

    /**
     * The RGBDistortFilter class applies a filter by executing a shader on the object being filtered. 
     * The Shader must be defines with the RGBDistort pixelbender implementation.
     */
    public class RGBDistortFilter extends ShaderCustomFilter
    {
        /**
         * Creates a new RGBDistorFilter instance.
         * @param shader The Shader reference with the RGBDistort pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function RGBDistortFilter( shader:Shader , init:Object = null )
        {
            super( shader , init ) ;
        }
        
        /**
         * Indicates the direction level of the blue component (between -1 and 1).
         */
        public function get blueDirection():Number
        {
            return shader.data.direction.value[2] ;
        }
        
        /**
         * @private
         */
        public function set blueDirection( value:Number ):void
        {
            shader.data.direction.value[2] = Mathematics.clamp( isNaN(value) ? 0 : value , -1 , 1 );
        }
        
        /**
         * Indicates the frequency level of the blue component (between 0 and 1).
         */
        public function get blueFrequency():Number
        {
            return shader.data.frequency.value[2] ;
        }
        
        /**
         * @private
         */
        public function set blueFrequency( value:Number ):void
        {
            shader.data.frequency.value[2] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the intensity level of the blue component (between 0 and 1).
         */
        public function get blueIntensity():Number
        {
            return shader.data.intensity.value[2] ;
        }
        
        /**
         * @private
         */
        public function set blueIntensity( value:Number ):void
        {
            shader.data.intensity.value[2] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the direction level of the green component (between -1 and 1).
         */
        public function get greenDirection():Number
        {
            return shader.data.direction.value[1] ;
        }
        
        /**
         * @private
         */
        public function set greenDirection( value:Number ):void
        {
            shader.data.direction.value[1] = Mathematics.clamp( isNaN(value) ? 0 : value , -1 , 1 );
        }
        
        /**
         * Indicates the frequency level of the green component (between 0 and 1).
         */
        public function get greenFrequency():Number
        {
            return shader.data.frequency.value[1] ;
        }
        
        /**
         * @private
         */
        public function set greenFrequency( value:Number ):void
        {
            shader.data.frequency.value[1] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the intensity level of the green component (between 0 and 1).
         */
        public function get greenIntensity():Number
        {
            return shader.data.intensity.value[1] ;
        }
        
        /**
         * @private
         */
        public function set greenIntensity( value:Number ):void
        {
            shader.data.intensity.value[1] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the direction level of the red component (between -1 and 1).
         */
        public function get redDirection():Number
        {
            return shader.data.direction.value[1] ;
        }
        
        /**
         * @private
         */
        public function set redDirection( value:Number ):void
        {
            shader.data.direction.value[0] = Mathematics.clamp( isNaN(value) ? 0 : value , -1 , 1 );
        }
        
        /**
         * Indicates the frequency level of the red component (between 0 and 1).
         */
        public function get redFrequency():Number
        {
            return shader.data.frequency.value[0] ;
        }
        
        /**
         * @private
         */
        public function set redFrequency( value:Number ):void
        {
            shader.data.frequency.value[0] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the intensity level of the red component (between 0 and 1).
         */
        public function get redIntensity():Number
        {
            return shader.data.intensity.value[0] ;
        }
        
        /**
         * @private
         */
        public function set redIntensity( value:Number ):void
        {
            shader.data.intensity.value[0] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
    }
}
