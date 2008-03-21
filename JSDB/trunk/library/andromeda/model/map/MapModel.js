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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

// TODO unit tests

/**
 * This model use an internal Map to register value objects with a specific key.
 * @author eKameleon
 */
if ( andromeda.model.map.MapModel == undefined) 
{

	/**
	 * @requires andromeda.model.map.MapModel
	 */
	require("andromeda.model.AbstractModelObject") ;

	/**
	 * Creates a new AbstractModel instance.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	andromeda.model.map.MapModel = function ( id , bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		andromeda.model.AbstractModelObject.call( this , id, bGlobal, sChannel ) ; // super
		this._map = this.initializeMap() ;
	}
	
	/**
	 * @extends andromeda.model.AbstractModelObject
	 */
	proto = andromeda.model.map.MapModel.extend( andromeda.model.AbstractModelObject ) ;

	/**
	 * Inserts a value object in the model.
	 */
	proto.addVO = function ( vo /*IValueObject*/ ) /*void*/
	{
		if ( vo == null )
		{
			throw new vegas.errors.IllegalArgumentError( this + " addVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		this.validate( vo ) ;
		if ( ! this._map.containsKey( vo.getID() ) )
		{
			try
			{
				this._map.put( vo.getID() , vo ) ;
			}
			catch(e)
			{
				trace(e) ;
			}
			this.notifyAdd( vo ) ;
		}
		else
		{
			throw new vegas.errors.Warning( this + " addVO method failed, the id passed in argument already register in the model, you must remove this 'id' key before add a noew value object.") ;	
		}
	}

	/**
	 * Removes all value objects in the model.
	 */
	proto.clear = function() /*void*/
	{
		this._map.clear() ;
		andromeda.model.AbstractModelObject.prototype.clear.call(this) ;
	}
	
	/**
	 * Returns {@code true} if the model contains the specified IValueObject.
	 * @return {@code true} if the model contains the specified IValueObject.
	 */
	proto.contains = function( vo /*IValueObject*/ ) /*Boolean*/
	{
		return this._map.containsValue( vo ) ;
	}

	/**
	 * Returns {@code true} if the model contains the specified id key in argument.
	 * @return {@code true} if the model contains the specified id key in argument
	 */
	proto.containsByID = function ( id ) /*Boolean*/
	{
		return this._map.containsKey( id ) ;
	}

	/**
	 * Returns {@code true} if the model contains the specified attribute value.
	 * @return {@code true} if the model contains the specified id key in argument
	 */
	proto.containsByProperty = function ( propName /*String*/ , value ) /*Boolean*/
	{
		if ( propName == null && ! propName instanceof String )
		{
			return false ;
		}
		var datas /*Array*/  = this._map.getValues() ;
		var size  /*Number*/ = datas.length ;
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
	proto.getEventTypeADD = function () /*String*/
	{
		return this._eAdd.getType() ;
	}
	
	/**
	 * Returns the event name use in the {@code removeVO} method.
	 * @return the event name use in the {@code removeVO} method.
	 */
	proto.getEventTypeREMOVE = function () /*String*/
	{
		return this._eRemove.getType() ;
	}

	/**
	 * Returns the event name use in the {@code updateVO} method.
	 * @return the event name use in the {@code updateVO} method.
	 */
	proto.getEventTypeUPDATE = function () /*String*/
	{
		return this._eUpdate.getType() ;
	}
	
	/**
	 * Returns the internal map of this model.
	 * @return the internal map of this model.
	 */
	proto.getMap = function() /*Map*/
	{
		return this._map ;	
	}
	
	/**
	 * Returns the IValueObject defined by the id passed in argument.
	 * @return the IValueObject defined by the id passed in argument.
	 */
	proto.getVO = function ( id ) /*IValueObject*/
	{
		return this._map.get( id ) ;
	}

	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 */
	/*override*/ proto.initEvent = function () /*void*/
	{
		andromeda.model.AbstractModelObject.prototype.initEvent.call(this) ; // super.initEvent()
		this._eAdd    = this.createNewModelObjectEvent( andromeda.events.ModelObjectEvent.ADD_VO    ) ;
		this._eRemove = this.createNewModelObjectEvent( andromeda.events.ModelObjectEvent.REMOVE_VO ) ; 
		this._eUpdate = this.createNewModelObjectEvent( andromeda.events.ModelObjectEvent.UPDATE_VO ) ;
	}

	/**
	 * Initialize the internal Map instance in the constructor of the class.
	 * You can overrides this method if you want change the default HashMap use in this model.
	 */
	proto.initializeMap = function () /*Map*/
	{
		return new vegas.data.map.HashMap() ;	
	}

	/**
	 * Returns {@code true} if the model is empty.
	 * @return {@code true} if the model is empty.
	 */
	proto.isEmpty = function() /*Boolean*/ 
	{
		return this._map.isEmpty() ;	
	}

	/**
	 * Returns the iterator of this model.
	 * @return the iterator of this model.
	 */
	proto.iterator = function () /*Iterator*/
	{
		return this._map.iterator() ;	
	}

    /**
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is inserted in the model.
     */ 
    proto.notifyAdd = function( vo /*IValueObject*/ ) /*void*/
    {
        if ( this.isLocked() )
        {
            return ;
        }
        this._eAdd.setVO( vo ) ;
        this.dispatchEvent( this._eAdd  ) ;
    }

    /**
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is removed in the model.
     */ 
    proto.notifyRemove = function( vo /*IValueObject*/ ) /*void*/
    {
        if ( this.isLocked() )
        {
            return ;
        }
        this._eRemove.setVO( vo ) ;
        this.dispatchEvent( this._eRemove  ) ;
    }

    /**
     * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is updated in the model.
     */ 
	proto.notifyUpdate = function( vo /*IValueObject*/ ) /*void*/
	{
        if ( this.isLocked() )
        {
            return ;
        }
		this._eUpdate.setVO( vo ) ;
		this.dispatchEvent( this._eUpdate  ) ;
	}

	/**
	 * Notify with the update event of this model a value object is changed.
	 */
	proto.notifyUpdate = function ( vo /*ValueObject*/ ) /*void*/
	{
		this._eUpdate.setVO( vo ) ;
		this.dispatchEvent( this._eUpdate  ) ;
	}

	/**
	 * Removes a value object in the model.
	 */
	proto.removeVO = function ( vo /*IValueObject*/ ) /*void*/
	{
		if (vo == null)
		{
			throw new vegas.errors.IllegalArgumentError( this + " addVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;	
		}
		this.validate(vo) ;
		if ( this._map.containsKey( vo.getID() ) )
		{
			this._map.remove( vo.getID() ) ;
			this.notifyRemove( vo ) ;
		}
		else
		{
			throw vegas.errors.Warning( this + " addVO method failed, the id passed in argument allready register in the model, you must remove this 'id' key before add a noew value object.") ;	
		}
	}
	
	/**
	 * Sets the event name use in the {@code addVO} method.
	 */
	proto.setEventTypeADD = function ( type /*String*/ ) /*void*/
	{
		this._eAdd.setType( type ) ;
	}
	
	/**
	 * Sets the event name use in the {@code removeVO} method.
	 */
	proto.setEventTypeREMOVE = function ( type /*String*/ ) /*void*/
	{
		this._eRemove.setType( type ) ;
	}
	
	/**
	 * Sets the event name use in the {@code addVO} method.
	 */
	proto.setEventTypeUPDATE = function ( type /*String*/ ) /*void*/
	{
		this._eUpdate.setType( type ) ;
	}

	/**
	 * Sets the internal map of this model. By default the initializeMap() method is used in the passed-in argument is null.
	 */
	proto.setMap = function ( m /*Map*/ ) /*void*/
	{
		this._map = m || this.initializeMap() ;	
	}

	/**
	 * Returns the number of IValueObject in this model.
	 * @return the number of IValueObject in this model.
	 */
	proto.size = function () /*Number*/
	{
		return this._map.size() ;
	}

	/**
	 * Update a value object in the model.
	 * @throw Warning if the value object passed-in argument don't exist.
	 */
	proto.updateVO = function( vo /*IValueObject*/ ) /*void*/
	{
		if ( vo == null || ( vo instanceof andromeda.model.IValueObject == false ) )
		{
			throw vegas.errors.Warning( this + " updateVO method failed, the value object passed in argument don't must be 'null' and must be an instanceof the IValuObject class.") ;
		}
		if ( this._map.containsKey( vo.getID() ) )
		{
			this._map.put( vo.getID() , vo ) ;
			this.notifyUpdate( vo ) ;
		}
		else
		{
			throw vegas.errors.Warning( this + " updateVO method failed, the value object passed in argument don't exist in the model.") ;
		}
	}
	
	/**
	 * The internal ModelObjectEvent use in the addVO method.
	 */
	proto._eAdd /*ModelObjectEvent*/ = null ;

	/**
	 * The internal ModelObjectEvent use in the removeVO method.
	 */
	proto._eRemove /*ModelObjectEvent*/ = null ;

	/**
	 * The internal ModelObjectEvent when the update event type is use.
	 */
	proto._eUpdate /*ModelObjectEvent*/ = null ;

	/**
	 * The internal map of this model.
	 */
	proto._map /*Map*/ = null ;

	// encapsulate
	
	delete proto ;

}