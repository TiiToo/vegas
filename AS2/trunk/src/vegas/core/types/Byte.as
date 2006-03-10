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

/* ------- Byte

	AUTHOR

		Name : Byte
		Package : vegas.core.types
		Version : 1.0.0.0
		Date :  2005-11-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANTS
	
		- SHORT_BYTE : Shortname of byte.
		
		- SHORT_KILO_BYTE : Shortname of kilo-byte.
		
		- SHORT_MEGA_BYTE : Shortname of mega-byte.
		
		- SHORT_GIGA_BYTE : Shortname of giga-byte.
		
		- SHORT_TERA_BYTE : Shortname of tera-byte. 
	
----------  */

import vegas.core.types.Bit;

class vegas.core.types.Byte extends Bit {

	// ----o Constructor
	
	public function Byte(bytes:Number) {
		super(bytes*BYTE);
	}

	// ----o Static Properties

	static public var SHORT_BYTE:String = "B" ;
	static public var SHORT_KILO_BYTE:String = "KB";
	static public var SHORT_MEGA_BYTE:String = "MB";
	static public var SHORT_GIGA_BYTE:String = "GB";
	static public var SHORT_TERA_BYTE:String = "TB";	

	static private var __ASPF__ = _global.ASSetPropFlags(Byte, null, 7, 7) ;

	// ----o Public Methods
	
	public function toString():String {
		if (_bit < Bit.KBYTE) return getBytes() + Byte.SHORT_BYTE ;
		else if(_bit < Bit.MBYTE) return getKBytes() + Byte.SHORT_KILO_BYTE ;
		else if(_bit < Bit.GBYTE) return getMegaBytes() + Byte.SHORT_MEGA_BYTE ;
		else if(_bit < Bit.TBYTE) return getGigaBytes() + Byte.SHORT_GIGA_BYTE ;
		else return getTeraBytes() + Byte.SHORT_TERA_BYTE ;
	}
	
}
