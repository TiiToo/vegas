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
package andromeda.ioc.factory 
{

	/**
	 * Describes a factory tool who creates prototype or singletons.
	 * @author eKameleon
	 */
	public interface IObjectFactory 
	{
		
		/**
		 * Returns <code>true</code> if the referencial contains the specified object.
		 * @param The id name of the object to search.
	 	 * @return <code>true</code> if the referencial contains the specified object.
		 */		
		function containsObject(name:String):Boolean;
				
		/**
		 * This method returns an object with the specified name in argument.
		 * @param The id name of the object to return.
		 * @return the instance of the object with the name passed in argument.
		 */		
		function getObject( name:String ):* ;
	
		/**
		 * This method defined if the object is a lazy init singleton object (must be singleton).
		 * @param name The name of the object to find.
		 * @return <code>true</code> if the object is a lazy init singleton object (must be singleton).
	 	 */	
		function isLazyInit( name:String ):Boolean ; 		
		
		/**
	 	 * This method defined if the object is a singleton or a prototype.
		 * @param The id name of the object.
		 * @return <code>true</code> if the object is a singleton or else if the object is a prototype. 
	 	 */		
		function isSingleton(name:String):Boolean ;	
		
	}
}
