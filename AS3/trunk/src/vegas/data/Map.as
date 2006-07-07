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

/* Map [Interface]

	AUTHOR

		Name : Map
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2006-07-07
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

    INHERIT

        ICloneable, IFormattable, IHashable, ISerializable, Iterable.

**/

package vegas.data
{

    import vegas.core.IFormattable;
    import vegas.core.ISerializable;
    import vegas.core.IHashable;
    import vegas.core.ICloneable;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;

    public interface Map extends Iterable, ICloneable, ISerializable, IFormattable, IHashable
    {
     
     	function clear():void ;

        function containsKey( key:* ):Boolean ;
	
    	function containsValue( value:* ):Boolean ;

	    function get(key:*):* ;
	
    	function getKeys():Array ;
	
    	function getValues():Array ;

	    function isEmpty():Boolean ;
	
        function keyIterator():Iterator ;

    	function put(key:*, value:*):*  ;
	
    	function putAll(m:Map):void ;

    	function remove(key:*):*  ;
	
    	function size():uint ;

    }

}