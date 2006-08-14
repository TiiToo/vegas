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

/* SimpleStack

	AUTHOR
	
		Name : SimpleStack
		Package : vegas.data.stack
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():void
		
		- clone(:*

		- contains(o:*):Boolean

		- copy():*

		- get(key:*):*

		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int

		- insert(o:*):Boolean

		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- peek():*
		
		- pop():*
		
		- push(o):*

		- remove(o):*

		- search(o):Number
		
		- size():uint
		
		- toArray():Array ;
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCollection → SimpleStack

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IFormattable, Iterable, ISerializable, Stack

	EXAMPLE
	
		var stack:Stack = new SimpleStack(["item1", "item2"]) ;
		trace("push : " + stack.push("item3")) ;
		trace("toSource : " + stack.toSource()) ;
		trace("pop : " + stack.pop()) ;
		trace("stack : " + stack) ;			

**/

package vegas.data.stack
{
	import vegas.data.collections.AbstractCollection;
	import vegas.data.iterator.ArrayIterator;
	import vegas.data.iterator.Iterator;
	import vegas.data.iterator.ProtectedIterator;
	import vegas.data.Stack;
	import vegas.util.Copier ;

	public class SimpleStack extends AbstractCollection implements Stack
	{

		// ----o Constructor
		
		public function SimpleStack(ar:Array=null)
		{
			super(ar);
		}
		
		// ----o Public Methods
	
		override public function clone():* 
		{
			return new SimpleStack(toArray()) ;
		}

		override public function copy():*
		{
			return new SimpleStack(Copier.copy(toArray())) ;
		}

		override public function get(key:*):*
		{ 
			var a:Array = toArray() ;
			return a[key] ;
		}

		override public function iterator():Iterator 
		{
			return (new ProtectedIterator(new ArrayIterator(toArray()))) ;
		}

		public function peek():*
		{
			return _a[_a.length - 1] ;
		}

		public function pop():*
		{
			return isEmpty() ? null : _a.pop() ;
		}

		public function push(o:*):void
		{
			_a.push(o) ;
		}

		public function search(o:*):uint
		{
			return indexOf(o) ;
		}

		override public function toArray():Array 
		{
			var aReverse:Array = _a.slice() ;
			aReverse.reverse() ;
			return aReverse ;
		}
		
	}
}