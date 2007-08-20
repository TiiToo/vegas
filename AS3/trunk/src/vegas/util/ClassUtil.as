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
	
	import flash.utils.getQualifiedClassName ;
	import flash.utils.getQualifiedSuperclassName ;
	
	import vegas.core.HashCode ;
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
		static public function createNewInstance(c:Class = null , initProperties:Object = null ) :* 
		{
			if ( c == null )
			{
			    return null ;
			}
			var instance:Object = new c() ;
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
	     * Returns the name string representation of the specified instance passed in arguments.
    	 * @param instance the reference of the object to apply reflexion.
    	 */
		static public function getName(instance:*):String 
		{
			return _formatName(getPath(instance)) ;
		}
		
		/**
		 * Returns the unique name of the specified instance in argument.
		 * @return the unique name of the specified instance in argument.
		 */
		static public function getUniqueName(instance:*):String
		{
			var name:String = getName(instance) ;
			
			var charCode:int = name.charCodeAt(name.length - 1);
			if (charCode >= 48 && charCode <= 57)
			{
				name += "_" ;
			}
			
			var count:uint = 0 ;
			
			if (instance is IHashable)
			{
				//			 
			}	
			else
			{
				HashCode.initialize(instance) ;
			}
			
			count += instance["hashCode"]() ;
			
			return name + count ;
		}

    	/**
    	 * Returns the package string representation of the specified instance passed in arguments.
    	 * @param instance the reference of the object to apply reflexion.
    	 */
		static public function getPackage(instance:*):String 
		{
			return _formatPackage(getPath(instance)) ;
		}	

    	/**
    	 * Returns the full path string representation of the specified instance passed in arguments (package + name).
    	 * @param instance the reference of the object to apply reflexion.
    	 */
		static public function getPath(instance:*):String 
		{
            return _formatPath(flash.utils.getQualifiedClassName(instance)) ;
		}

		static public function getSuperName(instance:*):String 
		{
			return _formatName(getSuperPath(instance)) ;
		}

		static public function getSuperPackage(instance:*):String 
		{
			return _formatPackage(getSuperPath(instance)) ;
		}
		
		static public function getSuperPath(instance:*):String 
		{
			return _formatPath(flash.utils.getQualifiedSuperclassName(instance)) ;
		}
	
		private static var _counter:uint = 0;

		static private function _formatName( path:String ):String 
		{
			var a:Array = path.split(".") ;
            return (a.length > 1) ? a.pop() : path ;
		}

		static private function _formatPackage( path:String ):String 
		{
			var a:Array = path.split(".") ;
			if (a.length > 1) 
			{
				a.pop() ;
	            return a.join(".") ;
			}
			else 
			{
				return null ;
			}
		}
		
		static private function _formatPath( path:String ):String 
		{
			return (path.split("::")).join(".") ;
		}
		
	}

}