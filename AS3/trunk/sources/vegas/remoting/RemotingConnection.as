﻿/*

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
package vegas.remoting
{
    import system.Cloneable;
    
    import flash.net.NetConnection;
    
    /**
     * The <code class="prettyprint">RemotingConnection</code> object used in the RemotingService class to connect the client with the server.
     */
    public class RemotingConnection extends NetConnection implements Cloneable
    {
        /**
         * Creates a new <code class="prettyprint">RemotingConnection</code> instance.
         * @param url the optional url to connect the object.
         */
        public function RemotingConnection( url:String = null )
        {
            if ( url != null && url != "" )
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
        public function clone():* 
        {
            return new RemotingConnection( uri ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">RemotingConnection</code> reference defines with the specified url representation.
         * @return the <code class="prettyprint">RemotingConnection</code> reference defines with the specified url representation.
         */
        public static function getConnection( url:String ):RemotingConnection 
        {
            if ( url != null && url != "" )
            {
                if ( !connections.containsConnection( url ) ) 
                {
                    connections.addConnection( url, new RemotingConnection( url ) );
                }
                return connections.getConnection( url ) ;
            }
            return null ;
        }
        
        /**
         * Sets the credentials authentification value of this connection.
         * @param authentification The <code class="prettyprint">RemotingAuthentification</code> object to defines the credentials user id and password of the service session.
         */
        public function setCredentials( authentification:RemotingAuthentification = null ):void  
        {
            if ( authentification )
            {
                addHeader( RemotingConnection.CREDENTIALS , false, authentification.toObject() );
            }
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
        
        /**
         * The connection collector singleton.
         * @private
         */
        protected static const connections:RemotingCollector = new RemotingCollector() ;
    }
}