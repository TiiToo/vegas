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

**/

import vegas.core.CoreObject;
import vegas.core.ICloneable;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.data.map.MapFormat;
import vegas.data.map.MapIterator;
import vegas.util.serialize.Serializer;

class vegas.data.map.HashMap extends CoreObject implements ICloneable, Iterable, Map {

	// ----o Construtor
	
	public function HashMap() {
		var k:Array = arguments[0] ;
		var v:Array = arguments[1] ;
		var b:Boolean = (k.length > 0 && k.length == v.length) ;
		_keys = b ? [].concat(k) : [] ;
		_values = b ? [].concat(v) : [] ;
	}
	
	// ----o Public Methods	
	
	/**
	 * This clears all in the map.
	 */
	public function clear():Void {
		_keys = [] ;
		_values = [] ;
	}
	
	/**
	 * Clones the map.
	 */
	public function clone() {
		var m:HashMap = new HashMap() ;
		m.putAll(this) ;
		return m ;
	}
	
	public function containsKey( key ):Boolean {
		return indexOfKey(key) > -1 ;
	}
	
	public function containsValue( value ):Boolean {
		return indexOfValue(value) > -1 ;
	}

	public function get(key) {
		return _values[indexOfKey(key)] ;
	}

	public function getKeys():Array {
		return _keys.slice() ;
	}

	public function getValues():Array {
		return _values.slice() ;
	}
	
	public function indexOfKey(key):Number {
		var l:Number = _keys.length ;
		while (_keys[--l] != key && l>-1);
		return l ;
	}
	
	public function indexOfValue(value):Number {
		var l:Number = _values.length ;
		while (_values[--l] != value && l>-1) ;
		return l ;
	}
	
	public function isEmpty():Boolean {
		return (size() < 1 || size == undefined) ;
	}

	public function iterator():Iterator {
		return new MapIterator(this) ;
	}
	
	public function keyIterator():Iterator {
		return new ArrayIterator(_keys) ;
	}

	public function put(key, value) {
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
	
	public function putAll(m:Map):Void {
		var aV:Array = m.getValues() ;
		var aK:Array = m.getKeys() ;
		var l:Number = aK.length ;
		for (var i:Number = 0 ; i<l ; i = i - (-1) ) {
			put(aK[i], aV[i]) ;
		}
	}

	public function remove(key) {
		var r = null ;
		var i:Number = indexOfKey(key) ;
		if (i > -1) {
			r = _values[i] ;
			_values.splice(i, 1) ;
			_keys.splice(i, 1) ;
		}
		return r ;
	}

	public function size():Number {
		return _keys.length ;
	}

	public function toSource(indent:Number, indentor:String):String {
		var sourceA:String = Serializer.toSource(_keys) ;
		var sourceB:String = Serializer.toSource(_values) ;
		return Serializer.getSourceOf(this, [sourceA, sourceB]) ;
	}

	public function toString():String {
		return (new MapFormat()).formatToString(this) ;
	}

	// -----o Private Properties
	
	private var _keys:Array ;
	private var _values:Array ;

	
}