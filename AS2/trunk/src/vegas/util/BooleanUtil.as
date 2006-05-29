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

/** BooleanUtil

	AUTHOR
	
		Name : BooleanUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2005-12-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static clone(b:Boolean):Boolean
		
		- static copy(b:Boolean):Boolean
		
		- static equals(b1:Boolean, b2:Boolean):Boolean
		
		- static toBoolean(b:Boolean):Boolean
		
		- static toNumber(b:Boolean):Number
		
		- static toObject(b:Boolean):Object

**/

class vegas.util.BooleanUtil {

	// ----o Construtor
	
	private function BooleanUtil() {
		//
	}
	
	// ----o Static Methods

	static public function clone(b:Boolean):Boolean {
		return b ;
	}

	static public function copy(b:Boolean):Boolean {
		return b.valueOf() ;
	}

	static public function equals( b1:Boolean, b2:Boolean ):Boolean {
		if ( !b2 ) return false ;
		return b1.valueOf() == b2.valueOf() ;
    }
	
	static public function toBoolean(b:Boolean):Boolean {
		return b.valueOf() ;
	}
	
	static public function toNumber(b:Boolean):Number {
		return  b.valueOf() == true ? 1 : 0 ;
    }
	
	static public function toObject(b:Boolean):Object {
		return new Boolean( b.valueOf() ) ;
    }

	
	
}