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

import andromeda.model.IValueObject;

import vegas.core.CoreObject;

/**
 * This class provides a skeletal implementation of the {@code IValueObject} interface, to minimize the effort required to implement this interface.
 * @author eKameleon
 */
class andromeda.model.AbstractValueObject extends CoreObject implements IValueObject 
{
	
	/**
	 * Creates a new AbstractValueObject.
	 */
	public function AbstractValueObject() 
	{
		_id = hashCode() ;
	}

	/**
	 * (read-write) Returns the id of this IValueObject.
	 * @return the id of this IValueObject.
	 */
	public function get id() 
	{
		return getID() ;
	}

	/**
	 * (read-write) Sets the id of this IValueObject.
	 */
	public function set id( id ):Void 
	{
		setID( id ) ;
	}

	/**
	 * Returns the id of this IValueObject. This method is use to register this object in a category of models.
	 * You can overrides this method to change the nature of the natural id property of this object but this hack don't modify the value of the id property. 
	 * @return the id of this IValueObject.
	 */
	public function getID() 
	{
		return _id ;
	}

	/**
	 * Sets the id of this IValueObject.
	 * @return the id of this IValueObject.
	 */
	public function setID( id ):Void 
	{
		_id = id ;
	}

	/**
	 * The internal id of this IValueObject
	 */
	private var _id ;

}
