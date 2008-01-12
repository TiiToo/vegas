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

package vegas.util
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import system.Reflection;
	
	import vegas.core.HashCode;
	import vegas.core.IHashable;	

	/**
	 * The {@code ClassUtil} utility class is an all-static class with methods for working with function the Class in AS3.
	 * @author eKameleon
	 */
	public class ClassUtil
	{

		/**
		 * Creates an instance with the passed-in Class.
		 * @param c the class to instanciate.
		 * @param initProperties An object with all properties to to pass over the new instance.
		 * @return a new instance of the specified Class in argument.
		 */
		public static function createNewInstance(c:Class = null , initProperties:Object = null ):* 
		{
			if ( c == null )
			{
				return null ;
			}
			var instance:Object = new c( ) ;
			if (initProperties != null) 
			{
				for (var prop:String in initProperties)
				{
					instance[prop] = initProperties[prop];
				}
			}
			return instance ;
		}
		
		/**
		 * Returns {@code true} if the first specified object extends the second specified parent Class.
		 * @return {@code true} if the first specified object extends the second specified parent Class.
		 */
		public static function extendsClass( clazz:Class , parent:Class ):Boolean
		{
			if ( clazz == null || parent == null )
			{
				return false ;
			}
			return describeType(clazz).factory.extendsClass.( @type == getQualifiedClassName( parent ) ).length() > 0  ;
		}		
		
		/**
		 * Returns {@code true} if the specified first Class in argument implements the specified interface.
		 * @return {@code true} if the specified first Class in argument implements the specified interface.
		 */
		public static function implementsInterface( clazz:Class , interf:Class ):Boolean
		{
			if ( clazz == null || interf == null )
			{
				return false ;
			}
			return describeType(clazz).factory.implementsInterface.( @type == getQualifiedClassName( interf ) ).length() > 0  ;
		}

		/**
		 * Returns the unique name of the specified instance in argument.
		 * @return the unique name of the specified instance in argument.
		 */
		public static function getUniqueName(instance:*):String
		{
			var name:String = Reflection.getClassName( instance ) ;
			var charCode:int = name.charCodeAt( name.length - 1 );
			if (charCode >= 48 && charCode <= 57)
			{
				name += "_" ;
			}
			var count:uint ;
			if ( instance is IHashable )
			{
				count = (instance as IHashable).hashCode() ;		 
			}	
			else
			{
				count = HashCode.next() ;
			}
			
			return name + count ;
		}

	}
}