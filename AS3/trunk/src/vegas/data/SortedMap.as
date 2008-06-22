﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.data
{
	
	import vegas.core.IComparer;
	
	/**
	 * Map that further guarantees that it will be in ascending key order, sorted according to the natural ordering of its keys.
	 * @author eKameleon
	 */
	public interface SortedMap extends IComparer, Map
	{
		
		/**
		 * Returns the first (lowest) key currently in this sorted map.
		 */
		function firstKey():* ;
	
		/**
		 * Returns a view of the portion of this sorted map whose keys are strictly less than toKey.
		 */
		function heapMap(toKey:*):SortedMap ;

		/**
		 * Returns the last (highest) key currently in this sorted map.
		 */
		function lastKey():* ;

		/**
		 * Returns a view of the portion of this sorted map whose keys range from fromKey, inclusive, to toKey, exclusive.
		 */
		function subMap(fromKey:*, toKey:*):SortedMap ;

		/**
		 * Returns a view of the portion of this sorted map whose keys are greater than or equal to fromKey.
		 */
		function tailMap(fromKey:*):SortedMap ;
		
	}
}