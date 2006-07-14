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

/* TypedMap

	AUTHOR

		Name : TypedMap
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- clear()

		- containsKey( key:* ):Boolean
	
		- containsValue( value:* ):Boolean

		- get(key:*):*
	
		- getKeys():Array
	
		- getValues():Array

		- getType():*

		- isEmpty():Boolean
	
		- iterator():Iterator

		- keyIterator():Iterator

		- put(key:*, value:*):*
	
		- putAll(m:Map):void

		- remove(key):*
	
		- setType(type:*):void
	
		- size():Number

		- supports(value:*):Boolean
		
        - toSource(...arguments:Array):String

		- toString():String

		- validate(value:*):void

    INHERIT
    
   		CoreObject → AbstractTypeable → TypedMap

	IMPLEMENTS
	
        ICloneable, IFormattable, IHashable, ISerializable, Iterable, ITypeable, IValidator

*/

package vegas.data.map
{
	
	import vegas.util.AbstractTypeable;
	
	import vegas.data.Map;
	import vegas.data.iterator.Iterator;

	public class TypedMap extends AbstractTypeable implements Map
	{
		
		// ----o Constructor
		
		public function TypedMap(type:*, map:Map)
		{
			super(type) ;
			if (!map) 
			{
				throw new IllegalArgumentError(this " constructor, argument 'map' must not be 'null' or 'undefined'.") ;
			}
			if (map.size() > 0) {
				var it:Iterator = map.iterator() ;
				while ( it.hasNext() ) 
				{
					validate(it.next()) ;
				}
			}
			_map = map ;
		}
		
		// ----o Public Methods
		
		public function clear():void
		{
			_map.clear() ;
		}

		public function clone():*
		{
			return new TypedMap(getType(), _map.clone()) ;
		}

		public function copy():*
		{
			return new TypedMap(getType(), _map.copy()) ;
		}

		public function containsKey(key:*):Boolean
		{
			return _map.containsKey(key) ;
		}
		
		public function containsValue(value:*):Boolean
		{
			return _map.containsValue(value) ;
			return false;
		}

		public function get(key:*):*
		{
			return _map.get(key) ;
		}

		public function getKeys():Array
		{
			return _map.getKeys() ;
		}
		
		public function getValues():Array
		{
			return _map.getValues() ;
		}
		
		public function isEmpty():Boolean
		{
			return _map.isEmpty() ;
		}

		public function iterator():Iterator
		{
			return _map.iterator() ;
		}

		public function keyIterator():Iterator
		{
			return _map.keyIterator() ;
		}		

		public function put(key:*, value:*):*
		{
			validate(value) ;
			return _map.put(key, value) ;
		}
		
		
		public function putAll(m:Map):void
		{
			var it:Iterator = m.iterator() ;
			while(it.hasNext()) {
				validate(it.next()) ;
			}
			_map.putAll(m) ;
		}
		
		public function remove(key:*):*
		{
			return _map.remove(key) ;
		}

		override public function setType(type:*):void 
		{
			super.setType(type) ;
			_map.clear() ;
		}

		public function size():uint
		{
			return _map.size() ;
		}

		override public function toSource(...arguments:Array):String
		{
			return 'new ' + ClassUtil.getPath(this) + '(' + ClassUtil.getName(getType()) + ',' + _map.toSource() + ')' ;
		}
		
		override public function toString():String
		{
			return _map.toString() ;
		}

		// ----o Private Properties
		
		private var _map:Map ;
	
	}
}