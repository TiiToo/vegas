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

package vegas.util.comparators
{

	import vegas.core.CoreObject;
	import vegas.core.ICloneable;
	import vegas.core.IComparator;
	import vegas.core.ICopyable;

	import vegas.errors.IllegalArgumentError;
	
	/**
	 * This comparator compare Date objects.
	 * @author eKameleon
	 */
	public class DateComparator extends CoreObject implements IComparator, ICloneable, ICopyable
	{
		
		/**
		 * Creates a new DateCompator instance.
		 */
		public function DateComparator()
		{
			super();
		}

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new DateComparator() ;
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
		 * @throw IllegalArgumentError if compare(a, b) and 'a' and 'b' must be Date or uint objects.
		 */
		public function compare(o1:*, o2:*):int
		{
			
			if (o1 == null) o1 = 0 ;
			if (o2 == null) o2 = 0 ;
			var b1:Boolean = (o1 is Number) || (o1 is Date) ;
			var b2:Boolean = (o2 is Number) || (o2 is Date) ;
			if ( b1 && b2 ) 
			{
				var a:Number = (o1 is Date) ? o1.valueOf() : o1 ;
				var b:Number = (o2 is Date) ? o2.valueOf() : o2 ;
				if( a < b ) 
				{
					return -1;
				}
				else if( a > b ) 
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
				throw new IllegalArgumentError(this + ".compare(a, b), 'a' and 'b' must be Date or uint objects.") ;
			}
		}
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */	
		public function copy():*
		{
			return new DateComparator() ;
		}
		
	}
}