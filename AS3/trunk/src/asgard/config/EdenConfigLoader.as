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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
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
     * @author eKameleon
     */
    public class EdenConfigLoader extends AbstractConfigLoader
    {
        
        // ----o Constructor
        
        public function EdenConfigLoader( name:String="" )
        {

            super(name ) ;
            default_file_name = "config" ;
            default_file_suffix = ".eden" ;
            
        }
    
        public function getEdenProperty( prop:String ):*
        {
            return vegas.string.eden.Config[prop] ;
        }
    
        /**
         * Return the original loader in the constructor. Override this method.
         */ 
        override public function getLoader():URLLoader
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