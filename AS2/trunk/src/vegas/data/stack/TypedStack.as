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

/** TypedStack

	AUTHOR
		
		Name : TypedStack
		Package : vegas.data.stack
		Version : 1.0.0.0
		Date : 2005-10-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS
	
		- clear()
		
		- clone()
		
		- getType()
		
		- isEmpty()
		
		- iterator()
		
		- peek()
		
		- pop()
		
		- push(o)
		
		- search(o):Number
		
		- setType(type:Function)
		
		- size():Number
		
		- toArray():Array ;
		
		- toString():String

	INHERIT
	
		AbstractTypeable
		
	IMPLEMENTS
	
		ICloneable, Iterable, Stack, IFormattable, IHashable

*/

import vegas.core.ICloneable;
import vegas.core.IFormattable;
import vegas.core.ISerializable;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Stack;
import vegas.errors.IllegalArgumentError;
import vegas.util.AbstractTypeable;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.data.stack.TypedStack extends AbstractTypeable implements ICloneable, Iterable, ISerializable, Stack, IFormattable {

	// ----o Constructor

	public function TypedStack(p_type:Function , p_stack:Stack) {
		super(p_type) ;
		if (!p_stack) 
		{
			throw new IllegalArgumentError("TypedStack constructor, argument 'p_stack' must not be 'null' or 'undefined'.") ;
		}
		_stack = p_stack ;
		if (_stack.size() > 0) {
			var it:Iterator = _stack.iterator() ;
			while (it.hasNext()) validate(it.next()) ;
		}
	}
	
	// ----o Public Methods

	public function clear():Void {
		_stack.clear() ;
	}
	
	public function clone() {
		return new TypedStack(getType(), _stack.clone()) ;
	}

	public function isEmpty():Boolean {
		return _stack.isEmpty() ;
	}

	public function iterator():Iterator {
		return _stack.iterator() ;
	}

	public function peek() {
		return _stack.peek() ;
	}

	public function pop() {
		return _stack.pop() ;
	}

	public function push(o):Void {
		validate(o) ;
		_stack.push(o) ;
	}

	public function search(o):Number {
		return _stack.search(o) ;
	}

	public function setType(type:Function):Void {
		super.setType(type) ;
		_stack.clear() ;
	}

	public function size():Number {
		return _stack.size() ;
	}
	
	public function toArray():Array {
		return _stack.toArray() ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = TypeUtil.toString(_type) ;
		var sourceB:String = Serializer.toSource(_stack) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function toString():String {
		return _stack.toString() ;
	}

	// ----o Private Properties
	
	private var _stack:Stack ;
	
}