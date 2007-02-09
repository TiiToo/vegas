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

import andromeda.events.ModelObjectEvent;
import andromeda.model.AbstractModelObject;
import andromeda.model.IValueObject;

import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.map.HashMap;
import vegas.errors.IllegalArgumentError;
import vegas.errors.Warning;

/**
 * This model use an internal Map to register value objects with a specific key.
 * @author eKameleon
 */
class andromeda.model.map.MapModel extends AbstractModelObject implements Iterable
{

	/**
	 * Creates a new MapModel instance.
	 * @param id the id of this model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	function MapModel( id , bGlobal:Boolean , sChannel:String ) 
	{
		super( id , bGlobal, sChannel ) ;
		setEventTypeADD( ModelObjectEvent.ADD_VO ) ;
		setEventTypeREMOVE( ModelObjectEvent.REMOVE_VO ) ;
		_map = initializeMap() ;
	}

	/**
	 * Inserts a value object in the model.
	 */
	public function addVO( vo:IValueObject ):Void
	{
		if (vo == null)
		{
			throw new IllegalArgumentError( this + " addVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		validate(vo) ;
		if ( !_map.containsKey( vo.getID() ) )
		{
			_map.put( vo.getID() , vo ) ;
			_eAdd.setVO( vo ) ;
			dispatchEvent( _eAdd ) ;
		}
		else
		{
			throw new Warning( this + " addVO method failed, the id passed in argument already register in the model, you must remove this 'id' key before add a noew value object.") ;	
		}
	}
	
	/**
	 * Removes all value objects in the model.
	 */
	public function clear():Void
	{
		super.clear() ;
		_map.clear() ;
	}

	/**
	 * Returns {@code true} if the model contains the specified IValueObject.
	 * @return {@code true} if the model contains the specified IValueObject.
	 */
	public function contains( vo:IValueObject ):Boolean
	{
		return _map.containsValue( vo ) ;
	}
	
	/**
	 * Returns {@code true} if the model contains the specified id key in argument.
	 * @return {@code true} if the model contains the specified id key in argument
	 */
	public function containsByID( id ):Boolean
	{
		return _map.containsKey( id ) ;
	}


	/**
	 * Returns the event name use in the {@code addVO} method.
	 * @return the event name use in the {@code addVO} method.
	 */
	public function getEventTypeADD():String
	{
		return _eAdd.getType() ;
	}
	
	/**
	 * Returns the event name use in the {@code removeVO} method.
	 * @return the event name use in the {@code removeVO} method.
	 */
	public function getEventTypeREMOVE():String
	{
		return _eRemove.getType() ;
	}

	/**
	 * Returns the IValueObject defined by the id passed in argument.
	 * @return the IValueObject defined by the id passed in argument.
	 */
	public function getVO( id ):IValueObject
	{
		return _map.get( id ) ;
	}

	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 */
	/*override*/ public function initEvent():Void
	{
		super.initEvent() ;
		_eAdd    = createNewModelObjectEvent( getEventTypeADD() ) ;
		_eRemove = createNewModelObjectEvent( getEventTypeREMOVE() ) ; 
	}

	/**
	 * Initialize the internal Map instance in the constructor of the class.
	 * You can overrides this method if you want change the default HashMap use in this model.
	 */
	public function initializeMap():Map
	{
		return new HashMap() ;	
	}

	/**
	 * Returns the iterator of this model.
	 * @return the iterator of this model.
	 */
	public function iterator():Iterator
	{
		return _map.iterator() ;	
	}

	/**
	 * Removes a value object in the model.
	 */
	public function removeVO( vo:IValueObject ):Void
	{
		if (vo == null)
		{
			throw new IllegalArgumentError( this + " addVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		validate(vo) ;
		if ( _map.containsKey( vo.getID() ) )
		{
			_map.remove( vo.getID() ) ;
			_eRemove.setVO( vo ) ;
			dispatchEvent( _eRemove ) ;
		}
		else
		{
			throw Warning( this + " addVO method failed, the id passed in argument allready register in the model, you must remove this 'id' key before add a noew value object.") ;	
		}
	}
	
	/**
	 * Sets the event name use in the {@code addVO} method.
	 */
	public function setEventTypeADD( type:String ):Void
	{
		_eAdd.setType( type ) ;
	}
	
	/**
	 * Sets the event name use in the {@code removeVO} method.
	 */
	public function setEventTypeREMOVE( type:String ):Void
	{
		_eRemove.setType( type ) ;
	}

	/**
	 * Returns the number of IValueObject in this model.
	 * @return the number of IValueObject in this model.
	 */
	public function size():Number
	{
		return _map.size() ;
	}

	/**
	 * The internal ModelObjectEvent use in the addVO method.
	 */
	private var _eAdd:ModelObjectEvent ;

	/**
	 * The internal ModelObjectEvent use in the removeVO method.
	 */
	private var _eRemove:ModelObjectEvent ;

	/**
	 * The internal map of this model.
	 */
	private var _map : Object;

}