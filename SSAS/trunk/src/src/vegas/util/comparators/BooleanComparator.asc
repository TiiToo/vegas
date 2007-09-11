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
 * A IComparator for {@code Boolean} objects that can sort either {@code true} or {@code false} first.
 * @author eKameleon
 */
if (vegas.util.comparators.BooleanComparator == undefined) 
{
	
	/**
	 * Creates a BooleanComparator that sorts trueFirst values before !trueFirst values.
	 * Please use the static factories instead whenever possible.
	 * @param trueFirst when true, sort true boolean values before false
	 */
	vegas.util.comparators.BooleanComparator = function ( trueFirst /*Boolean*/ ) 
	{ 
		this.trueFirst = (trueFirst != null) ? trueFirst : true ;
	}

	/**
	 * @extends vegas.core.IComparator
	 */
	vegas.util.comparators.BooleanComparator.extend(vegas.core.IComparator) ;

	/**
	 * When {@code true} sort {@code true} boolean values before {@code false}.
	 */
	vegas.util.comparators.BooleanComparator.prototype.trueFirst /*Boolean*/ = null ; 

	/**
	 * Returns an integer value to compare two Boolean objects.
	 * @param o1 the first Number object to compare.
	 * @param o2 the second Number object to compare.
	 * @return <p>
	 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	 * <li> 0 if o1 and o2 are equal.</li>
	 * </p>
	 * @throws NullPointerError if the first argument is null and not a Boolean object.
	 * @throws ClassCastError when either argument is not Boolean
	 */
	vegas.util.comparators.BooleanComparator.prototype.compare = function (o1, o2) /*Number*/ 
	{
		if (o1 == null)
		{
			throw vegas.errors.NullPointerError(this + " compare method failed if the first argument is null.") ;
		}
		if ( vegas.util.TypeUtil.typesMatch(o1, Boolean) && vegas.util.TypeUtil.typesMatch(o2, Boolean)) 
		{
			if( o1 == o2 )
			{
				return 0 ;
			}
			else if( o1 == true && o2 == false )
			{
				return trueFirst ? 1 : -1 ;
			}
			else 
			{
				return trueFirst ? -1 : 1 ;
			}
		}
		else 
		{
			throw new vegas.errors.ClassCastError(this + " compare method failed, Arguments number expected") ;
		}
	}

	/**
	 * Returns a BooleanComparator singleton that sorts false values before true values.
	 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple BooleanComparators may be used in the same application.
	 * @return a BooleanComparator instance that sorts false values before true values.
	 */
	vegas.util.comparators.BooleanComparator.getFalseFirstComparator = function() /*BooleanComparator*/
	{
		var BooleanComparator = vegas.util.comparators.BooleanComparator ; 
		if (BooleanComparator._falseFirstInstance == null)
		{
			BooleanComparator._falseFirstInstance = new BooleanComparator(false) ;	
		}
		return BooleanComparator._falseFirstInstance ;
	}

	/**
	 * Returns a BooleanComparator singleton that sorts true values before false values.
	 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple BooleanComparators may be used in the same application.
	 * @return a BooleanComparator instance that sorts true values before false values.
	 */
	vegas.util.comparators.BooleanComparator.getTrueFirstComparator = function() /*BooleanComparator*/
	{
		var BooleanComparator = vegas.util.comparators.BooleanComparator ; 
		if (BooleanComparator._trueFirstInstance == null)
		{
			BooleanComparator._trueFirstInstance = new BooleanComparator(true) ;	
		}
		return BooleanComparator._trueFirstInstance ;
	}

	/**
	 * The internal singleton reference who define a BooleanComparator that sorts false values before true values.
	 */
	vegas.util.comparators.BooleanComparator._falseFirstInstance /*BooleanComparator*/ = null ; 
	
	/**
	 * The internal singleton reference who define a BooleanComparator that sorts true values before false values.
	 */
	vegas.util.comparators.BooleanComparator._trueFirstInstance /*BooleanComparator*/ = null ; 


}
