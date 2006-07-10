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

/* AbstractList [Interface]

    AUTHOR

    	Name : AbstractList
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
		
		- containsAll(c:Collection):Boolean
		
		- ensureCapacity( capacity:uint ):void 
		
		- get(id:uin):*
		
		- indexOf(o:*):int
		
		- insert(o:*):Boolean
		
		- insertAll(c:Collection):Boolean
		
		- insertAllAt(id:uint, c:Collection):Boolean
		
		- insertAt(id:uint, o:*):void
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- lastIndexOf(o:*):int
		
		- listIterator():ListIterator
		
		- remove(o):Boolean
		
		- removeAll(c:Collection):Boolean

		- retainAll(c:Collection):Boolean

		- removeAt(id:uint):*
		
		- retainAll(c:Collection):Boolean
		
		- setAt(id:uint, o:*):void
		
		- size():Number
		
		- subList(fromIndex:uint, toIndex:uint):List
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

    INHERIT
    
	    CoreObject → AbstractCollection → SimpleCollection → AbstractList → ArrayList
    
    IMPLEMENTS
    
        Collection, ICloneable, ICopyable, IEquality, IFormattable, ISerialzable, Iterable, List

**/


package vegas.data.list
{

	import vegas.data.Collection ;
	import vegas.data.iterator.Iterator ;
	import vegas.util.Copier ;
		
	public class ArrayList extends AbstractList
	{
		
		// ----o Constructor
		
		/**
		 * ArrayList constructor.
		 * 
		 * @use 
		 * 	new ArrayList() ;
		 * 	new ArrayList(ar:Array) ;
		 * 	new ArrayList(co:Collection) ;
		 *  new ArrayList( capacity:uint ) ;
		 * 
		 */
		
		public function ArrayList( init:*=null )
		{
			
			var ar:Array ;			
			
			if ( init is Array )
			{
				ar = init ;
			}
			else if (init is Collection)
			{
				ar = [] ;
				var it:Iterator = init.iterator() ;
				while (it.hasNext()) {
					insert(it.next()) ;
				}
			}
			else if (init is uint)
			{
				ar = new Array(init) ;
			}
			else 
			{
				ar = [] ;
			}
			
			super(ar) ;
			
		}
		
		// ----o Public Methods
	
		override public function clone():* 
		{
			return new ArrayList(toArray()) ;
		}
	
		override public function copy():*
		{
			return new ArrayList( Copier.copy(toArray())) ;
		}
	
		public function ensureCapacity( capacity:uint ):void 
		{
			_a.length = capacity ;
		}
		
	}
}