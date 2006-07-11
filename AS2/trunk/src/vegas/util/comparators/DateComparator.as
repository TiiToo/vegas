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

/**	DateComparator

	AUTHOR

		Name : DateComparator
		Package : vegas.util.comparators
		Version : 1.0.0.0
		Date :  2005-09-18
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var comp:DateComparator = new DateComparator(myDate) ;
	
	ARGUMENTS
	
		myDate : a Date object or a timeStamp number.
	
	PROPERTY SUMMARY
	
		- date
	
	METHOD SUMMARY
	
		- compare(o1, o2):Number
			
			RETURNS 
			
				- -1 if o1 is "lower" than (less than, before, etc.) o2 ;
				- 1 if o1 is "higher" than (greater than, after, etc.) o2 ;
				- 0 if o1 and o2 are equal.
		
		- equals(d:Date):Boolean
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject → DateComparator

	IMPLEMENTS
	
		ICloneable, IComparator, IEquality, IFormattable, IHashable, ISerializable

**/

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.errors.IllegalArgumentError;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.util.comparators.DateComparator extends CoreObject implements ICloneable, IComparator, ISerializable {

	// ----o Constructor
	
	public function DateComparator(p_date) {
		date = p_date ;
	}
	
	// ----o Public Properties
	
	public var date ;
	
	// ----o Public Methods

	public function clone() {
		return new DateComparator(date) ;
	}
	
	public function compare(o1, o2):Number {
		var b1:Boolean = TypeUtil.typesMatch(o1, Number) || TypeUtil.typesMatch(o1, Date) ;
		var b2:Boolean = TypeUtil.typesMatch(o2, Number) || TypeUtil.typesMatch(o2, Date) ;
		if ( b1  && b2 ) {
				var a:Number = (o1 instanceof Date) ? o1.valueOf() : o1 ;
				var b:Number = (o2 instanceof Date) ? o2.valueOf() : o2 ;
				if( a < b ) return -1;
				else if( a > b ) return 1;
				else return 0 ;
				
		} else {
			throw new IllegalArgumentError() ;
		}
	}
	
	public function equals(o):Boolean {
		if (o instanceof Date) {
			return compare(date, o) == 0 ;
		} else {
			return false ;
		}
	}

	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(date)]) ;
	}
	
}