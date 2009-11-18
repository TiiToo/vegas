/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.display 
{
    import flash.display.Shader;
    import flash.events.Event;
    import flash.filters.ShaderFilter;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;

    /**
     * This loader load an external .pbj file and creates a specific Shader object.
     * @since FlashPlayer 10
     */
    public class ShaderLoader extends URLLoader 
    {
        /**
         * Creates a new ShaderLoader instance.
         * @param shader The Shader reference used in this loader.
         * @param request The URLRequest of this loader to load the external style sheet.
         */ 
        public function ShaderLoader( shader:Shader = null , request:URLRequest = null )
        {
            super(request) ;
            addEventListener( Event.COMPLETE, _complete, false, 99999) ;
            dataFormat = URLLoaderDataFormat.BINARY ;
            _shader    = shader ;
        }
        
        /**
         * Indicates the Shader reference of this loader.
         */
        public function get shader():Shader
        {
            return _shader ;
        }
        
        /**
         * @private
         */
        public function set shader( shader:Shader ):void
        {
            _shader = shader ;
        }
        
        /**
         * Returns a new ShaderFilter of the Shader in this loader.
         */
        public function get shaderFilter():ShaderFilter
        {
            return _shader != null ? new ShaderFilter( _shader ) : null ;
        }
        
        /**
         * Invoked when the loader process is complete to parse the datas.
         */
        private function _complete(e:Event):void
        {
            if ( _shader == null )
            {
                _shader = new Shader() ;
            }
            if ( data is ByteArray )
            {
                _shader.byteCode = data ;
            }
        }
        
        /**
         * @private
         */
        private var _shader:Shader ;
    }
}
