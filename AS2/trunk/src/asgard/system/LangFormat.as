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

/* ---------- 	LangFormat

	AUTHOR

		Name : LangStrigifier
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2005-07-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- formatToString(o):String
	
	IMPLEMENTS
	
		IFormat
	
----------  */

import vegas.core.IFormat;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;

class asgard.system.LangFormat implements IFormat {

	// ----o Constructor
	
	public function LangFormat() {}
		
	// ----o Public Methods

	public function formatToString(o):String {
		var l:HashMap = o.LANGS ;
		var txt:String = "[Lang" ;
		if (l.size() > 0) {
			txt += " : " ;
			var it:Iterator = l.iterator() ;
			while(it.hasNext()) { 
				txt += "\r\t" + it.next() ;
			} 
			txt += "\r" ;
		} 
		txt += "]" ;
		return txt ;
	}
	
}


