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

/* ------- 	Bag [Interface]

	AUTHOR
	
		Name : Bag
		Package : vegas.data.bag
		Version : 1.0.0.0
		Date :  2005-11-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS
	
		- comparator():IComparator
		
		- first()
		
		- last()
	

	INHERIT : 
	
		Collection > Bag > SortedBag
			
	INHERIT METHODS
	
		- clear()
		
		- contains(o)
		
		- containsAll(c:Collection):Boolean
		
			(Violation)  Returns true if the bag contains all elements in the given collection, respecting cardinality.
		
		- get(id:Number)
		
		- getCount(o):Number 
		
			Return the number of occurrences (cardinality) of the given object currently in the bag.
		
		- insert(o):Boolean
		
		- insertAll(c:Collection):Boolean 
		
		- insertCopies(o, i:Number):Boolean 
			
			Add i copies of the given object to the bag and keep a count.
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		- removeAll(c:Collection):Boolean
		
			(Violation)  Remove all elements represented in the given collection, respecting cardinality.
		
		- removeCopies(o, i:Number):Boolean
		
			Remove the given number of occurrences from the bag.
		
		- retainAll(c:Collection):Boolean
		
			(Violation)  Remove any members of the bag that are not in the given collection, respecting cardinality.
		
		- size():Number
		
		- toArray():Array
		
		- uniqueSet():Set
		
			The Set of unique members that represent all members in the bag.


	TODO TypedBag, Buffer, MultiBag, TreeBag ??	....


----------  */

import vegas.core.IComparator;
import vegas.data.Bag;

interface vegas.data.SortedBag extends Bag {

	function comparator():IComparator ;
	
	function first() ;
	
	function last() ;

}
