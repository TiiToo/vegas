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

/** ErrorFormat


	AUTHOR

		Name : ErrorFormat
		Package : vegas.errors
		Version : 1.0.0.0
		Date : 2006-01-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- formatToString(o):String

	INHERIT
	
		CoreObject → ErrorFormat

	IMPLEMENT
	
		IFormat, IFormattable, IHashable
	
**/

import vegas.core.CoreObject;
import vegas.core.IFormat;
import vegas.errors.AbstractError;
import vegas.util.ConstructorUtil;

class vegas.errors.ErrorFormat extends CoreObject implements IFormat {
    
	// ----o Constructor
	
	public function ErrorFormat() {
		//
	}
	
	// ----o Public Method
	
	public function formatToString(o):String {
		o = AbstractError(o) ;
		var txt:String = "[" + ConstructorUtil.getName(o) + "]" ;
		var msg = o.getMessage() ;
		if (msg && msg.length > 0) txt += " " + msg ;
		return txt ;
	}
	
}
