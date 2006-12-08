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
import vegas.core.IComparator;
import vegas.core.ISerializable;
import vegas.util.serialize.Serializer;

/**
 * Reverse an IComparator.
 * @author eKameleon
 */
class vegas.util.comparators.ReverseComparator extends CoreObject implements IComparator, ISerializable 
{

	/**
	 * Creates a new ReverseComparator instance.
	 */
	public function ReverseComparator( c:IComparator ) 
	{
		comparator = c ;
	}
	
	/**
	 * The IComparator instance to reverse.
	 */	
	public var comparator:IComparator ;
	
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
	public function compare(o1, o2):Number 
	{
		return comparator.compare(o2, o1) ;
	}


	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		if ( this == o )  
		{
			return true ;
		}
		else if (null == o) 
		{
			return false ;
		}
		else if ( o.constructor == this.constructor ) 
		{
			var rc:ReverseComparator = ReverseComparator(o) ;
			return comparator.equals(rc.comparator) ;
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
		return Serializer.getSourceOf(this, [Serializer.toSource(comparator)]) ;
	}
	
}