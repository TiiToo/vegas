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

package vegas.net.remoting 
{
    import vegas.events.RemotingEvent;
    import vegas.net.remoting.RemotingService;
    
    import system.events.ActionEvent;
    
    /**
     * This interface provides a basic event listener for the RemotingService instances.
     * @param service The RemotingService reference of this listener.
     */
    public interface IRemotingServiceListener 
    {
        /**
         * Invoked when the service notify an error.
         */
        function error( e:RemotingEvent ):void ;
        
        /**
         * Invoked when the service notify a fault.
         */
        function fault( e:RemotingEvent ):void ;
        
        /**
         * Invoked when the service process is finished.
         */
        function finish( e:ActionEvent ):void ;
        
        /**
         * Registers the specific remoting service.
         * @return True if the service is registered.
         */
        function registerService( service:RemotingService ):Boolean ;
        
        /**
         * Invoked when the service notify a success.
         */
        function result( e:RemotingEvent ):void ;
        
        /**
         * Invoked when the service process is started.
         */
        function start( e:ActionEvent ):void ;
        
        /**
         * Invoked when the service notify a timeout.
         */
        function timeout( e:ActionEvent ):void ;
        
        /**
         * Unregister the passed-in service.
         * @return True if the service is unregister with success.
         */
        function unregisterService( service:RemotingService ):Boolean ;
    }
}
