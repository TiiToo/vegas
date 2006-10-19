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

/**	HashMap

	AUTHOR
	
		Name : HashMap
		Package : vegas.data.map
		Version : 1.0.1.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Tableau associatif d'objets

	METHOD SUMMARY
	
		- clear()
		
		- clone()
		
		- containsKey( key )
		
		- containsValue( value )
		
		- get(key)
		
		- getKeys()
		
		- getValues()
		
		- indexOfKey(key)
		
		- indexOfValue(value)
		
		- isEmpty()
		
		- iterator()
		
		- keyIterator()
		
		- put(key, value)
		
		- putAll(m:Map)
		
		- remove(key)
		
		- size()
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject → HashMap
	
	IMPLEMENTS
	
		ICloneable, IFormattable, IHashable, ISerializable, Iterable, Map

*/

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.map.MapFormat;
import vegas.data.map.MapIterator;
import vegas.util.serialize.Serializer;

class vegas.data.map.HashMap extends CoreObject implements ICloneable, Iterable, Map 
{

	/**
	 * Creates a new HashMap instance.
	 */
	public function HashMap() 
	{
		var k:Array = arguments[0] ;
		var v:Array = arguments[1] ;
		var b:Boolean = (k.length > 0 && k.length == v.length) ;
		_keys = b ? [].concat(k) : ((_keys != null) ? [].concat(_keys) : []) ;
		_values = b ? [].concat(v) : ((_values != null) ? [].concat(_values) : [])  ;
	}
	
	// ----o Public Methods	
	
	/**
	 * Removes all mappings from this map.
	 */
	public function clear():Void 
	{
		_keys = [] ;
		_values = [] ;
	}
	
	/**
	 * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
	 */
	public function clone() {
		var m:HashMap = new HashMap() ;
		m.putAll(this) ;
		return m ;
	}
	
	/**
	 * Returns true if this map contains a mapping for the specified key.
	 */
	public function containsKey( key ):Boolean 
	{
		return indexOfKey(key) > -1 ;
	}
	
	/**
	 * Returns true if this map maps one or more keys to the specified value.
	 */
	public function containsValue( value ):Boolean 
	{
		return indexOfValue(value) > -1 ;
	}

	/**
	 * Returns the value to which this map maps the specified key.
	 */
	public function get(key) 
	{
		return _values[indexOfKey(key)] ;
	}

	public function getKeys():Array 
	{
		return _keys.slice() ;
	}

	public function getValues():Array 
	{
		return _values.slice() ;
	}
	
	public function indexOfKey(key):Number 
	{
		var l:Number = _keys.length ;
		while (_keys[--l] != key && l>-1);
		return l ;
	}
	
	public function indexOfValue(value):Number 
	{
		var l:Number = _values.length ;
		while (_values[--l] != value && l>-1) ;
		return l ;
	}
	
	/**
	 * Returns true if this map contains no key-value mappings.
	 */
	public function isEmpty():Boolean 
	{
		return (size() < 1 || size == undefined) ;
	}

	/**
	 * Returns the iterator of this map.
	 */
	public function iterator():Iterator 
	{
		return new MapIterator(this) ;
	}
	
	public function keyIterator():Iterator 
	{
		return new ArrayIterator(_keys) ;
	}

	/**
	 * Associates the specified value with the specified key in this map.
	 */
	public function put(key, value) 
	{
		var r ;
		var i:Number = indexOfKey(key) ;
		if (i<0) {
			_keys.push(key) ;
			_values.push(value) ;
			return null ;
		} else {
			r = _values[i] ;
			_values[i] = value ;
			return r ;
		}
	}
	
	/**
	 * Copies all of the mappings from the specified map to this one.
	 */
	public function putAll(m:Map):Void 
	{
		var aV:Array = m.getValues() ;
		var aK:Array = m.getKeys() ;
		var l:Number = aK.length ;
		for (var i:Number = 0 ; i<l ; i = i - (-1) ) {
			put(aK[i], aV[i]) ;
		}
	}

	/**
	 * Removes the mapping for this key from this map if present.
	 */
	public function remove(key) 
	{
		var r = null ;
		var i:Number = indexOfKey(key) ;
		if (i > -1) {
			r = _values[i] ;
			_values.splice(i, 1) ;
			_keys.splice(i, 1) ;
		}
		return r ;
	}

	/**
	 * Returns the number of key-value mappings in this map.
	 */
	public function size():Number 
	{
		return _keys.length ;
	}

	/**
	 * Returns the Eden representation of this map.
	 */
	public function toSource(indent:Number, indentor:String):String 
	{
		var sourceA:String = Serializer.toSource(_keys) ;
		var sourceB:String = Serializer.toSource(_values) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	/**
	 * Returns the String representation of this map.
	 */
	public function toString():String {
		return (new MapFormat()).formatToString(this) ;
	}

	// -----o Private Properties
	
	private var _keys:Array ;
	private var _values:Array ;

	
}