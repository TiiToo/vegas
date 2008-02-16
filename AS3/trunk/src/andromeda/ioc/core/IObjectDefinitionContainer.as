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
package andromeda.ioc.core 
{

	/**
	 * This interface creates the dependencies with the definitions.
	 * @author eKameleon
	 */
	public interface IObjectDefinitionContainer 
	{
		
		/**
		 * Registers an object in the container.
		 * @param name the name of the object.
		 * @param definition the definition of the object.
		 */
		function addObjectDefinition( name:String , definition:IObjectDefinition ):void ;
		
		/**
		 * Returns <code>true</code> if the object define with the specified name in register in the container.
		 * @return <code>true</code> if the object define with the specified name in register in the container.
		 */
		function containsObjectDefinition( name:String ):Boolean ;
		
		/**
		 * Returns the numbers objects registered in the container.
		 * @return the numbers objects registered in the container.
	 	 */
		function getObjectDefinition( name:String ):IObjectDefinition ;
		
		/**
		 * Returns the numbers objects registered in the container.
		 * @return the numbers objects registered in the container.
		 */
		function sizeObjectDefinition():Number ;
		
	}
}
