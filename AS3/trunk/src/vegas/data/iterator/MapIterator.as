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
    import vegas.data.Map ;
    import vegas.errors.UnsupportedOperation ;
    import vegas.util.Serializer ;

    public class MapIterator extends CoreObject implements Iterator
    {
        
        public function MapIterator(m:Map)
        {
		    _m = m ;
    		_i = new ArrayIterator(m.getKeys()) ;
    		_k = null ;
        }
        
        public function hasNext():Boolean
        {
            return _i.hasNext() ;
        }

        public function key():*
        {
            return _k ;
        }
        
        public function next():*
        {
		    _k = _i.next() ;
    		return _m.get(_k) ;
        }
        
        public function remove():*
        {
		    _i.remove() ;
    		return _m.remove(_k) ;
        }
        
        public function reset():void
        {
            _i.reset() ;
        }        

        public function seek(position:*):void
        {
		    throw new UnsupportedOperation("This Iterator does not support the seek() method.") ;
        }

        override public function toSource(...arguments:Array):String 
        {
            return "new vegas.data.iterator.MapIterator(" + Serializer.toSource(_m) + ")" ;
        }
    
    	private var _m:Map ; 
    	private var _i:ArrayIterator ; 
    	private var _k:* ; // current key
        
    }
}