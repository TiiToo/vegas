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

/* ---------- ObjectUtil

	AUTHOR

		Name : ObjectUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2006-01-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- static hasProperty(o, prop:String)
			
			Returns a Boolean value indicating whether an object has a property with the specified name (*ECMA-262*).
			Returns true whether the property is in the prototype chain or not.

----------  */

class vegas.util.ObjectUtil {
	
	// ----o Constructor
	
	private function ObjectUtil() {
		//
	}

	// ----o Static Methods

	static public function hasProperty(o, prop:String):Boolean {
		return (o.hasOwnProperty(prop) || o.__proto__.hasOwnProperty(prop)) ;
	}



}
