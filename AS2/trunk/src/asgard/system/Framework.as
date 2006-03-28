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

/* ---------- Framework

	AUTHOR

		Name : Framework
		Package : asgard.system
		Version : 1.0.0.0
		Date : 2005-09-11
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	STATIC PROPERTY SUMMARY
	
		- COPYRIGHT
		
	STATIC METHOD SUMMARY
	
		- getAuthor():String
		
		- getLicence():String

		- getLink():String
		
		- getMail():String
		
		- getName():String
		
		- getVersion():Version
		
		- setAuthor(s:String)
		
		- setLicence(s:String)

		- setLink(s:String)
		
		- setMail(s:String)
		
		- setName(s:String)
		
		- setVersion(v:Version)
		
		- toString():String
		
----------  */

import asgard.system.Version;

class asgard.system.Framework {
	
	// -----o Constructor
	
	private function Framework() {}

	// ----o Properties
	
	static public var COPYRIGHT = {} ;
	
	// ---- Methods
	
	static public function getAuthor():String {
		return COPYRIGHT.author ;
	}
	
	static public function getLicence():String {
		return COPYRIGHT.licence ;
	}
	
	static public function getLink():String {
		return COPYRIGHT.link ;
	}
	
	static public function getMail():String {
		return COPYRIGHT.mail ;
	}
	
	static public function getName():String {
		return COPYRIGHT.name ;
	}
	
	static public function getVersion():Version {
		return COPYRIGHT.version ;
	}
		
	static public function setAuthor(s:String):Void {
		COPYRIGHT.author = s ;
	}

	static public function setLicence(s:String):Void {
		COPYRIGHT.licence = s ;
	}

	static public function setLink(s:String):Void {
		COPYRIGHT.link = s ;
	}

	static public function setMail (s:String):Void {
		COPYRIGHT.mail = s ;
	}
	
	static public function setName(s:String):Void {
		COPYRIGHT.name = s ;
	}
	
	static public function setVersion(v:Version):Void {
		COPYRIGHT.version = v ;
	}
	
	static public function toString():String {
		var txt:String = "<" ;
		for (var prop in COPYRIGHT) {
			txt += "\r\t" + prop + " : " + (COPYRIGHT[prop].toString() || "empty") ;
		}
		txt += "\r>" ;
		return txt ;
	}

}