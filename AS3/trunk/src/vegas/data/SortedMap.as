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

/* SortedMap [Interface]

	AUTHOR

		Name : SortedMap
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- comparator:IComparator [R/W]

	METHOD SUMMARY

		- clear()

		- containsKey( key ):Boolean
	
		- containsValue( value ):Boolean

		- firstKey():*

		- get(key)
	
		- getKeys():Array
	
		- getValues():Array

		- heapMap(toKey:*):SortedMap

		- isEmpty():Boolean
	
		- iterator():Iterator

		- keyIterator():Iterator

		- lastKey():*

		- put(key, value)
	
		- putAll(m:Map)

		- remove(key)
	
		- size():uint

		- subMap(fromKey:*, toKey:*):SortedMap

		- tailMap(fromKey:*):SortedMap

        - toSource(...arguments:Array):String

		- toString():String

    INHERIT

        ICloneable, IComparer, IFormattable, IHashable, ISerializable, Iterable, Map

**/

package vegas.data
{
	
	import vegas.core.IComparator;
	import vegas.core.IComparer;
	
	public interface SortedMap extends IComparer, Map
	{
		
		function firstKey():* ;
	
		function heapMap(toKey:*):SortedMap ;
	
		function lastKey():* ;
	
		function subMap(fromKey:*, toKey:*):SortedMap ;
	
		function tailMap(fromKey:*):SortedMap ;
		
	}
}