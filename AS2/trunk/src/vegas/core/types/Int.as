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

/* ------- Int

	AUTHOR
	
		Name : Int
		Package : vegas.core.types
		Version : 1.0.0.0
		Date :  2005-11-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Nombre entier

	METHODS

		- toString()
		
		- valueOf()
	
	IMPLEMENTS
	
		IFormattable
		
	INHERIT
	
		Number
			|
			Int

----------  */

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.errors.NumberFormatError;

class vegas.core.types.Int extends Number implements IFormattable {

	// ----o Construtor
	
	public function Int(n:Number) {
		if (n == Infinity || n == -Infinity) {
			throw new NumberFormatError() ;
		} else {
			_int = n - n%1 ;
		}
	}
	
	// ----o Init HashCode
	
	static private var _initHashCode:Boolean = HashCode.initialize(Int.prototype) ;
	
	// ----o Public Methods

	public function hashCode():Number {
		return null ;
	}
	
	public function toString():String {
		return _int.toString() ;
	}

	public function valueOf() {
		return _int ;
	}
	
	// ----o Private Properties
	
	private var _int:Number ;

	
}