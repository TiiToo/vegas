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
	import vegas.core.ICopyable ;
	import vegas.errors.IllegalArgumentError;
	
	/**
	 * Reverse an IComparator.
	 * @author eKameleon
	 */
	public class ReverseComparator extends CoreObject implements IComparator, ICloneable, ICopyable
	{
		
		/**
		 * Creates a new ReverseComparator instance.
		 */
		public function ReverseComparator( comp:IComparator=null )
		{
			if (comp == null) 
			{
				throw new IllegalArgumentError(this + " constructor argument 'comp' not mmust be 'null' or 'undefined'.") ;
			}
			_comp = comp ;
		}

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */	
		public function clone():* 
		{
			return new ReverseComparator( _comp ) ;
		}

		/**
		 * Returns an integer value to compare two objects (reverse the value).
		 * @param o1 the first object to compare.
		 * @param o2 the second object to compare.
		 * @return <p>
		 * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
		 * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
		 * <li> 0 if o1 and o2 are equal.</li>
		 * </p>
		 * @throw IllegalArgumentError if compare(a, b) and 'a' and 'b' must be Date or uint objects.
		 */
		public function compare(o1:*, o2:*):int
		{
			return _comp.compare(o2, o1) ;
		}

		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */
		public function copy():*
		{
			return new ReverseComparator( _comp ) ;
		}
	
		private var _comp:IComparator ;
		
	}
}