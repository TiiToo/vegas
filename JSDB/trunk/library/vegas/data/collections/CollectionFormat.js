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
 * Converts a Collection to a custom string representation.
 * @author eKameleon
 */
if (vegas.data.collections.CollectionFormat == undefined) 
{

	/**
	 * Creates a new Collectionformat instance.
	 */
	vegas.data.collections.CollectionFormat = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.data.collections.CollectionFormat.extend(vegas.core.CoreObject) ;

	/**
	 * Converts the object to a custom string representation.
	 */	
	vegas.data.collections.CollectionFormat.prototype.formatToString = function ( co ) 
	{
		if (co == undefined) return "" ;
		var r /*String*/ = "{";
		if (co.toArray() != undefined) 
		{
			var ar = co.toArray() ;
			var len = ar.length ;
			for (var i = 0 ; i<len ; i++) 
			{
				r += (ar[i] != null) ? ar[i].toString() : "" ;
				if (i < len-1) r += "," ;
			}
		}
		r += "}";
		return r ;
	}

}