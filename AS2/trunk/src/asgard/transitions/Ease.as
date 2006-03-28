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

/** Ease

	AUTHOR

		Name : Ease
		Package : asgard.transitions
		Version : 1.0.0.0
		Date :  2005-12-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		EASE_IN : easeIn
		
		EASE_IN_OUT : easeInOut
		
		EASE_OUT : easeOut
		
	METHOD SUMMARY
	
		- static easeIn (t:Number, b:Number, c:Number, d:Number):Number
		
		- static easeOut (t:Number, b:Number, c:Number, d:Number):Number
		
		- static easeInOut (t:Number, b:Number, c:Number, d:Number):Number
		
		- validate(constructor:Function):Boolean
		
----------  */	

import vegas.util.ConstructorUtil ;

class asgard.transitions.Ease {

	// ----o Constructor
	
	private function Ease() {
		//
	}
	
	// ----o Constants
	
	static public var EASE_IN:String = "easeIn" ; 
	static public var EASE_IN_OUT:String = "easeInOut" ;
	static public var EASE_OUT:String = "easeOut" ;
		
	static private var __ASPF__ = _global.ASSetPropFlags(Ease, null , 7, 7) ;
	
	// ----o Static Methods
	
	static public function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
		return null ;
	}
	
	static public function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
		return null ;
	}
	
	static public function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
		return null ;
	}
	
	static public function validate( c:Function ):Boolean {
		 return ConstructorUtil.isSubConstructorOf(c, Ease) ;
	}
	
}