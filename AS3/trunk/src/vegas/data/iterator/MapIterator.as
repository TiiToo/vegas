package vegas.data.iterator
{
 
    import vegas.core.CoreObject;
    import vegas.data.iterator.ArrayIterator ;   
    import vegas.data.iterator.Iterator ;    
    import vegas.data.Map ;
    import vegas.errors.UnsupportedOperation ;
    import vegas.util.Serializer ;

    public class MapIterator extends CoreObject implements Iterator
    {
        
        // ----o Constructor
        
        public function MapIterator(m:Map)
        {
		    _m = m ;
    		_i = new ArrayIterator(m.getKeys()) ;
    		_k = null ;
        }
        
        // ----o Public Methods
        
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
		    throw new UnsupportedOperation("'seek' method is unsupported in MapIterator object.") ;
        }

        override public function toSource(...arguments:Array):String 
        {
            return "new vegas.data.iterator.MapIterator(" + Serializer.toSource(_m) + ")" ;
        }
    
    	// ----o Private Properties
	
    	private var _m:Map ; 
    	private var _i:ArrayIterator ; 
    	private var _k:* ; // current key
        
    }
}