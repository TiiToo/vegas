
import vegas.core.IComparator;
import vegas.data.map.ArrayMap;
import vegas.data.map.HashMap;

/**
 * This ArrayMap can be sorted with an IComparator object.
 * @author eKameleon
 */
class vegas.data.map.SortedArrayMap extends ArrayMap 
{

	/**
	 * Creates a new SortedArrayMap instance.
	 */	
	public function SortedArrayMap() 
	{
		if ( arguments.caller == null )
		{
			Function( HashMap ).apply(this, [].concat(arguments)) ;
		} 
		sortBy = SortedArrayMap.KEY ;
	}
	
	/**
	 * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "key".
	 */
	static public var KEY:String = "key" ;
	
	/**
	 * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "value".
	 */
	static public var VALUE:String = "value" ;
	
	/**
	 * (read-write) Returns the IComparator instance.
	 */
	public function get comparator():IComparator 
	{
		return getComparator() ;
	}
	
	/**
	 * (read-write) Sets the IComparator instance.
	 */
	public function set comparator(comp:IComparator):Void 
	{
		setComparator(comp) ;
	}
	
	/**
	 * (read-write) Returns the options to sort the elements in the list.
	 */
	public function get options() 
	{
		return getOptions() ;
	}

	/**
	 * (read-write) Sets the options to sort the elements in the list.
	 */
	public function set options(o):Void 
	{
		setOptions(o) ;
	}
	
	/**
	 * (read-write) Returns the options to sort the elements in the list.
	 * Returns the expression who defines if the map is sorted by "key" or "value".
	 */
	public function get sortBy():String
	{
		return _sortBy ;
	}

	/**
	 * (read-write) Sets the options to sort the elements in the list.
	 */
	public function set sortBy( str:String ):Void 
	{
		_sortBy = ( str == SortedArrayMap.VALUE ) ? SortedArrayMap.VALUE : SortedArrayMap.KEY ;
	}

	/**
	 * Returns the IComparator instance.
	 * @return the IComparator instance.
	 */
	public function getComparator():IComparator 
	{
		return _comparator ;
	}

	/**
	 * Returns the options to sort the elements in the list.
	 * @return the options to sort the elements in the list.
	 */
	public function getOptions() 
	{
		return _options ;
	}

	/**
	 * Sets the IComparator instance.
	 */
	public function setComparator(comp:IComparator):Void 
	{
		_comparator = comp ;
	}

	/**
	 * Sets the options to sort the elements in the list.
	 */
	public function setOptions(o):Void 
	{
		_options = o ;
	}
	
	/**
	 * Sorts the elements in Map by key or value.
	 * @see sortBy
	 */
	public function sort():Void  
	{
		
		var compare:Function = _comparator.compare ;
		
		var max:Number = size() ;
		
		if (compare == null && !(max > 0) )
		{
			return ;	
		}

		var result:Array ;
		
		if ( sortBy == KEY )
		{
			result = _keys.sort( compare , _options | Array.RETURNINDEXEDARRAY ) ;
			_keys.sort( compare , _options ) ;
			var clone:Array = getValues() ;
			while ( --max > -1 )
			{
				_values[max] = clone[ result[max] ] ;
			}
		}
		else
		{
			result = _values.sort( compare , _options | Array.RETURNINDEXEDARRAY ) ;
			_values.sort( compare , _options ) ;
			var clone:Array = getKeys() ;
			while ( --max > -1 )
			{
				_keys[max] = clone[ result[max] ] ;
			}
		}
		
	}
	
	/**
	 * Sorts the elements in the list according to one or more fields in the array.
	 * @param fieldName A string that identifies a field to be used as the sort value.
	 * @param opts (optional) The option number value to use to sort this map. 
     */
	public function sortOn( fieldName , opts:Number ):Void 
	{
		
		var max:Number = size() ;
		
		if (fieldName == null && !(max > 0) )
		{
			return ;	
		}
		
		if ( !isNaN(opts) )
		{
			_options = opts ;	
		}
		
		var result:Array ;
		
		if ( sortBy == KEY )
		{
			result = _keys.sortOn( fieldName , _options | Array.RETURNINDEXEDARRAY ) ;
			_keys.sortOn( fieldName , _options ) ;
			var clone:Array = getValues() ;
			while ( --max > -1 )
			{
				_values[max] = clone[ result[max] ] ;
			}
		}
		else
		{
			result = _values.sortOn( fieldName , _options | Array.RETURNINDEXEDARRAY ) ;
			_values.sortOn( fieldName  , _options ) ;
			var clone:Array = getKeys() ;
			while ( --max > -1 )
			{
				_keys[max] = clone[ result[max] ] ;
			}
		}
		
	}

	private var _comparator:IComparator ;

	private var _options ;
	
	private var _sortBy:String ;

}