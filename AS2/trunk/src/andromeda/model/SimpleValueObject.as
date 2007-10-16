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

import andromeda.model.IValueObject;

import vegas.core.CoreObject;
import vegas.core.Identifiable;
import vegas.core.IEquality;
import vegas.util.ConstructorUtil;

/**
 * This class is a basic implementation of the IValueObject interface. This class is really useful with a remote 'AMF' value object.
 * @author eKameleon
 */
class andromeda.model.SimpleValueObject extends CoreObject implements IEquality, IValueObject 
{
	
	/**
	 * Creates a new SimpleValueObject instance.
	 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored
	 */
	public function SimpleValueObject( init:Object ) 
	{
		if ( init != null )
		{
			for (var prop:String in init )
			{
				this[prop] = init[prop] ;	
			} 	
		}
	}

	/**
	 * The id of this value object.
	 */
	public var id ;

	/**
	 * Compares the specified object with this object for equality. This method compares the ids of the objects with the {@code Identifiable.getID()} method.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals( o ):Boolean
	{
		if (o instanceof Identifiable)
		{
			return Identifiable(o).getID() == this.getID() ;			
		}
		else
		{
			return false ;
		}
	}

	/**
	 * Returns the id of the value object.
	 * @return the id of the value object.
	 */
	public function getID() 
	{
		return this.id ;
	}
	
	/**
	 * Sets the id of the value object.
	 */
	public function setID(id) : Void 
	{
		this.id = id ;		
	}

	/**
	 * Returns the {@code String} representation of this object.
	 * @return the {@code String} representation of this object.
	 */
	public function toString():String
	{
		return "[" + ConstructorUtil.getName(this) + " " + id + "]" ;
	}

}