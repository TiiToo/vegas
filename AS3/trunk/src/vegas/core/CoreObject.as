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

/*	CoreObject

	AUTHOR
	
		Name : CoreObject
		Package : vegas.core
		Version : 1.0.0.0
		Date :  2006-07-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
		
		- hashCode():Number
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String

	INHERIT
	
		Object → CoreObject
	
	IMPLEMENT
	
		IFormattable, IHashable, ISerializable

	EXAMPLE
	
		var core:CoreObject = new CoreObject() ;
		trace("> core : " + core) ;
		trace("> hashcode : " + core.hashCode()) ;
		trace("> toSource : " + core.toSource()) ;
    
 */

package vegas.core
{
	
	import vegas.core.IFormattable ;
	import vegas.core.IHashable ;
	import vegas.core.ISerializable ;
	import vegas.util.ClassUtil ;
		
	public class CoreObject implements IFormattable, IHashable, ISerializable
	{
		
		// ----o Constructor
		
		function CoreObject() 
		{
		//				
		}
		
    	// ----o Init HashCode
	
		HashCode.initialize(CoreObject.prototype) ;
		
		// ----o Public Methods
		
		public function hashCode():uint {
			return null ;
		}

		public function toSource(...arguments):String {
			return "new CoreObject()" ;
		}

		public function toString():String {
			return "[" + ClassUtil.getName(this) + "]" ;
		}

	}
	
}