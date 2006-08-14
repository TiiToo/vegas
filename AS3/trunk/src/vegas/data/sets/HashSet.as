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

/* AbstractSet

	AUTHOR
	
		Name : AbstractSet
		Package : vegas.data.sets
		Version : 1.0.0.0
		Date : 2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	DESCRIPTION
	
		A collection that contains no duplicate elements.
		
		It makes no guarantees as to the iteration order of the set.
	
	METHOD SUMMARY

		- clear():void
		
		- clone():*
		
		- copy():*
				
		- contains(o:*):Boolean
		
		- containsAll(c:Collection):Boolean
		
		- equals(o:*):Boolean
		
		- get(id)
		
		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- insertAll(c:Collection):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):*
		
		- removeAll(c:Collection):Boolean
		
		- retainAll(c:Collection):Boolean
		
		- size():Number
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCollection → SimpleCollection → AbstractSet → HashSet

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IEquality, IFormattable, IHashable, ISerialzable, Iterable, Set

*/

package vegas.data.sets
{
	
	import vegas.data.Collection ; 
	import vegas.data.iterator.ArrayIterator 
	import vegas.data.iterator.Iterator 
	import vegas.data.map.HashMap;
	import vegas.util.Copier ;
	import vegas.util.Serializer ;
	
	public class HashSet extends AbstractSet
	{
		
		// ----o Constructor
		
		public function HashSet( init:*=null )
		{
			
			super(null) ;
			
			_map = new HashMap() ;
			
			if (init == null) return ;
			
			var it:Iterator = null ;
			
			if (init is Array) 
			{
				it = new ArrayIterator(init) ;
			}
			else if (init is Collection) 
			{
				it = init.iterator() ;
			}
			
			if (it != null) {
				
				while (it.hasNext())
				{
					insert(it.next()) ;
				} 
				
			}
			
		}
		
		// ----o Constants
	
		static private const PRESENT:Object = new Object() ;
		
		// ----o Publlic Methods
		
		override public function clear():void
		{
			_map.clear() ;
		}
		
		override public function clone():*
		{
			return new HashSet(toArray()) ;
		}
				
		override public function contains(o:*):Boolean 
		{
			return _map.containsKey(o) ;
	    }

		override public function copy():*
		{
			return new HashSet( Copier.copy(toArray())) ;
		}

		override public function insert(o:*):Boolean 
		{
			return _map.put(o, PRESENT) == null ;
    	}

		override public function isEmpty():Boolean 
		{
			return _map.isEmpty() ;
		}

		override public function iterator():Iterator 
		{
			return _map.keyIterator() ;
		}

    	override public function remove(o:*):* {
			return _map.remove(o) == PRESENT ;
    	}
	
		override public function size():uint {
			return _map.size() ;
		}
	
		override public function toArray():Array 
		{
			return _map.getKeys() ;
		}
	
		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}
		
		// ----o Private Properties
		
		private var _map:HashMap ;
		
	}
}