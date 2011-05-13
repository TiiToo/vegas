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

package vegas.net
{
    import system.events.BasicEvent;
    import system.events.FrontController;
    
    /**
     * The NetSeverGateway create a gateway between the Flash client and the FMS server.
     * @see NetServerConnection
     */
    public class NetServerGateway
    {
        /**
         * Creates a new NetServerGateway instance.
         */
        public function NetServerGateway( connection:NetServerConnection , controller:FrontController ) 
        {
            this.connection = connection ;
            this.controller = controller || initController() ;
        }
        
         /**
         * Returns the NetConnection reference of this instance.
         * @return the NetConnection reference of this instance.
         */
        public function get connection():NetServerConnection
        {
            return _connection ;
        }
        
        /**
         * Set the NetServerGateway controller reference.
         * @param connection The AMF connection reference (NetServerConnection). 
         */
        public function set connection( connection:NetServerConnection ):void
        {
            if (_connection != null)
            {
                _connection.client = null ;
                _connection        = null ;
            }
            
            if ( connection != null )
            {
                _connection = connection ;
                _connection.client = this ;
            }
            
        }
        
        /**
         * Sets the NetServerGateway controller reference.
         */
        public function set controller( controller:FrontController ):void
        {
            _controller = controller ;
        }
        
        /*
         * Returns the FrontController reference of this instance.
         * @return the FrontController reference of this instance.
         */
        public function get controller():FrontController 
        {
            return _controller ;
        }
        
        /**
         * Adds a new entry into the Gateway controller.
         * @param type The type of the event to register in the controller.
         * @param listener The listener reference to register.
         */
        public function add( type:String , listener:* ):void
        {
            _controller.add( type, listener ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the eventName is registered in the Gateway Controller.
         * @param eventName the name of the event type in the internal controller.
         */
        public function contains( eventName:String ):Boolean 
        {
            return _controller.contains(eventName) ;
        }
        
        /**
         * Inits the NetServerGateway controller reference in the constructor of this instance.
         * Overrides this method to customize initial Gateway controller.
         */
        public function initController():FrontController 
        {
            return new FrontController() ;
        }
        
        /**
         * Invoked when the NetServerConnection receive from the server a shared event.
         */
        public function receiveSharedEvent( e:* ):void
        {
            if (_controller != null)
            {
                if ( e is BasicEvent )
                {
                    _controller.fireEvent( e ) ;
                }
                else if ( e is String )
                {
                    _controller.fireEvent( new BasicEvent( e as String  ) ) ;
                }
                else
                {
                    throw new Error(this + " receive a shared event or event type from the server but you can't propagate this event, the object isnt' an Event object or a String.") ;
                }
            }
            else
            {
                throw new Error(this + " receive a shared event or event type from the server but you can't propagate this event with a FrontController 'null' or 'undefined'.") ;    
            }
        }
        
        /**
         * Remove an entry into the Gateway controller.
         * @param type The type to unregister. 
         */
        public function remove( type:String ):void
        {
            _controller.remove( type ) ;
        }
        
        /**
         * @private
         */
        private var _connection:NetServerConnection ;
        
        /**
         * @private
         */
        private var _controller:FrontController ;
    }
}