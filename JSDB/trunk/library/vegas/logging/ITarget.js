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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * All logger target implementations within the logging framework must implement this interface.
 * @author eKameleon
 */
if (vegas.logging.ITarget == undefined) 
{

	/**
	 * @requires vegas.events.EventListener
	 */
	require("vegas.events.EventListener") ;
	
	/**
	 * Creates a new ITarget instance.
	 */
	vegas.logging.ITarget = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.events.EventListener
	 */
	vegas.logging.ITarget.extend( vegas.events.EventListener ) ;
	
	/**
	 * In addition to the level setting, filters are used to provide a pseudo hierarchical mapping for processing only those events for a given category.
	 */
	vegas.logging.ITarget.prototype.filters /*Array*/ = null ;

	/**
	 * Provides access to the level this target is currently set at.
	 */
	vegas.logging.ITarget.prototype.level /*Number*/ = null ;
	
	/**
	 * Sets up this target with the specified logger.
	 * Note : this method is called by the framework and should not be called by the developer.
	 */
	vegas.logging.ITarget.prototype.addLogger = function ( logger /*ILogger*/ ) /*void*/ 
	{
		//
	}
	
	/**
	 * Stops this target from receiving events from the specified logger.
	 * Note : this method is called by the framework and should not be called by the developer.
	 */
	vegas.logging.ITarget.prototype.removeLogger = function ( logger /*ILogger*/ ) /*void*/ 
	{
		//
	}

	
}