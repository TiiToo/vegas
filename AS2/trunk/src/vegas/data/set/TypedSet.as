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

/* ---------- TypedSet

	AUTHOR

		Name : TypedSet
		Package : vegas.data.set
		Version : 1.0.0.0
		Date : 2005-10-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS

		- clear()
		
		- clone()
		
		- contains(o)
		
		- getType()
		
		- insert(o)
		
		- isEmpty()
		
		- iterator()
		
		- remove(o)
		
		- setType(type:Function) : set the type and clear TypedArray
		
		- size():Number
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String
		
	IMPLEMENTS 

		Iterable, Collection, ISerializable, IHashable, IFormattable, Set, Typeable, Validator	
	
	INHERIT 
	
		CoreObject 
			|
			AbstractTypeable
				|
				TypedSet
	
----------  */

import vegas.core.ICloneable;
import vegas.data.iterator.Iterator;
import vegas.data.Set;
import vegas.errors.IllegalArgumentError;
import vegas.util.AbstractTypeable;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.data.set.TypedSet extends AbstractTypeable implements ICloneable, Set {

	// ----o Constructor

	public function TypedSet(p_type:Function , p_set:Set) {
		super(p_type) ;
		if (!p_set) throw new IllegalArgumentError() ; // "Argument 'p_set' must not be 'null' or 'undefined'.
		_set = p_set ;
		if (_set.size() > 0) {
			var it:Iterator = _set.iterator() ;
			while (it.hasNext()) validate(it.next()) ;
		}
	}
	
	// ----o Public Methods

	public function clear():Void {
		_set.clear() ;
	}
	
	public function clone() {
		return _set.clone() ;
	}

	public function contains(o):Boolean {
		return _set.contains(o) ;
    }

	public function get(id:Number) {
		return _set.get(id) ;
	}

    public function insert(o):Boolean {
		validate(o) ;
		return _set.insert(o) ;
    }

	public function isEmpty():Boolean {
		return _set.isEmpty() ;
	}

	public function iterator():Iterator {
		return _set.iterator() ;
	}

    public function remove(o):Boolean {
		return _set.remove(o);
    }

	public function setType(type:Function):Void {
		super.setType(type) ;
		_set.clear() ;
	}

	public function size():Number {
		return _set.size() ;
	}
	
	public function toArray():Array {
		return _set.toArray() ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = TypeUtil.toString(_type) ;
		var sourceB:String = Serializer.toSource(_set) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function toString():String {
		return _set.toString() ;
	}

	// ----o Private Properties
	
	private var _set:Set ;

	
}