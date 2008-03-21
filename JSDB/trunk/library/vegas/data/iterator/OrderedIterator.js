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
 * Defines an iterator that operates over an ordered collection. This iterator allows both forward and reverse iteration through the collection.
 * @author eKameleon
 */
if (vegas.data.iterator.OrderedIterator == undefined) 
{

	/**
	 * Creates a new OrderedIterator instance.
	 */
	vegas.data.iterator.OrderedIterator = function () 
	{ 
		
	}
	
	/**
	 * @extends vegas.data.iterator.Iterator
	 */
	vegas.data.iterator.OrderedIterator.extend( vegas.data.iterator.Iterator ) ;
	
	/**
	 * Checks to see if there is a previous element that can be iterated to.
	 */
	vegas.data.iterator.OrderedIterator.prototype.hasPrevious = function () 
	{
		//
	}
	
	/**
	 * Returns the previous element in the collection.
	 * @return the previous element in the collection.
	 */
	vegas.data.iterator.OrderedIterator.prototype.previous = function () 
	{
		//
	}

}