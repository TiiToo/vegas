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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This comparator compare two Number objects.
 * <p><b>Example :</b></p>
 * {@code
 * var c = new vegas.util.comparators.NumberComparator() ;
 * 
 * trace( c.compare(0,0) ) ; // 0
 * trace( c.compare(1,1) ) ; // 0
 * trace( c.compare(-1,-1) ) ; // 0
 * trace( c.compare(0.1,0.1) ) ; // 0
 * trace( c.compare( Number(Math.cos(25)) , 0.9912028118634736 ) ) ; // 0
 * trace( c.compare(1, 0) ) ; // 1
 * trace( c.compare(0, 1) ) ; // -1
 * }
 * @author eKameleon
 */
if (vegas.util.comparators.NumberComparator == undefined) 
{
	
	/**
	 * Creates a new NumberCompator instance.
	 */
	vegas.util.comparators.NumberComparator = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.IComparator
	 */
	vegas.util.comparators.NumberComparator.extend(vegas.core.IComparator) ;

	/**
	 * Returns an integer value to compare two Number objects.
	 * @param o1 the first Number object to compare.
	 * @param o2 the second Number object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws vegas.errors.ClassCastError if compare(a, b) and 'a' and 'b' must be Number objects.
	 */
	vegas.util.comparators.NumberComparator.prototype.compare = function (o1, o2) /*Number*/ 
	{
		if ( vegas.util.TypeUtil.typesMatch(o1, Number) && vegas.util.TypeUtil.typesMatch(o2, Number )) 
		{
			// fix float bug with Math methods and float number operations.
			o1 = Number(o1.toString()) ; 
			o2 = Number(o2.toString()) ;
			if( o1 < o2 )
			{
				return -1;
			}
			else if( o1 > o2 )
			{
				return 1;
			}
			else 
			{
				return 0 ;
			}
		}
		else 
		{
			throw new vegas.errors.ClassCastError(this + " compare method failed, Arguments number expected") ;
		}
	}
	
	/**
	 * Returns the singleton instance of this class.
	 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 * @return the singleton instance of this class.
	 */
	vegas.util.comparators.NumberComparator.getInstance = function() /*NumberComparator*/
	{
		var NumberComparator = vegas.util.comparators.NumberComparator ;
		if (NumberComparator._instance == null)
		{
			NumberComparator._instance = new NumberComparator() ;
		}
		return NumberComparator._instance ;	
	}

	/**
	 * The internal static singleton of this class.
	 */
	vegas.util.comparators.NumberComparator._instance /*NumberComparator*/ = null ;

}
