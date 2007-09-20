﻿/*

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

import vegas.data.iterator.Iterator;
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.errors.IllegalArgumentError;
import vegas.errors.Warning;

/**
 * This model use an internal {@code Set} to register value objects.
 * @author eKameleon
 */
class andromeda.model.set.SetModel extends AbstractModelObject 
{
	
	/**
	 * Creates a new SetModel instance.
	 * @param id the id of this model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	function SetModel(id, bGlobal : Boolean, sChannel : String) 
	{
		super(id, bGlobal, sChannel);
		_set = initializeSet() ;
	}
	
	/**
	 * Inserts a value object in the model.
	 * @param vo The value object to insert in the model.
	 */
	public function addVO( vo:IValueObject ):Boolean
	{
		if (vo == null)
		{
			throw new IllegalArgumentError( this + " addVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		validate(vo) ;
		if ( _set.insert( vo ) )
		{
			_eAdd.setVO( vo ) ;
			dispatchEvent( _eAdd ) ;
			return true ;
		}
		else
		{
			return false ;	
		}
	}
	
	/**
	 * Removes all value objects in the model.
	 */
	public function clear():Void
	{
		_set.clear() ;
		super.clear() ;
	}

	/**
	 * Returns {@code true} if the model contains the specified IValueObject.
	 * @return {@code true} if the model contains the specified IValueObject.
	 */
	public function contains( vo:IValueObject ):Boolean
	{
		return _set.contains( vo ) ;
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
	 * Returns the internal {@code Set} of this model.
	 * @return the internal {@code Set} of this model.
	 */
	public function getSet():Set
	{
		return _set ;	
	}
	
	/**
	 * Returns the IValueObject defined by the index passed in argument.
	 * @return the IValueObject defined by the index passed in argument.
	 */
	public function getVO( id ):IValueObject
	{
		return _set.get( id ) ;
	}

	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 */
	/*override*/ public function initEvent():Void
	{
		super.initEvent() ;
		_eAdd    = createNewModelObjectEvent( ModelObjectEvent.ADD_VO ) ;
		_eRemove = createNewModelObjectEvent( ModelObjectEvent.REMOVE_VO ) ; 
	}

	/**
	 * Initialize the internal Set instance in the constructor of the class.
	 * You can overrides this method if you want change the default HashSet use in this model.
	 */
	public function initializeSet():Set
	{
		return new HashSet() ;	
	}

	/**
	 * Returns {@code true} if this model is empty.
	 * @return {@code true} if this model is empty.
	 */
	public function isEmpty():Boolean 
	{ 
		return _set.isEmpty() ;
	}

	/**
	 * Returns the iterator of this model.
	 * @return the iterator of this model.
	 */
	public function iterator():Iterator
	{
		return _set.iterator() ;	
	}

	/**
	 * Removes a value object in the model.
	 * @param vo The value object to remove.
	 */
	public function removeVO( vo:IValueObject ):Void
	{
		if (vo == null)
		{
			throw new IllegalArgumentError( this + " removeVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		validate(vo) ;
		if ( _set.contains( vo ) )
		{
			_set.remove( vo ) ;
			_eRemove.setVO( vo ) ;
			dispatchEvent( _eRemove ) ;
		}
		else
		{
			throw Warning( this + " removeVO method failed, the id passed in argument allready register in the model, you must remove this 'id' key before add a noew value object.") ;	
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
	 * Sets the internal Set of this model. 
	 * By default the initializeSet() method is used if the passed-in argument is null.
	 */
	public function setSet( s:Set ):Void
	{
		_set = s || initializeSet() ;	
	}

	/**
	 * Returns the number of IValueObject in this model.
	 * @return the number of IValueObject in this model.
	 */
	public function size():Number
	{
		return _set.size() ;
	}

	/**
	 * Returns the {@code Array} representation of this object.
	 * @return the {@code Array} representation of this object.
	 */
	public function toArray():Array
	{
		return _set.toArray() ;	
	}
	
	/**
	 * The internal {@code Set} reference of this model.
	 */
	private var _set:Set ;

	/**
	 * The internal ModelObjectEvent use in the addVO method.
	 */
	private var _eAdd:ModelObjectEvent ;

	/**
	 * The internal ModelObjectEvent use in the removeVO method.
	 */
	private var _eRemove:ModelObjectEvent ;

}