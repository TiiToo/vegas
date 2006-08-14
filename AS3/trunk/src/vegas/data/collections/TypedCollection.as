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

/* AbstractTypeable

	AUTHOR

		Name : AbstractTypeable
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2006-07-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		private

	METHOD SUMMARY

		- clear():void
		
		- clone():*
		
		- copy():*
				
		- contains(o:*):Boolean
			
		- get(key:*):*

		- getType():*

		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):*

		- setType(type:*):void
			
		- size():uint

		- supports(value):Boolean

		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String
		
		- validate(value:*):Boolean
	
	INHERIT
	
		CoreObject → AbstractTypeable → AbstractTypeable
	
	IMPLEMENTS 

		Collection, ICloneable, ICopyable, IFormattable, IHashable ISerializable, Iterable, ITypeable, IValidator

*/

package vegas.data.collections
{

	import vegas.errors.IllegalArgumentError ;

	import vegas.data.Collection;
	import vegas.data.iterator.Iterator ;
	
	import vegas.util.AbstractTypeable;
	import vegas.util.ClassUtil ;
	

	public class TypedCollection extends AbstractTypeable implements Collection
	{
		
		// ----o Constructor
		
		public function TypedCollection(type:*, co:Collection=null)
		{
			super(type);
			if (co == null) {
				throw new IllegalArgumentError("Argument 'co' must not be 'null' or 'undefined'.") ;
			}
			if (co.size() > 0) {
				var it:Iterator = co.iterator() ;
				while ( it.hasNext() ) validate(it.next()) ;
			}
			_co = co ;
		}
		
		// ----o Public Methods
		
		public function clear():void 
		{
			_co.clear() ;
		}
		
		public function clone():* 
		{
			return new TypedCollection(getType(), _co) ;
		}
		
		public function copy():*
		{
			return new TypedCollection(getType(), _co.clone()) ;
		}

		public function contains(o:*):Boolean
		{
			return _co.contains(o) ;
		}

    	public function get(key:*):*
    	{
    		return _co.get(key) ;	
    	}

		public function indexOf(o:*, fromIndex:uint=0):int
		{
			return _co.indexOf(o, fromIndex) ;
		}

		public function insert(o:*):Boolean
		{
			return _co.insert(o) ;
		}
		
		public function isEmpty():Boolean
		{
			return _co.isEmpty();
		}
	
		public function iterator():Iterator
		{
			return _co.iterator() ;
		}
		
		public function remove(o:*):*
		{
			return _co.remove(o) ;
		}
	
		override public function setType(type:*):void
		{
			super.setType(type) ;
			_co.clear() ;
		}
		
		public function size():uint
		{
			return _co.size() ;
		}
		
		public function toArray():Array
		{
			return _co.toArray() ;
		}

		override public function toSource(...arguments):String
		{
			return 'new ' + ClassUtil.getPath(this) + '(' + ClassUtil.getName(getType()) + ',' + _co.toSource() + ')' ;
		}
		
	
		override public function toString():String
		{
			return _co.toString() ;
		}
		
		// ----o Private Properties
		
		private var _co:Collection ;
		
	}
	
}