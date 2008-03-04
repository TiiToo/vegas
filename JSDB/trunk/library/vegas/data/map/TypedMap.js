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
 * TypedMap is a wrapper for Map instances that ensures that only values of a specific type can be added to the wrapped Map.
 * @author eKameleon
 */
if (vegas.data.map.TypedMap == undefined) 
{

	/**
	 * @require vegas.util.AbstractTypeable
	 */
	require("vegas.util.AbstractTypeable") ;

	/**
	 * Creates a new TypedMap instance.
	 * @param fType the type of all values in this TypedMap.
	 * @param m the map to wrapp.
	 * @throws IllegalArgumentError if the specified map in argument is {@code null} or {@code undefined}.
	 */
	vegas.data.map.TypedMap = function ( type /*Function*/ , map /*Map*/ ) 
	{ 
		this.__constructor__.call(this, type) ;
		if (map == null) throw new vegas.errors.IllegalArgumentError("TypedMap constructor failed with the 'map' argument. It must not be 'null' or 'undefined'") ;
		if (map.size() > 0) 
		{
			var it = map.iterator() ;
			while ( it.hasNext() ) 
			{
				this.validate(it.next()) ;
			}
		}
		this._map = map ;
	}

	/**
	 * @extends vegas.util.AbstractTypeable
	 */
	proto = vegas.data.map.TypedMap.extend(vegas.util.AbstractTypeable) ;

	/**
	 * Removes all mappings from this map (optional operation).
	 */
	proto.clear = function () 
	{
		this._map.clear() ;
	}

	/**
	 * Returns a shallow copy of the map.
	 * @return a shallow copy of the map.
	 */
	proto.clone = function () 
	{
		return new vegas.data.map.TypedMap(this.getType(), this._map) ;
	}

	/**
	 * Returns {@code true} if this map contains a mapping for the specified key.
	 * @return {@code true} if this map contains a mapping for the specified key.
	 */
	proto.containsKey = function ( key ) /*Boolean*/ 
	{
		return this._map.containsKey(key) ;
	}

	/**
	 * Returns {@code true} if this map maps one or more keys to the specified value.
	 * @return {@code true} if this map maps one or more keys to the specified value.
	 */
	proto.containsValue = function ( value ) /*Boolean*/ 
	{
		return this._map.containsValue(value) ;
	}

	/**
	 * Returns the value to which this map maps the specified key.
	 * @return the value to which this map maps the specified key.
	 */
	proto.get = function (key) 
	{
		return this._map.get(key) ;
	}

	/**
	 * Returns an array of all the keys in the map.
	 * @return an array of all the keys in the map.
	 */
	proto.getKeys = function () /*Array*/ 
	{
		return this._map.getKeys() ;
	}

	/**
	 * Returns an array of all the values in the map.
	 * @return an array of all the values in the map.
	 */
	proto.getValues = function () /*Array*/ 
	{
		return this._map.getValues() ;
	}

	/**
	 * Returns {@code true} if this map contains no key-value mappings.
	 * @return {@code true} if this map contains no key-value mappings.
	 */
	proto.isEmpty = function () /*Boolean*/ 
	{
		return this._map.isEmpty() ;
	}

	/**
	 * Returns the values iterator of this map.
	 * @return the values iterator of this map.
	 */
	proto.iterator = function () /*Iterator*/ 
	{
		return this._map.iterator() ;
	}

	/**
	 * Returns the keys iterator of this map.
	 * @return the keys iterator of this map.
	 */
	proto.keyIterator = function () /*Iterator*/ 
	{
		return this._map.keyIterator() ;
	}

	/**
	 * Associates the specified value with the specified key in this map (optional operation).
	 */
	proto.put = function (key, value) 
	{
		this.validate(value) ;
		return this._map.put(key, value) ;
	}

	/**
	 * Copies all of the mappings from the specified map to this map (optional operation).
	 */
	proto.putAll = function (m /*Map*/) 
	{
		var it = m.iterator() ;
		while(it.hasNext()) this.validate(it.next()) ;
		this._map.putAll(m) ;
	}

	/**
	 * Removes the mapping for this key from this map if it is present (optional operation).
	 */
	proto.remove = function (key) 
	{
		return this._map.remove() ;
	}

	/**
	 * Sets the type of the ITypeable object.
	 */
	/*override*/ proto.setType = function (type /*Function*/ ) 
	{
		this.__constructor__.prototype.setType.call(this, type) ;
		this._map.clear() ;
	}

	/**
	 * Returns the number of key-value mappings in this map.
	 * @return the number of key-value mappings in this map.
	 */
	proto.size = function () /*Number*/ 
	{
		return this._map.size() ;
	}

	/**
	 * Returns a Eden representation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function (indent, indentor) /*String*/ 
	{
		var sourceA/*String*/ = vegas.util.TypeUtil.toString(this._type) ;
		var sourceB/*String*/ = this._map.toSource() ;
		return "new " + this.getConstructorPath + "(" + sourceA + "," + sourceB + ")" ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	proto.toString = function () 
	{
		return this._map.toString() ;
	}
	
	delete proto ;
	
}