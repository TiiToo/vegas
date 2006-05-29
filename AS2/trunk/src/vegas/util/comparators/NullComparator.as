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

/**	NullComparator

	AUTHOR
	
		Name : NullComparator
		Package : vegas.util.comparators
		Version : 1.0.0.0
		Date :  2005-10-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var comp:NullComparator = new NullComparator( o ) ;
	
	ARGUMENTS
	
		an object reference.
	
	METHOD SUMMARY
	
		- compare(o1, o2) : return a number
		
		- equals(o) : return a boolean
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject → NullComparator

	IMPLEMENTS
	
		IComparator, ISerializable, IFormattable

	TODO : ?? voir si vraiment utile pour le moment pas d'utilité ^_^

**/

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.errors.IllegalArgumentError;
import vegas.util.serialize.Serializer;

class vegas.util.comparators.NullComparator extends CoreObject implements IComparator, ISerializable {

	// ----o Constructor
	
	public function NullComparator( o ) {
		_oNull = o ;
	}
	
	// ----o Public Methods

	public function compare(o1, o2):Number {
		if (o1 == null && o2 == null) {
			return (o1 == o2) ? 1 : -1 ;
		} else {
			throw IllegalArgumentError ;
		}
	}
	
	public function equals(o):Boolean {
		if (_oNull) return (_oNull == null && o == null) ;
		else return (o == null) ;
	}
	
	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(_oNull)]) ;
	}
	
	// ----o Private Properties
	
	private var _oNull ;
	
}