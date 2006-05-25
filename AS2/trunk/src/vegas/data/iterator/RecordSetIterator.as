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

/**	RecordSetIterator

	AUTHOR
	
		Name : RecordSetIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2005-05-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var it:RecordSetIterator = new RecordSetIterator(rs:RecordSet) ;

	METHOD SUMMARY
	
		- hashCode():Number
		
		- hasNext():Boolean
		
		- key()
		
		- next()
		
		- reset():Void
		
		- remove()
		
		- seek(n:Number)
		
		- toString():String

	INHERIT
	
		CoreObject → RecordSetIterator

	IMPLEMENTS
	
		Iterator, IFormattable, IHashable

**/

import vegas.core.CoreObject;
import vegas.data.iterator.Iterator;
import vegas.data.remoting.RecordSet;
import vegas.util.MathsUtil;

/**
 * @author eKameleon
 */
class vegas.data.iterator.RecordSetIterator extends CoreObject implements Iterator {

	// ----o Constructor
	
	public function RecordSetIterator(rs:RecordSet) {
		_rs = rs ;
		_k = -1;
	}

	// ----o Public Methods

	function hasNext() : Boolean {
		return _k < (_rs.size() - 1) ;
	}

	function key() {
		return _k ;
	}

	function next() {
		return _rs.getItemAt( ++_k );
	}

	function remove() {
		return _rs.removeItemAt(_k--);
	}

	function reset() : Void {
		_k = -1 ;
	}

	function seek(n : Number) : Void {
		_k = MathsUtil.clamp ((n-1), -1, _rs.size()) ;
	}
	
	// ----o Private Properties
	
	private var _k:Number ; 
	private var _rs:RecordSet ;

}