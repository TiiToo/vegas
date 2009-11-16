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
	import flash.errors.IllegalOperationError;
    import flash.display.Shader;
    import flash.display.ShaderData;
    import flash.filters.ShaderFilter;

    /**
     * The ShaderCustomFilter class applies a filter by executing a custom shader on the object being filtered. 
     * The Shader must be defines with the custom pixelbender implementation.
     */
    public class ShaderCustomFilter extends ShaderFilter
    {
        /**
         * Creates a new ShaderCustomFilter instance.
         * @param shader The Shader reference with a custom pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function ShaderCustomFilter( shader:Shader , init:Object = null )
        {
            super( shader ) ;
            if ( init != null )
            {
                for ( var prop:String in init )
                {
                    this[prop] = init[prop] ;
                }
            }
        }
        
        /**
         * The description of the filter (defines in the Shader).
         */
        public function get description():String
        {
            return _description ;
        }
        
        /**
         * The name of the filter (defines in the Shader).
         */
        public function get name():String
        {
            return _name ;
        }
        
        /**
         * The namespace of the filter (defines in the Shader).
         */
        public function get namespace():String
        {
            return _namespace ;
        }
        
        /**
         * @private
         */
        public override function set shader( shader:Shader ):void
        {
            if ( shader == null )
            {
                throw new IllegalOperationError(this + " the shader of this filter not must be null.") ;
            }
            super.shader = shader ;
            var data:ShaderData = shader.data ;
            _description = data["description"] ;
            _name        = data["name"] ;
            _namespace   = data["namespace"] ;
            _version     = data["version"]  ;
        }
        
        /**
         * The version of the filter (defines in the Shader).
         */
        public function get version():String
        {
            return _version ;
        }
        
        /**
         * @private
         */
        private var _description:String ;
        
        /**
         * @private
         */
        private var _name:String ;
        
        /**
         * @private
         */
        private var _namespace:String ;
        
        /**
         * @private
         */
        private var _version:String ;
    }
}
