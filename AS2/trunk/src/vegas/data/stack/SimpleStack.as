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

/**	SimpleStack

	AUTHOR

		Name : SimpleStack
		Package : vegas.data.stack
		Version : 1.0.0.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var s:SimpleStack = new SimpleStack(ar:Array) ;
	
	METHOD SUMMARY
	
		- clear()
		
		- contains(o)
		
		- get(id)
		
			return an element but if id = 0, it's the last element in the stack
		
		- clone()
		
		- iterator()
		
		- insert(o):Boolean 
		
			the same of push() method
		
		- isEmpty()
		
		- iterator()
		
		- peek()
		
		- pop()
		
		- push(o)
		
		- remove(o):Boolean
		
		- search(o):Number
		
		- size():Number
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject
			|
			AbstractCollection
				|
				SimpleStack
	
	IMPLEMENTS
	
		Collection, ICloneable, IFormattable, IHashable, Iterable, ISerializable, Stack.
	
**/

import vegas.core.ICloneable;
import vegas.data.Collection;
import vegas.data.collections.AbstractCollection;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.iterator.ProtectedIterator;
import vegas.data.Stack;

class vegas.data.stack.SimpleStack extends AbstractCollection implements Iterable, ICloneable, Collection, Stack {

	// ----o Construtor
	
	public function SimpleStack(ar:Array) {
		super(ar) ;
	}

	// ----o Public Methods
	
	public function clone() {
		return new SimpleStack(_a) ;
	}

	public function get(id:Number) { 
		var a:Array = toArray() ;
		return a[id] ;
	}

	public function iterator():Iterator {
		return (new ProtectedIterator(new ArrayIterator(toArray()))) ;
	}

	public function peek() {
		return _a[_a.length - 1] ;
	}

	public function pop() {
		return isEmpty() ? null : _a.pop() ;
	}

	public function push(o):Void {
		_a.push(o) ;
	}

	public function search(o):Number {
		return indexOf(o) ;
	}

	public function toArray():Array {
		var aReverse:Array = _a.slice() ;
		aReverse.reverse() ;
		return aReverse ;
	}

}