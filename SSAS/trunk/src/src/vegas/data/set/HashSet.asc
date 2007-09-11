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
 * Hash Set based implementation of the Set interface.
 * <p><b>Example :</b></p>
 * {
 * var oSet = new vegas.data.set.HashSet([17, 68]) ;
 * trace ("set insert 12 : " + oSet.insert(12)) ;
 * trace ("set insert 24 : " + oSet.insert(24)) ;
 * trace ("set insert 48 : " + oSet.insert(48)) ;
 * trace ("set insert 48 : " + oSet.insert(48)) ;
 * trace ("set : " + oSet) ;
 * trace ("iterator :") ;
 * 
 * var it = oSet.iterator() ;
 * while(it.hasNext()) 
 * {
 *     trace ("\t-> " + it.next()) ;
 * }
 * 
 * var oSet2 = oSet.clone() ;
 * trace ("equals : " + oSet.equals(oSet2)) ;
 * 
 * // insert
 * 
 * oSet.insert("test") ;
 * oSet.insert("coucou") ;
 * oSet2.insert(150) ;
 * oSet2.insert("hello") ;
 * oSet2.insert(true) ;
 * oSet2.insert("welcome") ;
 * 
 * // remove
 * oSet2.remove(17) ;
 * 
 * trace ("oSet : " + oSet) ;
 * trace ("oSet2 : " + oSet2) ;
 * 
 * // --- removeAll
 * 
 * trace ("removeAll : " + oSet.removeAll(oSet2)) ;
 * trace ("oSet : " + oSet) ;
 * 
 * var ar = oSet.toArray() ;
 * trace ("set.toArray : " + ar) ;
 * 
 * trace ("set.toSource : " + oSet.toSource()) ;
 * }
 * @author eKameleon
 */
if (vegas.data.set.HashSet == undefined) 
{

	/**
	 * Creates a new HashSet instance.
	 * <p>You can use an optional parameter in this constructor with different type : an Array or a Collection instance to fill the Set object.</p>
	 */
	vegas.data.set.HashSet = function () 
	{ 
		this._map = new vegas.data.map.HashMap() ;
		if (arguments.length == 0) 
		{
			return ;
		}
		var it  ;
		var arg = arguments[0] ;
		if (arg instanceof Array) 
		{
			it = new vegas.data.iterator.ArrayIterator(arg) ;
		}
		else if (arg instanceof Collection) 
		{
			it = arg.iterator() ;
		}
		if (it != undefined) 
		{
			while(it.hasNext()) 
			{
				this.insert(it.next()) ;
			}
		}
	}

	/**
	 * @extends vegas.data.set.AbstractSet
	 */
	proto = vegas.data.set.HashSet.extend(vegas.data.set.AbstractSet) ;

	/**
	 * Removes all of the elements from this Set (optional operation).
	 */
	proto.clear = function()/*Void*/ 
	{
		this._map.clear() ;
	}

	/**
	 * Returns a shallow copy of this Set (optional operation).
	 * @return a shallow copy of this Set (optional operation).
	 */
	/*override*/ proto.clone = function () 
	{
		var s = new vegas.data.set.HashSet() ; 
		if (this.size() > 0) 
		{
			var it/*Iterator*/ = this._map.keyIterator() ;
			while(it.hasNext()) 
			{
				s.insert(it.next()) ;
			}
		}
		return s ;
	}

	/**
	 * Returns {@code true} if this Set contains the specified element.
	 * @return {@code true} if this Set contains the specified element.
	 */
	/*override*/ proto.contains = function (o)/*Boolean*/ 
	{
		return this._map.containsKey(o) ;
    }

	/**
	 * Adds the specified element to this set if it is not already present.
	 */
	/*override*/ proto.insert = function (o)/*Boolean*/ 
	{
		return this._map.put(o, vegas.data.set.HashSet.PRESENT) == null ;
    }

	/**
	 * Returns true if this set contains no elements.
	 * @return true if this set contains no elements.
	 */
	/*override*/ proto.isEmpty = function ()/*Boolean*/ 
	{
		return this._map.isEmpty() ;
	}

	/**
	 * Returns an iterator over the elements in this Set.
	 * @return an iterator over the elements in this Set.
	 */
	/*override*/ proto.iterator = function ()/*Iterator*/ 
	{
		return this._map.keyIterator() ;
	}

	/**
	 * Removes the specified element from this set if it is present.
	 */
    /*override*/ proto.remove = function (o)/*Boolean*/ 
    {
		return this._map.remove(o) == vegas.data.set.HashSet.PRESENT ;
    }

	/**
	 * Returns the number of elements in this set (its cardinality).
	 * @return the number of elements in this set (its cardinality).
	 */
	/*override*/ proto.size = function ()/*Number*/ 
	{
		return this._map.size() ;
	}
	
	/**
	 * Returns the array representation of all the elements of this Set.
	 * @return the array representation of all the elements of this Set.
	 */
	/*override*/ proto.toArray = function ()/*Array*/ 
	{
		return this._map.getKeys() ;
	}

	/**
	 * Returns a Eden representation of this object.
	 * @return a string representing the source code of the object.
	 */
	/*override*/ proto.toSource = function (indent/*Number*/, indentor/*String*/)/*String*/ 
	{
		return "new " + this.getConstructorName() + "(" + this.toArray().toSource() + ")";
	}


	vegas.data.set.HashSet.PRESENT = new Object() ;

	
	delete proto ;
		
}