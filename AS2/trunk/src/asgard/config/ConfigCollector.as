/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.config.IConfigurable;

import vegas.data.iterator.Iterator;
import vegas.data.Set;
import vegas.data.set.HashSet;

/**
 * The ConfigCollector class.
 * @author eKameleon
 * @version 1.0.0.0
 */
class asgard.config.ConfigCollector 
{
	
	/**
	 * Returns {@code true} if the collector contains the specified {@code IConfigurable} object.
	 * @return {@code true} if the collector contains the specified {@code IConfigurable} object.
	 */	
	public static function contains( conf:IConfigurable ) :Boolean 
	{
		return _set.contains( conf ) ;	
	}
	
	/**
	 * Inserts an IConfigurable object in the collector.
	 */
	public static function insert( conf:IConfigurable ) :Boolean 
	{
		return _set.insert( conf ) ;
	}
	
	/**
	 * Returns the {@code Iterator} of this collector.
	 * @return the {@code Iterator} of this collector.
	 */
	public static function iterator() :Iterator
	{
		return _set.iterator() ;	
	}
	
	/**
	 * Removes the specified {@code IConfigurable} object in the collector.
	 */
	public static function remove( conf:IConfigurable ) :Void 
	{
		_set.remove( conf ) ;
	}
	
	/**
	 * Run the {@code ConfigCollector} command to invoked the {@code setup()} method of all {@code IConfigurable} object registered in the collector.
	 */
	public static function run():Void
	{
		if (size() > 0)
		{
			var it:Iterator = iterator() ;
			while(it.hasNext())
			{
				(it.next()).setup() ;	
			}
		}	
	}
	
	/**
	 * Returns the number of elements in the collector.
	 * @return the number of elements in the collector.
	 */
	public static function size():Number
	{
		return _set.size() ;
	}
	
	/**
	 * The internal ArrayList of this collector.
	 */
	private static var _set:Set = new HashSet() ;
	
}