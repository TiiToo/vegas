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
package vegas.remoting
{
    import system.data.maps.HashMap;
    
    /**
     * This collector of all singleton remoting connections in the application.
     */
    public class RemotingCollector
    {
        /**
         * Creates a new RemotingCollector instance.
         */
        public function RemotingCollector()
        {
            _map = new HashMap() ;
        }
        
        /**
         * Adds a new RemotingConnection object with a single gateway url. 
         * If the single gateway url is already registered in the collector, the method returns false.
         * @return <code>true</code> if the connection can be registered with the single specific gateway's url.
         */
        public function addConnection( gatewayUrl:String , connection:RemotingConnection ):Boolean
        {
            if ( gatewayUrl != null && gatewayUrl != "" )
            {
                if ( _map.containsKey( gatewayUrl ) )
                {
                    return false ;
                }
                return _map.put( gatewayUrl , connection ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Indicates if the collector contains the specific gatewayUrl.
         * @return <code>true</code> if the specific gatewayUrl is already registered.
         */
        public function containsConnection( gatewayUrl:String ):Boolean
        {
            return _map.containsKey( gatewayUrl ) ;
        }
        
        /**
         * Creates the ObjectResource object with the specified generic object.
         * @param o The object definition to create an ObjectResource instance.
         */
        public function getConnection( gatewayUrl:String ):RemotingConnection
        {
            return _map.get( gatewayUrl ) as RemotingConnection ;
        }
        
        /**
         * Removes the specific connection with the passed-in gateway url or all connections if the passed-in argument is null or empty. 
         * @return <code>true</code> If the Object resource is removed.
         */
        public function removeConnection( gatewayUrl:String = null ):Boolean
        {
            var b:Boolean ;
            if ( gatewayUrl == null || gatewayUrl == "" )
            {
                if ( _map.size() > 0 )
                {
                    _map.clear() ;
                    b = true ;
                }
            }
            else
            {
                b = _map.remove( gatewayUrl ) != null ;
            }
            return b ;
        }
        
        /**
         * @private
         */
        private var _map:HashMap ;
    }
}