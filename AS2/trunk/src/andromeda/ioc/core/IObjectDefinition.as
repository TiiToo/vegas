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

import vegas.data.Map;

/**
 * Describes an object instance, which has property values, constructor argument values, and further information supplied by concrete implementations.
 * @author eKameleon
 */
interface andromeda.ioc.core.IObjectDefinition 
{

	/**
	 * Returns the constructor arguments values of this object in a Array list.
	 * @return the constructor arguments values of this object in a Array list.
	 */	
	function getConstructorArguments():Array ;

	/**
	 * Returns the name of the method invoqued when the object is destroyed.
	 * @return the name of the method invoqued when the object is destroyed.
	 */	
	function getDestroyMethodName():String ; 

	/**
	 * Returns the name of the method call when the object is instanciate.
	 * @return the name of the method call when the object is instanciate.
	 */	
	function getInitMethodName():String ; 

	/**
	 * Returns the Map of all properties of this Definition.
	 * @return the Map of all properties of this Definition.
	 */	
	function getProperties():Map ; 

	/**
	 * Returns the type of the object (the class name).
	 * @return the type of the object (the class name).
	 */	
	function getType():String  ;

	/**
	 * Returns {@code true} if the object in a Sigleton else the object is a prototype.
	 * @return {@code true} if the object in a Sigleton else the object is a prototype.
	 */		
	function isSingleton():Boolean ; 

	/**
	 * Sets the constructor arguments values of this object.
	 */	
	function setConstructorArguments( value:Array ):Void ;

	/**
	 * Sets the name of the method invoqued when the object is destroyed.
	 */	
	function setDestroyMethodName( value:String ):Void ; 

	/**
	 * Init the name of the method.
	 */		
	function setInitMethodName( value:String ):Void ;

	/**
	 * Sets the Map of all properties of this Definition.
	 */	
	function setProperties( value:Map ):Void ; 

	/**
	 * Sets the type of the object (the class name).
	 */	
	function setType( value:String ):Void ; 

}