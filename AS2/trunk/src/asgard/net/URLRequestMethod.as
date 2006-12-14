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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** URLRequest

	AUTHOR

		Name : URLRequestMethod
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-03-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		static const GET:String = "GET" 
			Specifies that the URLRequest is a GET.

		static const POST:String = "POST"
			Specifies that the URLRequest is a POST.
	
	METHOD SUMMARY

		static validate(sMethod:String):Boolean

**/

/**
 * @author eKameleon
 */
 
class asgard.net.URLRequestMethod {
	
	// ----o Constructor
	
	private function URLRequestMethod() {
		//	
	}
	
	// ----o Constants
	
	static public var GET:String = "GET" ;
	
	static public var POST:String = "POST" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(URLRequestMethod, null , 7, 7) ;
	
	// ----o Public Methods
	
	static public function validate(sMethod:String):Boolean {
		return (sMethod == URLRequestMethod.GET) || (sMethod == URLRequestMethod.POST) ;
	}
	
}