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
	import vegas.util.MathsUtil;
	import vegas.util.Serializer ;
	
	public class ObjectIterator extends CoreObject implements Iterator
	{
		
		public function ObjectIterator(o:Object)
		{
			_o = o ;
			_a = new Array() ;
			_k = -1 ;
			var value:* ;
			for (var each:String in o)
			{
				value = o[each] ;
				if ( ! (value is Function) ) 
				{	
					_a.push(each) ;
				}
			} 
			_len = _a.length ;
		}
		
		public function hasNext():Boolean
		{
			return _k <  (_len - 1) ;
		}

		public function index():int
		{
			return _k ;
		}

		public function key():*
		{
			return _a[_k] ;
		}

		public function next():*
		{
			return _o[ _a[++_k] ] ;
		}
		
		public function remove():*
		{
			var p:String = _a[_k] ;
			_a.splice(_k--, 1) ;
			delete _o[p] ;
			_len -- ;
			return p ;
		}
		
		public function reset():void
		{
			_k = -1 ;
		}

		public function seek(position:*):void
		{
			_k = MathsUtil.clamp ((position-1), -1, _len) ;
		}

        override public function toSource(...arguments:Array):String 
        {
            return Serializer.getSourceOf(this, [_o] ) ;
        }

		private var _a:Array ;
		private var _k:int ;
		private var _o:Object ;
		private var _len:uint ;

	}
}