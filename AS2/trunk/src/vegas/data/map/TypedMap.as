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

/** TypedMap
	
	AUTHOR

		Name : TypedMap
		Package : vegas.data.map
		Version : 1.0.0.0
		Date : 2005-11-03
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHODS

		- clear():Void
		
		- clone()
		
		- containsKey(o):Boolean
		
		- containsValue(o):Boolean
		
		- get(key)
		
		- getKeys():Array
		
		- getValues():Array
		
		- getType()
		
		- isEmpty()
		
		- iterator()
		
		- keyIterator():Iterator
		
		- put(key, value)
		
		- putAll(m:Map):Void
		
		- remove(o)
		
		- setType(type:Function) : set the type and clear TypedArray
		
		- size():Number
		
		- toSource():String
		
		- toString():String
	
	INHERIT
	
		CoreObject → AbstractTypeable → AbstractTypeable

	IMPLEMENTS 

		ICloneable, Iterable, Map, Typeable, ISerializable, IFormattable, Validator
	
*/

import vegas.core.ICloneable;
import vegas.core.IFormattable;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.errors.IllegalArgumentError;
import vegas.util.AbstractTypeable;
import vegas.util.serialize.Serializer;
import vegas.util.TypeUtil;

class vegas.data.map.TypedMap extends AbstractTypeable implements ICloneable, Map, IFormattable {

	// ----o Constructor

	public function TypedMap( fType:Function , m:Map) {
		
		super( fType ) ;
		if ( m == null) 
		{
			throw new IllegalArgumentError("Argument 'map' must not be 'null' or 'undefined'.") ;
		}
		if ( m.size() > 0) 
		{
			var it = m.iterator() ;
			while ( it.hasNext() ) 
			{
				validate(it.next()) ;
			}
		}
		_map = m ;
		trace(_map) ;
	}

	// ----o Public Methods

	public function clear():Void 
	{
		_map.clear() ;
	}
	
	public function clone() 
	{
		return new TypedMap(_type, _map) ;
	}

	public function containsKey(o):Boolean 
	{
		return _map.containsKey(o) ;
    }

	public function containsValue(o):Boolean 
	{
		return _map.containsValue(o) ;
    }

	public function get(key) 
	{
		return _map.get(key) ;
	}

	public function getKeys():Array 
	{
		return _map.getKeys() ;
	}
	
	public function getValues():Array 
	{
		return _map.getValues() ;
	}
	
	public function isEmpty():Boolean 
	{
		return _map.isEmpty() ;
	}

	public function iterator():Iterator 
	{
		return _map.iterator() ;
	}

	public function keyIterator():Iterator 
	{
		return _map.keyIterator() ;
	}

	public function put(key, value) 
	{
		validate(value) ;
		return _map.put(key, value) ;
	}
	
	public function putAll(m:Map):Void 
	{
		var it:Iterator = m.iterator() ;
		while(it.hasNext()) {
			validate(it.next()) ;
		}
		_map.putAll(m) ;
	}

    public function remove(key) 
    {
		return _map.remove(key) ;
    }

	/*override*/ public function setType(type:Function):Void 
	{
		super.setType(type) ;
		_map.clear() ;
	}

	public function size():Number 
	{
		return _map.size() ;
	}

	public function toSource(indent:Number, indentor:String):String 
	{
		var sourceA:String = TypeUtil.toString(_type) ;
		var sourceB:String = Serializer.toSource(_map) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function toString():String 
	{
		return _map.toString() ;
	}

	// ----o Private Properties
	
	private var _map:Map ;

	
}