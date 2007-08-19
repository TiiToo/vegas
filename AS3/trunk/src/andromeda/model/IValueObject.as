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

package andromeda.model
{

	/**
	 * This interface define a value object, the value object are use for example in the models.
	 * @author eKameleon
	 */
	public interface IValueObject
	{
		
		/**
		 * Returns the id of this IValueObject.
		 * @return the id of this IValueObject.
		 */
		function get id():* ;
		
		/**
		 * Sets the id of this IValueObject.
		 * @return the id of this IValueObject.
		 */
		function set id( value:* ):void ;
		
	}
}