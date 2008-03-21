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
 * 
 * <p><b>Example : </b></p>
 * {@code
 * var ar = ["item1", "item2", "item3"]
 * var co1 = new vegas.data.collections.SimpleCollection(ar) ;
 * var co2 = new vegas.data.collections.SimpleCollection(["item2", "item3"]) ;
 * var co3 = new vegas.data.collections.SimpleCollection(["item5", "item3"]) ;
 * trace ("co1 : " + co1) ;
 * trace ("co1.toSource : " + co1.toSource()) ;
 * trace ("co1.constainsAll(co2) : " + co1.containsAll(co2)) ;
 * trace ("co1.retainAll(co2) : " + co1.retainAll(co2)) ;
 * trace ("co1 : " + co1) ;
 * trace ("co1.insertAll(co3) : " + co1.insertAll(co3)) ;
 * trace ("co1.removeAll(co2) : " + co1.removeAll(co2)) ;
 * trace ("co1 : " + co1) ;
 * }
 * @author eKameleon
 */
if (vegas.data.collections.SimpleCollection == undefined) 
{

	/**
	 * Creates a new SimpleCollection instance.
	 */
	vegas.data.collections.SimpleCollection = function ( ar /*Array*/ ) 
	{ 
		vegas.data.collections.AbstractCollection.call(this, ar) ;
	}

	/**
	 * @extends vegas.data.collections.AbstractCollection
	 */
	proto = vegas.data.collections.SimpleCollection.extend(vegas.data.collections.AbstractCollection) ;

	/**
	 * Returns a shallow copy of this collection (optional operation).
	 * @return a shallow copy of this collection.
	 */
	proto.clone = function () 
	{
		return new vegas.data.collections.SimpleCollection(this._a) ;
	}

	/**
	 * Returns {@code true} if this collection contains all of the elements of the specified collection.
	 * @return {@code true} if this collection contains all of the elements of the specified collection.
	 */
	proto.containsAll = function (c/*Collection*/) /*Boolean*/ 
	{
		var it = c.iterator() ;
		while(it.hasNext()) 
		{
			if ( ! this.contains(it.next()) ) return false ;
		}
		return true ;
	}

	/**
	 * Appends all of the elements in the specified collection to the end of this Collection, in the order that they are returned by the specified collection's iterator (optional operation).
	 */
	proto.insertAll = function (c/*Collection*/) /*Boolean*/ 
	{
		if (c.size() > 0) 
		{
			if (c.iterator()) 
			{
				var it = c.iterator() ;
				while(it.hasNext()) this.insert(it.next()) ;
				return true ;
			}
		}
		return false
	}
	
	/**
	 * Removes from this Collection all the elements that are contained in the specified Collection (optional operation).
	 */
	proto.removeAll = function (c/*Collection*/) /*Boolean*/ 
	{
		var b = false ;
		var it = this.iterator() ;
		while (it.hasNext()) 
		{
			if ( c.contains(it.next()) ) 
			{
				it.remove() ;
				b = true ;
			}
		}
		return b ;
	}

	/**
	 * Retains only the elements in this Collection that are contained in the specified Collection (optional operation).
	 */
	proto.retainAll = function (c/*Collection*/) /*Boolean*/ 
	{
		var b = false ;
		var it = this.iterator() ;
		while(it.hasNext()) 
		{
			if ( ! c.contains(it.next() ) ) 
			{
				it.remove() ;
				b = true ;
			}
		}
		return b ;
	}
	
	delete proto ;
	
}