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
 * This file inject hashCode method in all objects in the application.
 */
if (Object.prototype.hashCode == undefined) 
{

	/**
	 * @requires vegas.core.HashCode
	 */
	require("vegas.core.HashCode") ;

	/**
	 * This property hide in enumeration all enumerable properties of the object.
	 */
	Object.prototype.dontEnumAllProperties = function()
	{
		try
		{
			for (var prop in this)
			{
				setAttributes(this, prop, false, false, false) ;
			}
		}
		catch( e )
		{
			//			
		}
	}

	/**
	 * Returns a hash code value for the object.
	 * @return a hash code value for the object.
	 */
	Object.prototype.hashCode = function ()  
	{
		if (this.__hashcode__ == null) 
		{
			this.__hashcode__ = vegas.core.HashCode.next() ;
		}
		return this.__hashcode__ ;
	}

	Object.prototype.dontEnumAllProperties() ;
	
	
}
