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

/* ------ ApplicationType
 
	AUTHOR
 
		Name : ApplicationType
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2005-09-15
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
 
	CONSTANT SUMMARY
	
		- FILE:String
		
			"file"
		
		- FTP:String
		
			"ftp"
		
		- HTTP:String
		
			"http"
		
		- HTTPS:String
		
			"https"
	
------ */

class asgard.system.ApplicationType {

	// ----o Constructor
	
	private function ApplicationType() {
		//
	}

	// ----o Static Properties
	
	static public var FILE:String = "file" ;
	static public var FTP:String = "ftp" ;
	static public var HTTP:String = "http" ;
	static public var HTTPS:String = "https" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(ApplicationType, null , 7, 7) ;
	
}