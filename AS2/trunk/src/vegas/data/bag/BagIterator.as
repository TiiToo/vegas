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

/**	BagIterator

	AUTHOR
	
		Name : BagIterator
		Package : vegas.data.collections
		Version : 1.0.0.0
		Date :  2005-11-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
	METHODS SUMMARY
	
		- hashCode():Number
		
		- hasNext():Boolean
		
		- key()
		
		- next()
		
		- remove()
		
		- reset():Void
		
		- seek(n:Number):Void
		
		- toString():String

	IHNERIT
	
		CoreObject → BagIterator

	IMPLEMENTS 
	
		IFormattable, IHashable, Iterator

*/

import vegas.core.CoreObject;
import vegas.data.bag.AbstractBag;
import vegas.data.iterator.Iterator;
import vegas.errors.ConcurrentModificationError;
import vegas.errors.UnsupportedOperation;

class vegas.data.bag.BagIterator extends CoreObject implements Iterator {

	// ----o Constructor
	
    public function BagIterator( parent:AbstractBag, support:Iterator ) {
		_parent = parent;
		_support = support ;
		_current = null;
		_mods = parent.getModCount() ;
	}

	// ----o Public Methods

	public function hasNext():Boolean {
		return _support.hasNext() ;
	}

	public function key() {
		throw new UnsupportedOperation() ;
	}

	public function next() {
		if (_parent.getModCount() != _mods) {
			throw new ConcurrentModificationError();
		}
        _current = _support.next() ;
		return _current;
    }

	public function remove() {
		if (_parent.getModCount() != _mods) {
            throw new ConcurrentModificationError();
        }
        _support.remove() ;
        _parent.removeCopies(_current, 1);
		_mods++ ;
    }
	
	public function reset():Void {
		throw new UnsupportedOperation() ;
	}
	
	public function seek(n:Number):Void {
		throw new UnsupportedOperation() ;
	}

	// ----o Private Properties
	
	private var _parent:AbstractBag = null ;
	private var _support:Iterator = null ;
	private var _current = null ;
	private var _mods:Number = 0;

}