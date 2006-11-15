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

import vegas.core.types.Bit;

/**
 * @author eKameleon
 */
class vegas.core.types.Byte extends Bit 
{

	/**
	 * Creates a new Byte instance.
	 */
	public function Byte(bytes:Number) 
	{
		super(bytes*BYTE);
	}

	static public var SHORT_BYTE:String = "B" ;

	static public var SHORT_KILO_BYTE:String = "KB";

	static public var SHORT_MEGA_BYTE:String = "MB";

	static public var SHORT_GIGA_BYTE:String = "GB";

	static public var SHORT_TERA_BYTE:String = "TB";	

	/**
	 * Returns a string representation of the object.
	 */
	public function toString():String 
	{
		if (_bit < Bit.KBYTE) 
		{
			return getBytes() + Byte.SHORT_BYTE ;
		}
		else if(_bit < Bit.MBYTE) 
		{
			return getKBytes() + Byte.SHORT_KILO_BYTE ;
		}
		else if(_bit < Bit.GBYTE) 
		{
			return getMegaBytes() + Byte.SHORT_MEGA_BYTE ;
		}
		else if(_bit < Bit.TBYTE) 
		{
			return getGigaBytes() + Byte.SHORT_GIGA_BYTE ;
		}
		else 
		{
			return getTeraBytes() + Byte.SHORT_TERA_BYTE ;
		}
	}
	
}
