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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
 */

import andromeda.events.ModelObjectEvent;
import andromeda.model.AbstractModelObject;
import andromeda.vo.IValueObject;

import vegas.data.Map;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
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
	 * @param sChannel (optional) the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	function MapModel( id , bGlobal:Boolean , sChannel:String ) 
	{
		super( id , bGlobal, sChannel ) ;
		_map = initializeMap() ;
	}

	/**
	 * Inserts a value object in the model.
	 * @throws IllegalArgumentError if the argument of this method is 'null' or 'undefined'. 
	 * @throws Warning if the {@code IValueObject} passed in argument is already register in the model.
	 */
	public function addVO( vo:IValueObject ):Void
	{
		if (vo == null)
		{
			throw new IllegalArgumentError( this + " addVO method failed, the argument passed in argument not must be 'null' or 'undefined'.") ;	
		}
		validate(vo) ;
		if ( !_map.containsKey( vo.getID() ) )
		{
			_map.put( vo.getID() , vo ) ;
			notifyAdd(vo) ;
		}
		else
		{
			throw new Warning( this + " addVO method failed, the IValueObject passed in argument already register in the model, you must remove this 'id' key before add a new value object.") ;	
		}
	}
	
	/**
	 * Removes all value objects in the model.
	 */
	public function clear():Void
	{
		_map.clear() ;
		super.clear() ;
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
	 * Returns {@code true} if the model contains the specified attribute value.
	 * @return {@code true} if the model contains the specified id key in argument
	 */
	public function containsByProperty( propName:String , value ):Boolean
	{
		if ( propName == null )
		{
			return false ;
		}
		var datas:Array = _map.getValues() ;
		var size:Number = datas.length ;
		if (size > 0)
		{
			while ( --size > -1 )
			{
				if ( datas[size][propName] == value )
				{
					return true ;
				}
			}
			return false ;
		}
		else
		{
			return false ;
		}
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
	 * Returns the event name use in the {@code updateVO} method.
	 * @return the event name use in the {@code updateVO} method.
	 */
	public function getEventTypeUPDATE():String
	{
		return _eUpdate.getType() ;
	}
	
	/**
	 * Returns the internal map of this model.
	 * @return the internal map of this model.
	 */
	public function getMap():Map
	{
		return _map ;	
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
	 * This method is invoked in the constructor of the class to initialize all events.
	 */
	/*override*/ public function initEvent():Void
	{
		super.initEvent() ;
		_eAdd    = createNewModelObjectEvent( ModelObjectEvent.ADD_VO ) ;
		_eRemove = createNewModelObjectEvent( ModelObjectEvent.REMOVE_VO ) ; 
		_eUpdate = createNewModelObjectEvent( ModelObjectEvent.UPDATE_VO ) ;
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
	 * Returns {@code true} if the model is empty.
	 * @return {@code true} if the model is empty.
	 */
	public function isEmpty():Boolean 
	{
		return _map.isEmpty() ;	
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
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is inserted in the model.
     */ 
    public function notifyAdd( vo:IValueObject ):Void
    {
        if ( isLocked() )
        {
            return ;
        }
        _eAdd.setVO( vo ) ;
        dispatchEvent( _eAdd  ) ;
    }

    /**
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is removed in the model.
     */ 
    public function notifyRemove( vo:IValueObject ):Void
    {
        if ( isLocked() )
        {
            return ;
        }
        _eRemove.setVO( vo ) ;
        dispatchEvent( _eRemove  ) ;
    }

    /**
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is updated in the model.
     */ 
	public function notifyUpdate( vo:IValueObject ):Void
	{
        if ( isLocked() )
        {
            return ;
        }
		_eUpdate.setVO( vo ) ;
		dispatchEvent( _eUpdate  ) ;
	}

	/**
	 * Removes a value object in the model.
	 */
	public function removeVO( vo:IValueObject ):Void
	{
		if (vo == null)
		{
			throw new IllegalArgumentError( this + " removeVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		validate(vo) ;
		if ( _map.containsKey( vo.getID() ) )
		{
			_map.remove( vo.getID() ) ;
			notifyRemove( vo ) ;
		}
		else
		{
			throw new Warning( this + " removeVO method failed, the id passed in argument allready register in the model, you must remove this 'id' key before add a noew value object.") ;	
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
	 * Sets the event name use in the {@code addVO} method.
	 */
	public function setEventTypeUPDATE( type:String ):Void
	{
		_eUpdate.setType( type ) ;
	}

	/**
	 * Sets the internal map of this model. By default the initializeMap() method is used if the passed-in argument is null.
	 */
	public function setMap( m:Map ):Void
	{
		_map = m || initializeMap() ;	
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
	 * Update a value object in the model.
	 * @throws Warning if the value object passed-in argument don't exist.
	 */
	public function updateVO( vo:IValueObject ):Void
	{
		if ( _map.containsKey( vo.getID() ) )
		{
			_map.put( vo.getID() , vo ) ;
			notifyUpdate(vo) ;
		}
		else
		{
			throw new Warning( this + " updateVO method failed, the value object passed in argument don't exist in the model.") ;
		}
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
	 * The internal ModelObjectEvent when the update event type is use.
	 */
	private var _eUpdate:ModelObjectEvent ;

	/**
	 * The internal map of this model.
	 */
	private var _map:Map ;

}