/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import andromeda.model.IModel;
import andromeda.model.ModelCollector;

import vegas.core.IRunnable;
import vegas.events.AbstractCoreEventDispatcher;
import vegas.events.EventDispatcher;

/**
 * This class provides a skeletal implementation of the {@code IModel} interface, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
class andromeda.model.AbstractModel extends AbstractCoreEventDispatcher implements IModel, IRunnable
{
	
	/**
	 * Creates a new AbstractModel instance.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	function AbstractModel( id , bGlobal:Boolean , sChannel:String ) 
	{
		_setID( id || hashCode() ) ;
		setGlobal( bGlobal , sChannel ) ;
	}

	/**
	 * Returns the {@code id} of this IModelObject.
	 * @return the {@code id} of this IModelObject.
	 */
	public function get id() 
	{
		return getID() ;
	}

	/**
	 * Sets the {@code id} of this IModelObject.
	 */
	public function set id( id ):Void 
	{
		setID( id ) ;
	}
	
	/**
	 * (read-only) Returns the value of the isGlobal flag of this model. Use the {@code setGlobal} method to modify this value.
	 * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	 */
	public function get isGlobal():Boolean 
	{
		return getIsGlobal() ;
	}
	
	/**
	 * Returns the {@code id} of this IModelObject. This method is use to register this object in a category of models.
	 * @return the {@code id} of this IModelObject.
	 */
	public function getID() 
	{
		return _id ;
	}

	/**
	 * Returns the value of the isGlobal flag of this model.
	 * @return {@code true} if the model use a global EventDispatcher to dispatch this events.
	 */
	public function getIsGlobal():Boolean 
	{
		return _isGlobal ;
	}

	/**
	 * Init the EventDispatcher reference of this EventTarget object. 
	 * Uses a global EventDispatcher to used this model with the FrontController of the application.
	 */
	public function initEventDispatcher():EventDispatcher
	{
		return EventDispatcher.getInstance() ;	
	}

	/**
	 * Run the first process with this model.
	 * Overrides this method if you want implement a command process.
	 */
	public function run() : Void 
	{
		//
	}

	/**
	 * Sets the {@code id} of this IModelObject.
	 */
	public function setID( id ):Void 
	{
		_setID( id || hashCode() ) ;
	}

	/**
	 * Sets if the model use a global {@code EventDispatcher} to dispatch this events, if the {@code flag} value is {@code false} the model use a local EventDispatcher.
	 * @param flag the flag to use a global event flow or a local event flow.
	 * @param channel the name of the global event flow if the {@code flag} argument is {@code true}.  
	 */
	public function setGlobal( flag:Boolean , channel:String ):Void 
	{
		_isGlobal = flag ;
		setEventDispatcher( flag ? EventDispatcher.getInstance( channel ) : null ) ;
	}

	/**
	 * The internal id property of this IModelObject. By default the id equals the hashCode() value.
	 */
	private var _id ;
	
	/**
	 * The internal flag to indicate if the 
	 */
	private var _isGlobal ;

	/**
	 * Internal method to register the IModel in the ModelCollector with the specified id in argument.
	 * @see ModelCollector.
	 */
	private function _setID( id ):Void 
	{
		if ( ModelCollector.contains( _id ) )
		{
			ModelCollector.remove( this._id ) ;
		}
		this._id = id ;
		ModelCollector.insert ( this._id, this ) ;
	}

}