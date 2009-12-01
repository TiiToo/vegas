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
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    /**
     * This class defines a proxy of the RemotingService class to invoke all methods of the service with a simple method.
     */
    public dynamic class RemotingServiceProxy extends Proxy 
    {
        /**
         * Creates a new RemotingServiceProxy instance.
         */
        public function RemotingServiceProxy( service:RemotingService )
        {
            this.service = service ;
        }
        
        /**
         * The RemotingService reference of this proxy.
         */
        public function get service():RemotingService
        {
            return _service ;
        }
        
        /**
         * @private
         */
        public function set service( service:RemotingService ):void
        {
            _service = service ;
        }
        
        /**
         * Overrides the behavior of an object property that can be called as a function.
         */
        flash_proxy override function callProperty( name:* , ...rest:Array ):*
        {
            _service.methodName = name ;
            _service.params     = rest ;
            _service.run() ;
            return _service ;
        }
        
        /**
         * @private
         */
        protected var _service:RemotingService ;
    }
}
