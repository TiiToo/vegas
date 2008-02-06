﻿/*

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
	 * The static enumeration list of all object attributes.
	 * @author eKameleon
	 */
	public class ObjectAttribute 
	{
		
		/**
		 * Defines the label of the arguments in a method or a constructor object.
		 */
		public static const ARGUMENTS:String = "arguments" ;  
		
		/**
		 * Defines the label of the assembly name property of the object.
		 */
		public static const ASSEMBLY_NAME:String = "assemblyName" ;
		
		/**
		 * Defines the label of the imports attribute.
		 */
		public static const IMPORTS:String = "imports" ;		
		
		/**
		 * Defines the label of the lazyInit name property of the object.
		 */		
		public static const LAZY_INIT:String = "lazyInit" ;
		
		/**
		 * Defines the label of the name in a property object.
	 	 */
		public static const NAME:String = "name" ;  
		
		/**
		 * The name of the external object property to register the destroy method name.
		 */
		public static const OBJECT_DESTROY_METHOD_NAME:String = "destroy" ;  
		
		/**
		 * The name of the external object property to define the id of the object.
		 */
		public static const OBJECT_ID:String = "id" ;  
		
		/**
		 * The name of the external object property to register the init method name.
		 */
		public static const OBJECT_INIT_METHOD_NAME:String = "init" ;  

		/**
		 * The name of the external object property to register the methods.
		 */
		public static const OBJECT_METHODS:String = "methods" ;  

		/**
		 * The name of the external object property to register the properties.
		 */
		public static const OBJECT_PROPERTIES:String = "properties" ;  
	
		/**
		 * The name of the external object property to define the singleton flag of the object.
		 */
		public static const OBJECT_SINGLETON:String = "singleton" ;  
		
		/**
		 * Defines the label of the ressource attribute in the imports objects.
		 */
		public static const RESSOURCE:String = "ressource" ;
		
		/**
		 * Defines the label of the type of the object.
		 */
		public static const TYPE:String = "type" ;  
		
		/**
		 * Defines the label of the reference in a property object.
		 */
		public static const REFERENCE:String = "ref" ;  
		
		/**
		 * Defines the label of the value in a property object.
		 */
		public static const VALUE:String = "value" ;  
		
	}
}
