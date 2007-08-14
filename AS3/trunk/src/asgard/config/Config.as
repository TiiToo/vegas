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

// TODO : ajouter proxy ??
// TODO : voir pour le protect Config.

package asgard.config
{
	import vegas.core.CoreObject;
	import vegas.core.IFormattable;
	import vegas.data.map.HashMap;
	import vegas.util.ClassUtil;
	
	/**
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
	    static protected var instances:HashMap = new HashMap() ;

        /**
         * clear all configs in the global map.
         */
       	static public function clear():void 
       	{
	    	instances.clear() ;
	    }

        /**
         * Returns 'true' if the Config map contains the key "name".
         */
	    static public function contains( name:String ):Boolean
	    {
	        
	        return instances.containsKey(name) ;
	        
	    }
	    
        /**
         * Returns a singleton.
         */
	   	static public function getInstance( name:String="" ):Config
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
	   	static public function removeInstance( name:String ):Boolean 
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
	    
	    override public function toString():String
	    {
	        return "[" + ClassUtil.getName(this) + "]" ;
	    }
	
    }
    
}