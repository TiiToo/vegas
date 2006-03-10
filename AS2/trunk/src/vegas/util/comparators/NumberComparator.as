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

/* ------- 	NumberComparator

	AUTHOR

		Name : NumberComparator
		Package : vegas.util.comparators
		Version : 1.0.0.0
		Date :  2005-11-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var comp:NumberComparator = new NumberComparator(n:Number) ;
	
	ARGUMENTS
	
		n : a number object
	
	METHOD SUMMARY
	
		- compare(o1, o2):Number
			
			RETURNS 
			
				- -1 if o1 is "lower" than o2 ;
				- 1 if o1 is "higher" than o2 ;
				- 0 if o1 and o2 are equal.
		
		- equals(n:Number) : return a boolean
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject > NumberComparator

	IMPLEMENTS
	
		IComparator, ISerializable, IFormattable

----------  */

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.errors.IllegalArgumentError;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.util.comparators.NumberComparator extends CoreObject implements IComparator, ISerializable {

	// ----o Constructor
	
	public function NumberComparator( p_n:Number ) {
		n = p_n ;
	}
	
	// ----o Public Properties
	
	public var n ;
	
	// ----o Public Methods

	public function compare(o1, o2):Number {
		if ( TypeUtil.typesMatch(o1, Number) && TypeUtil.typesMatch(o2, Number )) {
			if( o1 < o2 ) return -1;
			else if( o1 > o2 ) return 1;
			else return 0 ;
		} else {
			throw IllegalArgumentError ;
		}
	}
	
	public function equals(o):Boolean {
		if (TypeUtil.typesMatch(o, Number) ) {
			return compare(n, o) == 0 ;
		} else {
			return false ;
		}
	}

	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(n)]) ;
	}
	
}