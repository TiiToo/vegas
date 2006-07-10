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

/* Collection [Interface]

    AUTHOR

    	Name : Collection
    	Package : vegas.data
    	Version : 1.0.0.0
    	Date :  2006-07-08
    	Author : ekameleon
    	URL : http://www.ekameleon.net
    	Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():Void
		
		- clone():*
		
		- copy():*
		
		- contains(o:*):Boolean
		
		- get(id:uin):*
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		- size():Number
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

    INHERIT
    
        ICloneable, ICopyable, IFormattable, ISerialzable, Iterable

**/

package vegas.data
{
   
    import vegas.core.ISerializable;
    import vegas.core.ICloneable;
    import vegas.core.ICopyable;
    import vegas.core.IFormattable ;
    import vegas.data.iterator.Iterable;

    public interface Collection extends ICloneable, ICopyable, IFormattable, ISerializable, Iterable
    {
        
        function clear():void ;

    	function contains(o:*):Boolean ;
	
    	function get(id:uint):* ;

		function indexOf(o:*, fromIndex:uint=0):int

    	function insert(o:*):Boolean ;
	
    	function isEmpty():Boolean ;
	
    	function remove(o:*):Boolean ;
	
    	function size():uint ;

    	function toArray():Array ;

    }
}