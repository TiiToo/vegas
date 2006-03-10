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

/* ------- 	Map [Interface]

	AUTHOR

		Name : Map
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- clear()

		- containsKey( key ):Boolean
	
		- containsValue( value ):Boolean

		- get(key)
	
		- getKeys():Array
	
		- getValues():Array

		- isEmpty():Boolean
	
		- iterator():Iterator

		- keyIterator():Iterator

		- put(key, value)
	
		- putAll(m:Map)

		- remove(key)
	
		- size():Number

		- toString():String

	TODO : PrimitiveTypeMap
	TODO : PriorityMap

----------  */

import vegas.core.ISerializable;
import vegas.data.iterator.Iterator;

interface vegas.data.Map extends ISerializable {

	function clear():Void ;

	function clone() ;
	
	function containsKey( key ):Boolean ;
	
	function containsValue( value ):Boolean ;

	function get(key) ;
	
	function getKeys():Array ;
	
	function getValues():Array ;

	function isEmpty():Boolean ;
	
	function iterator():Iterator ;

	function keyIterator():Iterator ;

	function put(key, value) ;
	
	function putAll(m:Map):Void ;

	function remove(key) ;
	
	function size():Number ;

	function toString():String ;

}
