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