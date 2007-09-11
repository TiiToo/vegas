/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This interface defines a common structure for classes that has an 'id' (index).
 * @author eKameleon
 */
if (vegas.core.Identifiable == undefined) 
{

	/**
	 * Creates a new Identifiable instance.
	 */
	vegas.core.Identifiable = function () 
	{ 
		//	
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.core.Identifiable.extend( vegas.core.CoreObject ) ;

	/**
	 * Compares the specified object with this object for equality. This method compares the ids of the objects with the {@code Identifiable.getID()} method.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	proto.equals = function( o ) /*Boolean*/
	{
		if (o instanceof vegas.core.Identifiable)
		{
			return o.getID() == this.getID() ;			
		}
		else
		{
			return false ;
		}
	}

	/**
	 * Returns the id value of this object.
	 * @return the id value of this object.
	 */
	proto.getID = function() {} ;
	
	/**
	 * Sets the id of this object.
	 */
	proto.setID = function( id ) /*void*/ {}  ;
	
}