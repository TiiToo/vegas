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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package graphics.display 
{
    import flash.display.Shader;
    import flash.events.Event;
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
