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

/** Char

	AUTHOR
	
		Name : Char
		Package : vegas.core.types
		Version : 1.0.0.0
		Date :  2005-11-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- getCode():Number
		
		- hashCode():Number
		
		- toString():String
		
		- valueOf()
	
	INHERIT
	
		String → Char  

	IMPLEMENTS
	
		IFormattable, IHashable

**/

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;

class vegas.core.types.Char extends String implements IFormattable, IHashable {

	// ----o Construtor
	
	public function Char(s:String) {
		_char = (s || "").substring(0, 1) ;
	}

	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(Char.prototype) ;
	
	// ----o Public Methods
	
	public function getCode():Number {
		return _char.charCodeAt(0) ;
	}

	public function hashCode():Number {
		return null ;
	}
	
	public function toString():String {
		return _char.toString() ;
	}

	public function valueOf() {
		return _char.valueOf() ;
	}
	
	// ----o Private Properties
	
	private var _char:String ;
	
}