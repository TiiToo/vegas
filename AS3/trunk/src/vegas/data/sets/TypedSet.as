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

/* TypedSet [Interface]
	
	AUTHOR

    	Name : TypedSet
    	Package : vegas.data
    	Version : 1.0.0.0
    	Date : 2006-07-08
    	Author : ekameleon
    	URL : http://www.ekameleon.net
    	Mail : vegas@ekameleon.net

    DESCRIPTION
    
        A collection that contains no duplicate elements and no duplicate elements with the same Type.

	METHOD SUMMARY
	
		- clear():Void
		
		- clone():*
		
		- copy():*
		
		- contains(o:*):Boolean
		
		- get(id:uin):*

		- getType():*

		- insert(o:*):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean

		- setType(type:*):void

		- size():uint
		
		- supports(value:*):Boolean

		- toArray():Array
	
        - toSource(...arguments:Array):String

		- toString():String

		- validate(value:*):void

    INHERIT
    
    	CoreObject → AbstractTypeable → TypedSet
    
    IMPLEMENTS
    
    	Collection, ICloneable, ICopyable, IFormattable, ISerialzable, Iterable, ITypeable, IValidator, Set

**/

package vegas.data.sets
{
	
	import vegas.errors.IllegalArgumentError ;
	import vegas.data.iterator.Iterator ;
	import vegas.data.Set;
	import vegas.util.AbstractTypeable;
	import vegas.util.ClassUtil ;

	public class TypedSet extends AbstractTypeable implements Set
	{
		
		// ----o Constructor
		
		public function TypedSet(type:*, s:Set)
		{
			super(type);
			if (s == null) {
				throw new IllegalArgumentError(this + " argument 's' must not be 'null' or 'undefined'.") ;
			}
			if (s.size() > 0) {
				var it:Iterator = s.iterator() ;
				while ( it.hasNext() )
				{
					validate(it.next()) ;
				} 
			}
			_set = s ;
		}
		
		// ----o Public Methods

		public function clear():void 
		{
			_set.clear() ;
		}	
		
		public function clone():* 
		{
			return new TypedSet(getType(), _set.clone()) ;
		}
		
		public function contains(o:*):Boolean 
		{
			return _set.contains(o) ;
	    }

		public function copy():* 
		{
			return new TypedSet(getType(), _set.copy()) ;
		}
		
		public function get(id:uint):*
		{
			return _set.get(id) ;
		}
	
		public function indexOf(o:*, fromIndex:uint=0):int
		{
			return _set.indexOf(o) ;
		}

  		public function insert(o:*):Boolean 
  		{
			validate(o) ;
			return _set.insert(o) ;
	    }

		public function isEmpty():Boolean 
		{
			return _set.isEmpty() ;
		}

		public function iterator():Iterator 
		{
			return _set.iterator() ;
		}

	    public function remove(o:*):Boolean 
	    {
			return _set.remove(o);
	    }

		override public function setType(type:*):void
		{
			super.setType(type) ;
			_set.clear() ;
		}

		public function size():uint
		{
			return _set.size() ;
		}
	
		public function toArray():Array 
		{
			return _set.toArray() ;
		}

		override public function toSource(...arguments:Array):String {
			return 'new ' + ClassUtil.getPath(this) + '(' + ClassUtil.getName(getType()) + ',' + _set.toSource() + ')' ;
		}

		override public function toString():String 
		{
			return _set.toString() ;
		}

		// ----o Private Properties
	
		private var _set:Set ;
		
	}
}