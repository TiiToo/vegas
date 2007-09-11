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
 * A IComparator that compares IComparable objects.
 * @author eKameleon
 */
if (vegas.util.comparators.ComparableComparator == undefined) 
{
	
	/**
	 * Creates a new ComparableComparator instance.
	 * This constructor whose use should be avoided.
	 */
	vegas.util.comparators.ComparableComparator = function ( trueFirst /*Boolean*/ ) 
	{ 
		//
	}

	/**
	 * @extends vegas.core.IComparator
	 */
	vegas.util.comparators.ComparableComparator.extend(vegas.core.IComparator) ;

	/**
	 * Returns an integer value to compare two objects in parameters.
	 * @param o1 the first object to compare.
	 * @param o2 the second object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws NullPointerError when the {@code o1} object is {@code null} or {@code undefined}.
	 * @throws ClassCastError it the {@code o1} object is not a {@code IComparable} object.
	 */
	vegas.util.comparators.ComparableComparator.prototype.compare = function (o1, o2) /*Number*/ 
	{
		if (o1 == null)
		{
			throw new vegas.errors.NullPointerError(this + " compare method failed, the o1 object is 'null' or 'undefined'.") ;	
		}
		if ( o1 instanceof vegas.core.IComparable || o1.hasProperty("compareTo") )
		{
			return o1.compareTo(o2) ;	
		}
		else
		{
			throw new vegas.errors.ClassCastError(this + " compare method failed, the o1 object is not a IComparable object : " + o1) ; 	
		}
	}

	/**
	 * Returns the singleton instance of a ComparableComparator.
	 * Developers are encouraged to use the comparator returned from this method instead of constructing a new instance to reduce allocation and GC overhead when multiple comparable comparators may be used in the same application.
	 * @return the singleton instance of a ComparableComparator.
	 */
	vegas.util.comparators.ComparableComparator.getInstance = function() /*ComparableComparator*/
	{
		var ComparableComparator = vegas.util.comparators.ComparableComparator ;
		if (ComparableComparator._instance == null)
		{
			ComparableComparator._instance = new ComparableComparator() ;
		}
		return ComparableComparator._instance ;	
	}

	/**
	 * The internal static singleton of this class.
	 */
	vegas.util.comparators.ComparableComparator._instance /*ComparableComparator*/ = null ;

}
