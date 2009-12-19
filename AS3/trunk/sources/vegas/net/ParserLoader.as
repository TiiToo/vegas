/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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

package vegas.net
{
    import system.Serializer;
    
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    
    /**
     * This loader use a parse external data and deserialize it. 
     */
    public class ParserLoader extends URLLoader
    {
        /**
         * Creates a new ParserLoader instance.
         * @param request The URLRequest of the file to load.
         */ 
        public function ParserLoader( request:URLRequest=null )
        {
            super( request );
            addEventListener( Event.COMPLETE, complete ) ;
        }
        
        /**
         * Use a Sserializer object to deserialize the external data if this property is <code class='prettyprint'>true</code>.
         */
        public var isDeserialize:Boolean = true ;
        
        /**
         * Indicates the Serializer object use to deserialize the external datas.
         */
        public function get serializer():Serializer
        {
            return _serializer ;
        }
        
        /**
         * @private
         */
        public function set serializer( serializer:Serializer ):void
        {
            _serializer = serializer ;
        }
        
        /**
         * Invoked when the loader process is complete to parse the datas.
         */
        protected function complete(e:Event):void
        {
            switch (dataFormat) 
            {
                case URLLoaderDataFormat.TEXT :
                {
                    if ( serializer != null && isDeserialize )
                    {
                        data = serializer.deserialize(data) ;
                    }
                    
                    break ;
                }
                case URLLoaderDataFormat.VARIABLES :
                {
                    data = new URLVariables(data) ;
                    if ( serializer != null && isDeserialize )
                    {
                        for (var prop:String in data)
                        {
                            data[prop] = serializer.deserialize( data[prop] ) ;
                        }
                    }
                    break ;
                }
                case URLLoaderDataFormat.BINARY :
                default :
                {
                    //
                    break ;
                }
            }
        }
        
        /**
         * @private
         */
        private var _serializer:Serializer ;
    }
}