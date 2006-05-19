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

/** HashSet

	Name : HashSet
	Package : vegas.data.set
	Version : 1.0.0.0
	Date : 2005-10-08
	Author : ekameleon
	URL : http://www.ekameleon.net
	Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Collection d'objets. Tous les objets sont différents les uns des autres.

	USE
	
		var mySet:HashSet = new HashSet( arg ) ;
		
	ARGUMENTS
	
		arg : an Array or a Collection instance to fill the Set object.
	
	METHOD SUMMARY

		- clear()
		
		- clone()
		
		- contains(o)
		
		- insert(o)
		
		- isEmpty()
		
		- iterator()
		
		- remove(o)
		
		- size()
		
		- toArray():Array
		
		- toSource():String
		
		- toString():String
		
	INHERIT		
	
		CoreObject → AbstractCollection → AbstractSet		
	
	IMPLEMENTS
	
		ICloneable, Collection, ISerializable, Set, IFormattable
	
**/

import vegas.data.Collection;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.data.Set;
import vegas.data.set.AbstractSet;
import vegas.util.serialize.Serializer;

class vegas.data.set.HashSet extends AbstractSet {

	// ----o Constructor

	public function HashSet() {
		_map = new HashMap() ;
		if (arguments.length == 0) return ;
		var arg = arguments[0] ;
		var it:Iterator ;
		if (arg instanceof Array) {
			it = new ArrayIterator(arg) ;
		} else if (arg instanceof Collection) {
			it = arg.iterator() ;
		}
		if (it) {
			while (it.hasNext()) insert(it.next()) ;
		}
	}

	// ----o Static Properties
	
	static private var PRESENT = new Object ;

	// ----o Public Methods

	/*override*/ public function clear():Void {
		_map.clear() ;
	}
	
	/*override*/ public function clone() {
		var s:Set = new HashSet() ; 
		if (size() > 0) {
			var it:Iterator = _map.keyIterator() ;
			while(it.hasNext()) {
				s.insert(it.next()) ;
			}
		}
		return s ;
	}

	/*override*/ public function contains(o):Boolean {
		return _map.containsKey(o) ;
    }

	/*override*/ public function insert(o):Boolean {
		return _map.put(o, PRESENT) == null ;
    }

	/*override*/ public function isEmpty():Boolean {
		return _map.isEmpty() ;
	}

	/*override*/ public function iterator():Iterator {
		return _map.keyIterator() ;
	}

    /*override*/ public function remove(o):Boolean {
		return _map.remove(o) == PRESENT ;
    }

	/*override*/ public function size():Number {
		return _map.size() ;
	}
	
	/*override*/ public function toArray():Array {
		return _map.getKeys() ;
	}
	
	/*override*/ public function toSource(indent:Number, indentor:String):String {
		return Serializer.getSourceOf(this, [Serializer.toSource(toArray())]) ;
	}
	
	// ----o Private Properties
	
	private var _map:HashMap ;

}