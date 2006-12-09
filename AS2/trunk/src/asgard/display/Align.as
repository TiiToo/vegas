/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.util.ArrayUtil;

/**
 * The Align enumeration class provides constant values to align displays or components.
 * @author eKameleon
 */
class asgard.display.Align 
{

	static public var CENTER:Number = 0 ;

	static public var LEFT:Number = 2 ;

	static public var RIGHT:Number = 4 ;

	static public var TOP:Number = 8 ;

	static public var BOTTOM:Number = 16 ;

	static public var REVERSE:Number = 32 ;

	static public var BOTTOM_LEFT = BOTTOM | LEFT ;

	static public var BOTTOM_RIGHT = BOTTOM | RIGHT ;

	static public var TOP_LEFT = TOP | LEFT ;

	static public var TOP_RIGHT = TOP | RIGHT ;

	static public var LEFT_BOTTOM = BOTTOM_LEFT | REVERSE ;

	static public var RIGHT_BOTTOM = BOTTOM_RIGHT | REVERSE ;

	static public var LEFT_TOP = TOP_LEFT | REVERSE ;

	static public var RIGHT_TOP = TOP_RIGHT | REVERSE ;

	static public var aList:Array = 
	[ 
		Align.CENTER, Align.LEFT , Align.RIGHT, 
		Align.TOP, Align.BOTTOM, 
		Align.TOP_LEFT, Align.TOP_RIGHT,
		Align.BOTTOM_LEFT, Align.BOTTOM_RIGHT
	] ;

	static private var __ASPF__ = _global.ASSetPropFlags(Align, null , 7, 7) ;

	static public function toNumber(str:String):Number 
	{
		switch (str.toLowerCase()) 
		{
			case "l" : 
				return Align.LEFT ;
			case "r" :
				return Align.RIGHT ;
			case "t" :
				return Align.TOP ;
			case "b" :
				return Align.BOTTOM ;
			case "tl" :
				return Align.TOP_LEFT ;
			case "tr" :
				return Align.TOP_RIGHT ;
			case "bl" :
				return Align.BOTTOM_LEFT ;
			case "br" :
				return Align.BOTTOM_RIGHT ;
			case "lt" :
				return Align.LEFT_TOP ;
			case "rt" :
				return Align.RIGHT_TOP ;
			case "lb" :
				return Align.LEFT_BOTTOM ;
			case "rb" :
				return Align.RIGHT_BOTTOM ;
			default :
				return Align.CENTER ;
		}
	}

	static public function toString(n:Number):String 
	{
		switch (n) {
			case Align.LEFT : return "l" ;
			case Align.RIGHT : return "r" ;
			case Align.TOP : return "t" ;
			case Align.BOTTOM : return "b" ;
			case Align.TOP_LEFT : return "tl" ; 
			case Align.TOP_RIGHT : return "tr" ;
			case Align.BOTTOM_LEFT  : return "bl" ;
			case Align.BOTTOM_RIGHT : return "br" ;
			case Align.LEFT_TOP : return "lt" ; 
			case Align.RIGHT_TOP : return "rt" ;
			case Align.LEFT_BOTTOM : return "lb" ;
			case Align.RIGHT_BOTTOM : return "rb" ;
			default : return "" ;
		}
	}

	static public function validate(n:Number):Boolean 
	{
		return  ArrayUtil.contains(aList, n) ;
	}
	
}