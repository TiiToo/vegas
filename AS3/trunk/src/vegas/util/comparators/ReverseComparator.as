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

/*	ReverseComparator

	AUTHOR

		Name : ReverseComparator
		Package : vegas.util.comparators
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	CONSTRUCTOR
	
		var comp:Reverseomparator = new ReverseComparator( comp:IComparator ) ;
	
	PROPERTY SUMMARY
	
		- date
	
	METHOD SUMMARY
	
		- clone():*
	
		- compare(o1, o2):Number
			
			RETURNS 
			
				- -1 if o1 is "lower" than (less than, before, etc.) o2 ;
				- 1 if o1 is "higher" than (greater than, after, etc.) o2 ;
				- 0 if o1 and o2 are equal.
	
		- copy():*
	
		- hashCode():uint
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → ReverseComparator

	IMPLEMENTS
	
		ICloneable, IComparator, IFormattable, IHashable, ISerializable

*/


package vegas.util.comparators
{
	
	import vegas.core.CoreObject;
	import vegas.core.ICloneable;
	import vegas.core.IComparator;
	import vegas.core.ICopyable ;
	import vegas.errors.IllegalArgumentError;
	
	public class ReverseComparator extends CoreObject implements IComparator, ICloneable, ICopyable
	{
		
		// ----o Constructor
		
		public function ReverseComparator( comp:IComparator=null )
		{
			if (comp == null) {
				throw new IllegalArgumentError(this + " constructor argument 'comp' not mmust be 'null' or 'undefined'.") ;
			}
			_comp = comp ;
		}
		
		// ----o Public Methods

		public function clone():* 
		{
			return new ReverseComparator( _comp ) ;
		}

		public function compare(o1:*, o2:*):int
		{
			return _comp.compare(o2, o1) ;
		}

		public function copy():*
		{
			return new ReverseComparator( _comp ) ;
		}
	
		// ----o Private Properties
		
		private var _comp:IComparator ;
		
	}
}