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

/* HashMap

	AUTHOR
	
		Name : HashMap
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Tableau associatif d'objets.

	METHOD SUMMARY
	
		- clear()
		
		- clone()
		
		- containsKey( key )
		
		- containsValue( value )
		
		- get(key)
		
		- getKeys()
		
		- getValues()
		
		- isEmpty()
		
		- iterator()
		
		- keyIterator()
		
		- put(key, value)
		
		- putAll(m:Map)
		
		- remove(key)
		
		- size()
		
		- toSource():String
		
		- toString():String

	INHERIT
	
		CoreObject → HashMap
	
	IMPLEMENTS
	
		ICloneable, IFormattable, IHashable, ISerializable, Iterable, Map

    NOTE
     
        This class is not the same AS2 vegas.data.map.HashMap !

    EXAMPLE

        package {
        	
            import flash.display.Sprite;
    	    import flash.utils.* 
	
            import vegas.data.Map ;
            import vegas.data.map.HashMap;
    	    import vegas.data.iterator.Iterator;

            public class TestHashMap extends Sprite
            {
        
                // ----o Constructor
		
                public function TestHashMa() 
                {
                    
                    var map:Map = new HashMap() ;
                    trace("> put key1 -> value0 : " + map.put("key1", "value0") ) ;
                    trace("> put key1 -> value1 : " + map.put("key1", "value1") ) ;            
                    trace("> put key2 -> value2 : " + map.put("key2", "value2") ) ;
                    
                    trace("> map : " + map) ;
                    
                    trace("> map toSource : " + map.toSource()) ;
                    
                    trace("> iterator") ;
                    var it:Iterator = map.iterator() ;
                    while(it.hasNext()) 
                    {
                        var v:* = it.next() ;
                        var k:* = it.key() ;
                        trace( "   -> " + k + " : " + v ) ;
                        
                    }
                    
                    trace("> remove key1 : " + map.remove("key1")) ;
                    
                    trace("> size : " + map.size()) ;      
                    
                    map.clear() ;  
                    
                    trace("> isEmpty : " + map.isEmpty()) ;      
                    
                }
            }
        }

*/

// TODO Finir les tests.

package vegas.data.map
{

    import flash.utils.Proxy;
    import flash.utils.getDefinitionByName;

    import vegas.core.HashCode ;
    import vegas.core.ICloneable ;
    import vegas.core.IFormattable ;
    import vegas.data.iterator.ArrayIterator  ;
    import vegas.data.iterator.Iterator  ;
    import vegas.data.iterator.MapIterator  ;
    import vegas.data.Map 
    import vegas.util.Serializer ;

    public class HashMap extends Proxy implements Map
    {
        
        // ----o Constructor
        
        public function HashMap( ...arguments:Array )
        {
            clear() ;
            
            var k:* = arguments[0] ;
    		var v:* = arguments[1] ;
    		
    		if (k != null && v!=null)
            {
                if (k is Array && v is Array && k.length == v.length)
                {
                    var count:uint = k.length ;
                    for(var i:uint = 0 ; i<count ; i++) {
                        
                        put(k[i], v[i]) ;
                        
                    }
                }
            }
            
        }
        
    	// ----o Init HashCode
	
		HashCode.initialize(HashMap.prototype) ;
        
        // ----o Public Methods
        
    	/**
    	 * This clears all in the map.
    	 */  
        public function clear():void
        {
            var clazz:* = flash.utils.getDefinitionByName("flash.utils.Dictionary");
            _keys = new clazz(true) ;
    		_values = new clazz(true) ;
    		_size = 0 ;
        }
        
    	/**
    	 * Clones the map.
    	 */
        public function clone():*
        {
            var m:HashMap = new HashMap() ;
            m.putAll(this) ;
            return m ;
        }

        public function containsKey(key:*):Boolean
        {
            return _keys[ key ] != null ;
        }
        
        public function containsValue(value:*):Boolean
        {
    		return _values[ value ] != null ;
        }

        public function get(key:*):* 
        {
            return _keys[key] ;
        }

        public function getKeys():Array
        {
            var ar:Array = [] ;
            for (var key:* in _keys) {
                ar.push(key) ;
            }
            return ar ;
        }

        public function getValues():Array
        {
            var ar:Array = [] ;
            for each (var value:* in _keys) {
                ar.push(value) ;
            }
            return ar ;
        }

        public function hashCode():uint
        {
            return null ;
        }

        public function isEmpty():Boolean
        {
	        return _size == 0 ;
        }
        
        public function iterator():Iterator
        {
            return new MapIterator(this) ;
        }
        
        public function keyIterator():Iterator
        {
            return new ArrayIterator(getKeys()) ;
        }
        
        public function put(key:*, value:*):*
        {
		    var r:* = null ;

    		if ( containsKey( key ) )
    		{
    		    r = _keys[ key ] ;
    		    remove( key );
    		    
    		}
			
			var count:uint = _values[ value ] ;
			
			_values[ value ] = (count > 0) ? count+1 : 1 ;
			
			_size++ ;
			_keys[ key ] = value ;
			
			return r ;
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
        
        public function remove(key:*):*
        {
		    var r:* = null ;
    		var value:* ;
			
			if ( containsKey( key ) ) 
			{
				_size -- ;

				value = _keys[ key ];
				
				var count:uint = _values[ value ];
				if (count > 1)
				{
					_values[ value ] = count - 1;
				} else
				{
					delete _values[ value ];
				}
				
				delete _keys[ key ];
				
				return value ;
				
			}
			
			return null ;
			
        }
        
        public function size():uint
        {
            return _size ;
        }
        
        public function toSource(...arguments):String
        {
    		return Serializer.getSourceOf(this, [getKeys(), getValues()]) ;
        }
        
        public function toString():String
        {
		    var m:Map = this ;
    		var r:String = "{";
    		var vIterator:Iterator = m.iterator() ;
    		var kIterator:Iterator = new ArrayIterator(m.getKeys());
    		while (kIterator.hasNext()) {
    			r += kIterator.next().toString() + ":" + vIterator.next().toString();
    			if (kIterator.hasNext()) r += ",";
    		}
    		r += "}";
    		return r ;
        }

        // ----o Private Properties
        
        private var _size:uint ;
        private var _keys:* ;
        private var _values:* ;

    }
}