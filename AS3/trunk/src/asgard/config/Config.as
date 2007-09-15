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
	import vegas.core.CoreObject;
	import vegas.core.IFormattable;
	import vegas.data.map.HashMap;
	import vegas.util.ClassUtil;
	
	/**
	 * The dynamic Config singleton. This object is a global reference to register all external properties.
     * @author eKameleon
     */
    dynamic public class Config extends CoreObject implements IFormattable
    {
        
        public function Config()
        {
            super();
        }

	   /**
        * The map who contains all configs.
        */
	    protected static var instances:HashMap = new HashMap() ;

        /**
         * clear all configs in the global map.
         */
       	public static function clear():void 
       	{
	    	instances.clear() ;
	    }

        /**
         * Returns 'true' if the Config map contains the key "name".
         * @return 'true' if the Config map contains the key "name".
         */
	    public static function contains( name:String ):Boolean
	    {
	        
	        return instances.containsKey(name) ;
	        
	    }
	    
        /**
         * Returns a singleton reference of this class.
         * @return a singleton reference of this class.
         */
	   	public static function getInstance( name:String="" ):Config
	   	{
    		
    		if (name == null) 
    		{
    		    return null ;
    		}
    		
	    	if ( ! instances.containsKey(name)) 
	    	{
		    	instances.put( name, new Config() ) ;
    		}
    		
    		return (instances.get(name) as Config ) ;
    		
    	}

        /**
         * Remove a Singleton.
         */
	   	public static function removeInstance( name:String ):Boolean 
	   	{
	    	if ( !instances.containsKey(name) ) 
	    	{
		    	return instances.remove(name) != null ;
		    }
		    else 
		    {
			    return false ;
    		}
	
	    }

    }
    
}