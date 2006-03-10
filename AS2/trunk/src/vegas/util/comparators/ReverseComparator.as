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

/* ------- ReverseComparator

	AUTHOR
		
		Name : ReverseComparator
		Package : vegas.util.comparators
		Version : 1.0.0.0
		Date :  2005-10-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	DESCRIPTION
	
		reverse a comparator result

	CONSTRUCTOR
	
		var comp:ReverseIComparator = new ReverseComparator( o ) ;
	
	ARGUMENTS
	
		an object
	
	METHOD SUMMARY
	
		- compare(o1, o2) : return a number
		
		- equals(o) : return a boolean
		
		- ToSource():String
		
		- toString():String

	INHERIT
	
		Object > CoreObject > ReverseIComparator

	IMPLEMENTS
	
		IComparator, ISerializable, IFormattable, IHashable
		
----------  */

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.util.serialize.Serializer;

class vegas.util.comparators.ReverseComparator extends CoreObject implements IComparator, ISerializable {

	// ----o Constructor
	
	public function ReverseComparator( c:IComparator ) {
		comparator = c ;
	}

	// ----o Public Properties
	
	public var comparator:IComparator ;
	
	// ----o Public Methods

	public function compare(o1, o2):Number {
		return comparator.compare(o2, o1) ;
	}
	
	public function equals(o):Boolean {
		if ( this == o )  return true ;
		else if (null == o) return false ;
		else if ( o.constructor == this.constructor ) {
			var rc:ReverseComparator = ReverseComparator(o) ;
			return comparator.equals(rc.comparator) ;
		} else {
			return false ;
		}
	}

	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(comparator)]) ;
	}

	
}