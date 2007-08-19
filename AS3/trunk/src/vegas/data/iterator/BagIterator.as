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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.data.iterator
{
	
	import vegas.core.CoreObject;
	
	import vegas.data.bag.AbstractBag ;

	import vegas.errors.ConcurrentModificationError ;
	import vegas.errors.UnsupportedOperation ;

	import vegas.util.Serializer ;

	public class BagIterator extends CoreObject implements Iterator
	{
		
		public function BagIterator( parent:AbstractBag, support:Iterator  )
		{
			_parent = parent;
			_support = support ;
			_current = null;
			_mods = parent.getModCount() ;
		}
		
		public function hasNext():Boolean
		{
			return _support.hasNext() ;
		}

		public function key():*
		{
			throw new UnsupportedOperation(this + " 'key' method is unsupported.") ;
		}

		public function next():*
		{
			if (_parent.getModCount() != _mods) {
				throw new ConcurrentModificationError(this + " concurrent modification impossible in 'next' method.");
			}
    	    _current = _support.next() ;
			return _current;
		}

		public function remove():*
		{
			if (_parent.getModCount() != _mods) 
			{
            	throw new ConcurrentModificationError(this + " concurrent modification impossible in 'remove' method.");
        	}
	        _support.remove() ;
    	    _parent.removeCopies(_current, 1);
			_mods++ ;
		}
		
		public function reset():void
		{
			throw new UnsupportedOperation(this + " 'reset' method is unsupported.") ;
		}
		
		public function seek(position:*):void
		{
			throw new UnsupportedOperation(this + " 'seek' method is unsupported.") ;
		}

        override public function toSource(...arguments:Array):String 
        {
            return Serializer.getSourceOf(this, [_parent, _support] ) ;
        }

		private var _parent:AbstractBag = null ;
		private var _support:Iterator = null ;
		private var _current:* = null ;
		private var _mods:uint = 0;

	}
}