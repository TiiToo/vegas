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

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.errors.IllegalArgumentError;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;
	
/**
 * This comparator compare Date objects.
 * @author eKameleon
 */
class vegas.util.comparators.DateComparator extends CoreObject implements ICloneable, IComparator, ISerializable 
{

	/**
	 * Creates a new DateCompator instance.
	 */
	public function DateComparator(p_date) 
	{
		date = p_date ;
	}
	
	/**
	 * The current Date reference.
	 */
	public var date ;
	
	/**
	 * Creates and returns a shallow copy of the object.
	 * @return A new object that is a shallow copy of this instance.
	 */	
	public function clone() {
		return new DateComparator(date) ;
	}

	/**
	 * Returns an integer value to compare two Date objects.
	 * @param o1 the first Date object to compare.
	 * @param o2 the second Date object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws IllegalArgumentError if compare(a, b) and 'a' and 'b' must be Date or uint objects.
	 */
	public function compare(o1, o2):Number {
		var b1:Boolean = TypeUtil.typesMatch(o1, Number) || TypeUtil.typesMatch(o1, Date) ;
		var b2:Boolean = TypeUtil.typesMatch(o2, Number) || TypeUtil.typesMatch(o2, Date) ;
		if ( b1  && b2 ) 
		{
			var a:Number = (o1 instanceof Date) ? o1.valueOf() : o1 ;
			var b:Number = (o2 instanceof Date) ? o2.valueOf() : o2 ;
			if( a < b ) return -1;
			else if( a > b ) return 1;
			else return 0 ;
		}
		else 
		{
			throw new IllegalArgumentError(this + ".compare(a, b), 'a' and 'b' must be Date or uint objects.") ;
		}
	}

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		if (o instanceof Date) 
		{
			return compare(date, o) == 0 ;
		}
		else 
		{
			return false ;
		}
	}

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	public function toSource(indent:Number, indentor:String):String
	{
		return Serializer.getSourceOf(this, [Serializer.toSource(date)]) ;
	}
	
}