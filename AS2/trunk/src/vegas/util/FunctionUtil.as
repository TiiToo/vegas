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

/** FunctionUtil

	AUTHOR
	
		Name : FunctionUtil
		Package : vegas.util.type
		Version : 1.0.0.0
		Date :  2006-04-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- static clone(f:Function):Function
		
		- static copy(f:Function):Function
		
		- static equals( f1:Function, f2:Function ):Boolean

**/

class vegas.util.FunctionUtil {

	// ----o Construtor
	
	private function FunctionUtil() {
		//
	}
	
	// ----o Static Methods

	/**
	 * Returns a copy by value of this function.
	 * Attention : we can not copy by reference a function , if you want to do that use apply or call method to make a kind of delegate.
	 */
	static public function clone(f:Function):Function {
		return f ;
	}

	/**
	 * Returns a copy by value of this object.
	 */
	static public function copy(f:Function):Function {
		return Function(f.valueOf()) ;
	}

	/**
	 * Compare if two Functions are equal by reference.
 	 */
	static public function equals( f1:Function, f2:Function ):Boolean {
		if (! f2 ) return false ;
		return f1.valueOf() == f2.valueOf() ;
    }
	
}