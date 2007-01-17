/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net.remoting
{
	import vegas.core.CoreObject;
    
    /**
     * @author eKameleon
     */
	public class RemotingAuthentification extends CoreObject
	{
		
		/**
		 * Creates a new RemotingAuthentification instance.
		 */
		public function RemotingAuthentification(id:String=null, pass:String=null)
		{
			userid = id ;
			password = pass ;
		}
	
	    /**
	     * Defines and returns an ID of connection to be used to be connected with the server. 
	     */
		public var userid:String ;

	    /**
	     * Defines and returns a password of connection to be used to be connected with the server. 
	     */
		public var password:String ;
        
        /**
         * Returns the object representation of this instance.
         * @return the object representation of this instance.
         */
		public function toObject():Object
		{
			return { userid : userid , 	password : password } ;
		}
		
	}
}