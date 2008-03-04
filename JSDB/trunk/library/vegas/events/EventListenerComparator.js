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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * This comparator is used in the {@code EventDispatcher} class to ordered all {@code EventLister} with a priority value.
 * @author eKameleon
 */
if (vegas.events.EventListenerComparator == undefined) {

	/**
	 * Creates the EventListenerComparator instance.
	 */
	vegas.events.EventListenerComparator = function ( container /*EventListenerContainer*/ ) 
	{
		this._container = container ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.EventListenerComparator.extend(vegas.core.CoreObject) ;

	/**
	 * Compares its two arguments for order.
	 * @return -1 if o1 is "lower" than o2, 1 if o1 is "higher" than o2 and 0 if o1 and o2 are equal.
	 */
	vegas.events.EventListenerComparator.prototype.compare = function (o1, o2) /*Number*/ 
	{
		if ( o1 instanceof vegas.events.EventListenerContainer && o2 instanceof vegas.events.EventListenerContainer ) 
		{
			var p1 /*Number*/ = o1.getPriority() ;
			var p2 /*Number*/ = o2.getPriority() ;
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
			throw new vegas.errors.IllegalArgumentError(this + ".compare(" + o1 + "," + o2 + "), arguments must be EventListenerContainer") ;
		}
	}

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	vegas.events.EventListenerComparator.prototype.equals = function (o) /*Boolean*/ 
	{
		if ( o instanceof EventListenerContainer ) 
		{
			return this.compare(this._container, o) == 0 ;
		}
		else 
		{
			return false ;
		}
	}

	vegas.events.EventListenerComparator.prototype._container /*EventListenerContainer*/ = null ;


}