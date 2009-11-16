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
    import flash.geom.Point;
    
    /**
     * The HoleFilter class applies a hole mask over a display or a bitmap. 
     * The Shader must be defines with the Hole pixelbender implementation.
     */
    public class TwirlFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new TwirlFilter instance.
         * @param shader The Shader reference with the Twirl pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function TwirlFilter(shader:Shader, init:Object = null)
        {
            super( shader , init ) ;
        }
        
        /**
         * The angle in degrees of the twirl filter.
         */
        public function get angle():Number
        {
            return shader.data.angle.value[0] ;
        }
        
        /**
         * @private
         */
        public function set angle( value:Number ):void
        {
            shader.data.angle.value[0] = value ;
        }
        
        /**
         * The center of the twirl filter.
         */
        public function get center():Point
        {
            var p:* = shader.data.center.value ;
            return new Point( p[0] , p[1] ) ;
        }
        
        /**
         * @private
         */
        public function set center( p:Point ):void
        {
            shader.data.center.value[0] = p.x ;
            shader.data.center.value[1] = p.y ;
        }
        
        /**
         * The gaussian flag indicates if a gaussian calcul is used to defines the filter or not.
         */
        public function get gaussian():Boolean
        {
            return shader.data.gaussian.value[0] == 1 ;
        }
        
        /**
         * @private
         */
        public function set gaussian( b:Boolean ):void
        {
            shader.data.gaussian.value[0] = b ? 1 : 0 ;
        }
        
        /**
         * The radius of the twirl filter.
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
