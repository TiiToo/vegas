/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net 
{
    import system.Cloneable;
    import system.Equatable;
    
    import vegas.core.CoreObject;    

    /**
     * @author eKameleon
     */
    public class HTTPHost extends CoreObject implements Cloneable, Equatable
    {
    	
    	/**
    	 * Creates a new HttpHost instance.
    	 * @param name The host to use.
    	 * @param port The port to use.
    	 * @param scheme The scheme.
    	 */
    	public function HTTPHost( hostName:String, port:int , scheme:String )
    	{
        }
        
        /**
         * Indicates the host name.
         */
        public function get hostName():String
        {
            return null ;        	
        }
        
        /**
         * Indicates the port value.
         */
        public function get port():int
        {
            return 0 ;           
        }
        
        /**
         * Indicates the scheme name.
         */
        public function get schemeName():String
        {
            return null ;           
        }        
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */         
        public function clone():*
        {
        	return new HTTPHost( hostName , port , schemeName ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */        
        public function equals(o:*):Boolean
        {
        	return true ;
        }
        
        /**
         * Returns a string containing a concise, human-readable description of the receiver.
         * @return a string containing a concise, human-readable description of the receiver.
         */
        public override function toString():String
        {
            return null ;           
        }        
        
        /**
         * Returns the host URI, as a string.
         * @return the host URI, as a string.
         */
        public function toURI():String
        {
            return null ;        	
        }

    }
}
