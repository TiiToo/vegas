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

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.util.MathsUtil;

/**
 * @author eKameleon
 */
class vegas.core.types.Bit extends Number implements IFormattable, IHashable 
{

	/**
	 * Creates a new Bit instance.
	 */
	public function Bit(n:Number) 
	{
		_bit = n ;
		_comma = DEFAULT_FLOATING_POINTS ;
	}

	/**
	 * Init the hashcode representation of the class.
	 */
	static private var _initHashCode:Boolean = HashCode.initialize(Bit.prototype) ;

	static public var DEFAULT_FLOATING_POINTS:Number = 2 ;

	static public var KBIT:Number = 1024 ; // KILO BIT

	static public var MBIT:Number = KBIT * KBIT ; // MEGA BIT

	static public var GBIT:Number = MBIT * KBIT ; // GIGA BIT

	static public var TBIT:Number = GBIT * KBIT ; // TERA BIT
	
	static public var BYTE:Number = 8 ; // BYTE

	static public var KBYTE:Number = 1024 * BYTE ; // KILO BYTE

	static public var MBYTE:Number = KBYTE * 1024 ; // MEGA BYTE

	static public var GBYTE:Number = MBYTE * 1024 ; // GIGA BYTE

	static public var TBYTE:Number = GBYTE * 1024 ; // TERA BYTE
	
	static public var SB:String = "b" ;

	static public var SKB:String = "Kb" ;

	static public var SMB:String = "Mb" ;

	static public var SGB:String = "Gb" ;

	static public var STB:String = "Tb" ;

	public function getBit():Number 
	{
		return _bit ;
	}
	
	public function getBytes():Number 
	{
		return MathsUtil.round( _bit / BYTE, _comma) ;
	}

	public function getKBit():Number {
		return MathsUtil.round( _bit / KBIT, _comma) ;
	}

	public function getKBytes():Number 
	{
		return MathsUtil.round( _bit / KBYTE, _comma) ;
	}
	
	public function getMegaBit():Number 
	{
		return MathsUtil.round( _bit / MBIT, _comma) ;
	}

	public function getMegaBytes():Number 
	{
		return MathsUtil.round( _bit / MBYTE, _comma) ;
	}

	public function getGigaBit():Number 
	{
		return MathsUtil.round( _bit / GBIT, _comma) ;
	}
	
	public function getGigaBytes():Number 
	{
		return MathsUtil.round( _bit / GBYTE, _comma) ;
	}
	
	public function getTeraBit():Number 
	{
		return MathsUtil.round( _bit / TBIT, _comma);
	}

	public function getTeraBytes():Number 
	{
		return MathsUtil.round(_bit / TBYTE, _comma);
	}

	/**
	 * Returns a hash code value for the object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}
	
	public function setFloatingPoints(n:Number):Bit 
	{
		_comma = (n > 0) ? n : 0 ;
		return this ;
	}

	/**
	 * Returns a string representation of the object.
	 */
	public function toString():String 
	{
		if (_bit < KBIT) return getBit() + SB ;
		else if(_bit < MBIT) return getKBit() + SKB ;
		else if(_bit < GBIT) return getMegaBit() + SMB ;
		else if(_bit < TBIT) return getGigaBit() + SGB ;
		else return getTeraBit() + STB ;
	}
	
	/**
	 * Returns the real value of the object.
	 */
	public function valueOf() 
	{
		return getBytes().valueOf();
	}
	
	// ----o Private Properties
	
	private var _bit:Number ;
	private var _comma:Number ;
	

}
