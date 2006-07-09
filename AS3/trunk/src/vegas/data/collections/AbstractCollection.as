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

/* AbstractCollection

	AUTHOR
	
		Name : AbstractCollection
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
			
		- get(id:uin):*
		
		- hashCode():uint
		
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
	
		CoreObject → AbstractCollection

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IFormattable, IHashable, ISerialzable, Iterable

*/

package vegas.data.collections
{

	import vegas.core.CoreObject;
	
	import vegas.data.Collection;
	
	import vegas.data.collections.CollectionFormat ;
	import vegas.data.iterator.ArrayIterator ;
	import vegas.data.iterator.Iterator ;
	
	import vegas.util.Serializer ;
	
	public class AbstractCollection extends CoreObject implements Collection
	{
		
		// ----o Constructor
				
		public function AbstractCollection( ...arguments:Array )
		{
		
			if(arguments.length > 0) {
				
				_a = [].concat(arguments[0]) ;
				
			} else {
				
				_a = [] ;
				
			}
			
		}
		
		// ----o Public Methods
		
		public function clear():void
		{
			_a.splice(0) ;
		}	
		
		public function clone():*
		{
			return null ;
		}
		
		public function copy():*
		{
			return null;
		}
		
		public function contains(o:*):Boolean
		{
			return _a.indexOf(o) >- 1  ;
		}

    	public function get(id:uint):* 
    	{
    		return _a[id] ;	
    	}

		public function indexOf(o:*, fromIndex:uint=0):int
		{
			return _a.indexOf(o, fromIndex) ;
		}

		public function insert(o:*):Boolean
		{
			if (o == undefined) return false ;
			_a.push(o);
			return true ;
		}
		
		public function isEmpty():Boolean
		{
			return _a.length == 0 ;
		}
	
		public function iterator():Iterator
		{
			return new ArrayIterator(_a) ;
		}
		
		public function remove(o:*):Boolean
		{
			var it:Iterator ;
			it = iterator() ;
			if (o == null) 
			{
				while(it.hasNext()) 
				{
					if (it.next() == null) 
					{
						it.remove() ;
						return true ;
					}
					
				}	
				
			}
 			else {
				while (it.hasNext()) 
				{
					if (o == it.next() ) 
					{
						it.remove() ;
						return true ;
					}
				}
			}
			return false ;
			
		}
		
		public function size():Number
		{
			return _a.length ;
		}
		
		public function toArray():Array
		{
			return _a.concat() ;
		}

		override public function toSource(...arguments):String
		{
			return Serializer.getSourceOf(this, [_a]) ;
		}
		
	
		override public function toString():String
		{
			return (new CollectionFormat()).formatToString(this) ;
		}
		
		// ----o Protected Properties
	
		protected var _a:Array ;

		
	}
}