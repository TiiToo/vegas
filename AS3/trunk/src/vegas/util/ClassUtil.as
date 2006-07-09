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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* ClassUtil

	AUTHOR
	
		Name : ClassUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2006-07-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		Constructor tools.
	
	METHOD SUMMARY
	
		- createNewInstance(c:Class, initProperties:Object=null):*
	
		- getName(instance:*):String
		
		- getPackage(instance:*):String
		
		- getPath(instance:*):String
		
		- getSuperName(instance:*):String
		
		- getSuperPackage(instance:*):String

		- getSuperPath(instance:*):String

**/

package vegas.util
{
	
	import flash.utils.getQualifiedClassName ;
	import flash.utils.getQualifiedSuperclassName ;
	
	public class ClassUtil
	{
		
		// ----o Public Methods
		
		static public function createNewInstance(c:Class, initProperties:Object=null):*
		{
			
			var instance:Object = new c ;
			if (initProperties != null) 
			{
				for (var prop:String in initProperties)
				{
        			instance[prop] = initProperties[prop];
				}
			}
			
		}
		
		static public function getName(instance:*):String 
		{
			return _formatName(getPath(instance)) ;
		}	

		static public function getPackage(instance:*):String 
		{
			return _formatPackage(getPath(instance)) ;
		}	

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
		
		// ----o Private Methods
		
		static private function _formatName( path:String ):String 
		{
			var a:Array = path.split(".") ;
            return (a.length > 1) ? a.pop() : path ;
		}

		static private function _formatPackage( path:String ):String 
		{
			var a:Array = path.split(".") ;
			if (a.length > 1) {
				a.pop() ;
	            return a.join(".") ;
			} else {
				return null ;
			}
		}
		
		static private function _formatPath( path:String ):String 
		{
			return (path.split("::")).join(".") ;
		}
		
	}

}