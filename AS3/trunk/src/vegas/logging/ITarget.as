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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/


/** ITarget

	AUTHOR

		Name : ITarget
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2006-08-31
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

package vegas.logging
{
    
    public interface ITarget
    {
        
        // ----o Public Properties

        /**
         * In addition to the level setting, filters are used to provide a psuedo-hierarchical mapping for processing only those events for a given category.	
         */
    	function get filters():Array ;
    	function set filters( value:Array ):void ;
	
        /**
         * Provides access to the level this target is currently set at.
         */ 
    	function get level():LogEventLevel ;
    	function set level( value:LogEventLevel ):void ;
	
    	// ----o Public Methods
	
	    /**
	     * Sets up this target with the specified logger.
	     */
    	function addLogger(logger:ILogger):void ;
		
		/**
	     * Stops this target from receiving events from the specified logger.
	     */
    	function removeLogger(logger:ILogger):void ;
        
    }
    
}