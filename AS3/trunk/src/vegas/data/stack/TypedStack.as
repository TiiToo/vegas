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

/* Stack [Interface]

	AUTHOR
	
		Name : Stack
		Package : vegas.data
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- clear():void
		
		- clone(:*

		- getType():*

		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- peek():*
		
		- pop():*
		
		- push(o):*
		
		- search(o):Number

		- setType(type:*):void

		- size():uint
		
		- supports(value:*):Boolean

		- toArray():Array
	
        - toSource(...arguments:Array):String

		- toString():String

		- validate(value:*):void

    INHERIT
    
    	CoreObject → AbstractTypeable → TypedStack
    	
	IMPLEMENTS
	
		ICloneable, Iterable, IFormattable, ISerializable, ITypeable, IValidator

**/

package vegas.data.stack
{

	import vegas.data.iterator.Iterator ;	
	import vegas.data.Stack;
	import vegas.errors.IllegalArgumentError;
	import vegas.util.AbstractTypeable;
	import vegas.util.ClassUtil ;

	public class TypedStack extends AbstractTypeable implements Stack
	{
		
		// ----o Constructor
		
		public function TypedStack(type:*, stack:Stack)
		{
			super(type);
			if (stack == null) {
				throw new IllegalArgumentError("TypedStack constructor, argument 'stack' must not be 'null' or 'undefined'.") ;
			}
			this._stack = stack ;
			if (_stack.size() > 0) {
				var it:Iterator = _stack.iterator() ;
				while ( it.hasNext() )
				{
					validate(it.next()) ;
				} 
			}

		}
				
		// ----o Public Methods

		public function clear():void
		{
			_stack.clear() ;
		}

		public function clone():*
		{
			return _stack.clone() ;
		}

		public function copy():*
		{
			return _stack.copy() ;
		}
	
		public function isEmpty():Boolean
		{
			return false;
		}
		
		public function iterator():Iterator
		{
			return _stack.iterator() ;
		}
		
		public function peek():*
		{
			return _stack.peek() ;
		}
		
		public function pop():*
		{
			return _stack.pop() ;
		}

		public function push(o:*):void
		{
			validate(o) ;
			_stack.push(o) ;
		}
		
		public function search(o:*):uint
		{
			return _stack.search(o) ;
		}

		override public function setType(type:*):void
		{
			super.setType(type) ;
			_stack.clear() ;
		}

		public function size():uint
		{
			return _stack.size() ;
		}

		public function toArray():Array
		{
			return _stack.toArray() ;
		}
		
		override public function toSource(...arguments:Array):String {
			return 'new ' + ClassUtil.getPath(this) + '(' + ClassUtil.getName(getType()) + ',' + _stack.toSource() + ')' ;
		}

		override public function toString():String
		{
			return _stack.toString() ;
		}

		// ----o Private Properties
		
		private var _stack:Stack ;
		
	}
}