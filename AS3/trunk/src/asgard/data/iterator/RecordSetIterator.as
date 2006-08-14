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

/*	RecordSetIterator

	AUTHOR
	
		Name : RecordSetIterator
		Package : asgard.data.iterator
		Version : 1.0.0.0
		Date :  2005-08-14
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

*/

package asgard.data.iterator
{
	
	import asgard.data.remoting.RecordSet ;
	
	import vegas.core.CoreObject;
	import vegas.data.iterator.Iterator;
	import vegas.util.MathsUtil;
	
	public class RecordSetIterator extends CoreObject implements Iterator
	{
		
		// ----o Constructor
		
		public function RecordSetIterator(rs:RecordSet)
		{
			_rs = rs ;
			_k = -1;
		}
	
		// ----o Public Methods

		public function hasNext():Boolean 
		{
			return _k < (_rs.size() - 1) ;
		}

		public function key():* 
		{
			return _k ;
		}

		public function next():* 
		{
			return _rs.getItemAt( ++_k );
		}

		public function remove():* {
			return _rs.removeItemAt(_k--);
		}

		public function reset():void
		{
			_k = -1 ;
		}

		public function seek(position:*):void 
		{
			_k = MathsUtil.clamp ((position-1), -1, _rs.size()) ;
		}

		// ----o Private Properties
	
		private var _k:Number ; 
		private var _rs:RecordSet ;
	
	}

}