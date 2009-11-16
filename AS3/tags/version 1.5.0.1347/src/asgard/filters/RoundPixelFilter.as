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
     * The RoundPixelFilter class applies a filter by executing a shader on the object being filtered. 
     * The Shader must be defines with the RoundPixel pixelbender implementation.
     */
    public class RoundPixelFilter extends ShaderCustomFilter
    {
        /**
         * Creates a new RoundPixelFilter instance.
         * @param shader The Shader reference with the RGBDistort pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function RoundPixelFilter( shader:Shader  , init:Object = null )
        {
            super( shader , init ) ;
        }
        
        /**
         * Indicates the edge alpha level of the rounded pixels (between 0 and 300).
         */
        public function get edge():Number
        {
            return shader.data.edge.value[0] ;
        }
        
        /**
         * @private
         */
        public function set edge( value:Number ):void
        {
            shader.data.edge.value[0] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 300);
        }
        
        /**
         * The space between the centers of the circles (between 1 and 300).
         */
        public function get space():Number
        {
            return shader.data.space.value[0] ;
        }
        
        /**
         * @private
         */
        public function set space( value:Number ):void
        {
            shader.data.space.value[0] = Mathematics.clamp( isNaN( value ) ? 0 : value , 1 , 300) ;
        }
        
        /**
         * The size ratio of the circle pixels (between 0 and 2).
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
            shader.data.size.value[0] = Mathematics.clamp( isNaN(value) ? 0 : value , 0 , 2) ;
        }
    }
}
