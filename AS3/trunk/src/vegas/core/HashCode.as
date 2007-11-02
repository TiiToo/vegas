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

package vegas.core
{

	/**
	 * Collected methods which allow easy implementation of <code>hashCode</code>.
	 * @author eKameleon
	 * @version 1.0.0.0
	 */
	public class HashCode
	{
		
		/**
		 * Compare two IHashable objects.
		 * @usage   var isEquals:Boolean = HashCode.equals(o1, o2) ;
		 * @param   o1 the first value to compare.
		 * @param   o2 the second value to compare.
		 * @return {@code true} of the two object are equals.  
		 */
		public static function equals(o1:*, o2:*):Boolean 
		{
			return HashCode.identify(o1) == HashCode.identify(o2) ;
		}
	
		/**
		 * Indenfity the hashcode value of an object.
		 */
		public static function identify(o:*):uint 
		{
			return o.hashCode() ;
		}

		/**
		 * Returns the next hashcode value.
		 * @return the next hashcode value.
		 */
		public static function next():uint 
		{
			return HashCode._nHash++ ;
		}

		/**
		 * Returns the string representation of the next hashcode value.
		 * @return the string representation of the next hashcode value.
		 */
		public static function nextName():String {
			return String( HashCode._nHash + 1 ) ;
		}
		
		/**
		 * Initialize the hashcode value of an object.
		 * @return {@code true}
		 */
		public static function initialize( o:* ):Boolean 
		{
		
			if (o.hasOwnProperty("hashCode")) 
			{
				return false ;
			}
			
			o["hashCode"] = function ():uint 
			{
				if (this.__hashcode__ == null) 
				{
					this.__hashcode__ = HashCode.next() ;
					this.setPropertyIsEnumerable("__hashcode__", false) ;
				}
				return this.__hashcode__ ;
			} ;
			
			o.setPropertyIsEnumerable("hashCode", false) ;

			return true ;
			
		}

		/**
		 * The internal hashcode counter.
		 */
		private static var _nHash:uint = 0 ;

		/**
		 * Launch the initialize of the Object.prototype object.
		 */
		HashCode.initialize( Object.prototype ) ;
			
	}
}


