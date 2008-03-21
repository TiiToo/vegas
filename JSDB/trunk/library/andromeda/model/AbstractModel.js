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
 * This class provides a skeletal implementation of the {@code IModel} interface, 
 * to minimize the effort required to implement this interface.
 */
if ( andromeda.model.AbstractModel == undefined) 
{

	/**
	 * @requires andromeda.model.IModel
	 */
	require("andromeda.model.IModel") ;

	/**
	 * Creates a new AbstractModel instance.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	andromeda.model.AbstractModel = function ( id , bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		andromeda.model.IModel.call(this, bGlobal, sChannel ) ; // super
		this.setID( id ) ;
	}

	/**
	 * @extends andromeda.model.IModel
	 */
	proto = andromeda.model.AbstractModel.extend( andromeda.model.IModel ) ;

	/**
	 * Returns the id of this IModel .
	 * @return the id of this IModel .
	 */
	proto.getID = function() 
	{
		return this._id ;	
	}

	/**
	 * Run the first process with this model.
	 * Overrides this method if you want implement a command process.
	 */
	proto.run = function() /*Void*/ 
	{
		//
	}

	/**
	 * Sets the id of this IModel .
	 */
	proto.setID = function( id ) /*void*/ 
	{
		this._setID( id || this.hashCode() ) ;
	}
	
	/**
	 * The internal id property of this IModelObject. By default the id equals the hashCode() value.
	 */
	proto._id = null ;
	
	/**
	 * The internal flag to indicate if the model is global. 
	 */
	proto._isGlobal = true ;

	/**
	 * Internal method to register the IModel in the ModelCollector with the specified id in argument.
	 * @see ModelCollector.
	 */
	proto._setID = function( id ) /*void*/ 
	{
		var collector = andromeda.model.ModelCollector ;
		if ( collector.contains( this._id ) )
		{
			collector.remove( this._id ) ;
		}
		this._id = id ;
		collector.insert ( this._id, this ) ;
	}
	
	/**
	 * Returns the {@code id} of this IModelObject.
	 * @return the {@code id} of this IModelObject.
	 */
	proto.__defineGetter__( "id", proto.getID ) ;
	proto.__defineSetter__( "id", proto.setID ) ;

	// encapsulate

	delete proto ;
	
}