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

/* ------- 	MultiMap [Interface]

	AUTHOR

		Name : MultiMap
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2005-05-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHODS
	
		- putCollection(key, c:Collection)
		
		- totalSize():Number
		
		- values():Collection
		
		- valueIterator():Iterator
	
	INHERITS
	
		Map

----------  */

import vegas.data.Collection;
import vegas.data.iterator.Iterator;
import vegas.data.Map;

interface vegas.data.MultiMap extends Map {

	function putCollection(key, c:Collection):Void ;

	function totalSize():Number ;
	
	function values():Collection ;
	
	function valueIterator():Iterator ;
	
}
