/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.util.ConstructorUtil;

class pegas.transitions.Ease 
{

	static public var EASE_IN:String = "easeIn" ; 

	static public var EASE_IN_OUT:String = "easeInOut" ;

	static public var EASE_OUT:String = "easeOut" ;
		
	static private var __ASPF__ = _global.ASSetPropFlags(Ease, null , 7, 7) ;
	
	static public function easeIn (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return null ;
	}
	
	static public function easeOut (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return null ;
	}
	
	static public function easeInOut (t:Number, b:Number, c:Number, d:Number):Number 
	{
		return null ;
	}
	
	static public function validate( c:Function ):Boolean 
	{
		 return ConstructorUtil.isSubConstructorOf(c, Ease) ;
	}
	
}