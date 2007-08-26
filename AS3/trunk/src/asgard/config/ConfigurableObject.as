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
	import vegas.errors.Warning;
	
	public class ConfigurableObject extends CoreObject implements IConfigurable
    {
        
        public function ConfigurableObject()
        {
            super();
            isConfigurable = true ;
        }
        
       	public function setup():void
        {
            throw new Warning(this + ".setup(), you must override this method !") ;
        }
    	
    	public function get isConfigurable():Boolean
    	{
    		return _isConfigurable ;
    	}
    	
    	public function set isConfigurable(b:Boolean):void
    	{
    		_isConfigurable = (b == true) ;
    		if (_isConfigurable)
    		{
    			ConfigCollector.insert(this) ;	
    		}
    		else
    		{
    			ConfigCollector.remove(this) ;
    		}
    	}
    	 
    	private var _isConfigurable:Boolean ;
        
    }

}