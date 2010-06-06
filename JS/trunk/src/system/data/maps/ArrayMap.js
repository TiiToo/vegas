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
 * ArrayMap is an Map implementation based on two arrays to defines the collections of the keys and the values.
 * <p><b>Example :</b></p>
 * {@code
 * var map = new vegas.data.map.ArrayMap(["k0"] , ["v0"]) ;
 * map.put("k1", "v1") ;
 * map.put("k2", "v2") ;
 * 
 * trace(map) ; // {k0:v0,k1:v1,k2:v2}
 * 
 * map.setKeyAt(0, "key0") ; // {key0:v0,k1:v1,k2:v2}
 * trace(map) ;
 * 
 * map.setValueAt(1, "value1") ; // {key0:v0,k1:value1,k2:v2}
 * trace(map) ; 
 * }
 * @author eKameleon
 */
if (vegas.data.map.ArrayMap == undefined) 
{

	/**
	 * @requires vegas.data.map.HashMap
	 */
	require("vegas.data.map.HashMap") ;

	/**
	 * Creates a new ArrayMap instance.
	 */
	vegas.data.map.ArrayMap = function () 
	{ 
		if ( arguments.caller == null )
		{
			vegas.data.map.HashMap.apply(this, Array.fromArguments(arguments) ) ;
		} 
	}

	/**
	 * @extends vegas.data.map.HashMap
	 */	
	proto = vegas.data.map.ArrayMap.extend(vegas.data.map.HashMap) ;

	/**
	 * Sets the value of the "key" in the HashMap (ArrayMap) with the specified index.
	 * @return the old 'key' value in the map if exist.
	 */
	proto.setKeyAt = function( index /*Number*/ , key ) 
	{
		var old = this._keys[index] ;
		if (old === undefined)
		{
			return null ;	
		}
		this._keys[index] = key ;
		return old ;
	}

	/**
	 * Sets the value of the "value" in the HashMap (ArrayMap) with the specified index.
	 * @return the old value in the map if exist.
	 */
	proto.setValueAt = function( index /*Number*/ , value ) 
	{
		var old = this._values[index] ;
		if (old === undefined)
		{
			return null ;	
		}
		this._values[index] = value ;
		return old ;
	}
	
	delete proto ;
		
}