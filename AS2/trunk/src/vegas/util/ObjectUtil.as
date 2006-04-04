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

/** ObjectUtil

	AUTHOR

		Name : ObjectUtil
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2006-01-13
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- static clone(o)
		
		- static copy(o)
			
			Returns a copy by value of this object.
			
			See : ICopyable
			
		- static hasProperty(o, prop:String)
			
			Returns a Boolean value indicating whether an object has a property with the specified name (*ECMA-262*).
			Returns true whether the property is in the prototype chain or not.

		- static memberwiseClone( o )
			 Creates a shallow copy of the current Object.
		
		- static toBoolean(o):Boolean
		
		- static toNumber(o):Number
		
		- static toObject(o):Object
			
**/

import vegas.util.Copier;

class vegas.util.ObjectUtil {
	
	// ----o Constructor
	
	private function ObjectUtil() {
		//
	}

	// ----o Static Methods

	static public function clone(o) {
		return o ;	
	}

	static public function copy(o) {
		var obj = {} ;
		var prop:String ;
		for (prop in o) {
			if( ! o.hasOwnProperty( prop ) ) {
			  	continue ;
		  	} else if ( o[prop] == undefined ) {
		  		obj[prop] = undefined ;
		  	} else if ( o[prop] = null ) {
		  		obj[prop] = null ;
			} else {
		  		obj[prop] = Copier.copy(obj[prop]) ; 
		  	}
		}
		return obj ;
	}

	static public function hasProperty(o, prop:String):Boolean {
		return (o.hasOwnProperty(prop) || o.__proto__.hasOwnProperty(prop)) ;
	}

	static public function memberwiseClone( o ) {
    	var obj = {} ;
    	for( var prop:String in o ) {
        	obj[prop] = o[prop];
        }
		return obj;
    }

	static public function toBoolean(o):Boolean {
		return (new Boolean( o.valueOf() )).valueOf() ;
	}

	static public function toNumber(o):Number {
		return (new Number( o.valueOf() )).valueOf() ;
	}

	static public function toObject(o):Object {
		return new Object( o.valueOf() ) ;
	}

}
