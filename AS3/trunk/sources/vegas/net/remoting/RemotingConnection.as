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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.net.remoting
{
    import vegas.net.NetServerConnection;
    
    /**
     * The <code class="prettyprint">RemotingConnection</code> object used in the RemotingService class to connect the client with the server.
     */
    public class RemotingConnection extends NetServerConnection
    {
        /**
         * Creates a new <code class="prettyprint">RemotingConnection</code> instance.
         * @param url the url of the connection.
         */
        public function RemotingConnection( url:String = null )
        {
            if ( url != null )
            {
                this.connect( url );
            }
        }
        
        /**
         * The string value of the amf server debug attribut.
         */
        public static const AMF_SERVER_DEBUG:String = "amf_server_debug" ;
        
        /**
         * The "credentials" constant.
         */
        public static const CREDENTIALS:String = "Credentials" ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():* 
        {
            return new RemotingConnection( uri ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">RemotingConnection</code> reference defines with the specified url representation.
         * @return the <code class="prettyprint">RemotingConnection</code> reference defines with the specified url representation.
         */
        public static function getConnection( url:String ):RemotingConnection 
        {
            if ( url != null && url.length > 0 )
            {
                if ( ! RemotingConnectionCollector.contains( url ) ) 
                {
                    RemotingConnectionCollector.insert( url, new RemotingConnection( url ) );
                }
                return RemotingConnectionCollector.get( url ) ;
            }
            return null ;   
        }
        
        /**
         * Sets the credentials authentification value of this connection.
         * @param authentification The <code class="prettyprint">RemotingAuthentification</code> object to defines the credentials user id and password of the service session.
         */
        public function setCredentials( authentification:RemotingAuthentification = null ):void  
        {
            addHeader( RemotingConnection.CREDENTIALS , false, authentification.toObject() );
        }
        
        /**
         * Start the debug mode of this connection.
         */
        public function startDebug():void
        {
            var debug:Object = 
            {
                amf         : false , 
                error       : true  ,
                trace       : true  ,
                coldfusion  : false , 
                m_debug     : true  ,
                httpheaders : false , 
                amfheaders  : false , 
                recordset   : true
            } ;
            addHeader( RemotingConnection.AMF_SERVER_DEBUG, true, debug ) ;
        }
        
        /**
         * Stop the debug mode of this connection.
         */
        public function stopDebug():void
        {
            addHeader( RemotingConnection.AMF_SERVER_DEBUG, true, undefined) ;
        }
    }
}