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

/* Stack [Interface]

	AUTHOR
	
		Name : Stack
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():void
		
		- clone(:*
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- peek():*
		
		- pop():*
		
		- push(o):*
		
		- search(o):Number
		
		- size():uint
		
		- toArray():Array ;
		
		- toString():String


	INHERIT
	
		ICloneable, Iterable, IFormattable, ISerializable

**/

package vegas.data
{
	import vegas.core.ICloneable;
	import vegas.data.iterator.Iterable;
	import vegas.core.IFormattable;
	import vegas.core.ISerializable;
	
    public interface Stack extends ICloneable, Iterable, IFormattable, ISerializable
    {

		function clear()void ;
	
		function isEmpty():Boolean ;

		function iterator():Iterator ;

		function peek():* ;

		function pop():* ;

		function push(o:*):void ;
	
		function search(o:*):uint ;

		function size():uint ;

		function toArray():Array ;
	
    }
}