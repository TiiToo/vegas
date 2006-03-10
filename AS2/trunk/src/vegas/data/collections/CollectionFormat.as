﻿/*

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

/* ------- 	CollectionFormat

	AUTHOR

		Name : CollectionFormat
		Package : vegas.data.collections
		Version : 1.0.0.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- formatToString(o):String
	
	IMPLEMENT
	
		IFormat
	
----------  */

import vegas.core.IFormat;
import vegas.data.Collection;
import vegas.data.iterator.Iterator;

class vegas.data.collections.CollectionFormat implements IFormat {

	// ----o Constructor
	
	public function CollectionFormat() {
		//
	}
	
	// ----o Public Methods

	public function formatToString(o):String {
		if (o instanceof Collection) {
			var r:String = "{";
			var it:Iterator = o.iterator() ;
			while (it.hasNext()) {
				r += it.next().toString() ;
				if (it.hasNext()) r += ",";
			}
			r += "}";
			return r ;
		}
		return null ;
	}
	
}