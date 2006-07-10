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

/* List [Interface]

    AUTHOR

    	Name : List
    	Package : vegas.data
    	Version : 1.0.0.0
    	Date :  2006-07-08
    	Author : ekameleon
    	URL : http://www.ekameleon.net
    	Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():Void
		
		- clone():*
		
		- containsAll(c:Collection):Boolean
		
		- copy():*
		
		- contains(o:*):Boolean
		
		- get(id:uin):*
		
		- indexOf(o:*):Number
		
		- insert(o:*):Boolean
		
		- insertAll(c:Collection):Boolean
		
		- insertAllAt(id:uint, c:Collection):Boolean
		
		- insertAt(id:uint, o:*):void
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- lastIndexOf(o:*):Number
		
		- listIterator():ListIterator
		
		- remove(o):Boolean
		
		- removeAll(c:Collection):Boolean
		
		- removeAt(id:uint):*
		
		- retainAll(c:Collection):Boolean
		
		- setAt(id:uint, o:*):void
		
		- size():Number
		
		- subList(fromIndex:uint, toIndex:uint):List
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

    INHERIT
    
        Collection, ICloneable, ICopyable, IEquality, IFormattable, ISerialzable, Iterable

**/

package vegas.data
{

    import vegas.core.IEquality;
    import vegas.data.iterator.ListIterator ;
    
    public interface List extends Collection, IEquality
    {
    	function containsAll(c:Collection):Boolean ;

    	function insertAll(c:Collection):Boolean ;
	
    	function insertAllAt(id:uint, c:Collection):Boolean ;

    	function insertAt(id:uint, o:*):void ;

    	function lastIndexOf(o:*):int ;
	
    	function listIterator( position:uint=0 ):ListIterator ;

    	function removeAll(c:Collection):Boolean ;

    	function removeAt(id:uint):* ;

    	function removeRange(fromIndex:uint, toIndex:uint):void ;
	
    	function removesAt(id:uint, len:uint):* ;

    	function retainAll(c:Collection):Boolean ;

    	function setAt(id:uint, o:*):void ;
	
	    function subList(fromIndex:uint, toIndex:uint):List ;
    }
}