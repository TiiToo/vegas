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

/* ------- BooleanSerializer

	AUTHOR
	
		Name : BooleanSerializer
		Package : vegas.util.serialize
		Version : 1.0.0.0
		Date :  2005-12-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		EDEN Compatibility to serialize ECMAScript data.

	METHOD SUMMARY
	
		- static toSource(b:Boolean):String
	
----------  */

import vegas.util.BooleanUtil;

class vegas.util.serialize.BooleanSerializer {

	// ----o Construtor
	
	private function BooleanSerializer() {
		//
	}
	
	// ----o Static Methods

	static public function toSource( b:Boolean ):String {
		return BooleanUtil.equals(b, true) ? "true" : "false" ;
    }

}