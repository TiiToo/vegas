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
 * Converts a Queue to a custom string representation.
 * @author eKameleon
 */
if (vegas.data.queue.QueueFormat == undefined) 
{

	/**
	 * Creates a new QueueFormat instance.
	 */
	vegas.data.queue.QueueFormat = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.data.queue.QueueFormat.extend(vegas.core.CoreObject) ;

	/**
	 * Converts the object to a custom string representation.
	 */	
	vegas.data.queue.QueueFormat.prototype.formatToString = function ( q ) 
	{
		if (q == undefined) return "" ;
		var r /*String*/ = "{";
		if (q.toArray() != undefined) 
		{
			var ar = q.toArray() ;
			var len = ar.length ;
			for (var i = 0 ; i<len ; i++) 
			{
				r += ar[i].toString() ;
				if (i < len-1) r += "," ;
			}
		}
		r += "}";
		return r ;
	}
	
}