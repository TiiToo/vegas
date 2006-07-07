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

/**	MapIterator

	AUTHOR

		Name : MapIterator
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2005-04-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- hashCode():Number
		
		- hasNext():Boolean
		
		- key():*
		
		- next():*
		
		- reset():Void
		
		- remove():*
		
		- seek(n:Number)
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject
		
	IMPLEMENTS
	
		IFormattable, IHashable, Iterator, ISerializable

*/

import vegas.core.CoreObject;
import vegas.data.iterator.ArrayIterator;
import vegas.data.iterator.Iterator;
import vegas.data.Map;
import vegas.errors.UnsupportedOperation;

class vegas.data.map.MapIterator extends CoreObject implements Iterator {

	// ----o Construtor
	
	public function MapIterator (m:Map) {
		_m = m ;
		_i = new ArrayIterator(m.getKeys()) ;
		_k = null ;
	}

	// ----o Public Methods
	
	public function hasNext():Boolean {
		return _i.hasNext() ;
	}
	
	public function key() {
		return _k ;
	}
	
	public function next() {
		_k = _i.next() ;
		return _m.get(_k) ;
	}

	public function remove() {
		_i.remove() ;
		return _m.remove(_k) ;
	}
	
	public function reset():Void {
		_i.reset() ;
	}

	public function seek(n:Number):Void {
		throw new UnsupportedOperation("'seek' method is unsupported in MapIterator object.") ;
	}
	
	// ----o Private Properties
	
	private var _m:Map ; 
	private var _i:ArrayIterator ; 
	private var _k ; // current key
	
}