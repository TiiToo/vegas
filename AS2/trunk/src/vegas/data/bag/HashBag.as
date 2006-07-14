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

/**	HashBag

	AUTHOR
	
		Name : HashBag
		Package : vegas.data.bag
		Version : 1.0.0.0
		Date :  2005-11-10
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear()

		- contains(o)
		
		+ containsAll(c:Collection):Boolean
		
			(Violation)  Returns true if the bag contains all elements in the given collection, respecting cardinality.
		
		+ containsAllInBag(b:Bag)
		
		- hashCode():Number
		
		+ insertAll(c:Collection):Boolean 
		
		+ insertCopies(o, i:Number):Boolean 
			
			Add i copies of the given object to the bag and keep a count.
			
		+ getCount(o):Number 
		
			Return the number of occurrences (cardinality) of the given object currently in the bag.
		
		- get(id:Number)
		
		- insert(o):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		+ removeAll(c:Collection):Boolean
		
			(Violation)  Remove all elements represented in the given collection, respecting cardinality.
		
		+ removeCopies(o, i:Number):Boolean
		
			Remove the given number of occurrences from the bag.
		
		+ retainAll(c:Collection):Boolean
		
			(Violation)  Remove any members of the bag that are not in the given collection, respecting cardinality.
		
		+ retainAllInBag(b:Bag):Boolean	
		
		- size():Number
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String
		
		+ uniqueSet():Set
		
			The Set of unique members that represent all members in the bag.
		
	
	INHERIT 
	
		CoreObject → AbstractBag → HashBag
	
	IMPLEMENTS 
	
		Bag , Collection, IFormattable, IHashable

	EXAMPLE
	
		import vegas.data.Bag ;
		import vegas.data.bag.HashBag ;
		import vegas.data.Collection ;
		import vegas.data.collections.SimpleCollection ;
		import vegas.data.Set ;
		
		var c1:Collection = new SimpleCollection( ["item1", "item1", "item3"] ) ;
		var c2:Collection = new SimpleCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
		
		trace ("c1 collection : " + c1) ;
		trace ("c2 collection : " + c2) ;
		
		trace ("---- create a new HashBag") ;
		var bag:Bag = new HashBag ;
		
		trace ("---- insert") ;
		trace (" + bag insertAll c1 : " + bag.insertAll(c1)) ;
		trace (" + bag insertAll c2 : " + bag.insertAll(c2)) ;
		trace (" > bag : " + bag) ;
		trace (" > bag.touSource : " + bag.toSource()) ;
		
		trace ("---- contains") ;
		trace (" > bag containsAll c2 : " + bag.containsAll(c2)) ;
		
		trace ("---- insert") ;
		trace (" + bag insert item2 : " + bag.insert("item2")) ;
		trace (" > bag : " + bag) ;
		trace (" + bag insertCopies 2xitem2 : " + bag.insertCopies("item2", 2)) ;
		trace (" > bag : " + bag) ;
		
		trace ("---- remove") ;
		trace (" > bag removeCopies 1 x item2 : " + bag.removeCopies("item2", 1)) ;
		
		trace ("---- size") ;
		trace (" - bag getCount item2 : " + bag.getCount("item2")) ;
		trace (" > bag size : " + bag.size()) ;
		
		trace ("---- retain") ;
		trace (" > bag : " + bag) ;
		trace (" > bag retainAll c1 : " + bag.retainAll(c1)) ;
		trace (" > bag : " + bag) ;
		
		trace ("----") ;
		var s:Set = bag.uniqueSet() ;
		trace("bag uniqueSet : " + s) ;


----------  */

import vegas.data.bag.AbstractBag;
import vegas.data.Collection;
import vegas.data.map.HashMap;
import vegas.util.serialize.Serializer;

class vegas.data.bag.HashBag extends AbstractBag {

	// ----o Constructor

	public function HashBag( c:Collection ) {
		super(new HashMap()) ;
		if (c) insertAll(c) ;
	}
	
	// ----o Public Methods
	
	/*override*/ public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(_extractList())]) ;
	}
	
}