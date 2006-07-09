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

/* SimpleCollection

	AUTHOR
	
		Name : SimpleCollection
		Package : vegas.data.collections
		Version : 1.0.0.0
		Date : 2005-04-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- clear():void
		
		- clone():*
		
		- copy():*
				
		- contains(o:*):Boolean
		
		- containsAll(c:Collection):Boolean
		
		- get(id)
		
		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- insertAll(c:Collection):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		- removeAll(c:Collection):Boolean
		
		- retainAll(c:Collection):Boolean
		
		- size():Number
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCollection → SimpleCollection

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IFormattable, IHashable, ISerialzable, Iterable

*/

package vegas.data.collections
{
	
	import vegas.data.Collection ;
	import vegas.data.iterator.Iterator ;
	import vegas.util.ObjectUtil ;
	
	public class SimpleCollection extends AbstractCollection
	{
		
		// ----o Constructor
		
		public function SimpleCollection(...arguments)
		{
			super(arguments);
		}
		
		// ----o Public Methods
		
		override public function clone():*
		{
			return new SimpleCollection(toArray()) ;
		}

		override public function copy():*
		{
			return new SimpleCollection(ObjectUtil.copy(toArray())) ;
		}

		public function containsAll(c:Collection):Boolean 
		{
			var it:Iterator = c.iterator() ;
			while(it.hasNext()) {
				if ( ! contains(it.next()) ) 
				{
					return false ;
				}
			}
			return true ;
		}
		
		public function insertAll(c:Collection):Boolean 
		{
			if (c.size() > 0) 
			{
				var it:Iterator = c.iterator() ;
				while(it.hasNext()) insert(it.next()) ;
				return true ;
			}
			else 
			{
				return false ;
			}
		}
	
		public function removeAll(c:Collection):Boolean 
		{
			var b:Boolean = false ;
			var it:Iterator = iterator() ;
			while (it.hasNext()) 
			{
				if ( c.contains(it.next()) ) 
				{
					it.remove() ;
					b = true ;
				}
			}
			return b ;
		}

		public function retainAll(c:Collection):Boolean 
		{
			var b:Boolean = false ;
			var it:Iterator = iterator() ;
			while(it.hasNext()) 
			{
				if ( ! c.contains(it.next()) ) 
				{
					it.remove() ;
					b = true ;
				}
			}
			return b ;
		}
		
	}
}