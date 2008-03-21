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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Hash table based implementation of the Map interface. 
 * <p><b>Attention :</b> this class is the ArrayMap class in the AS3 version of VEGAS.</p>
 * <p><b>Example :</b></p>
 * {@code
 * var map = new vegas.data.map.HashMap() ;
 * map.put("key1", "value1") ;
 * map.put("key2", "value2") ;
 * map.put("key3", "value3") ;
 * 
 * trace ("map toString : " + map) ;
 * trace ("map toSource : " + map.toSource()) ;
 * 
 * trace ("------ iterator") ;
 * var it = map.iterator() ;
 * while (it.hasNext()) 
 * {
 *     trace (it.next() + " : " + it.key()) ;
 * }
 * 
 * trace ("------ clone") ;
 * var map2 = map.clone() ;
 * map2.put("key1", "value4") ;
 * map2.remove("key2") ;
 * trace ("initial map : " + map) ;
 * trace ("clone map : " + map2) ;
 * }
 * @author eKameleon
 */
if (vegas.data.map.HashMap == undefined) 
{

	/**
	 * @requires vegas.data.Map
	 */
	require("vegas.data.Map") ;

	/**
	 * Creates a new HashMap instance.
	 */
	vegas.data.map.HashMap = function () 
	{ 
		var k = arguments[0] ;
		var v = arguments[1] ;
		var b = (k instanceof Array && v instanceof Array && k.length == v.length) ;
		this._keys = b ? [].concat(k) : [] ;
		this._values = b ? [].concat(v) : [] ;
	}

	/**
	 * @extends vegas.data.Map
	 */
	proto = vegas.data.map.HashMap.extend(vegas.data.Map) ;

	/**
	 * Removes all mappings from this map.
	 */
	proto.clear = function () 
	{
		this._keys = [] ;
		this._values = [] ;
	}

	/**
	 * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
	 * @return a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
	 */
	proto.clone = function () 
	{
		return new vegas.data.map.HashMap(this._keys, this._values) ;
	}

	/**
	 * Returns {@code true} if this map contains a mapping for the specified key.
	 * @return {@code true} if this map contains a mapping for the specified key.
	 */
	proto.containsKey = function ( key ) /*Boolean*/ 
	{
		return this._keys.contains(key) ;
	}

	/**
	 * Returns {@code true} if this map maps one or more keys to the specified value.
	 * @return {@code true} if this map maps one or more keys to the specified value.
	 */
	proto.containsValue = function ( value ) /*Boolean*/ 
	{
		return this._values.contains( value ) ;
	}

	/**
	 * Returns the value to which this map maps the specified key.
	 * @return the value to which this map maps the specified key.
	 */
	proto.get = function (key) 
	{
		return this._values[this.indexOfKey(key)] ;
	}

	/**
	 * Returns an array representation of all keys in the map.
	 * @return an array representation of all keys in the map.
	 */
	proto.getKeys = function () /*Array*/ 
	{
		return this._keys.concat() ;
	}

	/**
	 * Returns an array representation of all values in the map.
	 * @return an array representation of all values in the map.
	 */
	proto.getValues = function () /*Array*/ 
	{
		return this._values.concat() ;
	}

	/**
	 * Returns the index of the specified key in argument.
	 * @param key the key in the map to search.
	 * @return the index of the specified key in argument.
	 */
	proto.indexOfKey = function (key) /*Number*/ 
	{
		return this._keys.indexOf(key) ;
	}

	/**
	 * Returns the index of the specified value in argument.
	 * @param value the value in the map to search.
	 * @return the index of the specified value in argument.
	 */
	proto.indexOfValue = function (value) /*Number*/ 
	{
		return this._values.indexOf(value) ;
	}

	/**
	 * Returns true if this map contains no key-value mappings.
	 * @return true if this map contains no key-value mappings.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return (this.size() == undefined) || (this.size() < 1) ;
	}

	/**
	 * Returns the values iterator of this map.
	 * @return the values iterator of this map.
	 */
	proto.iterator = function () /*Iterator*/ 
	{
		return new vegas.data.map.MapIterator(this) ;
	}

	/**
	 * Returns the keys iterator of this map.
	 * @return the keys iterator of this map.
	 */
	proto.keyIterator = function () /*Iterator*/ 
	{
		return new vegas.data.iterator.ArrayIterator(this._keys) ;
	}

	/**
	 * Associates the specified value with the specified key in this map.
	 * @param key the key to register the value.
	 * @param value the value to be mapped in the map.
	 */
	proto.put = function (key, value) 
	{
		var r = null ;
		var i /*Number*/ = this.indexOfKey(key) ;
		if (i<0) 
		{
			this._keys.push(key) ;
			this._values.push(value) ;
		} 
		else 
		{
			r = this._values[i] ;
			this._values[i] = value ;
		}
		return r ;
	}

	/**
	 * Copies all of the mappings from the specified map to this one.
	 */
	proto.putAll = function (m /*Map*/) 
	{
		var aV /*Array*/ = m.getValues() ;
		var aK /*Array*/ = m.getKeys() ;
		var l = aK.length ;
		for (var i = 0 ; i<l ; i = i - (-1) ) 
		{
			this.put(aK[i], aV[i]) ;
		}
	}

	/**
	 * Removes the mapping for this key from this map if present.
	 */
	proto.remove = function (key) 
	{
		var r = null ;
		var i = this.indexOfKey(key) ;
		if (i > -1) {
			r = this._values[i] ;
			this._keys.splice(i, 1) ;
			this._values.splice(i, 1) ;
		}
		return r ;
	}

	/**
	 * Returns the number of key-value mappings in this map.
	 * @return the number of key-value mappings in this map.
	 */
	proto.size = function () /*Number*/ 
	{
		return this._keys.length ;
	}

	/**
	 * Returns the eden representation of this map.
	 * @return the eden representation of this map.
	 */
	proto.toSource = function (indent, indentor) /*String*/ 
	{
		return "new " + this.getConstructorPath() + "(" + this._keys.toSource() + "," + this._values.toSource() + ")" ;
	}

	/**
	 * Returns the string representation of this map.
	 * @return the string representation of this map.
	 */
	proto.toString = function () 
	{
		return (new vegas.data.map.MapFormat()).formatToString(this) ;
	}
	
	proto._keys = [] ;
	
	proto._values = [] ;
	
	delete proto ;
	
}