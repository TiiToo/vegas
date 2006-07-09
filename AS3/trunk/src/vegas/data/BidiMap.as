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

/* BidiMap [Interface]

	AUTHOR

		Name : BidiMap
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

		- inverseBidiMap():Map

		- isEmpty():Boolean
	
		- iterator():Iterator

		- keyIterator():Iterator

		- put(key, value)
	
		- putAll(m:Map)

		- remove(key)
	
		- size():Number

        - toSource(...arguments:Array):String

		- toString():String

    INHERIT

        ICloneable, IFormattable, IHashable, ISerializable, Iterable, Map.

**/

package vegas.data
{
	public interface BidiMap extends Map
	{
		/**
		 * Gets a view of this map where the keys and values are reversed.
		 */
		public function inverseBidiMap():Map ;
	}
}