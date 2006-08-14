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

/* LinearQueue

	AUTHOR
	
		Name : LinearQueue
		Package : vegas.data.queue
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
		
		- dequeue():Boolean 
		
		- element():* 
		
		- enqueue(o:*):Boolean
		
		- get(key:*):*
		
		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- peek():*
		
		- poll():*
		
		- remove(o):*
		
		- size():uint
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCollection → SimpleCollection → LinearQueue

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IFormattable, IHashable, ISerialzable, Iterable, Queue

	EXAMPLE
	
		var q:LinearQueue = new LinearQueue() ;
		trace("enqueue item1 : " + q.enqueue("item1")) ;
		trace("enqueue item1 : " + q.enqueue("item2")) ;
		trace("enqueue item1 : " + q.enqueue("item3")) ;
		trace("enqueue item1 : " + q.enqueue("item4")) ;
		
		trace("poll : " + q.poll()) ;
		
		trace("queue : " + q) ;
		trace("queue toSource : " + q.toSource()) ;
		trace("queue toArray : " + q.toArray()) ;

*/

package vegas.data.queue
{
	import vegas.data.collections.SimpleCollection;
	import vegas.data.Queue;
	
	import vegas.util.Copier ;

	public class LinearQueue extends SimpleCollection implements Queue
	{
		
		// ----o Constructor
		
		public function LinearQueue( ar:Array=null )
		{
			super(ar);
		}
		
		// ----o Public Methods
		

		override public function clone():*
		{
			return new LinearQueue(toArray()) ;
		}
		
		override public function copy():*
		{
			return new LinearQueue(Copier.copy(toArray())) ;
		}
	
        /**
         * Retrieves and removes the head of this queue.
         */
    	public function dequeue():Boolean 
    	{
    		return poll() != null  ;
    	}

	    /**
	     * Retrieves, but does not remove, the head of this queue.
	     */
    	public function element():* 
    	{
    		return _a[0] ;
    	}
    	
	    /**
	     * Inserts the specified element into this queue, if possible.
	     */
    	public function enqueue(o:*):Boolean 
    	{
    		if (o == null) return false ;
			_a.push(o) ;
			return true ;
    	}

        /**
         * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
         */
    	public function peek():* 
    	{
    		if (isEmpty()) return null ;
			return _a[0] ;
    	}
	
	    /**
	     * Retrieves and removes the head of this queue.
	     */
    	public function poll():*
    	{
			if (isEmpty()) return null ;
			return _a.shift() ;	
    	}
	
		
	}
}