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

package vegas.util.comparators
{

	import vegas.core.CoreObject;
	import vegas.core.ICloneable;
	import vegas.core.IComparator;
	import vegas.core.ICopyable;
	import vegas.errors.ClassCastError;
	import vegas.errors.NullPointerError;
	
	/**
	 * An IComparator for <code>Boolean</code> objects that can sort either <code>true</code> or <code>false</code> first.
	 * <p><b>Example :</b></p>
	 * <code>
	 * var c:IComparator = new BooleanComparator() ;
	 * trace(c.compare(true, true)) ; // 0
	 * trace(c.compare(true, false)) ; // 1
	 * trace(c.compare(false, true)) ; // -1
	 * trace(c.compare(false, false)) ; // 0
	 * </code>
	 * @author eKameleon
 	 */
	public class BooleanComparator extends CoreObject implements IComparator, ICloneable, ICopyable
	{
		
		/**
		 * Creates a BooleanComparator that sorts trueFirst values before !trueFirst values.
		 * Please use the static factories instead whenever possible.
		 * @param trueFirst when true, sort true boolean values before false
	 	 */
		public function BooleanComparator( trueFirst:Boolean=true ) 
		{
			this.trueFirst = trueFirst ;
		}

		/**
		 * When <code>true</code> sort <code>true</code> boolean values before <code>false</code>.
	 	 */
		public var trueFirst:Boolean ; 

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */			
		public function clone():* 
		{
			return new BooleanComparator(trueFirst) ;
		}

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
		public function compare(o1:*, o2:*):int
		{
			if (o1 == null)
			{
				throw NullPointerError(this + " compare method failed if the first argument is null.") ;
			}	
			if ( o1 is Boolean && o2 is Boolean ) 
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
				throw new ClassCastError(this + " compare method failed, Arguments number expected") ;
			}
		}
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return A new object that is a deep copy of this instance.
		 */	
		public function copy():*
		{
			return new BooleanComparator(trueFirst) ;
		}
		
		/**
	 	 * Returns a <code>BooleanComparator</code> singleton that sorts false values before true values.
		 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple BooleanComparators may be used in the same application.
	 	 * <p><b>Example :</b></p>
		 * <code>
		 * var c:IComparator = BooleanComparator.getFalseFirstComparator() ;
		 * trace(c.compare(true, true)) ; // 0
		 * trace(c.compare(true, false)) ; // -1
		 * trace(c.compare(false, true)) ; // 1
		 * trace(c.compare(false, false)) ; // 0
	 	 * </code>
		 * @return a <code>BooleanComparator</code> instance that sorts false values before true values.
		 */
		public static function getFalseFirstComparator():BooleanComparator
		{
			if (_falseFirstInstance == null)
			{
				_falseFirstInstance = new BooleanComparator(false) ;	
			}
			return _falseFirstInstance ;
		}
		
		/**
		 * Returns a <code>BooleanComparator</code> singleton that sorts true values before false values.
		 * Clients are encouraged to use the value returned from this method instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple BooleanComparators may be used in the same application.
 		 * <code>
		 * var c:IComparator = BooleanComparator.getTrueFirstComparator() ;
		 * trace(c.compare(true, true)) ; // 0
		 * trace(c.compare(true, false)) ; // 1
		 * trace(c.compare(false, true)) ; // -1
		 * trace(c.compare(false, false)) ; // 0
	 	 * </code>
	 	 * @return a <code>BooleanComparator</code> instance that sorts true values before false values.
	 	 */
		public static function getTrueFirstComparator():BooleanComparator
		{
			if (_trueFirstInstance == null)
			{
				_trueFirstInstance = new BooleanComparator(true) ;	
			}
			return _trueFirstInstance ;
		}

		/**
		 * The internal singleton reference who define a BooleanComparator that sorts false values before true values.
		 */
		private static var _falseFirstInstance:BooleanComparator ; 
	
		/**
		 * The internal singleton reference who define a BooleanComparator that sorts true values before false values.
	 	 */
		private static var _trueFirstInstance:BooleanComparator ; 
	
	}

}