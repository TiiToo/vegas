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

// TODO finish the unit tests of this class.
// TODO finish the AbstractValueObject class.

/**
 * This class provides a skeletal implementation of the {@code IModel} interface, 
 * to minimize the effort required to implement this interface.
 */
if ( andromeda.model.AbstractModelObject == undefined) 
{

	/**
	 * @requires andromeda.model.IModel
	 */
	require("andromeda.model.IModelObject") ;

	/**
	 * Creates a new AbstractModelObject instance.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */	
	andromeda.model.AbstractModelObject = function ( id , bGlobal /*Boolean*/ , sChannel /*String*/ ) 
	{ 
		andromeda.model.AbstractModel.call( this, id, bGlobal, sChannel ) ; // super
		this.initEvent() ;
	}

	/**
	 * @extends andromeda.model.AbstractModel
	 */
	proto = andromeda.model.AbstractModelObject.extend( andromeda.model.AbstractModel ) ;

	/**
	 * This property defined if the setCurrentVO method can accept the same vo in argument as the current one. 
	 */
	proto.security /*Boolean*/ = true ;

	/**
	 * Clear the model.
	 */	
	proto.clear = function() 
	{
		this._vo = null ;
		this.notifyClear() ;
	}

	/**
	 * Returns and creates a new empty ModelObjectEvent. You can override this method.
	 * @param type the type of the event.
	 * @return a new empty ModelObjectEvent with the type specified in argument.
	 */
	proto.createNewModelObjectEvent = function( type /*String*/ ) /*ModelObjectEvent*/ 
	{
		return new andromeda.events.ModelObjectEvent( type || null , this ) ;
	}

	/**
	 * Returns the current IValueObject selected in this model.
	 * @return the current IValueObject selected in this model.
	 */
	proto.getCurrentVO = function() /*IValueObject*/
	{
		return this._vo ;
	}

	/**
	 * Returns the event name use in the {@code setVO} method.
	 * @return the event name use in the {@code setVO} method.
	 */
	proto.getEventTypeCHANGE = function () /*String*/
	{
		return this._eChange.getType() ;
	}

	/**
	 * Returns the event name use in the {@code clear} method.
	 * @return the event name use in the {@code clear} method.
	 */
	proto.getEventTypeCLEAR = function () /*String*/
	{
		return this._eClear.getType() ;
	}

	/**
	 * This method is invoqued in the constructor of the class to initialize all events.
	 * Overrides this method.
	 */
	proto.initEvent = function () /*void*/
	{
		this._eChange = this.createNewModelObjectEvent( andromeda.events.ModelObjectEvent.CHANGE_CURRENT_VO ) ;
		this._eClear  = this.createNewModelObjectEvent( andromeda.events.ModelObjectEvent.CLEAR_VO ) ;
	}

	/**
	 * Notify a {@code ModelObjectEvent} when a {@code IValueObject} change in the model.
	 */	
	proto.notifyChange = function( vo /*IValueObject*/ ) /*void*/
	{
		if ( this.isLocked() )
		{
			return ;
		}
	    this._eChange.setVO(vo) ;
        this.dispatchEvent( this._eChange ) ;	
	}

    /**
     * Notify a {@code ModelObjectEvent} when the model is cleared.
     */ 
    proto.notifyClear = function() /*void*/
    {
        if ( this.isLocked() )
        {
            return ;
        }
        this.dispatchEvent( this._eClear ) ; 
    }

	/**
	 * Sets the current IValueObject selected in this model.
	 */
	proto.setCurrentVO = function ( vo /*IValueObject*/ ) /*void*/
	{
		if ( vo == this._vo && this.security == true )
		{
			return ;	
		}
		this.validate(vo) ;
		this._vo = vo ;
		this.notifyChange(vo) ;
	}
	
	/**
	 * Sets the event name use in the {@code setVO} method.
	 */
	proto.setEventTypeCHANGE = function ( type /*String*/ ) /*void*/
	{
		this._eChange.setType( type ) ;
	}

	/**
	 * Sets the event name use in the {@code clear} method.
	 */
	proto.setEventTypeCLEAR = function ( type /*String*/ ) /*void*/
	{
		this._eClear.setType( type ) ;
	}

	/**
	 * Returns {@code true} if the {@code IValidator} object validate the value. Overrides this method in your concrete IModelObject class.
	 * @param value the object to test.
	 * @return {@code true} is this specific value is valid.
	 */
	proto.supports = function ( value ) /*Boolean*/ 
	{
		return true ;
	}

	/**
	 * Evaluates the condition it checks and updates the IsValid property.
	 * @param value the object to validate.
	 */
	proto.validate = function ( value ) /*void*/ 
	{
		if ( !this.supports(value) ) 
		{
			throw new vegas.errors.TypeMismatchError( this + " validate(" + value + ") is mismatch.") ;
		}
	}

	/**
	 * The internal ModelObjectEvent use in the clearVO method.
	 */
	proto._eClear /*ModelObjectEvent*/ = null ;

	/**
	 * The internal ModelObjectEvent use in the setVO method.
	 */
	proto._eChange /*ModelObjectEvent*/ = null ;

	/**
	 * The current value object selectd in this model.
	 */
	proto._vo /*IValueObject*/ = null  ;

	// encapsulate

	delete proto ;
	
}