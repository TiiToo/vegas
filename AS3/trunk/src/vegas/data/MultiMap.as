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
    
    import vegas.data.iterator.Iterator ;
    
	/**
	 * Maps multiple values to keys.
	 * @author eKameleon
	 */
    public interface MultiMap extends Map
    {

		/**
		 * Adds the specified collection to the set of values associated with the specified key in this map (optional operation).
		 */
	    function putCollection(key:*, c:Collection):void ;

		/**
		 * Returns the total count of elements in all the collection in the MultiMap.
		 */
    	function totalSize():uint ;
	
		/**
		 * Returns a collection of all values associated with all the keys in this map.
		 */
    	function values():Collection ;

		/**
		 * Returns an iterator fo all the values in the map.
		 */
	    function valueIterator():Iterator ;
	    
    }
}