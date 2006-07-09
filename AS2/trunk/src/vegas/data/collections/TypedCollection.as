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

/** TypedCollection

 	AUTHOR
	
		Name : TypedCollection
		Package : vegas.data.collections
		Version : 1.0.0.0
		Date : 2005-11-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS

		- clear()
		
		- contains(o)
		
		- get(id:Number)
		
		- insert(o):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		- size():Number
		
		- toArray():Array
		
		- toSource():String

	INHERIT
	
		CoreObject > AbstractTypeable > TypedCollection

	IMPLEMENTS 

		Iterable, ISerializable, Typeable, Validator, IFormattable, IHashable	
	
*/

import vegas.core.ICloneable;
import vegas.data.Collection;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.errors.IllegalArgumentError;
import vegas.util.AbstractTypeable;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.data.collections.TypedCollection extends AbstractTypeable implements ICloneable, Iterable, Collection {

	// ----o Constructor

	public function TypedCollection(p_type:Function , co:Collection) {
		super(p_type) ;
		if (!co) throw new IllegalArgumentError("Argument 'co' must not be 'null' or 'undefined'.") ;
		if (co.size() > 0) {
			var it:Iterator = co.iterator() ;
			while ( it.hasNext() ) 	validate(it.next()) ;
		}
		_co = co ;
	}

	// ----o Public Methods

	public function clear():Void {
		_co.clear() ;
	}
	
	public function clone() {
		return new TypedCollection(getType(), _co.clone()) ;
	}

	public function contains(o):Boolean {
		return _co.contains(o) ;
    }

	public function get(id:Number) {
		return _co.get(id) ;
	}

    public function insert(o):Boolean {
		validate(o) ;
		return _co.insert(o) ;
    }

	public function isEmpty():Boolean {
		return _co.isEmpty() ;
	}

	public function iterator():Iterator {
		return _co.iterator() ;
	}

    public function remove(o):Boolean {
		return _co.remove(o);
    }

	public function setType(type:Function):Void {
		super.setType(type) ;
		_co.clear() ;
	}

	public function size():Number {
		return _co.size() ;
	}
	
	public function toArray():Array {
		return _co.toArray() ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = TypeUtil.toString(_type) ;
		var sourceB:String = Serializer.toSource(_co) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function toString():String {
		return _co.toString() ;
	}

	// ----o Private Properties
	
	private var _co:Collection ;
	
}