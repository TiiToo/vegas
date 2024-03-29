/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This collector use a Map to register all IModel in the application.
 * @author eKameleon
 */
if ( andromeda.model.ModelCollector == undefined) 
{

	/**
	 * @requires vegas.data.map.HashMap
	 */
	require("vegas.data.map.HashMap") ;

	/**
	 * Creates a ModelCollector singleton.
	 */	
	andromeda.model.ModelCollector = {} 

	/**
	 * Removes all IModel references in the collector.
	 */
	andromeda.model.ModelCollector.clear = function()
	{
		andromeda.model.ModelCollector._map.clear() ;			
	}

	/**
	 * Returns {@code true} if the collector contains the IModel register with the id passed in argument.
	 * @param id the id of the model register in the model.
	 * @return {@code true} if the collector contains the IModel register with the id passed in argument.
	 */
	andromeda.model.ModelCollector.contains = function( id ) /*Boolean*/ 
	{
		return andromeda.model.ModelCollector._map.containsKey( id ) ;	
	}
	
	/**
	 * Returns {@code true} if the collector contains the IModel passed in argument.
	 * @param model the IModel to search in the model.
	 * @return {@code true} if the collector contains the IModel passed in argument.
	 */
	andromeda.model.ModelCollector.containsModel = function( model /*IModel*/ ) /*Boolean*/
	{
		return andromeda.model.ModelCollector._map.containsValue( model ) ;	
	}
	
	/**
	 * Returns the IModel reference with the name passed in argument.
	 * @return the IModel reference with the name passed in argument.
	 * @throws Warning if the the specified name isn't register in the collector.
	 */
	andromeda.model.ModelCollector.get = function( id ) /*IModel*/ 
	{
		if ( andromeda.model.ModelCollector.contains( id ) == false ) 
		{
			throw new vegas.errors.Warning("[ModelCollector] get(" + id + ") failed. The specified id isn't register in the collector." ) ;
		} ;
		return andromeda.model.ModelCollector._map.get( id ) ;	
	}
	
	/**
	 * Insert a IModel in the collector and indexed it with the string name in the first parameter.
	 * @param id the id key of the model in the collector.
	 * @param model the IModel reference register in the map of the collector.
	 * @return {@code true} if the  specified model is inserted in the model.
	 * @throws Warning if the specified name is already registered in the collector.
	 */
	andromeda.model.ModelCollector.insert = function ( id , model /*IModel*/ ) /*Boolean*/ 
	{
		if ( andromeda.model.ModelCollector.contains(id) ) 
		{
			throw new vegas.errors.Warning( "[ModelCollector] insert method failed. An IModel instance is already registered with '" + id + "' id." ) ;
		} ;
		return andromeda.model.ModelCollector._map.put(id, model) == null ;	
	}
	
	/**
	 * Returns {@code true} if the collector is empty.
	 * @return {@code true} if the collector is empty.
	 */
	andromeda.model.ModelCollector.isEmpty = function() /*Boolean*/ 
	{
		return andromeda.model.ModelCollector._map.isEmpty() ;	
	}

	/**
	 * Removes the IModel in the collector specified by the argument {@code id}. 
	 * @param id the id of the model to unregister in the collector.
	 */
	andromeda.model.ModelCollector.remove = function( id ) /*void*/ 
	{
		andromeda.model.ModelCollector._map.remove( id ) ;
	}

	/**
	 * Returns the number of elements in the collector.
	 * @return the number of elements in the collector.
	 */
	andromeda.model.ModelCollector.size = function() /*Number*/ 
	{
		return andromeda.model.ModelCollector._map.size() ;	
	}

	/**
	 * Internal HashMap of all IModel in the application.
	 */	
	andromeda.model.ModelCollector._map /*HashMap*/ = new vegas.data.map.HashMap() ;
	
}