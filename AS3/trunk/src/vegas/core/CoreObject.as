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

package vegas.core
{
	
	import vegas.core.IFormattable ;
	import vegas.core.IHashable ;
	import vegas.core.ISerializable ;
	import vegas.util.ClassUtil ;

	/**
	 * CoreObject offers a default implementation of the IFormattable, IHashable and ISerializable interfaces.
	 * <p>
	 * {@code
	 * import vegas.core.CoreObject ;
	 *  
	 * var core:CoreObject = new CoreObject() ;
	 * trace("> core : " + core) ;
	 * trace("> hashcode : " + core.hashCode()) ;
	 * trace("> toSource : " + core.toSource()) ;
	 * }
	 * </p>
	 * @author eKameleon
	 * @version 1.0.0.0
	 */
	public class CoreObject implements IFormattable, IHashable, ISerializable
	{
		
		/**
		 * Creates a new CoreObject instance.
		 */
		function CoreObject() 
		{
		//				
		}
		
		HashCode.initialize(CoreObject.prototype) ;
		
		/**
		 * Returns a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			return null ;
		}

		/**
		 * Returns a Eden reprensation of the object.
		 * @return a string representing the source code of the object.
		 */
		public function toSource(...arguments:Array):String 
		{
			return "new " + ClassUtil.getPath(this) + "()" ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public function toString():String 
		{
			return "[" + ClassUtil.getName(this) + "]" ;
		}

	}
	
}