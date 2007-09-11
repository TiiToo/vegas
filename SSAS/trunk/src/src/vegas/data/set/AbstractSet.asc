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
 * This class provides a skeletal implementation of the Set interface to minimize the effort required to implement this interface.
 * A collection that contains no duplicate elements.
 * @author eKameleon
 */
if (vegas.data.set.AbstractSet == undefined) 
{

	/**
	 * Creates a new AbstractSet instance.
	 */
	vegas.data.set.AbstractSet = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.data.collections.SimpleCollection
	 */
	proto = vegas.data.set.AbstractSet.extend(vegas.data.collections.SimpleCollection) ;

	/**
	 * Compares the specified object with this object for equality.
	 * @return {@code true} if the the specified object is equal with this object.
	 */
	proto.equals = function (o) /*Boolean*/ 
	{
		if (o == this) return true ;
		if ( ! (o instanceof this.constructor) ) 
		{
			return false ;
		}
		if ( o.size() == undefined || o.size() != this.size() ) 
		{
			return false ;
		}
		return this.containsAll(o) ;
	}

	/**
	 * Removes from this Set all the elements that are contained in the specified Collection (optional operation).
	 */
	proto.removeAll = function (c /*Collection*/ ) /*Boolean*/ 
	{
		var b /*Boolean*/ = false ;
		if (this.size() > c.size()) 
		{
			var it /*Iterator*/ = c.iterator() ;
			while (it.hasNext()) 
			{
				b = this.remove(it.next()) ;
			}
		} 
		else 
		{
			var it /*Iterator*/ = this.iterator() ;
			while (it.hasNext()) 
			{
				if (c.contains(it.next())) 
				{
					it.remove() ;
					b = true ;
				}
			}
			
		}
		return b ;
	}

	delete proto ;
	
}
