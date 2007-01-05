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
import vegas.util.StringUtil;
import vegas.util.TypeUtil;

/**
 * This comparator compare String objects.
 * @author eKameleon
 */
class vegas.util.comparators.StringComparator extends CoreObject implements IComparator, ISerializable 
{

	/**
	 * Creates a new StringCompator instance.
	 */
	function StringComparator( str:String ) 
	{
		s = str ;
	}

	/**
	 * The string object to compare.
	 */
	public var s:String ;
	
	/**
	 * Allow to take into account the case for comparison.
	 */
	public var ignoreCase:Boolean ;

	/**
	 * Returns an integer value to compare two String objects.
	 * @param o1 the first String object to compare.
	 * @param o2 the second String object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws IllegalArgumentError if compare(a, b) and 'a' and 'b' must be String objects.
	 */
	public function compare(o1, o2):Number 
	{
		if ( o1 == null || o2 == null) 
		{
			if (o1 == o2) 
			{
				return 0 ;
			}
			else if (o1 == null) 
			{
				return -1 ;
			}
			else 
			{
				return 1 ;
			}
		}
		else 
		{
			if ( !TypeUtil.typesMatch(o1, String) || !TypeUtil.typesMatch(o2, String)) 
			{
				throw IllegalArgumentError(this + " compare() method failed, Arguments string expected") ;
			}
			else 
			{
				o1 = o1.toString() ;
				o2 = o2.toString() ;
				if (ignoreCase) 
				{
					o1 = o1.toLowerCase() ;
					o2 = o2.toLowerCase() ;
				}
				if (o1 == o2) 
				{
					return 0 ;
				}
				var i:Number = 0 ;
				var c:Number ;
				while ( i < Math.min(o1.length,o2.length) )
				{
					c = StringUtil.compareChars( o1.charAt(i), o2.charAt(i));
					if ( c != 0 ) 
					{
						return c;
					}
					i++ ;
				}
				if ( o1.length > o2.length ) 
				{
					return 1 ;
				}
				if (o1.length < o2.length ) 
				{
					return -1 ;
				}
			}
		}
	}

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	public function equals(o):Boolean 
	{
		if (TypeUtil.typesMatch(o, String)) 
		{
			return compare(s, o) == 0 ;
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
		return Serializer.getSourceOf(this, [s.toString()]) ;
	}
	
}