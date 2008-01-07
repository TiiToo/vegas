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
package asgard.system
{
	import asgard.net.IActionLoader;
	import asgard.system.Localization;	

	/**
     * This interface provides a config loader object.
     */ 
    public interface ILocalizationLoader extends IActionLoader
    {
    
        /**
         * (Read-only) Returns the Localization object.
         * @return the config object.
         */
        function get localization():Localization ;
    
        /**
         * (Read-write) The path of the localization file.
         */
    	function get path():String ;
        function set path( value:String ):void ;

		/**
	 	 * Determinates the prefix value of the localization files.
	 	 */
		function get prefix():String ; 
		function set prefix(s:String):void ; 

        /**
         * (Read-write) The suffix of the localization file.
         */
    	function get suffix():String ;
	    function set suffix( value:String ):void ;
        
        /**
         * Sends and loads data from the specified passed-in lang value (the passed-in argument must be a Lang reference or a valid string).
         * @param lang The localization Lang value.
         */
		function loadLang( lang:* ):void
    }
    
}