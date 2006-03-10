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

/* ------- 	List [Interface]

	AUTHOR

		Name : List
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2005-04-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	METHOD SUMMARY

		- clear()
		
		- clone()
		
		- contains(o)
		
		+ containsAll(c:Collection)
		
		+ equals()
		
		- get(id:Number)
		
		+ indexOf(o):Number
		
		- insert(o):Boolean
		
		+ insertAt(id:Number, o)
		
		+ insertAll(c:Collection):Boolean
		
		+ insertAllAt(id:Number, c:Collection):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		+ lastIndexOf(o):Number
		
		+ listIterator():ListIterator
		
		- remove(o):Boolean
		
		+ removeAll(c:Collection):Boolean
		
		+ removeAt(id:Number) 
		
		+ removeRange(from:Number, to:Number)
		
		+ removesAt(id:Number, len:Number)
		
		+ retainAll(c:Collection):Boolean
		
		+ setAt(id:Number, o)
		
		- size():Number
		
		- subList(fromIndex:Number, toIndex:Number):List
		
		- toArray():Array
		
		- toString():String

	INHERIT
	
		Collection 
			|
			List

	LEGEND : 
		- : Collection
		+ : List

----------  */

import vegas.data.Collection;
import vegas.data.list.ListIterator;

interface vegas.data.List extends Collection {

	function containsAll(c:Collection):Boolean ;

	function equals(o):Boolean ;

	function indexOf(o):Number ;
	
	function insertAt(id:Number, o):Void ;
	
	function insertAll(c:Collection):Boolean ;
	
	function insertAllAt(id:Number, c:Collection):Boolean ;

	function lastIndexOf(o):Number ;
	
	function listIterator():ListIterator ;

	function removeAll(c:Collection):Boolean ;

	function removeAt(id:Number) ;

	function removeRange(from:Number, to:Number):Void ;
	
	function removesAt(id:Number, len:Number) ;

	function retainAll(c:Collection):Boolean ;

	function setAt(id:Number, o):Void ;
	
	function subList(fromIndex:Number, toIndex:Number):List ;

}
