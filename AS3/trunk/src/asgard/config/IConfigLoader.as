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

    import asgard.net.IActionLoader ;
    
    /**
     * This interface provides a config loader object.
     */ 
    public interface IConfigLoader extends IActionLoader
    {
    
        /**
         * (Read-only) Returns the config object.
         * @return the config object.
         */
        function get config():Config ;
    
        /**
         * (Read-write) The name of the config file with datas.
         */
        function get fileName():String ;
    	function set fileName( value:String ):void ;
        
        /**
         * (Read-write) The path of the config file with datas.
         */
    	function get path():String ;
        function set path( value:String ):void ;

        /**
         * (Read-write) The suffix of the config file with datas.
         */
    	function get suffix():String ;
	    function set suffix( value:String ):void ;
        
    }
    
}