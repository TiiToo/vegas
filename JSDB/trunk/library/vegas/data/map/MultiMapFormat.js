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
 * Converts a MultiMap to a custom string representation.
 * @author eKameleon
 */
if (vegas.data.map.MultiMapFormat == undefined) 
{

	/**
	 * Creates a new MultiMapFormat instance.
	 */
	vegas.data.map.MultiMapFormat = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.map.MultiMapFormat.extend(vegas.core.CoreObject) ;

	/**
	 * Converts the object to a custom string representation.
	 */
	proto.formatToString = function ( map /*MultiMap*/ ) /*String*/ 
	{
		var r /*String*/ = "{" ;
		// TODO ici tester que l'objet hérite de MultiMap
		if (map.valueIterator() != undefined && map.keyIterator() != undefined) 
		{
			var kIterator = map.keyIterator() ;
			var vIterator = map.valueIterator() ;
			while  (kIterator.hasNext()) 
			{
				r += kIterator.next().toString() + ":" + vIterator.next().toString() ;
				if (kIterator.hasNext()) r += "," ;
			}
		}
		r += "}";
		return r ;
	}

	delete proto ;
	
}