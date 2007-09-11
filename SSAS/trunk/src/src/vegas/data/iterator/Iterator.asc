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
 * This interface defines the iterator pattern over a collection. 
 * @author eKameleon
 */
if (vegas.data.iterator.Iterator == undefined) 
{

	/**
	 * Creates a new Iterator instance.
	 */
	vegas.data.iterator.Iterator = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.iterator.Iterator.extend(vegas.core.CoreObject) ;

	/**
	 * Returns {@code true} if the iteration has more elements.
	 * @return {@code true} if the iteration has more elements.
	 */	
	proto.hasNext = function() {}

	/**
	 * Returns the current key of the internal pointer of the iterator (optional operation).
	 * @return the current key of the internal pointer of the iterator (optional operation).
	 */
	proto.key     = function() {}

	/**
	 * Returns the next element in the iteration.
	 * @return the next element in the iteration.
	 */
	proto.next    = function() {}

	/**
	 * Removes from the underlying collection the last element returned by the iterator (optional operation).
	 */
	proto.remove  = function() {}

	/**
	 * Reset the internal pointer of the iterator (optional operation).
	 */
	proto.reset   = function() {}

	/**
	 * Change the position of the internal pointer of the iterator (optional operation).
	 */
	proto.seek    = function (n) {}
	
	delete proto ;
	
}