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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.config
{
	import flash.net.URLLoader;
	
	import asgard.config.AbstractConfigLoader;
	import asgard.net.EdenLoader;
	
	import vegas.string.eden.Config;
	
	/**
 	 * The EdenConfigLoader class based on the Eden notation.
     * @author eKameleon
     */
    public class EdenConfigLoader extends AbstractConfigLoader
    {
        
		/**
		 * Creates a new EdenConfigLoader instance.
		 */
        public function EdenConfigLoader()
        {
            super() ;
        }
    
        /**
         * Defines the defaut file name ('config').
         */
    	public var default_file_name:String = "config" ;
        
        /**
         * Defines the defaut file suffix ('.eden').
         */
    	public var default_file_suffix:String = ".eden" ;
    
        public function getEdenProperty( prop:String ):*
        {
            return vegas.string.eden.Config[prop] ;
        }
    
        /**
         * Returns the original loader in the constructor. Override this method.
         */ 
        public override function getLoader():URLLoader
        {
            return (new EdenLoader() as URLLoader) ;
        }

        public function setEdenProperty( prop:String , value:* ):void
        {
            vegas.string.eden.Config[prop] = value ;
        }
        
        public function setSecurity( b:Boolean=true ):void
        {
            vegas.string.eden.Config.security = b ;
        }
  
    }
    
}