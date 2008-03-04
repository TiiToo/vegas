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
 * The ModelObjectEvent is the basic event use in a IModelObject to notify changed.
 * @author eKameleon
 * @see BasicEvent
 */
if (andromeda.events.ModelObjectEvent == undefined) 
{
	
	/**
	 * Creates a new ModelObjectEvent instance.
	 * @param type the type of the event.
	 * @param target the IModelObject reference of this event.
	 * @param (optional) the IValueObject of this event.
	 */	
	andromeda.events.ModelObjectEvent = function ( type/*String*/ , target/*Object*/ , vo /*IValueObject*/ ) 
	{
		vegas.events.BasicEvent.apply(this, Array.fromArguments(arguments)) ;
		this.setVO( vo ) ;
	}

	/**
	 * Default event type when the addVO method is invoqued.
	 */
	andromeda.events.ModelObjectEvent.ADD_VO /*String*/ = "onAddVO" ;

	/**
	 * Default event type when the clear method is invoqued.
	 */
	andromeda.events.ModelObjectEvent.CLEAR_VO /*String*/ = "onClearVO" ;

	/**
	 * Default event type when the setVO method is invoqued.
	 */
	andromeda.events.ModelObjectEvent.CHANGE_CURRENT_VO /*String*/ = "onChangeCurrentVO" ;

	/**
	 * Default event type when the removeVO method is invoqued.
	 */
	andromeda.events.ModelObjectEvent.REMOVE_VO /*String*/ = "onRemoveVO" ;

	/**
	 * Default event type when the removeVO method is invoqued.
	 */
	andromeda.events.ModelObjectEvent.UPDATE_VO /*String*/ = "onUpdateVO" ;

	/**
	 * @extends vegas.events.BasicEvent
	 */
	proto = andromeda.events.ModelObjectEvent.extend( vegas.events.BasicEvent ) ;

 	/**
 	 * Returns a new clone reference.
	 * @return a new clone reference.
	 */
	proto.clone = function () 
	{
		return new andromeda.events.ModelObjectEvent(this.getType(), this.getTarget(), this.getVO()) ;
	}
 
	/**
	 * Returns a IValueObject reference.
	 * @return a IValueObject reference.
	 */
	proto.getVO = function() /*IValueObject*/
	{
		return this._vo ;	
	}

	/**
	 * Sets a IValueObject reference.
	 */
	proto.setVO = function( vo /*IValueObject*/ ) /*void*/
	{
		this._vo = vo || null ;	
	}

	proto._vo /*IValueObject*/ = null ;
	
	// encapsulate
	
	delete proto ;
	
}
