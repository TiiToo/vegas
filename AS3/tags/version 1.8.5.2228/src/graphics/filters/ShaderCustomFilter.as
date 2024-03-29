﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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

package graphics.filters 
{
    import flash.display.Shader;
    import flash.display.ShaderData;
    import flash.errors.IllegalOperationError;
    import flash.filters.BitmapFilter;
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
        public function ShaderCustomFilter( shader:Shader = null , init:Object = null )
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
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new ShaderCustomFilter( shader ) ;
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
