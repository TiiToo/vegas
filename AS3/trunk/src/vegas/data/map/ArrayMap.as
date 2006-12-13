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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.data.map
{
    
    import vegas.core.CoreObject;
    import vegas.data.Map;
    import vegas.data.iterator.ArrayIterator ;
    import vegas.data.iterator.Iterator ;
    import vegas.data.iterator.MapIterator ;
    import vegas.data.map.MapFormat ;
    import vegas.util.Copier ;
    import vegas.util.Serializer ;

	/**
	 * @author eKameleon
	 */
    public class ArrayMap extends CoreObject implements Map
    {
        
		/**
		 * Creates a new ArrayMap instance.
		 */        
        public function ArrayMap( ...arguments:Array )
        {
            super();
            
            var k:* = arguments[0] ;
    		var v:* = arguments[1] ;
    		
    		if (k == null ||  v == null) 
    		{
        		_keys = [] ;
    	    	_values = [] ;
    		}
    		else 
            {
    		    var b:Boolean =  (k is Array && v is Array && k.length > 0 && k.length == v.length) ;
    		    _keys = b ? [].concat(k) : [] ;
        		_values = b ? [].concat(v) : [] ;
            }
        }
        
    	/**
    	 * This clears all in the map.
    	 */  
        public function clear():void
        {
            _keys = [] ;
    		_values = [] ;
        }
        
    	/**
    	 * Returns the shallow copy of this map.
    	 * @return the shallow copy of this map.
    	 */
        public function clone():*
        {
            var m:ArrayMap = new ArrayMap() ;
            m.putAll(this) ;
            return m ;
        }

        public function containsKey(key:*):Boolean
        {
            return indexOfKey(key) > -1 ;
        }
        
        public function containsValue(value:*):Boolean
        {
    		return indexOfValue(value) > -1 ;
        }

		public function copy():*
		{
			return new ArrayMap( Copier.copy(getKeys()) , Copier.copy(getValues()) ) ;
		}

        public function get(key:*):* 
        {
            return _values[indexOfKey(key)] ;
        }

        public function getKeys():Array
        {
            return _keys.slice() ;
        }

        public function getValues():Array
        {
            return _values.slice() ;
        }

	    public function indexOfKey(key:*):int 
	    {
            return _keys.indexOf(key) ;
	    }
	
    	public function indexOfValue(value:*):int
    	{
    		return _values.indexOf(value) ;
	    }

        public function isEmpty():Boolean
        {
	        return (size() < 1) ;
        }
        
        public function iterator():Iterator
        {
            return new MapIterator(this) ;
        }
        
        public function keyIterator():Iterator
        {
            return new ArrayIterator(_keys) ;
        }
        
        public function put(key:*, value:*):*
        {
		    var r:* ;
    		var i:int = indexOfKey(key) ;
		    if (i<0) {
			    _keys.push(key) ;
    			_values.push(value) ;
    			return null ;
    		} else {
    			r = _values[i] ;
    			_values[i] = value ;
    			return r ;
    		}
        }
        
        public function putAll(m:Map):void
        {
		    var aV:Array = m.getValues() ;
    		var aK:Array = m.getKeys() ;
    		var l:uint = aK.length ;
    		for (var i:uint = 0 ; i<l ; i = i - (-1) ) {
	    		put(aK[i], aV[i]) ;
    		}
        }
        
        public function remove(o:*):*
        {
		    var r:* = null ;
    		var i:int = indexOfKey(o) ;
    		if (i > -1) {
    			r = _values[i] ;
    			_values.splice(i, 1) ;
    			_keys.splice(i, 1) ;
    		}
    		return r ;
        }
        
        public function size():uint
        {
            return _keys.length ;
        }
        
        override public function toSource(...arguments):String
        {
    		return Serializer.getSourceOf(this, [_keys, _values]) ;
        }
        
        override public function toString():String
        {
		    return new MapFormat().formatToString(this) ;
        }

	    private var _keys:Array ;

    	private var _values:Array ;
    	
    }
}