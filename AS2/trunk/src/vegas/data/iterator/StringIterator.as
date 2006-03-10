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

/* ------- 	StringIterator

	AUTHOR
	
		Name : StringIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2005-11-04
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- hasNext()
		
		- key()
		
		- next()
		
		- reset()
		
		- seek(n:Number) : n between 0 and the size of the string object
		
		- toString():String

	INHERIT
	
		CoreObject
			|
			StringIterator

	IMPLEMENTS
	
		IFormattable, IHashable, Iterator

----------  */

import vegas.core.CoreObject;
import vegas.data.iterator.Iterator;
import vegas.errors.UnsupportedOperation;
import vegas.util.MathsUtil;

class vegas.data.iterator.StringIterator extends CoreObject implements Iterator {

	// ----o Construtor
	
	public function StringIterator(s:String) {
		_s = new String(s) ;
		_k = -1 ;
		_size = s.length ;
	}

	// ----o Public Methods
	
	public function hasNext():Boolean {
		return _k < _size-1  ;
	}

	public function key() {
		return _k ;
	}

	public function next() {
		return _s.charAt( ++_k );
	}
	
	public function remove() {
		throw new UnsupportedOperation ;
	}
	
	public function reset():Void {
		_k = -1 ;
	}
	
	public function seek(n:Number):Void {
		_k = MathsUtil.clamp (n-1, -1, _size-1) ;
	}
	
	// ----o Private Properties
	
	private var _s:String ;
	private var _k:Number ;
	private var _size:Number ;
	
}