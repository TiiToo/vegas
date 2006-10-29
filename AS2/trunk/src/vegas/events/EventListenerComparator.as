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
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2005-11-08
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
	
		IComparator, IFormattable, IHashable

*/

import vegas.core.CoreObject;
import vegas.core.IComparator;
import vegas.errors.IllegalArgumentError;
import vegas.events.EventListenerContainer;

// TODO vérifier méthode equals !! .. problème sur le test du typage de 'o'.

class vegas.events.EventListenerComparator extends CoreObject implements IComparator 
{

	// ----o Constructor
	
	function EventListenerComparator( container:EventListenerContainer ) 
	{
		_container = container ;
	}

	// ----o Public Methods

	public function compare(o1, o2):Number 
	{
		if ( o1 instanceof EventListenerContainer 
				&& o2 instanceof EventListenerContainer ) 
		{
			var p1:Number = o1.getPriority() ;
			var p2:Number = o2.getPriority() ;
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
	
	public function equals(o):Boolean 
	{
		if ( typeof(o) == "number" || o instanceof Number ) 
		{
			return compare(_container, o) == 0 ;
		} 
		else 
		{
			return false ;
		}
	}
	
	// ----o Private Properties
	
	private var _container:EventListenerContainer ;
	
}