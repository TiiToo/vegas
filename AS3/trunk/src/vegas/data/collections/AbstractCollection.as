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
		Date : 2006-07-09
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
		
		- size():uint
		
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
				
		public function AbstractCollection( ar:Array=null )
		{

			if (ar is Array && ar.length > 0) 
			{	
				_a = ar.slice() ;	
			}
			else 
			{
				_a = new Array() ;
			}
			
		}
		
		// ----o Public Methods
		
		/**
    	 * Clear the queue object.
    	 */
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
		
		/**
		 * Return true if the queue contains value.
		 */
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
		
        /**
         * Returns trus if the queue is empty.
         */
		public function isEmpty():Boolean
		{
			return _a.length == 0 ;
		}
	
		public function iterator():Iterator
		{
			return new ArrayIterator(toArray()) ;
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
		
	    /**
	     * Retrieves the size of the queue.
	     */
		public function size():uint
		{
			return _a.length ;
		}
	
		/**
	     * Retrieves an Array representation of the queue.
	     */
		public function toArray():Array
		{
			return _a.concat() ;
		}

		override public function toSource(...arguments:Array):String
		{
			return Serializer.getSourceOf(this, [toArray()]) ;
		}
		
	
		override public function toString():String
		{
			return (new CollectionFormat()).formatToString(this) ;
		}
		
		// ----o Protected Properties
	
		protected var _a:Array ;

		
	}
}