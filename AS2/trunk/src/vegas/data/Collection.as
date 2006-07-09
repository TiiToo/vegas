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

/** Collection [Interface]

	AUTHOR
		
		Name : Collection
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():Void
		
		- clone()
		
		- contains(o):Boolean
		
		- get(id:Number)
		
		- insert(o):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		- size():Number
		
		- toArray():Array
		
		- toString():String

**/

import vegas.core.ISerializable;
import vegas.data.iterator.Iterator;

interface vegas.data.Collection extends ISerializable {

	function clear():Void ;

	function clone() ;

	function contains(o):Boolean ;
	
	function get(id:Number) ;

	function insert(o):Boolean ;
	
	function isEmpty():Boolean ;

	function iterator():Iterator ;
	
	function remove(o):Boolean ;
	
	function size():Number ;

	function toArray():Array ;

	function toString():String ;

}
