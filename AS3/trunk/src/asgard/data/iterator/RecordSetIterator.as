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

package asgard.data.iterator
{
	
	import asgard.data.remoting.RecordSet ;
	
	import vegas.core.CoreObject;
	import vegas.data.iterator.Iterator;
	import vegas.util.MathsUtil;
	
	public class RecordSetIterator extends CoreObject implements Iterator
	{
		
        /**
         * Creates a new RecordSetIterator instance.
         */ 
		public function RecordSetIterator(rs:RecordSet)
		{
			_rs = rs ;
			_k = -1;
		}
	
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