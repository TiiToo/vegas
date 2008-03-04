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
 * Internal class in the {@code LinkedList} class to defined all entries in the list and the links betweens alls.
 * @author eKameleon
 * @version 1.0.0.0
 */
if (vegas.data.list.LinkedListEntry == undefined) 
{

	/**
	 * Creates a new LinkedListEntry instance.
	 */
	vegas.data.list.LinkedListEntry = function (  element , next /*LinkedListEntry*/ , previous /*LinkedListEntry*/ ) 
	{ 
		this.element  = element ;
		this.next     = next ;
		this.previous = previous ;	
	}
	
	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = vegas.data.list.LinkedListEntry.extend(vegas.core.CoreObject) ;

	/**
	 * The element of this entry.
	 */
	proto.element = null ;

	/**
	 * The next entry.
	 */
	proto.next /*LinkedListEntry*/ = null ;
	
	/**
	 * The previous entry.
	 */
	proto.previous /*LinkedListEntry*/ = null ;

	delete proto ;

}