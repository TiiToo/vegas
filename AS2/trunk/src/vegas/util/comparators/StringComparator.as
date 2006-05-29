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

/**	StringComparator

	AUTHOR

		Name : StringComparator
		Package : vegas.util.comparators
		Version : 1.0.0.0
		Date :  2005-11-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var comp:StringIComparator = new StringIComparator(str:String) ;
	
	ARGUMENTS
	
		s : a string object
	
	PROPERTY SUMMARY
	
		- ignoreCase:Boolean
		
			allow to take into account the case for comparison
	
	METHOD SUMMARY
	
		- compare(o1, o2):Number
			
			RETURNS 
			
				- -1 if o1 is "lower" than o2 ;
				- 1 if o1 is "higher" than o2 ;
				- 0 if o1 and o2 are equal.
		
		- equals(o) : return a boolean
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject → StringComparator

	IMPLEMENTS
	
		IComparator, IFormattable, IHashable, ISerializable

**/

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.errors.IllegalArgumentError;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.util.comparators.StringComparator extends CoreObject implements IComparator, ISerializable {

	// ----o Constructor
	
	function StringComparator( str:String ) {
		s = str ;
	}
	
	// ----o Public Properties
	
	public var s:String ;
	public var ignoreCase:Boolean ;
	
	// ----o Public Methods

	public function compare(o1, o2):Number {
		if ( o1 == null || o2 == null) {
			if (o1 == o2) return 0 ;
			else if (o1 == null) return -1 ;
			else return 1 ;
		} else {
			if ( !TypeUtil.typesMatch(o1, String) || !TypeUtil.typesMatch(o2, String)) {
				throw IllegalArgumentError(this + " : compare(), Arguments string expected") ;
			} else {
				if (ignoreCase) {
					o1 = String(o1).toLowerCase() ;
					o2 = String(o2).toLowerCase() ;
				}
				if (o1 == o2) return 0 ;
				if (String(o1).length > String(o2).length) return 1 ;
				else return -1 ;
			}
		}
	}
	
	public function equals(o):Boolean {
		if (TypeUtil.typesMatch(o, String)) {
			return compare(s, o) == 0 ;
		} else {
			return false ;
		}
	}
	
	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [s.toString()]) ;
	}
	
}