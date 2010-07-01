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
    /**
     * The enumeration of all codes notify in a Connection when this status is changed.
     */
    public class ConnectionCode
    {
        /**
         * Packet encoded in an unidentified format.
         */ 
        public static const CALL_BAD_VERSION:String = "NetConnection.Call.BadVersion" ;
        
        /**
         * The NetConnection.call method was not able to invoke the server-side method or command.
         */ 
        public static const CALL_FAILED:String = "NetConnection.Call.Failed" ;
        
        /**
         * An Action Message Format (AMF) operation is prevented for security reasons. 
         * Either the AMF URL is not in the same domain as the file containing the code calling the NetConnection.call() method, 
         * or the AMF server does not have a policy file that trusts the domain of the the file containing the code calling 
         * the NetConnection.call() method.
         */
        public static const CALL_PROHIBITED:String =  "NetConnection.Call.Prohibited" ;
        
        /**
         * The connection was closed successfully.
         */
        public static const CONNECT_CLOSED:String =  "NetConnection.Connect.Closed" ;
        
        /**
         * The connection attempt failed.
         */
        public static const CONNECT_FAILED:String =  "NetConnection.Connect.Failed" ;
        
        /**
         * The application name specified during connect is invalid.
         */
        public static const CONNECT_INVALID_APP:String =  "NetConnection.Connect.InvalidApp";
        
        /**
         * The connection attempt did not have permission to access the application.
         */
        public static const CONNECT_REJECTED:String =  "NetConnection.Connect.Rejected" ;
        
        /**
         * The specified application is shutting down.
         */
        public static const CONNECT_SHUTDOWN:String =  "NetConnection.Connect.AppShutdown" ;
       
        /**
         * The connection attempt succeeded.
         */
        public static const CONNECT_SUCCESS:String =  "NetConnection.Connect.Success" ;
    }
}