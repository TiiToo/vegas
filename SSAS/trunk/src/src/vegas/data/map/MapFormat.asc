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
 * Converts a Map to a custom string representation.
 * @author eKameleon
 */
if (vegas.data.map.MapFormat == undefined) 
{
	
	/**
	 * Creates a new MapFormat instance.
	 */
	vegas.data.map.MapFormat = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.data.map.MapFormat.extend(vegas.core.CoreObject) ;

	/**
	 * Converts the object to a custom string representation.
	 */	
	vegas.data.map.MapFormat.prototype.formatToString = function ( map ) 
	{
		var r /*String*/ = "{" ;
		if (map.getKeys() != undefined && map.getValues() != undefined) 
		{
			var k = map.getKeys() ;
			var v = map.getValues() ;
			var kIterator = new vegas.data.iterator.ArrayIterator( k ) ;
			var vIterator = new vegas.data.iterator.ArrayIterator( v ) ;
			while  (kIterator.hasNext()) 
			{
				r += kIterator.next().toString() + ":" + vIterator.next().toString() ;
				if (kIterator.hasNext()) r += "," ;
			}
		}
		r += "}";
		return r ;
	}

}