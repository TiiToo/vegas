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

/**
 * This ArrayMap can be sorted with an IComparator object.
 * @author eKameleon
 */
if (vegas.data.map.SortedArrayMap == undefined) 
{

	/**
	 * @requires vegas.data.map.ArrayMap
	 */
	require("vegas.data.map.ArrayMap") ;
	
	/**
	 * @requires vegas.util.factory.PropertyFactory 
	 */
	require("vegas.util.factory.PropertyFactory") ;
	
	/**
	 * Creates a new SortedArrayMap instance.
	 */	
	vegas.data.map.SortedArrayMap = function () 
	{ 
		if ( arguments.caller == null )
		{
			vegas.data.map.HashMap.apply(this, Array.fromArguments(arguments) ) ;
		}
		this.sortBy = vegas.data.map.SortedArrayMap.KEY ;
	}

	/**
	 * @extends vegas.data.map.ArrayMap
	 */	
	vegas.data.map.SortedArrayMap.extend(vegas.data.map.ArrayMap) ;

   /**
     * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
	 * for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> method. 
	 * <p>The value of this constant is 1.</p>
	 */
	vegas.data.map.SortedArrayMap.CASEINSENSITIVE /*Number*/ = 1;

	/**
     * Specifies descending sorting for the Array class sorting methods. 
 	 * You can use this constant for the <code>options</code> parameter in the <code>sort()</code>
 	 * or <code>sortOn()</code> method. 
 	 * <p>The value of this constant is 2.</p>
	 */
	vegas.data.map.SortedArrayMap.DESCENDING /*Number*/ = 2;

	/**
	 * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "key".
	 */
	vegas.data.map.SortedArrayMap.KEY /*String*/ = "key" ;

	/**
	 * Specifies the default numeric sorting value for the Array class sorting methods.
	 * <p>The value of this constant is 0.</p>
	 */
	vegas.data.map.SortedArrayMap.NONE /*Number*/ = 0;

	/**
     * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
     * Including this constant in the <code>options</code>
 	 * parameter causes the <code>sort()</code> and <code>sortOn()</code> methods 
	 * to sort numbers as numeric values, not as strings of numeric characters.  
     * Without the <code>NUMERIC</code> constant, sorting treats each array element as a 
 	 * character string and produces the results in Unicode order. 
 	 *
   	 * <p>For example, given the array of values <code>[2005, 7, 35]</code>, if the <code>NUMERIC</code> 
 	 * constant is <strong>not</strong> included in the <code>options</code> parameter, the 
   	 * sorted array is <code>[2005, 35, 7]</code>, but if the <code>NUMERIC</code> constant <strong>is</strong> included, 
   	 * the sorted array is <code>[7, 35, 2005]</code>. </p>
 	 * 
 	 * <p>This constant applies only to numbers in the array; it does 
   	 * not apply to strings that contain numeric data such as <code>["23", "5"]</code>.</p>
 	 * 
 	 * <p>The value of this constant is 16.</p>
	 */
	vegas.data.map.SortedArrayMap.NUMERIC /*Number*/ = 16;
		
	/**
 	 * Specifies that a sort returns an array that consists of array indices as a result of calling
 	 * the <code>sort()</code> or <code>sortOn()</code> method. You can use this constant
 	 * for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> 
 	 * method, so you have access to multiple views on the array elements while the original array is unmodified. 
 	 * <p>The value of this constant is 8.</p>
 	 */
	vegas.data.map.SortedArrayMap.RETURNINDEXEDARRAY /*Number*/ = 8;

	/**
   	 * Specifies the unique sorting requirement for the Array class sorting methods. 
     * You can use this constant for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> method. 
     * The unique sorting option terminates the sort if any two elements or fields being sorted have identical values. 
	 * <p>The value of this constant is 4.</p>
	 */
	vegas.data.map.SortedArrayMap.UNIQUESORT /*Number*/ = 4;
	
	/**
	 * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "value".
	 */
	vegas.data.map.SortedArrayMap.VALUE /*String*/ = "value" ;

	/**
	 * Returns the IComparator instance.
	 * @return the IComparator instance.
	 */
	vegas.data.map.SortedArrayMap.prototype.getComparator = function() /*IComparator*/ 
	{
		return this._comparator ;
	}

	/**
	 * Returns the options to sort the elements in the list.
	 * @return the options to sort the elements in the list.
	 */
	vegas.data.map.SortedArrayMap.prototype.getOptions = function() 
	{
		return this._options ;
	}

	/**
	 * Returns the options to sort the elements in the list.
	 * Returns the expression who defines if the map is sorted by "key" or "value".
	 */
	vegas.data.map.SortedArrayMap.prototype.getSortBy = function() /*String*/
	{
		return this._sortBy ;
	}

	/**
	 * Sets the IComparator instance.
	 */
	vegas.data.map.SortedArrayMap.prototype.setComparator = function (comp /*IComparator*/ ) /*void*/ 
	{
		this._comparator = comp ;
	}

	/**
	 * Sets the options to sort the elements in the list.
	 */
	vegas.data.map.SortedArrayMap.prototype.setOptions = function(o) /*void*/ 
	{
		this._options = o ;
	}

	/**
	 * Sets the options to sort the elements in the list.
	 */
	vegas.data.map.SortedArrayMap.prototype.setSortBy = function( str /*String*/ ) /*void*/ 
	{
		this._sortBy = ( str == vegas.data.map.SortedArrayMap.VALUE ) ? vegas.data.map.SortedArrayMap.VALUE : vegas.data.map.SortedArrayMap.KEY ;
	}
	
	/**
	 * Sorts the elements in Map by key or value with the IComparator of this ArrayMap.
	 * <p><b>Example :</b></p>
	 * {@code
	 * var map:SortedArrayMap = new SortedArrayMap() ;
	 * 
 	 * map.put( "key1", "value4" ) ;
	 * map.put( "key3", "value2" ) ;
 	 * map.put( "key4", "value3" ) ;
	 * map.put( "key2", "value1" ) ;
	 * 
	 * trace(map) ; // {key1:value4,key3:value2,key4:value3,key2:value1}
	 * 
 	 * map.comparator = StringComparator.getStringComparator() ;
	 * 
	 * map.options = SortedArrayMap.DESCENDING ;
	 * map.sort() ;
	 * 
	 * trace(map) ; // {key4:value3,key3:value2,key2:value1,key1:value4}
	 * 
 	 * map.options = SortedArrayMap.NONE ;
	 * map.sort() ;
	 * 
 	 * trace(map) ; // {key1:value4,key2:value1,key3:value2,key4:value3}
 	 * 
	 * map.sortBy = SortedArrayMap.VALUE ;
	 * 
	 * map.options = SortedArrayMap.DESCENDING ;
	 * map.sort() ;
	 * 
 	 * trace(map) ; // {key1:value4,key4:value3,key3:value2,key2:value1}
	 * 
 	 * map.options = SortedArrayMap.NONE ;
 	 * map.sort() ;
 	 * 
	 * trace(map) ; // {key2:value1,key3:value2,key4:value3,key1:value4}
	 * } 
 	 * @see SortedArrayMap#sortBy
 	 */
	vegas.data.map.SortedArrayMap.prototype.sort = function() /*void*/  
	{
		
		var compare /*Function*/ = this._comparator.compare ;
		
		var max /*Number*/ = this.size() ;
		
		if (compare == null && !(max > 0) )
		{
			return ;	
		}

		var result /*Array*/ ;
		
		if ( this.getSortBy() == vegas.data.map.SortedArrayMap.KEY )
		{
			// TODO change the default Array.prototype.sort method and add the "options" argument !
			result = this._keys.sort( compare , this._options | Array.RETURNINDEXEDARRAY ) ;
			this._keys.sort( compare , this._options ) ;
			var clone /*Array*/ = this.getValues() ;
			while ( --max > -1 )
			{
				this._values[max] = clone[ result[max] ] ;
			}
		}
		else
		{
			result = this._values.sort( compare , this._options | Array.RETURNINDEXEDARRAY ) ;
			this._values.sort( compare , this._options ) ;
			var clone /*Array*/ = this.getKeys() ;
			while ( --max > -1 )
			{
				this._keys[max] = clone[ result[max] ] ;
			}
		}
		
	}
	
	/**
 	 * Sorts the elements in the list according to one or more fields in the array.
 	 * <p><b>Example :</b></p>
 	 * {@code
 	 * import vegas.data.iterator.Iterator ;
 	 * import vegas.data.Map ;
 	 * import vegas.data.map.SortedArrayMap ;
 	 * 
 	 * var map:SortedArrayMap = new SortedArrayMap() ;
 	 * 
 	 * map.put( { id:5 } , { name:'name4' } ) ;
 	 * map.put( { id:1 } , { name:'name1' } ) ;
 	 * map.put( { id:3 } , { name:'name5' } ) ;
 	 * map.put( { id:2 } , { name:'name2' } ) ;
 	 * map.put( { id:4 } , { name:'name3' } ) ;
 	 * 
 	 * var debug:Function = function( map:Map ):void
 	 * {
 	 * 
 	 *     var vit:Iterator = map.iterator() ;
 	 *     var kit:Iterator = map.keyIterator() ;
 	 *     var str:String = "{" ;
 	 * 
 	 *     while( vit.hasNext() )
 	 *     {
 	 *         var value = vit.next() ;
 	 *         var key   = kit.next() ;
 	 *         str += key.id + ":" + value.name ;
 	 *         if (vit.hasNext())
 	 *         {
 	 *             str += "," ;
 	 *         }
 	 *     }
 	 *     str += "}" ;
 	 *     trace(str) ;
 	 * }
 	 * 
 	 * trace("----- original Map") ;
 	 * 
 	 * debug( map ) ; // {5:name4,1:name1,3:name5,2:name2,4:name3}
 	 * 
 	 * trace("----- sort by key with sort() method") ;
 	 * 
 	 * map.sortBy = SortedArrayMap.KEY ; // default
 	 * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
 	 * map.sortOn("id") ;
 	 * debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
 	 * 
 	 * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
 	 * map.sortOn("id") ;
 	 * debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
 	 * 
 	 * trace("----- sort by value with sort() method") ;
 	 * 
 	 * map.sortBy = SortedArrayMap.VALUE ;
 	 * map.options = SortedArrayMap.DESCENDING ;
 	 * map.sortOn("name") ;
 	 * debug( map ) ; // {3:name5,5:name4,4:name3,2:name2,1:name1}
 	 * 
 	 * map.options = SortedArrayMap.NONE ;
 	 * map.sortOn("name") ;
 	 * debug( map ) ; // {1:name1,2:name2,4:name3,5:name4,3:name5}
 	 * }
	 * @param fieldName A string that identifies a field to be used as the sort value.
	 * @param opts (optional) The option number value to use to sort this map.
	 * @see SortedArrayMap#sortBy 
     */
	vegas.data.map.SortedArrayMap.prototype.sortOn = function( fieldName , opts /*Number*/ ) /*void*/ 
	{
		
		var max /*Number*/ = this.size() ;
		
		if (fieldName == null && !(max > 0) )
		{
			return ;	
		}
		
		if ( !isNaN(opts) )
		{
			this._options = opts ;	
		}
		
		var result /*Array*/ ;
		
		if ( sortBy == vegas.data.map.SortedArrayMap.KEY )
		{
			result = this._keys.sortOn( fieldName , this._options | Array.RETURNINDEXEDARRAY ) ;
			this._keys.sortOn( fieldName , this._options ) ;
			var clone /*Array*/ = this.getValues() ;
			while ( --max > -1 )
			{
				this._values[max] = clone[ result[max] ] ;
			}
		}
		else
		{
			result = this._values.sortOn( fieldName , this._options | Array.RETURNINDEXEDARRAY ) ;
			this._values.sortOn( fieldName  , this._options ) ;
			var clone /*Array*/ = this.getKeys() ;
			while ( --max > -1 )
			{
				this._keys[max] = clone[ result[max] ] ;
			}
		}
		
	}

	vegas.data.map.SortedArrayMap.prototype._comparator /*IComparator*/ = null ;

	vegas.data.map.SortedArrayMap.prototype._options = null ;
	
	vegas.data.map.SortedArrayMap.prototype._sortBy /*String*/ = null ;

	/**
	 * (Read-write) The IComparator value of this instance.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.data.map.SortedArrayMap.prototype, "comparator") ;	

	/**
	 * (Read-write) The options value of this instance.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.data.map.SortedArrayMap.prototype, "options") ;	

	/**
	 * (Read-write) The sortBy value of this instance.
	 */
	vegas.util.factory.PropertyFactory.create(vegas.data.map.SortedArrayMap.prototype, "sortBy") ;	

}