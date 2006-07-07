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

/** HashCode

	AUTHOR
	
		Name : HashCode
		Package : vegas.core
		Version : 1.0.0.0
		Date :  2006-02-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static equals(o1, o2):Boolean
		
			return 'true' if o1 and o2 are the same HashCode.
		
		- static identify(o):Number
		
			return the hashcode of an object.
		
		- static next():Number
		
			return the next unique hashCode number.
		
		- static nextName():String
		
			Returns next available object's name. Use for building a default name for an object.

 **/

package vegas.core
{
	public class HashCode
	{
		
		// ----o Public Methods

		/**
		 * Compare two IHashable objects.
		 * @usage   var isEquals:Boolean = HashCode.equals(o1, o2) ;
		 * @param   o1 
		 * @param   o2 
		 * @return  
		 */
		static public function equals(o1:*, o2:*):Boolean {
			return HashCode.identify(o1) == HashCode.identify(o2) ;
		}
	
		static public function identify(o:*):uint {
			return o.hashCode() ;
		}
		
		static public function next():uint {
			return HashCode._nHash++ ;
		}
	
		static public function nextName():String {
			return String( HashCode._nHash + 1 ) ;
		}
		
		// ----o Private Properties
		
		static private var _nHash:uint = 0 ;
	
		// ----o Private Methods
		
		static public function initialize( o:* ):Boolean {
			if (o.hasOwnProperty("hasCode")) return false ;
			
			o["hashCode"] = function ():uint {
				if (this.__hashcode__ == null) {
					this.__hashcode__ = HashCode.next() ;
					this.setPropertyIsEnumerable("__hashcode__", false) ;
				}
				return this.__hashcode__ ;
			} ;
			o.setPropertyIsEnumerable("hashCode", false) ;
			return true ;
		}
		
		HashCode.initialize( Object.prototype ) ;
			
	}
}


