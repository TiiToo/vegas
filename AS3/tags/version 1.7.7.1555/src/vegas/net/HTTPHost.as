/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    import system.eden;
    
    /**
     * Holds all of the variables needed to describe an HTTP connection to a host. 
     * This includes remote host name, port and scheme.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.net.HTTPHost ;
     * 
     * var h:HTTPHost ;
     * 
     * h = new HTTPHost("localhost") ;
     * trace(h) ;     * 
     * 
     * h = new HTTPHost("127.0.0.1", 80, "https") ;
     * trace(h) ;
     * </pre>
     */
    public class HTTPHost implements Cloneable, Equatable, Serializable
    {
        /**
         * Creates a new HTTPHost instance.
         * @param host the host name (IP or DNS name). The host name is always normalized to lower case.
         * @param port the port number. <code class="prettyprint">-1</code> indicates the scheme default port.
         * @param scheme the name of the scheme. <code class="prettyprint">null</code> indicates the {@link #DEFAULT_SCHEME_NAME default scheme}.
         */
        public function HTTPHost( host:String , port:int=-1 , scheme:String = null )
        {
            if ( host == null )
            {
                throw new ArgumentError("HTTPHost failed, host name may not be null.") ;
            }
            this.host   = host   ;
            this.scheme = scheme ;
            this.port   = port   ;
        }
        
        /**
         * The default scheme is "http".
         */
        public static var DEFAULT_SCHEME_NAME:String = "http" ;
        
        /**
         * Determinates the host name. The host name is always normalized to lower case.
         */
        public function get host():String
        {
            return _host ;
        }
        
        /**
         * @private
         */
        public function set host( value:String ):void
        {
            if ( value  == null )
            {
                throw new Error("HTTPHost failed, host name may not be null.") ;
            }
            _host = value.toLowerCase() ;
        }
        
        /**
         * Determinates the port value. <code class="prettyprint">-1</code> indicates the scheme default port.
         */
        public function get port():int
        {
            return _port ;
        }
        
        /**
         * @private
         */
        public function set port( value:int ):void
        {
            _port = value ;
        }         
        
        /**
         * Determinates the scheme name. <code class="prettyprint">null</code> indicates the {@link #DEFAULT_SCHEME_NAME default scheme}.
         */
        public function get scheme():String
        {
            return _scheme ;
        }  
        
        /**
         * @private
         */
        public function set scheme( value:String ):void
        {
            _scheme = ( value != null ) ? value.toLowerCase() :DEFAULT_SCHEME_NAME ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new HTTPHost( _host , _port , _scheme ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals(o:*):Boolean
        {
            if ( o == null )
            {
                return false ;
            }
            if ( this == o )
            {
                return true ;
            }
            if ( o is HTTPHost )
            {
                var hh:HTTPHost = o as HTTPHost ;
                return hh.host == _host && hh.port == _port && hh.scheme == _scheme ;
            }
            return false ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            return "new vegas.net.HTTPHost(" + eden.serialize(_host) + "," + eden.serialize(_port) + "," + eden.serialize(_scheme) + ")" ;
        }
        
        /**
         * Returns a string containing a concise, human-readable description of the receiver.
         * @return a string containing a concise, human-readable description of the receiver.
         */
        public function toString():String
        {
            return toURI() ;
        }
        
        /**
         * Returns the host URI, as a string.
         * @return the host URI, as a string.
         */
        public function toURI():String
        {
            var str:String = _scheme + "://" + _host ;
            if (this.port != -1) 
            {
                str += ":" + _port ;
            }
            return str ;
        }
        
        /**
         * The host to use.
         * @private
         */
        protected var _host:String ;
        
        /**
         * The port to use.
         * @private
         */
        protected var _port:int ;
        
        /**
         * The scheme.
         * @private
         */
        protected var _scheme:String ;
    }
}
