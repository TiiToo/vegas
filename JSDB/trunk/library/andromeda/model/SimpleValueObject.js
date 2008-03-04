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
 * This class is a basic implementation of the IValueObject interface. This class is really useful with a remote 'AMF' value object.
 * @author eKameleon
 */
if ( andromeda.model.SimpleValueObject == undefined ) 
{
	
	/**
	 * @requires andomda.model.IValueObject
	 */
	require("andromeda.model.IValueObject") ;

	/**
	 * Creates a new SimpleValueObject.
	 */
	andromeda.model.SimpleValueObject = function () 
	{ 
		this.id = null ;
	}

	/**
	 * @extends andromeda.model.AbstractModel
	 */
	proto = andromeda.model.SimpleValueObject.extend( andromeda.model.IValueObject ) ;

	/**
	 * Returns the id of this IValueObject .
	 * @return the id of this IValueObject .
	 */
	proto.getID = function() 
	{
		return this.id ;	
	}
	
	/**
	 * Sets the id of this IValueObject.
	 */
	proto.setID = function( id ) /*void*/ 
	{
		this.id = id ;
	}

	/**
	 * Returns the {@code String} representation of this object.
	 * @return the {@code String} representation of this object.
	 */
	proto.toString = function() /*String*/
	{
		return "[" + vegas.util.ConstructorUtil.getName(this) + " " + this.id + "]" ;
	}

	// encapsulate

	delete proto ;
	
}