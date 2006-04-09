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

/** URLRequestHeader

	AUTHOR

		Name : URLRequestHeader
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-03-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY

		- name:String
			An HTTP request header name (such as Content-Type or SOAPAction).
		
		- value:String
			The value associated with the name property (such as text/plain).

	METHOD SUMMARY
	
		- hashCode():Number

		- toString():String
		
	INHERIT
	
		CoreObject > URLRequestHeader
		
	IMPLEMENTS
	
		IFormattable, IHashable

**/

import vegas.core.CoreObject;
import vegas.util.ConstructorUtil;

/**
 * @author eKameleon
 */
 
class asgard.net.URLRequestHeader extends CoreObject {
	
	// ----o Constructor
	
	public function URLRequestHeader(sName:String, sValue:String) {
		super() ;
		name = sName || "" ;
		value = sValue || "" ;
	}

	// ----o Public Properties
	
	public var name:String ;
	
	public var value:String ;
	
	// ----o Public Methods
	
	/*override*/ public function toString():String {
		return "[" + ConstructorUtil.getName(this) + " name:" + name + ", value:" + value + "]" ;
	}

	
}