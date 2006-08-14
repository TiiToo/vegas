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

/**	EventListenerComparator

	AUTHOR
	
		Name : EventListenerComparator
		Package : vegas.events.dom
		Version : 1.0.0.0
		Date :  2006-07-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new EventListenerComparator(container:EventListenerContainer) ;
	
	METHOD SUMMARY
	
		- compare(o1, o2) : return a number
			
			RETURNS 
			
				- -1 if o1 is "lower" than o2 ;
				-  1 if o1 is "higher" than o2 ;
				-  0 if o1 and o2 are equal.
		
		- equals(o) : return a boolean
		
		- toString()

	INHERIT
	
		CoreObject → EventListenerComparator

	IMPLEMENTS
	
		IComparator, IFormattable, IHashable, ISerializable

*/

package vegas.events.dom
{
	import vegas.core.IComparator;
	import vegas.core.CoreObject;

	import vegas.errors.IllegalArgumentError ;

	internal public class EventListenerComparator extends CoreObject implements IComparator
	{
		
		// ----o Constructor
		
		public function EventListenerComparator()
		{
			super();
		}
		
		// ----o Public Methods

		public function clone():* {
			return new EventListenerComparator() ;
		}

		public function copy():*
		{
			return new EventListenerComparator() ;
		}

		public function compare(o1:*, o2:*):int
		{
			if ( o1 is EventListenerContainer && o2 is EventListenerContainer ) 
			{
				var p1:uint = o1.getPriority() ;
				var p2:uint = o2.getPriority() ;
				if( p1 < p2 )
				{
					return 1 ;
				}
				else if( p1 > p2 )
				{
				 	return -1 ;
				}
				else 
				{
					return 0 ;
				}
			}
			else 
			{
				throw new IllegalArgumentError(this + ".compare(" + o1 + "," + o2 + "), arguments must be EventListenerContainer") ;
			}
		}
		
	}
}