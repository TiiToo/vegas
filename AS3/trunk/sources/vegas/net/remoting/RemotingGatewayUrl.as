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
    import system.Strings;
    
    import vegas.net.FlashVars;
    
    /**
     * This factory build the gateway url of the services of this application.
     */
    public class RemotingGatewayUrl
    {
        /**
         * Creates a new RemotingGatewayUrl instance.
         * @param flashVars The optional FlashVars reference who can contains the gatewayUrl and httpHostName values.
         */
        public function RemotingGatewayUrl( flashVars:FlashVars = null )
        {
            this.flashVars = flashVars ;
        }
        
        /**
         * The optional FlashVars reference.
         */
        public var flashVars:FlashVars ;
        
        /**
         * The name "gatewayUrl" of the flashVars passed-in. 
         */
        public var gatewayUrlName:String = "gatewayUrl" ;
        
        /**
         * The name "httpHost" of the flashVars passed-in. 
         */
        public var httpHostName:String = "httpHost" ;
        
        /**
         * Creates the url with the specified parameters.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var factory:RemotingGatewayUrl = new RemotingGatewayUrl( root ) ; // root is the reference of the Main class of the application
         * var url:String = factory.create("http://{0}/php/gateway.php", "localhost" ) ;
         * trace(url) ; // http://localhost/php/gateway.php
         * </pre>
         */
        public function create( gatewayUrl:String=null , httpHost:String=null ):String
        {
            if ( flashVars && flashVars.contains( gatewayUrlName ) )
            {
                gatewayUrl = flashVars.getValue( gatewayUrlName ) ;
            }
            if ( flashVars && flashVars.contains( httpHostName ) )
            {
                httpHost = flashVars.getValue( httpHostName ) ;
            }
            return Strings.format( gatewayUrl, httpHost ) ;
        }
    }
}

