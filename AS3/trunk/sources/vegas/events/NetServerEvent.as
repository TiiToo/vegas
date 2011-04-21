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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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

package vegas.events
{
    import system.events.BasicEvent;
    
    import vegas.net.NetServerConnection;
    import vegas.net.NetServerInfo;
    import vegas.net.NetServerStatus;
    
    import flash.events.Event;
    
    /**
     * This is invoked in a NetServerConnection object during a connection with a server.
     */    
    public class NetServerEvent extends BasicEvent
    {
        /**
         * Creates a new NetServerEvent instance.
         * @param type the string type of the instance.
         * @param connection The NetServerConnection reference of this event.
         * @param status The NetServerStatus reference of this event.
         * @param info The information object of the event (NetServerInfo or generic object).
         */
        public function NetServerEvent( type:String, connection:NetServerConnection=null, status:NetServerStatus=null, info:* = null )
        {
            super(type) ;
            this.connection = connection ;
            this.info       = info ;
            this.status     = status ;
        }
        
        /**
         * The name of the NetServerEvent when the connection is accepted.
         */
        public static const ACCEPT:String = "accept" ;
        
        /**
         * The name of the NetServerEvent when the connection is closed.
         */
        public static const CLOSE:String = "close" ;
        
        /**
         * The name of the NetServerEvent when the connection is rejected.
         */
        public static const REJECT:String = "reject" ;
        
        /**
         * Indicates the NetServerConnection target of this event.
         */
        public function get connection():NetServerConnection
        {
            return _connection ;
        }
        
        /**
         * @private
         */
        public function set connection( connection:NetServerConnection ):void
        {
            _connection = connection ;
        }
        
        /**
         * Indicates the NetServerInfo reference of this event.
         */
        public function get info():* 
        {
            return _info ;
        }
        
        /**
         * @private
         */
        public function set info( info:* ):void 
        {
            if (info is NetServerInfo) 
            {
                _info = info ;
            } 
            else if ( info is Object ) 
            {
                _info = new NetServerInfo(info) ;
            }     
            else
            {
                _info = null ;
            }
        }
        
        /**
         * Indicates the NetServerStatus reference of this event.
         */
        public function get status():NetServerStatus 
        {
            return _status ;
        }
            
        /**
         * @private
         */
        public function set status(status:NetServerStatus):void 
        {
            _status = NetServerStatus.validate(status) ? status : null ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new NetServerEvent( type , connection, status, info ) ;
        }
        
        /**
         * @private
         */
        private var _connection:NetServerConnection ;
        
        /**
         * @private
         */
        private var _status:NetServerStatus ;
        
        /**
         * @private
         */
        private var _info:NetServerInfo ;
    }
}