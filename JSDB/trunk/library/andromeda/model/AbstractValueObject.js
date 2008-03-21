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
 * This class provides a skeletal implementation of the {@code IValueObject} interface, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
if ( andromeda.model.AbstractValueObject == undefined ) 
{

	/**
	 * @requires andromeda.model.IValueObject
	 */
	require("andromeda.model.IValueObject") ;

	/**
	 * Creates a new AbstractValueObject.
	 */
	andromeda.model.AbstractValueObject = function () 
	{ 
		if ( this._id == null )
		{
			this._id = this.hashCode() ;			
		}
	}

	/**
	 * @extends andromeda.model.AbstractModel
	 */
	proto = andromeda.model.AbstractValueObject.extend( andromeda.model.IValueObject ) ;

	/**
	 * Returns the id of this IValueObject .
	 * @return the id of this IValueObject .
	 */
	proto.getID = function() 
	{
		return this._id ;	
	}
	
	/**
	 * Sets the id of this IValueObject.
	 */
	proto.setID = function( id ) /*void*/ 
	{
		this._id = id ;
	}

	/**
	 * The internal id of this IValueObject
	 */
	proto._id /*IValueObject*/ = null  ;

	// virtual properties

	/**
	 * The db id of the user.
	 */
	proto.__defineGetter__("id", proto.getID ) ;
	proto.__defineSetter__("id", proto.setID ) ;

	// encapsulate

	delete proto ;
	
}