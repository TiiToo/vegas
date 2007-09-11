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
 * This comparator compare Date objects.
 * <p><b>Example :</b></p>
 * {@code
 * var comp:DateComparator = new vegas.util.comparators.DateComparator() ;
 * 
 * var d1:Date   = new Date(2007, 1, 1) ;
 * var d2:Number =  1170284400000 ;
 * var d3:Date   = new Date(2007, 2, 2) ;
 * var d4:Number = 1172790000000 ;
 * 
 * trace( comp.compare(d1, d1) ) ; // 0
 * trace( comp.compare(d1, d2) ) ; // 0
 * trace( comp.compare(d2, d1) ) ; // 0
 * trace( comp.compare(d1, d3) ) ; // -1
 * trace( comp.compare(d1, d4) ) ; // -1
 * trace( comp.compare(d3, d1) ) ; // 1
 * trace( comp.compare(d4, d1) ) ; // 1
 * }
 * @author eKameleon
 */
if (vegas.util.comparators.DateComparator == undefined) 
{
	
	/**
	 * @requires vegas.util.comparators.NumberComparator
	 */
	require("vegas.util.comparators.NumberComparator") ;
	
	/**
	 * Creates a new DateCompator instance.
	 */
	vegas.util.comparators.DateComparator = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.IComparator
	 */
	vegas.util.comparators.DateComparator.extend(vegas.core.IComparator) ;

	/**
	 * Returns an integer value to compare two Date objects.
	 * @param o1 the first Date object to compare.
	 * @param o2 the second Date object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws ClassCastError if compare(a, b) and 'a' and 'b' must be Date or uint objects.
	 */
	vegas.util.comparators.DateComparator.prototype.compare = function (o1, o2) /*Number*/ 
	{
		var b1 /*Boolean*/ = vegas.util.TypeUtil.typesMatch(o1, Number) || vegas.util.TypeUtil.typesMatch(o1, Date) ;
		var b2 /*Boolean*/ = vegas.util.TypeUtil.typesMatch(o2, Number) || vegas.util.TypeUtil.typesMatch(o2, Date)
		if (b1 && b2) 
		{
			var a /*Number*/ = (o1 instanceof Date) ? o1.valueOf() : o1 ;
			var b /*Number*/ = (o2 instanceof Date) ? o2.valueOf() : o2 ;
			return vegas.util.comparators.NumberComparator.getInstance().compare(a,b) ;
		} 
		else 
		{
			throw new vegas.errors.ClassCastError("DateComparator.compare(" + o1 + "," + o2 + ") failed.") ;
		}
	}
	
	/**
	 * Returns the singleton instance of this class.
	 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 * @return the singleton instance of this class.
	 */
	vegas.util.comparators.DateComparator.getInstance = function() /*DateComparator*/
	{
		var DateComparator = vegas.util.comparators.DateComparator ;
		if (DateComparator._instance == null)
		{
			DateComparator._instance = new DateComparator() ;
		}
		return DateComparator._instance ;	
	}

	/**
	 * The internal static singleton of this class.
	 */
	vegas.util.comparators.DateComparator._instance /*DateComparator*/ = null ;
	
}
