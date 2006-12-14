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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.errors.IllegalArgumentError;
import vegas.util.serialize.Serializer;

/**
 * This comparator compare Null objects.
 * @author eKameleon
 */
class vegas.util.comparators.NullComparator extends CoreObject implements IComparator, ISerializable 
{

	/**
	 * Creates a new NullCompator instance.
	 */
	public function NullComparator( o ) {
		_oNull = o ;
	}
	
	/**
	 * Returns an integer value to compare two 'null' objects.
	 * @param o1 the first 'null' object to compare.
	 * @param o2 the second 'null' object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws IllegalArgumentError if compare(a, b) and 'a' and 'b' must be Number objects.
	 */
	public function compare(o1, o2):Number 
	{
		if (o1 == null && o2 == null) 
		{
			return (o1 == o2) ? 1 : -1 ;
		} 
		else 
		{
			throw IllegalArgumentError(this + " : compare(), Arguments 'null' expected") ; ;
		}
	}

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		if (_oNull) return (_oNull == null && o == null) ;
		else return (o == null) ;
	}

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(_oNull)]) ;
	}
	
	private var _oNull ;
	
}